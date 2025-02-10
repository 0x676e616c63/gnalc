#include <algorithm>
#include <functional>

#include "../../include/config/config.hpp"
#include "../../include/ir/constant.hpp"
#include "../../include/ir/instructions/binary.hpp"
#include "../../include/ir/instructions/compare.hpp"
#include "../../include/ir/instructions/control.hpp"
#include "../../include/ir/instructions/converse.hpp"
#include "../../include/ir/instructions/helper.hpp"
#include "../../include/ir/instructions/memory.hpp"
#include "../../include/ir/module.hpp"
#include "../../include/parser/irgen.hpp"
#include "../../include/utils/logger.hpp"

using namespace AST;
namespace Parser {
IRGenerator::IRGenerator(const std::string &module_name) {
    module.setName(module_name);
}

void IRGenerator::visit(CompUnit &node) {
    symbol_table.initScope("__global");

    auto void_type = IR::makeBType(IR::IRBTYPE::VOID);
    auto i1_type = IR::makeBType(IR::IRBTYPE::I1);
    auto i8_type = IR::makeBType(IR::IRBTYPE::I8);
    auto i8ptr_type = IR::makePtrType(i8_type);
    auto i32_type = IR::makeBType(IR::IRBTYPE::I32);
    auto i32ptr_type = IR::makePtrType(i32_type);
    auto f32_type = IR::makeBType(IR::IRBTYPE::FLOAT);
    auto f32ptr_type = IR::makePtrType(f32_type);
    // Warning: defaults to make Sylib function
    auto make_decl = [this](const std::string &name,
                            std::vector<std::shared_ptr<IR::Type>> params,
                            std::shared_ptr<IR::Type> ret,
                            bool is_va_arg = false, bool is_builtin = false,
                            bool is_sylib = true) {
        auto fn = std::make_shared<IR::FunctionDecl>(
            "@" + name, std::move(params), std::move(ret), is_va_arg,
            is_builtin, is_sylib);
        symbol_table.insert(name, fn);
        module.addFunctionDecl(fn);
    };

    // sylib
    make_decl("getint", {}, i32_type);
    make_decl("getch", {}, i32_type);
    make_decl("getarray", {i32ptr_type}, i32_type);
    make_decl("getfloat", {}, f32_type);
    make_decl("getfarray", {f32ptr_type}, i32_type);
    make_decl("putint", {i32_type}, void_type);
    make_decl("putch", {i32_type}, void_type);
    make_decl("putarray", {i32_type, i32ptr_type}, void_type);
    make_decl("putfloat", {f32_type}, void_type);
    make_decl("putfarray", {i32_type, f32ptr_type}, void_type);
    make_decl("putf", {i8ptr_type}, void_type, true); // VAArg
    make_decl("_sysy_starttime", {i32_type}, void_type);
    make_decl("_sysy_stoptime", {i32_type}, void_type);

    // builtin
    // memset (dest, val, len, isvolatile)
    make_decl(Config::IR::BUILTIN_MEMSET,
              {i8ptr_type, i8_type, i32_type, i1_type}, void_type, false, true,
              false); // -> not va_arg, is builtin, and not sylib

    for (auto &n : node.getNodes()) {
        n->accept(*this);
    }
    symbol_table.finishScope();

    module.removeUnusedFuncDecl();

    CFGBuilder builder;
    builder.build(module);
    curr_func = nullptr;
    curr_initializer.reset(IR::IRBTYPE::I32);
    curr_val = nullptr;
    curr_making_initializer = nullptr;
    curr_insts.clear();
    is_making_lval = false;
}

// DeclStmt: const int32
void IRGenerator::visit(DeclStmt &node) {
    for (auto &v : node.getVardefs()) {
        v->accept(*this);
    }
}

// VarDecl: 'a' const int32[1][2]
void IRGenerator::visit(VarDef &node) {
    IR::IRBTYPE node_type = IR::IRBTYPE::UNDEFINED;
    switch (node.getType()) {
    case dtype::INT:
        node_type = IR::IRBTYPE::I32;
        break;
    case dtype::FLOAT:
        node_type = IR::IRBTYPE::FLOAT;
        break;
    default:
        Err::error("VarDef should always be int or float.");
        break;
    }

    std::shared_ptr<IR::Type> irtype;
    if (node.isArray()) {
        std::vector<int> array_sizes;

        for (auto &ss : node.getSubscripts()) {
            ss->accept(*this);
            auto ci = std::dynamic_pointer_cast<IR::ConstantInt>(curr_val);
            Err::gassert(ci != nullptr,
                         "Array dimensions should be constant integers.");
            array_sizes.emplace_back(ci->getVal());
        }

        irtype = makeBType(node_type);
        for (auto rit = array_sizes.rbegin(); rit != array_sizes.rend(); ++rit)
            irtype = makeArrayType(irtype, *rit);
    } else
        irtype = makeBType(node_type);

    curr_initializer.reset(node_type);
    curr_making_initializer = &curr_initializer;

    // Pure Constant Variable
    // check if the given variable is usable in constant expression
    if (node.isConst() && !node.isArray()) {
        Err::gassert(node.isInited());
        node.getInitVal()->accept(*this);
        auto flatten_initializer = curr_initializer.flatten(irtype);
        Err::gassert(flatten_initializer.size() == 1);
        const auto &cv = flatten_initializer[0];
        if (cv.index() != 2) {
            std::shared_ptr<IR::Value> val;
            if (cv.index() == 0)
                val = module.getConstantPool().getConst(std::get<0>(cv));
            if (cv.index() == 1)
                val = module.getConstantPool().getConst(std::get<1>(cv));
            symbol_table.insert(node.getId(), val);
            return;
        }
    }

    if (curr_func != nullptr) // Check if global
    {
        auto alloca_inst =
            std::make_shared<IR::ALLOCAInst>(irval_temp_name, irtype);
        curr_func->addInst(alloca_inst); // CURR_FUNC

        curr_initializer.reset(node_type);
        curr_making_initializer = &curr_initializer;

        if (node.isInited()) {
            node.getInitVal()->accept(*this);

            auto toIRValue =
                [this](
                    const Initializer::val_t &a) -> std::shared_ptr<IR::Value> {
                if (a.index() == 0)
                    return module.getConstantPool().getConst(std::get<0>(a));
                if (a.index() == 1)
                    return module.getConstantPool().getConst(std::get<1>(a));
                if (a.index() == 2)
                    return std::get<2>(a);
                return nullptr;
            };

            if (node.isArray()) {
                auto curr_type = toArrayType(irtype);

                bool has_filled_zero = false;
                // If it is zero inited or exceeds the threshold, memset it.
                if (curr_initializer.isZeroIniter() ||
                    curr_type->getBytes() >
                        Config::IR::LOCAL_ARRAY_MEMSET_THRESHOLD) {
                    auto builtin_memset =
                        symbol_table.lookup(Config::IR::BUILTIN_MEMSET);
                    auto dest =
                        type_cast(alloca_inst,
                                  makePtrType(IR::makeBType(IR::IRBTYPE::I8)));
                    auto call_memset = std::make_shared<IR::CALLInst>(
                        std::dynamic_pointer_cast<IR::FunctionDecl>(
                            builtin_memset),
                        std::vector<std::shared_ptr<IR::Value>>{
                            dest, // ptr
                            module.getConstantPool().getConst(
                                static_cast<char>(0)), // val
                            module.getConstantPool().getConst(static_cast<int>(
                                curr_type->getBytes())), // length
                            module.getConstantPool().getConst(
                                false)}); // volatile
                    curr_insts.emplace_back(call_memset);
                    has_filled_zero = true;
                }

                if (!curr_initializer.isZeroIniter() || !has_filled_zero) {
                    auto flat = curr_initializer.flatten(irtype);
                    Err::gassert(flat.size() == irtype->getBytes() /
                                                    IR::getBytes(node_type),
                                 "Invalid initializer.");

                    size_t init_pos = 0;
                    std::function<void(const std::shared_ptr<IR::Type> &type,
                                       const std::shared_ptr<IR::Value> &base)>
                        init_array;
                    init_array = [this, &toIRValue, &flat, &init_pos,
                                  &init_array, &node_type, &has_filled_zero](
                                     const std::shared_ptr<IR::Type> &type,
                                     const std::shared_ptr<IR::Value> &base) {
                        auto arrtype = toArrayType(type);
                        Err::gassert(arrtype != nullptr);
                        if (arrtype->getElmType()->getTrait() ==
                            IR::IRCTYPE::ARRAY) {
                            auto elmarr_type =
                                IR::toArrayType(arrtype->getElmType());
                            for (size_t i = 0; i < arrtype->getArraySize();
                                 ++i) {
                                bool needs_init = !has_filled_zero;

                                size_t j = init_pos;
                                for (;
                                     !needs_init &&
                                     j < init_pos + elmarr_type->getBytes() /
                                                        IR::getBytes(node_type);
                                     j++) {
                                    if (flat[j] !=
                                        curr_initializer.getZeroValue()) {
                                        needs_init = true;
                                        break;
                                    }
                                }

                                if (!needs_init)
                                    init_pos = j;
                                else {
                                    auto gep_inst =
                                        std::make_shared<IR::GEPInst>(
                                            irval_temp_name, base,
                                            module.getConstantPool().getConst(
                                                0),
                                            module.getConstantPool().getConst(
                                                static_cast<int>(i)));

                                    curr_insts.emplace_back(gep_inst);
                                    init_array(elmarr_type, gep_inst);
                                }
                            }
                        } else if (arrtype->getElmType()->getTrait() ==
                                   IR::IRCTYPE::BASIC) {
                            for (size_t i = 0; i < arrtype->getArraySize();
                                 ++i) {
                                const auto &curr_init_val = flat[init_pos++];
                                if (!has_filled_zero ||
                                    curr_init_val !=
                                        curr_initializer.getZeroValue()) {
                                    auto gep_inst =
                                        std::make_shared<IR::GEPInst>(
                                            irval_temp_name, base,
                                            module.getConstantPool().getConst(
                                                0),
                                            module.getConstantPool().getConst(
                                                static_cast<int>(i)));

                                    auto str_inst =
                                        std::make_shared<IR::STOREInst>(
                                            toIRValue(curr_init_val), gep_inst);
                                    curr_insts.emplace_back(gep_inst);
                                    curr_insts.emplace_back(str_inst);
                                }
                            }
                        } else
                            Err::unreachable();
                    };
                    init_array(irtype, alloca_inst);
                }
            } else {
                auto flat = curr_initializer.flatten(irtype);
                Err::gassert(flat.size() == 1, "Invalid initializer.");

                auto str_inst = std::make_shared<IR::STOREInst>(
                    toIRValue(flat[0]), alloca_inst);
                curr_insts.emplace_back(str_inst);
            }
        }
        symbol_table.insert(node.getId(), alloca_inst);
    } else {
        curr_initializer.reset(node_type);
        curr_making_initializer = &curr_initializer;
        auto gviniter = IR::GVIniter(irtype);
        if (node.isInited()) {
            node.getInitVal()->accept(*this);
            if (!curr_initializer.isZeroIniter()) {
                auto flatten_initializer = curr_initializer.flatten(irtype);
                Err::gassert(flatten_initializer.size() ==
                                 irtype->getBytes() / IR::getBytes(node_type),
                             "Invalid initializer.");

                auto toIRValue = [this](const Initializer::val_t &a)
                    -> std::shared_ptr<IR::Value> {
                    if (a.index() == 0)
                        return module.getConstantPool().getConst(
                            std::get<0>(a));
                    if (a.index() == 1)
                        return module.getConstantPool().getConst(
                            std::get<1>(a));
                    Err::error("Invalid global initializer.");
                    return nullptr;
                };

                if (node.isArray()) {
                    auto curr_type = toArrayType(irtype);
                    size_t init_pos = 0;
                    std::function<void(const std::shared_ptr<IR::Type> &type,
                                       IR::GVIniter &base)>
                        init_array;
                    init_array = [this, &toIRValue, &flatten_initializer,
                                  &init_pos, &init_array](
                                     const std::shared_ptr<IR::Type> &type,
                                     IR::GVIniter &base) {
                        auto arrtype = toArrayType(type);
                        Err::gassert(arrtype != nullptr);
                        if (arrtype->getElmType()->getTrait() ==
                            IR::IRCTYPE::ARRAY) {
                            for (size_t i = 0; i < arrtype->getArraySize();
                                 ++i) {
                                auto &next =
                                    base.addIniter(arrtype->getElmType());
                                init_array(arrtype->getElmType(), next);
                            }
                        } else if (arrtype->getElmType()->getTrait() ==
                                   IR::IRCTYPE::BASIC) {
                            for (size_t i = 0; i < arrtype->getArraySize(); ++i)
                                base.addIniter(
                                    arrtype->getElmType(),
                                    toIRValue(flatten_initializer[init_pos++]));
                        } else
                            Err::unreachable();
                    };
                    init_array(irtype, gviniter);
                    gviniter.normalizeZero();
                } else {
                    gviniter =
                        IR::GVIniter(irtype, toIRValue(flatten_initializer[0]));
                }
            }
        }

        auto gv = std::make_shared<IR::GlobalVariable>(
            node.isConst() ? IR::STOCLASS::CONSTANT : IR::STOCLASS::GLOBAL,
            irtype, "@" + node.getId(), gviniter);
        module.addGlobalVar(gv);
        symbol_table.insert(node.getId(), gv);
    }
}

void IRGenerator::visit(InitVal &node) {
    if (node.isList()) {
        if (curr_initializer.empty())
            curr_making_initializer = curr_initializer.makeList();
        else
            curr_making_initializer = curr_making_initializer->addList();

        for (auto &iv : node.getInner()) {
            iv->accept(*this);
        }
        curr_making_initializer = curr_making_initializer->parent;
    } else {
        node.getExp()->accept(*this);
        if (curr_initializer
                .empty()) // TOP LEVEL and is value, then the whole is a value
        {
            curr_val = type_cast(curr_val, curr_initializer.base_type);
            if (auto ci = std::dynamic_pointer_cast<IR::ConstantInt>(curr_val))
                curr_initializer.setVal(ci->getVal());
            else if (auto cf =
                         std::dynamic_pointer_cast<IR::ConstantFloat>(curr_val))
                curr_initializer.setVal(cf->getVal());
            else
                curr_initializer.setVal(curr_val);
        } else // Not TOP LEVEL
        {
            curr_val = type_cast(curr_val, curr_making_initializer->base_type);
            if (auto ci = std::dynamic_pointer_cast<IR::ConstantInt>(curr_val))
                curr_making_initializer->add(ci->getVal());
            else if (auto cf =
                         std::dynamic_pointer_cast<IR::ConstantFloat>(curr_val))
                curr_making_initializer->add(cf->getVal());
            else
                curr_making_initializer->add(curr_val);
        }
    }
}

void IRGenerator::visit(ArraySubscript &node) { node.getExp()->accept(*this); }

// FunctionDef: 'func' int32
void IRGenerator::visit(FuncDef &node) {
    auto prev = symbol_table.lookup(node.getId());
    Err::gassert(prev == nullptr, "Invalid function id.");

    IR::IRBTYPE ty = IR::IRBTYPE::UNDEFINED;
    switch (node.getType()) {
    case dtype::INT:
        ty = IR::IRBTYPE::I32;
        break;
    case dtype::FLOAT:
        ty = IR::IRBTYPE::FLOAT;
        break;
    case dtype::VOID:
        ty = IR::IRBTYPE::VOID;
        break;
    default:
        Err::error("Invalid function return type.");
        break;
    }

    curr_func = nullptr;

    std::vector<std::shared_ptr<IR::FormalParam>> params;
    std::vector<std::string> param_ids;

    if (!node.isEmptyParam()) {
        const auto &ast_params = node.getParams();
        for (size_t i = 0; i < ast_params.size(); ++i) {
            ast_params[i]->accept(*this);
            param_ids.emplace_back(ast_params[i]->getId());
            auto f = std::dynamic_pointer_cast<IR::FormalParam>(curr_val);
            Err::gassert(f != nullptr, "Invalid formal param.");
            f->setIndex(i);
            params.emplace_back(f);
        }
    }

    curr_func = std::make_shared<IR::LinearFunction>("@" + node.getId(), params,
                                                     IR::makeBType(ty),
                                                     &module.getConstantPool());
    module.addFunction(curr_func);
    symbol_table.insert(node.getId(), curr_func);

    symbol_table.initScope();

    for (size_t i = 0; i < param_ids.size(); ++i) {
        auto alloca = std::make_shared<IR::ALLOCAInst>(irval_temp_name,
                                                       params[i]->getType());
        auto str = std::make_shared<IR::STOREInst>(params[i], alloca);

        curr_func->addInst(alloca); // CURR_FUNC
        curr_insts.emplace_back(str);
        // We need to look up `param_ids` to get real id.
        symbol_table.insert(param_ids[i], alloca);
    }

    node.getBody()->accept(*this);
    symbol_table.finishScope();

    // See Main function: https://en.cppreference.com/w/c/language/main_function
    // If the return type is compatible with int and control reaches the
    // terminating }, the value returned to the environment is the same as if
    // executing return 0;.
    auto ret_type =
        IR::toBType(IR::toFunctionType(curr_func->getType())->getRet())
            ->getInner();
    if (node.getId() == "main") {
        Err::gassert(ret_type == IR::IRBTYPE::I32, "Invalid main.");
        if (curr_insts.empty() || curr_insts.back()->getOpcode() != IR::OP::RET)
            curr_insts.emplace_back(std::make_shared<IR::RETInst>(
                module.getConstantPool().getConst(0)));
    } else if (curr_insts.empty() ||
               curr_insts.back()->getOpcode() != IR::OP::RET) {
        if (ret_type == IR::IRBTYPE::VOID)
            curr_insts.emplace_back(std::make_shared<IR::RETInst>());
        else {
            Logger::logDebug(
                "Warning: control reaches end of non-void function.");
            if (ret_type == IR::IRBTYPE::I32)
                curr_insts.emplace_back(std::make_shared<IR::RETInst>(
                    module.getConstantPool().getConst(0)));
            else if (ret_type == IR::IRBTYPE::FLOAT)
                curr_insts.emplace_back(std::make_shared<IR::RETInst>(
                    module.getConstantPool().getConst(0.0f)));
        }
    }

    curr_func->appendInsts(std::move(curr_insts));
    curr_insts.clear();
    curr_func = nullptr;
}

// FuncFParam: 'a' int32[][2] \n
void IRGenerator::visit(FuncFParam &node) {
    IR::IRBTYPE node_type = IR::IRBTYPE::UNDEFINED;
    switch (node.getType()) {
    case dtype::INT:
        node_type = IR::IRBTYPE::I32;
        break;
    case dtype::FLOAT:
        node_type = IR::IRBTYPE::FLOAT;
        break;
    default:
        Err::error(
            "Function parameters' base type should always be int or float.");
        break;
    }

    std::shared_ptr<IR::Type> ir_type;
    if (node.isArray()) {
        if (node.isOneDim()) {
            Err::gassert(node.getSubscripts().empty());
            ir_type = makePtrType(makeBType(node_type));
        } else {
            std::vector<int> array_sizes;

            for (const auto &ss : node.getSubscripts()) {
                ss->accept(*this);
                auto ci = std::dynamic_pointer_cast<IR::ConstantInt>(curr_val);
                Err::gassert(ci != nullptr,
                             "Array dimensions should be constant integers.");
                array_sizes.emplace_back(ci->getVal());
            }

            ir_type = makeBType(node_type);
            for (auto rit = array_sizes.rbegin(); rit < array_sizes.rend();
                 ++rit)
                ir_type = makeArrayType(ir_type, *rit);
            ir_type = makePtrType(ir_type);
        }
    } else {
        ir_type = IR::makeBType(node_type);
    }

    // The index should be overwritten by Function's visitor.
    curr_val = std::make_shared<IR::FormalParam>(irval_temp_name, ir_type, 0);
}

// The following two functions (DeclRef and ArrayExp) is handling LVal.
//
// Given that most time we are using the LVal's value, rather than its address,
// (except assign (only?)) we add a load inst (if possible and not
// `is_making_lval`) afterward. That means we are trying to make the `curr_val`
// a Basic Type if possible.
//
// This could simplify many insts that need a value, not its address, like
// binary inst, call inst,  ... And we don't need to add load insts everywhere.
// But this could also introduce bugs for Lval, when the context needs a ptr,
// rather than Basic Type. So we use `is_making_lval` explicitly to handle such
// situation, where we don't add load inst so that guarantees `curr_val` is a
// ptr.
//
// It's a bit quick and dirty. Maybe we should make it more sensible in the
// future. It seems that we can add some helper functions like cast_to_type to
// add load inst.

// DeclRefExp: 'a' \n
//
// From node's name to curr_val's alloca/load
//
// curr_val = is_making_lval (which guarantees a ptr) -> alloca
// Array -> alloca
// Basic -> alloca -> load
void IRGenerator::visit(DeclRef &node) {
    auto ref = symbol_table.lookup(node.getId());
    Err::gassert(ref != nullptr,
                 "Invalid reference to '" + node.getId() + "', not found.");

    if (curr_func == nullptr) {
        Err::gassert(ref->getVTrait() == IR::ValueTrait::CONSTANT_LITERAL,
                     "Global initializer must be a compile-time constant");
    }

    // TODO: Prevent potential bugs
    if (auto alloca_inst = std::dynamic_pointer_cast<IR::ALLOCAInst>(ref)) {
        if (is_making_lval || alloca_inst->isArray()) {
            curr_val = alloca_inst;
        } else {
            auto load =
                std::make_shared<IR::LOADInst>(irval_temp_name, alloca_inst);
            curr_insts.emplace_back(load);
            curr_val = load;
        }
    } else if (auto gv = std::dynamic_pointer_cast<IR::GlobalVariable>(ref)) {
        if (is_making_lval || gv->isArray()) {
            curr_val = gv;
        } else {
            auto load = std::make_shared<IR::LOADInst>(irval_temp_name, gv);
            curr_insts.emplace_back(load);
            curr_val = load;
        }
    } else
        curr_val = ref;
}

// a[2][1]
// ArrayExp: 'a' [2][1]
//
// From curr_val's Array ptr to curr_val's gep/load
// (e.g. curr_val: [2 x i32]* -> gep)
//
// curr_val =
// is_making_lval (which guarantees a ptr) -> ... -> gep
// result type is Array -> ... -> gep
// result type is Basic Type -> ... -> gep -> load
//
// Note that if the given ptr is from a load inst, which is always a function
// parameter (decays from array), we first gep the first index for the given
// ptr, and the remaining indices is handled by numerous small gep, which
// handles one index with its two gep indices a time.
void IRGenerator::visit(ArrayExp &node) {
    // Because the Array id and the ArraySubscripts may contain DeclRef or
    // ArrayExp, and they should not be treated as lval. So we temporarily turn
    // off `is_making_lval`.
    bool is_making_lvalbak = is_making_lval;
    is_making_lval = false;

    node.getRef()->accept(*this);
    auto base = curr_val;
    Err::gassert(base->getType()->getTrait() == IR::IRCTYPE::PTR,
                 "Not an array.");

    std::vector<std::shared_ptr<IR::Value>> indices;
    for (const auto &ss : node.getIndices()) {
        ss->accept(*this);
        auto idxty = toBType(curr_val->getType());
        Err::gassert(idxty != nullptr && idxty->getInner() == IR::IRBTYPE::I32,
                     "Array subscripts must be integers.");
        indices.emplace_back(curr_val);
    }

    is_making_lval = is_making_lvalbak;

    std::shared_ptr<IR::Value> curr_gep = base;
    size_t i = 0;

    // TODO: More sensible
    // LOAD from Function Parameters
    if (auto load_inst = std::dynamic_pointer_cast<IR::LOADInst>(base)) {
        curr_gep =
            std::make_shared<IR::GEPInst>(irval_temp_name, base, indices[0]);
        curr_insts.emplace_back(
            std::dynamic_pointer_cast<IR::Instruction>(curr_gep));
        ++i;
    }

    for (; i < indices.size(); i++) {
        Err::gassert(
            getElm(curr_gep->getType())->getTrait() == IR::IRCTYPE::ARRAY ||
                getElm(curr_gep->getType())->getTrait() == IR::IRCTYPE::PTR,
            "Invalid array index.");
        curr_gep = std::make_shared<IR::GEPInst>(
            irval_temp_name, curr_gep, module.getConstantPool().getConst(0),
            indices[i]);
        curr_insts.emplace_back(
            std::dynamic_pointer_cast<IR::Instruction>(curr_gep));
    }

    if (!is_making_lval &&
        IR::getElm(curr_gep->getType())->getTrait() == IR::IRCTYPE::BASIC) {
        auto load_inst =
            std::make_shared<IR::LOADInst>(irval_temp_name, curr_gep);
        curr_insts.emplace_back(load_inst);
        curr_val = load_inst;
    } else {
        curr_val = curr_gep;
    }
}

// a(1, 2, 3)
// CallExp: 'a' (1, 2, 3, )
void IRGenerator::visit(CallExp &node) {
    node.getRef()->accept(*this);

    auto func = std::dynamic_pointer_cast<IR::FunctionDecl>(curr_val);
    Err::gassert(func != nullptr, "Invalid to call '" + node.getId() +
                                      "', which is not a function.");

    std::vector<std::shared_ptr<IR::Value>> args;
    if (!node.isEmptyParam()) {
        for (auto &p : node.getParams()) {
            p->accept(*this);
            args.emplace_back(curr_val);
        }
    }

    auto functy = IR::toFunctionType(func->getType());
    auto expected = functy->getParams();

    if (functy->isVAArg()) {
        if (expected.size() > args.size())
            Err::error("Invalid call.");
    } else {
        if (expected.size() != args.size())
            Err::error("Invalid call.");
    }

    for (size_t i = 0; i < expected.size(); ++i)
        args[i] = type_cast(args[i], expected[i]);

    std::shared_ptr<IR::CALLInst> call;
    if (IR::toBType(functy->getRet())->getInner() == IR::IRBTYPE::VOID)
        call = std::make_shared<IR::CALLInst>(func, args);
    else
        call = std::make_shared<IR::CALLInst>(irval_temp_name, func, args);

    curr_insts.emplace_back(call);
    curr_val = call;
}

void IRGenerator::visit(FuncRParam &node) { node.getExp()->accept(*this); }

template <typename Base, typename T>
auto constant_binary(const std::shared_ptr<IR::Value> &lhs,
                     const std::shared_ptr<IR::Value> &rhs, T &&operation) {
    Err::gassert(IR::isSameType(lhs->getType(), rhs->getType()) &&
                 lhs->getType()->getTrait() == IR::IRCTYPE::BASIC);

    auto lhs_val = std::dynamic_pointer_cast<IR::getIRConstantType<Base>>(lhs);
    auto rhs_val = std::dynamic_pointer_cast<IR::getIRConstantType<Base>>(rhs);
    Err::gassert(lhs_val != nullptr && rhs_val != nullptr);
    return operation(lhs_val->getVal(), rhs_val->getVal());
}

void IRGenerator::visit(BinaryOp &node) {
    // Logical -> I1
    if (node.getOp() == BiOp::AND || node.getOp() == BiOp::OR) {
        node.getLHS()->accept(*this);
        auto lhs = curr_val;
        lhs = type_cast(lhs, IR::IRBTYPE::I1);

        std::vector<std::shared_ptr<IR::Instruction>> rhs_insts;
        std::swap(rhs_insts, curr_insts);

        node.getRHS()->accept(*this);
        auto rhs = curr_val;
        rhs = type_cast(
            rhs, IR::IRBTYPE::I1); // rhs's TYPECAST should also in rhs_insts

        std::swap(rhs_insts, curr_insts);

        bool is_constant =
            lhs->getVTrait() == IR::ValueTrait::CONSTANT_LITERAL &&
            rhs->getVTrait() == IR::ValueTrait::CONSTANT_LITERAL &&
            rhs_insts.empty();

        switch (node.getOp()) {
        case BiOp::AND:
            if (is_constant)
                curr_val =
                    module.getConstantPool().getConst(constant_binary<bool>(
                        lhs, rhs, [](auto &&a, auto &&b) { return a && b; }));
            else
                curr_val = std::make_shared<IR::ANDValue>(lhs, rhs,
                                                          std::move(rhs_insts));
            break;
        case BiOp::OR:
            if (is_constant)
                curr_val =
                    module.getConstantPool().getConst(constant_binary<bool>(
                        lhs, rhs, [](auto &&a, auto &&b) { return a || b; }));
            else
                curr_val = std::make_shared<IR::ORValue>(lhs, rhs,
                                                         std::move(rhs_insts));
            break;
        default:
            Err::unreachable();
        }
        return;
    }

    if (node.getOp() == BiOp::ASSIGN) {
        is_making_lval = true;
        node.getLHS()->accept(*this);
        is_making_lval = false;
        auto lhs = curr_val;
        node.getRHS()->accept(*this);
        auto rhs = curr_val;

        auto rhstype = IR::toBType(rhs->getType());
        Err::gassert(rhstype != nullptr &&
                         (rhstype->getInner() == IR::IRBTYPE::I32 ||
                          rhstype->getInner() == IR::IRBTYPE::FLOAT),
                     "Invalid assign.");
        auto lhstype = IR::toPtrType(lhs->getType());
        Err::gassert(lhstype != nullptr, "Invalid assign, not lval.");
        auto lhselmty = IR::toBType(getElm(lhs->getType()))->getInner();
        Err::gassert(lhselmty == IR::IRBTYPE::I32 ||
                         lhselmty == IR::IRBTYPE::FLOAT,
                     "Invalid assign.");

        rhs = type_cast(rhs, lhselmty);

        curr_insts.emplace_back(std::make_shared<IR::STOREInst>(rhs, lhs));
        curr_val = lhs;
        return;
    }

    node.getLHS()->accept(*this);
    auto lhs = curr_val;
    node.getRHS()->accept(*this);
    auto rhs = curr_val;

    std::shared_ptr<IR::BType> oprtype;
    // Type check and cast
    {
        auto lhstype = IR::toBType(lhs->getType());
        auto rhstype = IR::toBType(rhs->getType());
        Err::gassert(lhstype != nullptr && rhstype != nullptr &&
                         (lhstype->getInner() == IR::IRBTYPE::I32 ||
                          lhstype->getInner() == IR::IRBTYPE::I1 ||
                          lhstype->getInner() == IR::IRBTYPE::FLOAT) &&
                         (rhstype->getInner() == IR::IRBTYPE::I32 ||
                          rhstype->getInner() == IR::IRBTYPE::I1 ||
                          rhstype->getInner() == IR::IRBTYPE::FLOAT),
                     "Binary operation must be integers or floats.");

        if (lhstype->getInner() == IR::IRBTYPE::FLOAT ||
            rhstype->getInner() == IR::IRBTYPE::FLOAT) {
            lhs = type_cast(lhs, IR::IRBTYPE::FLOAT);
            rhs = type_cast(rhs, IR::IRBTYPE::FLOAT);
            oprtype = IR::makeBType(IR::IRBTYPE::FLOAT);
        } else if (lhstype->getInner() == IR::IRBTYPE::I32 ||
                   rhstype->getInner() == IR::IRBTYPE::I32) {
            lhs = type_cast(lhs, IR::IRBTYPE::I32);
            rhs = type_cast(rhs, IR::IRBTYPE::I32);
            oprtype = IR::makeBType(IR::IRBTYPE::I32);
        } else if (lhstype->getInner() == IR::IRBTYPE::I1 &&
                   rhstype->getInner() == IR::IRBTYPE::I1)
            oprtype = IR::makeBType(IR::IRBTYPE::I1);
        else
            Err::unreachable("Invalid type.");
    }

    bool is_constant = lhs->getVTrait() == IR::ValueTrait::CONSTANT_LITERAL &&
                       rhs->getVTrait() == IR::ValueTrait::CONSTANT_LITERAL;

    // Arithmetic -> I32
    if (node.getOp() == BiOp::ADD || node.getOp() == BiOp::SUB ||
        node.getOp() == BiOp::MUL || node.getOp() == BiOp::DIV ||
        node.getOp() == BiOp::MOD) {
        Err::gassert(oprtype->getInner() == IR::IRBTYPE::I32 ||
                         oprtype->getInner() == IR::IRBTYPE::FLOAT,
                     "Invalid arithmetic operations");
        IR::OP op;

        // clang-format off
// @formatter:off
#define MAKE_OP(biop, iop, fop, cppop) \
        case biop: \
            if (oprtype->getInner() == IR::IRBTYPE::I32) \
            { \
                if (is_constant) \
                { \
                    curr_val = module.getConstantPool().getConst(constant_binary<int>(lhs, rhs, [](auto&& v1, auto&& v2) {return v1 cppop v2;})); \
                    return; \
                } \
                op = iop; \
            } \
            else \
            { \
                if (is_constant) \
                { \
                    curr_val = module.getConstantPool().getConst(constant_binary<float>(lhs, rhs, [](auto&& v1, auto&& v2) {return v1 cppop v2;})); \
                    return; \
                } \
                op = fop; \
            } \
        break; \
// @formatter:on                                                    \
        // clang-format on

        switch (node.getOp()) {
            MAKE_OP(BiOp::ADD, IR::OP::ADD, IR::OP::FADD, +)
            MAKE_OP(BiOp::SUB, IR::OP::SUB, IR::OP::FSUB, -)
            MAKE_OP(BiOp::MUL, IR::OP::MUL, IR::OP::FMUL, *)
            MAKE_OP(BiOp::DIV, IR::OP::DIV, IR::OP::FDIV, /)

        case BiOp::MOD:
            Err::gassert(oprtype->getInner() == IR::IRBTYPE::I32);
            if (is_constant) {
                curr_val = module.getConstantPool().getConst(
                    constant_binary<int>(lhs, rhs, [](auto &&v1, auto &&v2) {
                        return v1 % v2;
                    }));
                return;
            }
            op = IR::OP::REM;
            break;
        default:
            Err::unreachable();
        }

#undef MAKE_OP

        auto inst =
            std::make_shared<IR::BinaryInst>(irval_temp_name, op, lhs, rhs);
        curr_insts.emplace_back(inst);
        curr_val = inst;
        return;
    }

    // Compare -> I1
    if (node.getOp() == BiOp::LESSEQ || node.getOp() == BiOp::GREATEQ ||
        node.getOp() == BiOp::GREAT || node.getOp() == BiOp::LESS ||
        node.getOp() == BiOp::NOTEQ || node.getOp() == BiOp::EQ) {
        Err::gassert(oprtype->getInner() == IR::IRBTYPE::I32 ||
                         oprtype->getInner() == IR::IRBTYPE::I1 ||
                         oprtype->getInner() == IR::IRBTYPE::FLOAT,
                     "Invalid compare.");
        if (oprtype->getInner() == IR::IRBTYPE::I32) {
            IR::ICMPOP icmpop;

            // clang-format off
// @formatter:off
#define MAKE_OP(biop, iop, cppop) \
        case biop: \
            if (is_constant) \
            { \
                curr_val = module.getConstantPool().getConst(constant_binary<int>(lhs, rhs, [](auto&& v1, auto&& v2) {return v1 cppop v2;})); \
                return; \
            } \
            icmpop = iop; \
        break; \
// @formatter:on                                                \
        // clang-format on
            switch (node.getOp()) {
                MAKE_OP(BiOp::LESSEQ, IR::ICMPOP::sle, <=)
                MAKE_OP(BiOp::GREATEQ, IR::ICMPOP::sge, >=)
                MAKE_OP(BiOp::LESS, IR::ICMPOP::slt, <)
                MAKE_OP(BiOp::GREAT, IR::ICMPOP::sgt, >)
                MAKE_OP(BiOp::NOTEQ, IR::ICMPOP::ne, !=)
                MAKE_OP(BiOp::EQ, IR::ICMPOP::eq, ==)
            default:
                Err::unreachable();
            }
#undef MAKE_OP
            auto inst = std::make_shared<IR::ICMPInst>(irval_temp_name, icmpop,
                                                       lhs, rhs);
            curr_insts.emplace_back(inst);
            curr_val = inst;
        } else if (oprtype->getInner() == IR::IRBTYPE::FLOAT) {
            IR::FCMPOP fcmpop;
            // clang-format off
// @formatter:off
#define MAKE_OP(biop, fop, cppop) \
        case biop: \
            if (is_constant) \
            { \
                curr_val = module.getConstantPool().getConst(constant_binary<float>(lhs, rhs, [](auto&& v1, auto&& v2) {return v1 cppop v2;})); \
                return; \
            } \
            fcmpop = fop; \
        break;                                                \
        // clang-format on                                                     \
        // @formatter:on
            switch (node.getOp()) {
                MAKE_OP(BiOp::LESSEQ, IR::FCMPOP::ole, <=)
                MAKE_OP(BiOp::GREATEQ, IR::FCMPOP::oge, >=)
                MAKE_OP(BiOp::LESS, IR::FCMPOP::olt, <)
                MAKE_OP(BiOp::GREAT, IR::FCMPOP::ogt, >)
                MAKE_OP(BiOp::NOTEQ, IR::FCMPOP::one, !=)
                MAKE_OP(BiOp::EQ, IR::FCMPOP::oeq, ==)
            default:
                Err::unreachable();
            }
#undef MAKE_OP
            auto inst = std::make_shared<IR::FCMPInst>(irval_temp_name, fcmpop,
                                                       lhs, rhs);
            curr_insts.emplace_back(inst);
            curr_val = inst;
        } else
            Err::not_implemented("Unsupported compare operation.");
        return;
    }
}

void IRGenerator::visit(UnaryOp &node) {
    node.getExp()->accept(*this);

    auto opreandtype = IR::toBType(curr_val->getType());
    Err::gassert(opreandtype != nullptr &&
                     (opreandtype->getInner() == IR::IRBTYPE::I32 ||
                      opreandtype->getInner() == IR::IRBTYPE::I1 ||
                      opreandtype->getInner() == IR::IRBTYPE::FLOAT),
                 "Unary operation be performed on integer or float.");
    switch (node.getOp()) {
    case UnOp::ADD:
        break;
    case UnOp::SUB:
        if (opreandtype->getInner() == IR::IRBTYPE::I32) {
            if (auto ci = std::dynamic_pointer_cast<IR::ConstantInt>(curr_val))
                curr_val = module.getConstantPool().getConst(-ci->getVal());
            else {
                auto neg = std::make_shared<IR::BinaryInst>(
                    irval_temp_name, IR::OP::SUB,
                    module.getConstantPool().getConst(0), curr_val);
                curr_insts.emplace_back(neg);
                curr_val = neg;
            }
        } else if (opreandtype->getInner() == IR::IRBTYPE::FLOAT) {
            if (auto cf =
                    std::dynamic_pointer_cast<IR::ConstantFloat>(curr_val))
                curr_val = module.getConstantPool().getConst(-cf->getVal());
            else {
                auto neg =
                    std::make_shared<IR::FNEGInst>(irval_temp_name, curr_val);
                curr_insts.emplace_back(neg);
                curr_val = neg;
            }
        } else if (opreandtype->getInner() == IR::IRBTYPE::I1) {
            if (auto ci1 = std::dynamic_pointer_cast<IR::ConstantI1>(curr_val))
                curr_val = module.getConstantPool().getConst(
                    -static_cast<int>(ci1->getVal()));
            else {
                curr_val = type_cast(curr_val, IR::IRBTYPE::I32);
                auto neg = std::make_shared<IR::BinaryInst>(
                    irval_temp_name, IR::OP::SUB,
                    module.getConstantPool().getConst(0), curr_val);
                curr_insts.emplace_back(neg);
                curr_val = neg;
            }
            break;
        } else
            Err::not_implemented("SUB on unsupported type.");
        break;
    case UnOp::NOT:
        curr_val = type_cast(curr_val, IR::IRBTYPE::I1);
        if (auto ci1 = std::dynamic_pointer_cast<IR::ConstantI1>(curr_val))
            curr_val = module.getConstantPool().getConst(!ci1->getVal());
        else if (auto icmp = std::dynamic_pointer_cast<IR::ICMPInst>(curr_val))
            icmp->condFlip();
        else if (auto fcmp = std::dynamic_pointer_cast<IR::FCMPInst>(curr_val))
            fcmp->condFlip();
        else
            Err::not_implemented("NOT on unsupported type.");
        break;
    }
}

void IRGenerator::visit(ParenExp &node) { node.getExp()->accept(*this); }

void IRGenerator::visit(IntLiteral &node) {
    curr_val = module.getConstantPool().getConst(node.getValue());
}

void IRGenerator::visit(FloatLiteral &node) {
    curr_val = module.getConstantPool().getConst(node.getValue());
}

void IRGenerator::visit(CompStmt &node) {
    symbol_table.initScope();

    for (auto &item : node.getItems()) {
        item->accept(*this);
    }

    symbol_table.finishScope();
}

void IRGenerator::visit(IfStmt &node) {
    node.getCond()->accept(*this);
    auto cond = curr_val;
    cond = type_cast(cond, IR::IRBTYPE::I1);

    std::vector<std::shared_ptr<IR::Instruction>> before_if_insts;
    std::vector<std::shared_ptr<IR::Instruction>> body_insts;
    std::vector<std::shared_ptr<IR::Instruction>> else_insts;

    std::swap(before_if_insts, curr_insts);

    node.getBody()->accept(*this);
    std::swap(body_insts, curr_insts);

    if (node.hasElse()) {
        node.getElseBody()->accept(*this);
        std::swap(else_insts, curr_insts);
    }

    auto if_inst = std::make_shared<IR::IFInst>(
        std::move(cond), std::move(body_insts), std::move(else_insts));
    std::swap(before_if_insts, curr_insts);
    curr_insts.emplace_back(if_inst);
}

void IRGenerator::visit(WhileStmt &node) {
    std::vector<std::shared_ptr<IR::Instruction>> before_while_insts;
    std::vector<std::shared_ptr<IR::Instruction>> cond_insts;
    std::vector<std::shared_ptr<IR::Instruction>> body_insts;

    std::swap(before_while_insts, curr_insts);

    node.getCond()->accept(*this);
    auto cond = curr_val;
    cond = type_cast(cond, IR::IRBTYPE::I1);

    std::swap(cond_insts, curr_insts);
    node.getBody()->accept(*this);
    std::swap(body_insts, curr_insts);

    auto while_inst = std::make_shared<IR::WHILEInst>(
        std::move(cond), std::move(cond_insts), std::move(body_insts));

    std::swap(before_while_insts, curr_insts);
    curr_insts.emplace_back(while_inst);
}

void IRGenerator::visit(NullStmt &node) {}

void IRGenerator::visit(BreakStmt &node) {
    curr_insts.emplace_back(std::make_shared<IR::BREAKInst>());
}

void IRGenerator::visit(ContinueStmt &node) {
    curr_insts.emplace_back(std::make_shared<IR::CONTINUEInst>());
}

void IRGenerator::visit(ReturnStmt &node) {
    auto expected =
        IR::toBType(IR::toFunctionType(curr_func->getType())->getRet())
            ->getInner();
    if (!node.isVoid()) {
        node.getReturnVal()->accept(*this);
        auto ret = type_cast(curr_val, expected);
        curr_insts.emplace_back(std::make_shared<IR::RETInst>(ret));
    } else {
        Err::gassert(expected == IR::IRBTYPE::VOID, "Invalid return.");
        curr_insts.emplace_back(std::make_shared<IR::RETInst>());
    }
}

std::shared_ptr<IR::Value>
IRGenerator::type_cast(const std::shared_ptr<IR::Value> &val,
                       const std::shared_ptr<IR::Type> &dest) {
    if (isSameType(dest, val->getType()))
        return val;

    if (dest->getTrait() == IR::IRCTYPE::BASIC)
        return type_cast(val, IR::toBType(dest)->getInner());

    if (dest->getTrait() == IR::IRCTYPE::PTR &&
        val->getType()->getTrait() == IR::IRCTYPE::PTR) {
        // decay
        if (getElm(val->getType())->getTrait() == IR::IRCTYPE::ARRAY &&
            IR::isSameType(getElm(getElm(val->getType())), IR::getElm(dest))) {
            auto gep = std::make_shared<IR::GEPInst>(
                irval_temp_name, val, module.getConstantPool().getConst(0),
                module.getConstantPool().getConst(0));
            Err::gassert(curr_func != nullptr,
                         "Invalid implicit type conversion in global.");
            curr_insts.emplace_back(gep);
            return gep;
        } else {
            auto bitcast =
                std::make_shared<IR::BITCASTInst>(irval_temp_name, val, dest);
            Err::gassert(curr_func != nullptr,
                         "Invalid implicit type conversion in global.");
            curr_insts.emplace_back(bitcast);
            return bitcast;
        }
    }

    Err::unreachable("Cannot cast type from '" + val->getType()->toString() +
                     "' to '" + dest->toString() + "'.");
    return nullptr;
}

// I32 <-> FLOAT
// I32 <-> I1
// FLOAT <-> I1
std::shared_ptr<IR::Value>
IRGenerator::type_cast(const std::shared_ptr<IR::Value> &val,
                       IR::IRBTYPE dest) {
    const std::string bad_cast_err = "Cannot cast type from '" +
                                     val->getType()->toString() + "' to '" +
                                     IR::makeBType(dest)->toString() + "'.";

    Err::gassert(val->getType()->getTrait() == IR::IRCTYPE::BASIC,
                 bad_cast_err);
    IR::IRBTYPE src = toBType(val->getType())->getInner();
    if (src == IR::IRBTYPE::I32 && dest == IR::IRBTYPE::FLOAT) {
        if (auto ci = std::dynamic_pointer_cast<IR::ConstantInt>(val))
            return module.getConstantPool().getConst(
                static_cast<float>(ci->getVal()));

        Err::gassert(curr_func != nullptr,
                     "Invalid implicit type conversion in global.");
        auto conv = std::make_shared<IR::SITOFPInst>(irval_temp_name, val);
        curr_insts.emplace_back(conv);
        return conv;
    } else if (src == IR::IRBTYPE::FLOAT && dest == IR::IRBTYPE::I32) {
        if (auto cf = std::dynamic_pointer_cast<IR::ConstantFloat>(val))
            return module.getConstantPool().getConst(
                static_cast<int>(cf->getVal()));

        Err::gassert(curr_func != nullptr,
                     "Invalid implicit type conversion in global.");
        auto conv = std::make_shared<IR::FPTOSIInst>(irval_temp_name, val);
        curr_insts.emplace_back(conv);
        return conv;
    } else if (src == IR::IRBTYPE::I32 && dest == IR::IRBTYPE::I1) {
        if (auto ci = std::dynamic_pointer_cast<IR::ConstantInt>(val))
            return module.getConstantPool().getConst(
                static_cast<bool>(ci->getVal()));

        Err::gassert(curr_func != nullptr,
                     "Invalid implicit type conversion in global.");
        auto conv = std::make_shared<IR::ICMPInst>(
            irval_temp_name, IR::ICMPOP::ne, val,
            module.getConstantPool().getConst(0));
        curr_insts.emplace_back(conv);
        return conv;
    } else if (src == IR::IRBTYPE::I1 && dest == IR::IRBTYPE::I32) {
        if (auto ci1 = std::dynamic_pointer_cast<IR::ConstantI1>(val))
            return module.getConstantPool().getConst(
                static_cast<int>(ci1->getVal()));

        Err::gassert(curr_func != nullptr,
                     "Invalid implicit type conversion in global.");
        auto conv = std::make_shared<IR::ZEXTInst>(irval_temp_name, val,
                                                   IR::IRBTYPE::I32);
        curr_insts.emplace_back(conv);
        return conv;
    } else if (src == IR::IRBTYPE::FLOAT && dest == IR::IRBTYPE::I1) {
        if (auto cf = std::dynamic_pointer_cast<IR::ConstantFloat>(val))
            return module.getConstantPool().getConst(
                static_cast<bool>(cf->getVal()));

        Err::gassert(curr_func != nullptr,
                     "Invalid implicit type conversion in global.");
        auto conv = std::make_shared<IR::FCMPInst>(
            irval_temp_name, IR::FCMPOP::one, val,
            module.getConstantPool().getConst(0.0f));
        curr_insts.emplace_back(conv);
        return conv;
    } else if (src == IR::IRBTYPE::I1 && dest == IR::IRBTYPE::FLOAT) {
        if (auto ci1 = std::dynamic_pointer_cast<IR::ConstantI1>(val))
            return module.getConstantPool().getConst(
                static_cast<float>(ci1->getVal()));

        Err::gassert(curr_func != nullptr,
                     "Invalid implicit type conversion in global.");
        auto conv2i32 = std::make_shared<IR::ZEXTInst>(irval_temp_name, val,
                                                       IR::IRBTYPE::I32);
        auto conv2f32 =
            std::make_shared<IR::SITOFPInst>(irval_temp_name, conv2i32);
        curr_insts.emplace_back(conv2i32);
        curr_insts.emplace_back(conv2f32);
        return conv2f32;
    }
    Err::gassert(src == dest, bad_cast_err);
    return val;
}

IRGenerator::Initializer::Initializer()
    : initializer(std::monostate{}), parent(nullptr),
      base_type(IR::IRBTYPE::UNDEFINED) {}
IRGenerator::Initializer::Initializer(Initializer *parent_, IR::IRBTYPE btype)
    : initializer(std::monostate{}), parent(parent_), base_type(btype) {}
IRGenerator::Initializer::Initializer(int a, Initializer *parent_)
    : base_type(IR::IRBTYPE::I32), initializer(val_t{a}), parent(parent_) {}
IRGenerator::Initializer::Initializer(float a, Initializer *parent_)
    : base_type(IR::IRBTYPE::FLOAT), initializer(val_t{a}), parent(parent_) {}
IRGenerator::Initializer::Initializer(std::shared_ptr<IR::Value> a,
                                      Initializer *parent_)
    : initializer(val_t{a}), parent(parent_) {
    auto bt = IR::toBType(a->getType());
    Err::gassert(bt != nullptr && (bt->getInner() == IR::IRBTYPE::I32 ||
                                   bt->getInner() == IR::IRBTYPE::FLOAT),
                 "Invalid initializer");
    base_type = bt->getInner();
}

bool IRGenerator::Initializer::isList() const {
    return initializer.index() == 1;
}

bool IRGenerator::Initializer::isVal() const {
    return initializer.index() == 2;
}

IRGenerator::Initializer *IRGenerator::Initializer::addList() {
    Err::gassert(isList());
    std::get<list_t>(initializer).emplace_back(this, base_type);
    return std::get<list_t>(initializer).back().makeList();
}

IRGenerator::Initializer *IRGenerator::Initializer::makeList() {
    Err::gassert(empty());
    initializer.emplace<list_t>();
    return this;
}

bool IRGenerator::Initializer::empty() const {
    return initializer.index() == 0;
}

void IRGenerator::Initializer::reset(IR::IRBTYPE irbtype) {
    parent = nullptr;
    base_type = irbtype;
    initializer.emplace<std::monostate>();
}

// TODO: Use Optimize zero, avoid padding too much zero.
// See: https://en.cppreference.com/w/c/language/array_initialization
std::vector<IRGenerator::Initializer::val_t>
IRGenerator::Initializer::flatten(const std::shared_ptr<IR::Type> &type) const {
    Err::gassert(type != nullptr);

    if (empty() || (isList() && std::get<list_t>(initializer).empty())) {
        if (type->getTrait() == IR::IRCTYPE::BASIC) {
            auto bty = IR::toBType(type)->getInner();
            Err::gassert(bty == base_type);
            return {getZeroValue()};
        }
        if (type->getTrait() == IR::IRCTYPE::ARRAY) {
            auto arrty = std::dynamic_pointer_cast<IR::ArrayType>(type);
            return std::vector{arrty->getBytes() / getBytes(base_type),
                               getZeroValue()};
        }
        Err::unreachable();
    } else if (isVal()) {
        if (type->getTrait() == IR::IRCTYPE::BASIC)
            return {std::get<val_t>(initializer)};
        if (type->getTrait() == IR::IRCTYPE::ARRAY) {
            auto arrty = std::dynamic_pointer_cast<IR::ArrayType>(type);
            std::vector ret{arrty->getBytes() / getBytes(base_type),
                            getZeroValue()};
            ret[0] = std::get<val_t>(initializer);
            return ret;
        }
        Err::unreachable();
    } else if (isList()) {
        const auto &list = std::get<list_t>(initializer);
        Err::gassert(!list.empty());
        if (type->getTrait() == IR::IRCTYPE::BASIC)
            return list[0].flatten(type);
        if (type->getTrait() == IR::IRCTYPE::ARRAY) {
            size_t len = 0;
            auto arrty = std::dynamic_pointer_cast<IR::ArrayType>(type);
            auto elmty = IR::getElm(arrty);
            if (elmty->getTrait() == IR::IRCTYPE::BASIC) {
                std::vector<val_t> ret;
                for (auto &subiniter : list) {
                    auto tmp = subiniter.flatten(elmty);
                    ret.insert(ret.end(), std::make_move_iterator(tmp.begin()),
                               std::make_move_iterator(tmp.end()));
                    ++len;
                }
                for (size_t i = len; i < arrty->getArraySize(); ++i)
                    ret.emplace_back(getZeroValue());
                return ret;
            }
            if (elmty->getTrait() == IR::IRCTYPE::ARRAY) {
                std::vector<val_t> ret;
                for (auto curr_sub = list.begin(); curr_sub != list.end();
                     ++curr_sub) {
                    // If the nested initializer begins with an opening brace,
                    // the entire nested initializer up to its closing brace
                    // initializes the corresponding array element:
                    if (curr_sub->isList() || curr_sub->empty()) {
                        auto tmp = curr_sub->flatten(elmty);
                        ret.insert(ret.end(),
                                   std::make_move_iterator(tmp.begin()),
                                   std::make_move_iterator(tmp.end()));
                        ++len;
                    }
                    // If the nested initializer does not begin with an opening
                    // brace, only enough initializers from the list are taken
                    // to account for the elements or members of the sub-array,
                    // struct or union; any remaining initializers are left to
                    // initialize the next array element:
                    else if (curr_sub->isVal()) {
                        Initializer helper(nullptr, base_type);
                        helper.makeList();
                        for (size_t i = 0;
                             i < elmty->getBytes() / IR::getBytes(base_type);
                             ++i) {
                            std::get<list_t>(helper.initializer)
                                .emplace_back(*curr_sub);
                            ++curr_sub;
                            if (curr_sub == list.end())
                                break;
                        }
                        --curr_sub;
                        auto tmp = helper.flatten(elmty);
                        ret.insert(ret.end(),
                                   std::make_move_iterator(tmp.begin()),
                                   std::make_move_iterator(tmp.end()));
                        ++len;
                    }
                }

                for (size_t i = len; i < arrty->getArraySize(); ++i) {
                    Initializer helper(nullptr, base_type);
                    auto tmp = helper.flatten(elmty);
                    ret.insert(ret.end(), std::make_move_iterator(tmp.begin()),
                               std::make_move_iterator(tmp.end()));
                }
                return ret;
            }
            Err::unreachable();
        }
        Err::unreachable();
    }
    Err::unreachable();
    return {};
}

IRGenerator::Initializer::val_t IRGenerator::Initializer::getZeroValue() const {
    if (base_type == IR::IRBTYPE::I32)
        return {0};
    else
        return {0.0f};
}

bool IRGenerator::Initializer::isZeroIniter() const {
    if (empty())
        return true;
    if (isVal())
        return std::get<val_t>(initializer) == getZeroValue();
    if (isList()) {
        const auto &list = std::get<list_t>(initializer);
        return list.empty() ||
               std::all_of(list.cbegin(), list.cend(),
                           [](auto &&p) { return p.isZeroIniter(); });
    }
    Err::unreachable();
    return false;
}
} // namespace Parser
