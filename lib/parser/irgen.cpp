#include <functional>
#include <algorithm>

#include "../../include/ir/instructions/converse.hpp"
#include "../../include/ir/instructions/compare.hpp"
#include "../../include/ir/constant.hpp"
#include "../../include/ir/instructions/binary.hpp"
#include "../../include/ir/instructions/control.hpp"
#include "../../include/ir/instructions/helper.hpp"
#include "../../include/ir/instructions/memory.hpp"
#include "../../include/ir/module.hpp"
#include "../../include/parser/visitor.hpp"

namespace AST
{
void IRGenerator::visit(CompUnit& node) {
    symbol_table.initScope("__global");

    auto void_type = IR::makeBType(IR::IRBTYPE::VOID);
    auto i8_type = IR::makeBType(IR::IRBTYPE::I8);
    auto i8ptr_type = IR::makePtrType(i8_type);
    auto i32_type = IR::makeBType(IR::IRBTYPE::I32);
    auto i32ptr_type = IR::makePtrType(i32_type);
    auto f32_type = IR::makeBType(IR::IRBTYPE::FLOAT);
    auto f32ptr_type = IR::makePtrType(f32_type);
    auto make_decl = [this](const std::string& name,
        std::vector<std::shared_ptr<IR::Type>> params,
        std::shared_ptr<IR::Type> ret,
        bool is_va_arg = false) {
        auto fn = std::make_shared<IR::FunctionDecl>("@" + name, std::move(params), std::move(ret), is_va_arg);
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


    for (auto& n : node.getNodes()) {
        n->accept(*this);
    }
    symbol_table.finishScope();
}

// DeclStmt: const int32
void IRGenerator::visit(DeclStmt& node) {
    for (auto& v : node.getVardefs()) {
        v->accept(*this);
    }
}

// VarDecl: 'a' const int32[1][2]
void IRGenerator::visit(VarDef& node) {
    IR::IRBTYPE node_type = IR::IRBTYPE::UNDEFINED;
    switch (node.getType())
    {
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

        for (auto &ss: node.getSubscripts()) {
            ss->accept(*this);
            auto ci = std::dynamic_pointer_cast<IR::ConstantInt>(curr_val);
            Err::gassert(ci != nullptr, "Array dimensions should be constant integers.");
            array_sizes.emplace_back(ci->getVal());
        }

        irtype = makeBType(node_type);
        for (auto rit = array_sizes.rbegin(); rit != array_sizes.rend(); ++rit)
            irtype = makeArrayType(irtype, *rit);
    }
    else
        irtype = makeBType(node_type);


    curr_initializer.reset(node_type);
    curr_making_initializer = &curr_initializer;

    // Pure Constant Variable
    // check if the given variable is unusable in constant expression
    if (node.isConst() && !node.isArray())
    {
        Err::gassert(node.isInited());
        node.getInitVal()->accept(*this);
        auto flatten_initializer = curr_initializer.flatten(irtype);
        Err::gassert(flatten_initializer.size() == 1);
        const auto& cv = flatten_initializer[0];
        if (cv.index() != 2)
        {
            std::shared_ptr<IR::Value> val;
            if (cv.index() == 0)
                val = constant_pool.getConst(std::get<0>(cv));
            if (cv.index() == 1)
                val = constant_pool.getConst(std::get<1>(cv));
            symbol_table.insert(node.getId(), val);
        }
    }


    if (curr_func != nullptr)    // Check if global
    {
        auto alloca_inst = std::make_shared<IR::ALLOCAInst>(get_irval_name(), irtype);
        curr_func->addInst(alloca_inst); // CURR_FUNC

        curr_initializer.reset(node_type);
        curr_making_initializer = &curr_initializer;

        if (node.isInited())
        {
            node.getInitVal()->accept(*this);
            auto flatten_initializer = curr_initializer.flatten(irtype);

            // // initializer flatten debug
            // if (flatten_initializer.size() > 1)
            // {
            //     for (auto&& r : flatten_initializer)
            //     {
            //         if (r.index() == 0)
            //             printf("%d, ", std::get<int>(r));
            //         else if (r.index() == 1)
            //             printf("%f, ", std::get<float>(r));
            //         else if (r.index() == 2)
            //             printf("%s, ", std::get<std::shared_ptr<IR::Value>>(r)->getName().c_str());
            //     }
            //     printf("\n");
            // }

            Err::gassert(flatten_initializer.size() == irtype->getBytes() / IR::getBytes(node_type), "Invalid initializer.");

            // TODO: check if it is pure constant (or part of it) and make it global for performance.
            // auto is_pure_constant = std::all_of(flatten_initializer.cbegin(), flatten_initializer.cend(),
            //     [](auto&& v) { return v.index() != 2; });

            auto toIRValue = [this](const Initializer::val_t& a) -> std::shared_ptr<IR::Value> {
                if (a.index() == 0)
                    return constant_pool.getConst(std::get<0>(a));
                if (a.index() == 1)
                    return constant_pool.getConst(std::get<1>(a));
                if (a.index() == 2)
                    return std::get<2>(a);
                return nullptr;
            };

            if (node.isArray())
            {
                auto curr_type = toArrayType(irtype);
                size_t init_pos = 0;
                std::function<void(const std::shared_ptr<IR::Type>& type, const std::shared_ptr<IR::Value>& base)> init_array;
                init_array = [this, &toIRValue, &flatten_initializer, &init_pos, &init_array]
                (const std::shared_ptr<IR::Type>& type, const std::shared_ptr<IR::Value>& base) {
                    auto arrtype = toArrayType(type);
                    Err::gassert(arrtype != nullptr);
                    if (arrtype->getElmType()->getTrait() == IR::IRCTYPE::ARRAY)
                    {
                        for (size_t i = 0; i < arrtype->getArraySize(); ++i) {
                            auto gep_inst = std::make_shared<IR::GEPInst>(get_irval_name(), base,
                                    constant_pool.getConst(0),
                                    constant_pool.getConst(static_cast<int>(i)));

                            curr_insts.emplace_back(gep_inst);
                            init_array(arrtype->getElmType(), gep_inst);
                        }
                    }
                    else if (arrtype->getElmType()->getTrait() == IR::IRCTYPE::BASIC)
                    {
                        for (size_t i = 0; i < arrtype->getArraySize(); ++i)
                        {
                            auto gep_inst = std::make_shared<IR::GEPInst>(get_irval_name(), base,
                                    constant_pool.getConst(0),
                                    constant_pool.getConst(static_cast<int>(i)));

                            auto str_inst = std::make_shared<IR::STOREInst>
                                    (toIRValue(flatten_initializer[init_pos++]), gep_inst);
                            curr_insts.emplace_back(gep_inst);
                            curr_insts.emplace_back(str_inst);
                        }
                    }
                    else Err::unreachable();
                };
                init_array(irtype, alloca_inst);
            }
            else
            {
                auto str_inst = std::make_shared<IR::STOREInst>(toIRValue(flatten_initializer[0]),
                    alloca_inst);
                curr_insts.emplace_back(str_inst);
            }
        }
        symbol_table.insert(node.getId(), alloca_inst);
    }
    else
    {
        curr_initializer.reset(node_type);
        curr_making_initializer = &curr_initializer;
        auto gviniter = IR::GVIniter(irtype);
        if (node.isInited())
        {
            node.getInitVal()->accept(*this);
            auto flatten_initializer = curr_initializer.flatten(irtype);
            Err::gassert(flatten_initializer.size() == irtype->getBytes() / IR::getBytes(node_type), "Invalid initializer.");

            auto toIRValue = [this](const Initializer::val_t& a) -> std::shared_ptr<IR::Value> {
                if (a.index() == 0)
                    return constant_pool.getConst(std::get<0>(a));
                if (a.index() == 1)
                    return constant_pool.getConst(std::get<1>(a));
                Err::error("Invalid global initializer.");
                return nullptr;
            };

            if (node.isArray())
            {
                auto curr_type = toArrayType(irtype);
                size_t init_pos = 0;
                std::function<void(const std::shared_ptr<IR::Type>& type, IR::GVIniter& base)> init_array;
                init_array = [this, &toIRValue, &flatten_initializer, &init_pos, &init_array]
                (const std::shared_ptr<IR::Type>& type, IR::GVIniter& base) {
                    auto arrtype = toArrayType(type);
                    Err::gassert(arrtype != nullptr);
                    if (arrtype->getElmType()->getTrait() == IR::IRCTYPE::ARRAY)
                    {
                        for (size_t i = 0; i < arrtype->getArraySize(); ++i)
                        {
                            auto& next = base.addIniter(arrtype->getElmType());
                            init_array(arrtype->getElmType(), next);
                        }
                    }
                    else if (arrtype->getElmType()->getTrait() == IR::IRCTYPE::BASIC)
                    {
                        for (size_t i = 0; i < arrtype->getArraySize(); ++i)
                            base.addIniter(arrtype->getElmType(), toIRValue(flatten_initializer[init_pos++]));
                    }
                    else Err::unreachable();
                };
                init_array(irtype, gviniter);
                gviniter.normalizeZero();
            }
            else
            {
                gviniter = IR::GVIniter(irtype, toIRValue(flatten_initializer[0]));
            }
        }

        auto gv = std::make_shared<IR::GlobalVariable>(
            node.isConst() ? IR::STOCLASS::CONSTANT :IR::STOCLASS::GLOBAL,
            irtype, "@" + node.getId(), gviniter);
        module.addGlobalVar(gv);
        symbol_table.insert(node.getId(), gv);
    }
}

void IRGenerator::visit(InitVal& node) {
    if (node.isList())
    {
        if (curr_initializer.empty())
            curr_making_initializer = curr_initializer.makeList();
        else
            curr_making_initializer = curr_making_initializer->addList();

        for (auto& iv : node.getInner()) {
            iv->accept(*this);
        }
        curr_making_initializer = curr_making_initializer->parent;
    } else
    {
        node.getExp()->accept(*this);
        if (curr_initializer.empty()) // TOP LEVEL and is value, then the whole is a value
        {
            curr_val = type_cast(curr_val, curr_initializer.base_type);
            if (auto ci = std::dynamic_pointer_cast<IR::ConstantInt>(curr_val))
                curr_initializer.setVal(ci->getVal());
            else if (auto cf = std::dynamic_pointer_cast<IR::ConstantFloat>(curr_val))
                curr_initializer.setVal(cf->getVal());
            else
                curr_initializer.setVal(curr_val);
        }
        else // Not TOP LEVEL
        {
            curr_val = type_cast(curr_val, curr_making_initializer->base_type);
            if (auto ci = std::dynamic_pointer_cast<IR::ConstantInt>(curr_val))
                curr_making_initializer->add(ci->getVal());
            else if (auto cf = std::dynamic_pointer_cast<IR::ConstantFloat>(curr_val))
                curr_making_initializer->add(cf->getVal());
            else
                curr_making_initializer->add(curr_val);
        }
    }
}

void IRGenerator::visit(ArraySubscript& node) {
    node.getExp()->accept(*this);
}

// FunctionDef: 'func' int32
void IRGenerator::visit(FuncDef& node) {
    auto prev = symbol_table.lookup(node.getId());
    Err::gassert(prev == nullptr, "Invalid function id.");

    IR::IRBTYPE ty = IR::IRBTYPE::UNDEFINED;
    switch (node.getType())
    {
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

    std::vector<std::shared_ptr<IR::Value>> params;
    std::vector<std::string> param_ids;

    if (!node.isEmptyParam()) {
        for (auto &p: node.getParams()) {
            p->accept(*this);
            param_ids.emplace_back(p->getId());
            params.emplace_back(curr_val);
        }
    }

    curr_func = std::make_shared<IR::Function>("@" + node.getId(), params, IR::makeBType(ty));
    module.addFunction(curr_func);
    symbol_table.insert(node.getId(), curr_func);

    symbol_table.initScope();

    for (size_t i = 0; i < param_ids.size(); ++i) {
        auto alloca = std::make_shared<IR::ALLOCAInst>(get_irval_name(), params[i]->getType());
        auto str = std::make_shared<IR::STOREInst>(params[i], alloca);

        curr_func->addInst(alloca); // CURR_FUNC
        curr_insts.emplace_back(str);
        // We need to look up `param_ids` to get real id.
        symbol_table.insert(param_ids[i], alloca);
    }

    node.getBody()->accept(*this);
    symbol_table.finishScope();

    // See Main function: https://en.cppreference.com/w/c/language/main_function
    // If the return type is compatible with int and control reaches the terminating },
    // the value returned to the environment is the same as if executing return 0;.
    if (node.getId() == "main")
    {
        Err::gassert(IR::isSameType(IR::toFunctionType(curr_func->getType())->getRet(),
            IR::makeBType(IR::IRBTYPE::I32)),
            "Invalid main.");
        if (curr_insts.empty() || curr_insts.back()->getOpcode() != IR::OP::RET)
        {
            curr_insts.emplace_back(std::make_shared<IR::RETInst>(constant_pool.getConst(0)));
        }
    }

    curr_func->appendInsts(std::move(curr_insts));
    curr_insts.clear();

    size_t new_irval_id = 0;
    for (const auto& param : curr_func->getParams())
        param->setName("%" + std::to_string(new_irval_id++));

    // I don't know why, but it seems clang do this. (Maybe I misunderstood it)
    ++new_irval_id;
    std::function<void(const std::shared_ptr<IR::Instruction>& val)> change_name;
    change_name = [&new_irval_id, &change_name](const std::shared_ptr<IR::Instruction>& inst) {
        if (auto if_inst = std::dynamic_pointer_cast<IR::IFInst>(inst))
        {
            for (auto&& inner_inst : if_inst->getBodyInsts())
                change_name(inner_inst);
            for (auto&& inner_inst : if_inst->getElseInsts())
                change_name(inner_inst);
        }
        else if (auto while_inst = std::dynamic_pointer_cast<IR::WHILEInst>(inst))
        {
            for (auto&& inner_inst : while_inst->getCondInsts())
                change_name(inner_inst);
            for (auto&& inner_inst : while_inst->getBodyInsts())
                change_name(inner_inst);
        }
        else if (!inst->getName().empty() && inst->getName()[0] == '%')
            inst->setName("%" + std::to_string(new_irval_id++));
    };
    for (const auto& inst : curr_func->getInsts())
        change_name(inst);

    curr_func = nullptr;
}

// FuncFParam: 'a' int32[][2] \n
void IRGenerator::visit(FuncFParam& node) {
    IR::IRBTYPE node_type = IR::IRBTYPE::UNDEFINED;
    switch (node.getType()) {
    case dtype::INT:
        node_type = IR::IRBTYPE::I32;
        break;
    case dtype::FLOAT:
        node_type = IR::IRBTYPE::FLOAT;
        break;
    default:
        Err::error("Function parameters' base type should always be int or float.");
        break;
    }

    std::shared_ptr<IR::Type> ir_type;
    if (node.isArray()) {
        if (node.isOneDim())
        {
            Err::gassert(node.getSubscripts().empty());
            ir_type = makePtrType(makeBType(node_type));
        }
        else
        {
            std::vector<int> array_sizes;

            for (const auto &ss: node.getSubscripts()) {
                ss->accept(*this);
                auto ci = std::dynamic_pointer_cast<IR::ConstantInt>(curr_val);
                Err::gassert(ci != nullptr, "Array dimensions should be constant integers.");
                array_sizes.emplace_back(ci->getVal());
            }

            ir_type = makeBType(node_type);
            for (auto rit = array_sizes.rbegin(); rit < array_sizes.rend(); ++rit)
                ir_type = makeArrayType(ir_type, *rit);
            ir_type = makePtrType(ir_type);
        }
    }
    else {
        ir_type = IR::makeBType(node_type);
    }

    curr_val = std::make_shared<IR::Value>(get_irval_name(), ir_type, IR::ValueTrait::FORMAL_PARAMETER);
}


// The following two functions (DeclRef and ArrayExp) is handling LVal.
//
// Given that most time we are using the LVal's value, rather than its address, (except assign (only?))
// we add a load inst (if possible and not `is_making_lval`) afterward.
// That means we are trying to make the `curr_val` a Basic Type if possible.
//
// This could simplify many insts that need a value, not its address, like binary inst, call inst,  ...
// And we don't need to add load insts everywhere.
// But this could also introduce bugs for Lval, when the context needs a ptr, rather than Basic Type.
// So we use `is_making_lval` explicitly to handle such situation,
// where we don't add load inst so that guarantees `curr_val` is a ptr.
//
// It's a bit quick and dirty. Maybe we should make it more sensible in the future.
// It seems that we can add some helper functions like cast_to_type to add load inst.

// DeclRefExp: 'a' \n
//
// From node's name to curr_val's alloca/load
//
// curr_val =
// is_making_lval (which guarantees a ptr) -> alloca
// Array -> alloca
// Basic -> alloca -> load
void IRGenerator::visit(DeclRef& node) {
    Err::gassert(curr_func != nullptr, "Global initializer must be a compile-time constant");

    auto ref = symbol_table.lookup(node.getId());

    Err::gassert(ref != nullptr, "Invalid reference to '" + node.getId() + "', not found.");

    // TODO: Prevent potential bugs
    if (auto alloca_inst = std::dynamic_pointer_cast<IR::ALLOCAInst>(ref))
    {
        if (is_making_lval || alloca_inst->isArray())
        {
            is_making_lval = false;
            curr_val = alloca_inst;
        }
        else
        {
            auto load = std::make_shared<IR::LOADInst>(get_irval_name(), alloca_inst);
            curr_insts.emplace_back(load);
            curr_val = load;
        }
    }
    else if (auto gv = std::dynamic_pointer_cast<IR::GlobalVariable>(ref))
    {
        if (is_making_lval || gv->isArray())
        {
            is_making_lval = false;
            curr_val = gv;
        }
        else
        {
            auto load = std::make_shared<IR::LOADInst>(get_irval_name(), gv);
            curr_insts.emplace_back(load);
            curr_val = load;
        }
    }
    else curr_val = ref;
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
// Note that if the given ptr is from a load inst, which is always a function parameter (decays from array),
// we first gep the first index for the given ptr, and the remaining indices is handled by
// numerous small gep, which handles one index with its two gep indices a time.
void IRGenerator::visit(ArrayExp& node) {
    node.getRef()->accept(*this);
    auto base = curr_val;

    std::vector<std::shared_ptr<IR::Value>> indices;
    for (const auto& ss: node.getIndices()) {
        ss->accept(*this);
        auto idxty = toBType(curr_val->getType());
        Err::gassert(idxty != nullptr && idxty->getInner() == IR::IRBTYPE::I32,
                     "Array subscripts must be integers.");
        indices.emplace_back(curr_val);
    }

    Err::gassert(base->getType()->getTrait() == IR::IRCTYPE::PTR, "Not an array.");

    std::shared_ptr<IR::Value> curr_gep = base;
    size_t i = 0;

    // TODO: More sensible
    // LOAD from Function Parameters
    if (auto load_inst = std::dynamic_pointer_cast<IR::LOADInst>(base))
    {
        curr_gep = std::make_shared<IR::GEPInst>(get_irval_name(), base, indices[0]);
        curr_insts.emplace_back(std::dynamic_pointer_cast<IR::Instruction>(curr_gep));
        ++i;
    }

    for (; i < indices.size(); i++)
    {
        Err::gassert(getElm(curr_gep->getType())->getTrait() == IR::IRCTYPE::ARRAY
            || getElm(curr_gep->getType())->getTrait() == IR::IRCTYPE::PTR,
            "Invalid array index.");
        curr_gep = std::make_shared<IR::GEPInst>(get_irval_name(), curr_gep,
                                                     constant_pool.getConst(0), indices[i]);
        curr_insts.emplace_back(std::dynamic_pointer_cast<IR::Instruction>(curr_gep));
    }

    if (!is_making_lval && IR::getElm(curr_gep->getType())->getTrait() == IR::IRCTYPE::BASIC) {
        auto load_inst = std::make_shared<IR::LOADInst>(get_irval_name(), curr_gep);
        curr_insts.emplace_back(load_inst);
        curr_val = load_inst;
    } else
    {
        is_making_lval = false;
        curr_val = curr_gep;
    }
}

// a(1, 2, 3)
// CallExp: 'a' (1, 2, 3, )
void IRGenerator::visit(CallExp& node) {
    node.getRef()->accept(*this);

    auto func = std::dynamic_pointer_cast<IR::FunctionDecl>(curr_val);
    Err::gassert(func != nullptr, "Invalid to call '" + node.getId() + "', which is not a function.");

    std::vector<std::shared_ptr<IR::Value>> args;
    if (!node.isEmptyParam()) {
        for (auto& p : node.getParams()) {
            p->accept(*this);
            args.emplace_back(curr_val);
        }
    }

    auto functy = IR::toFunctionType(func->getType());
    auto expected = functy->getParams();
    if (expected.size() != args.size())
        Err::error("Invalid call.");

    for (size_t i = 0; i < args.size(); ++i)
    {
        if (IR::isSameType(expected[i], args[i]->getType()))
            continue;

        if (expected[i]->getTrait() == IR::IRCTYPE::BASIC
            && expected[i]->getTrait() == args[i]->getType()->getTrait())
        {
            auto expected_bty = IR::toBType(expected[i])->getInner();
            args[i] = type_cast(args[i], expected_bty);
        }
        else if (expected[i]->getTrait() == IR::IRCTYPE::PTR
            && args[i]->getType()->getTrait() == IR::IRCTYPE::PTR)
        {
            if (getElm(args[i]->getType())->getTrait() == IR::IRCTYPE::ARRAY
                && IR::isSameType(getElm(getElm(args[i]->getType())), IR::getElm(expected[i])))
            {
                auto gep = std::make_shared<IR::GEPInst>(get_irval_name(), args[i],
                    constant_pool.getConst(0), constant_pool.getConst(0));
                curr_insts.emplace_back(gep);
            }
            else
            {
                Err::todo("Implicit pointer conversion.");
                break;
            }
        }
        else
        {
            Err::unreachable("Invalid call.");
            break;
        }
    }

    std::shared_ptr<IR::CALLInst> call;
    if (IR::toBType(functy->getRet())->getInner() == IR::IRBTYPE::VOID)
        call = std::make_shared<IR::CALLInst>(func, args);
    else
        call = std::make_shared<IR::CALLInst>(get_irval_name(), func, args);

    curr_insts.emplace_back(call);
    curr_val = call;
}

void IRGenerator::visit(FuncRParam& node) {
    node.getExp()->accept(*this);
}

template<typename Base, typename T>
Base constant_arithmetic(const std::shared_ptr<IR::Value>& lhs,
    const std::shared_ptr<IR::Value>& rhs,
    T&& operation) {
    Err::gassert(IR::isSameType(lhs->getType(), rhs->getType())
        && lhs->getType()->getTrait() == IR::IRCTYPE::BASIC);

    if constexpr (std::is_same_v<Base, int>)
    {
        auto cl = std::dynamic_pointer_cast<IR::ConstantInt>(lhs);
        auto cr = std::dynamic_pointer_cast<IR::ConstantInt>(rhs);
        Err::gassert(cl != nullptr && cr != nullptr);
        return operation(cl->getVal(), cr->getVal());
    }
    else if constexpr (std::is_same_v<Base, float>)
    {
        auto cl = std::dynamic_pointer_cast<IR::ConstantFloat>(lhs);
        auto cr = std::dynamic_pointer_cast<IR::ConstantFloat>(rhs);
        Err::gassert(cl != nullptr && cr != nullptr);
        return operation(cl->getVal(), cr->getVal());
    }
    else
        Err::not_implemented();
    return Base{};
}

void IRGenerator::visit(BinaryOp& node) {
    if (node.getOp() == BiOp::ASSIGN)
    {
        is_making_lval = true;
        node.getLHS()->accept(*this);
        is_making_lval = false;
        auto lhs = curr_val;
        node.getRHS()->accept(*this);
        auto rhs = curr_val;

        auto rhstype = IR::toBType(rhs->getType());
        Err::gassert(rhstype != nullptr
            && (rhstype->getInner() == IR::IRBTYPE::I32
                || rhstype->getInner() == IR::IRBTYPE::FLOAT),
            "Invalid assign.");
        auto lhstype = IR::toPtrType(lhs->getType());
        Err::gassert(lhstype != nullptr, "Invalid assign, not lval.");
        auto lhselmty = IR::toBType(getElm(lhs->getType()))->getInner();
        Err::gassert(lhselmty == IR::IRBTYPE::I32 || lhselmty == IR::IRBTYPE::FLOAT,
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
        Err::gassert(lhstype != nullptr && rhstype != nullptr
            && (lhstype->getInner() == IR::IRBTYPE::I32
            || lhstype->getInner() == IR::IRBTYPE::I1
            || lhstype->getInner() == IR::IRBTYPE::FLOAT)
            && (rhstype->getInner() == IR::IRBTYPE::I32
            || rhstype->getInner() == IR::IRBTYPE::I1
            || rhstype->getInner() == IR::IRBTYPE::FLOAT),
            "Binary operation must be integers or floats.");

        if (node.getOp() == BiOp::AND || node.getOp() == BiOp::OR)
        {
            lhs = type_cast(lhs, IR::IRBTYPE::I1);
            rhs = type_cast(rhs, IR::IRBTYPE::I1);
            oprtype = IR::makeBType(IR::IRBTYPE::I1);
        }
        else if (lhstype->getInner() == IR::IRBTYPE::FLOAT || rhstype->getInner() == IR::IRBTYPE::FLOAT)
        {
            lhs = type_cast(lhs, IR::IRBTYPE::FLOAT);
            rhs = type_cast(rhs, IR::IRBTYPE::FLOAT);
            oprtype = IR::makeBType(IR::IRBTYPE::FLOAT);
        }
        else if (lhstype->getInner() == IR::IRBTYPE::I1 && rhstype->getInner() == IR::IRBTYPE::I1)
            oprtype = IR::makeBType(IR::IRBTYPE::I1);
        else if (lhstype->getInner() == IR::IRBTYPE::I32 && rhstype->getInner() == IR::IRBTYPE::I32)
            oprtype = IR::makeBType(IR::IRBTYPE::I32);
        else Err::unreachable("Invalid type.");
    }

    bool is_constant = lhs->getVTrait() == IR::ValueTrait::CONSTANT_LITERAL
    && rhs->getVTrait() == IR::ValueTrait::CONSTANT_LITERAL;

    // Arithmetic -> I32
    if (node.getOp() == BiOp::ADD || node.getOp() == BiOp::SUB
    || node.getOp() == BiOp::MUL || node.getOp() == BiOp::DIV
    || node.getOp() == BiOp::MOD)
    {
        Err::gassert(oprtype->getInner() == IR::IRBTYPE::I32
            || oprtype->getInner() == IR::IRBTYPE::FLOAT,
            "Invalid arithmetic operations");
        IR::OP op;

#define MAKE_OP(biop, iop, fop, cppop) \
case biop: \
if (oprtype->getInner() == IR::IRBTYPE::I32) \
{ \
if (is_constant) \
{ \
curr_val = constant_pool.getConst(constant_arithmetic<int>(lhs, rhs, [](auto&& v1, auto&& v2) {return v1 cppop v2;})); \
return; \
} \
op = iop; \
} \
else \
{ \
if (is_constant) \
{ \
curr_val = constant_pool.getConst(constant_arithmetic<float>(lhs, rhs, [](auto&& v1, auto&& v2) {return v1 cppop v2;})); \
return; \
} \
op = fop; \
} \
break; \

        switch (node.getOp())
        {
            MAKE_OP(BiOp::ADD, IR::OP::ADD, IR::OP::FADD, +)
            MAKE_OP(BiOp::SUB, IR::OP::SUB, IR::OP::FSUB, -)
            MAKE_OP(BiOp::MUL, IR::OP::MUL, IR::OP::FMUL, *)
            MAKE_OP(BiOp::DIV, IR::OP::DIV, IR::OP::FDIV, /)

        case BiOp::MOD:
            Err::gassert(oprtype->getInner() == IR::IRBTYPE::I32);
            if (is_constant)
            {
                curr_val = constant_pool.getConst(constant_arithmetic<int>(lhs, rhs, [](auto&& v1, auto&& v2) {return v1 % v2;}));
                return;
            }
            op = IR::OP::REM;
            break;
        default:
            Err::unreachable();
        }

#undef MAKE_OP

        auto inst = std::make_shared<IR::BinaryInst>(get_irval_name(), op, lhs, rhs);
        curr_insts.emplace_back(inst);
        curr_val = inst;
        return;
    }

    // Compare -> I1
    if (node.getOp() == BiOp::LESSEQ || node.getOp() == BiOp::GREATEQ
        || node.getOp() == BiOp::GREAT || node.getOp() == BiOp::LESS
        || node.getOp() == BiOp::NOTEQ || node.getOp() == BiOp::EQ)
    {
        Err::gassert(oprtype->getInner() == IR::IRBTYPE::I32
            || oprtype->getInner() == IR::IRBTYPE::FLOAT,
            "Invalid compare.");
        if (oprtype->getInner() == IR::IRBTYPE::I32)
        {
            IR::ICMPOP icmpop;
            switch (node.getOp())
            {
            case BiOp::LESSEQ:
                icmpop = IR::ICMPOP::sle;
                break;
            case BiOp::GREATEQ:
                icmpop = IR::ICMPOP::sge;
                break;
            case BiOp::LESS:
                icmpop = IR::ICMPOP::slt;
                break;
            case BiOp::GREAT:
                icmpop = IR::ICMPOP::sgt;
                break;
            case BiOp::NOTEQ:
                icmpop = IR::ICMPOP::ne;
                break;
            case BiOp::EQ:
                icmpop = IR::ICMPOP::eq;
                break;
            default:
                Err::unreachable();
            }
            auto inst = std::make_shared<IR::ICMPInst>(get_irval_name(), icmpop, lhs, rhs);
            curr_insts.emplace_back(inst);
            curr_val = inst;
        }
        else
        {
            IR::FCMPOP fcmpop;
            switch (node.getOp())
            {
            case BiOp::LESSEQ:
                fcmpop = IR::FCMPOP::ole;
                break;
            case BiOp::GREATEQ:
                fcmpop = IR::FCMPOP::oge;
                break;
            case BiOp::LESS:
                fcmpop = IR::FCMPOP::olt;
                break;
            case BiOp::GREAT:
                fcmpop = IR::FCMPOP::ogt;
                break;
            case BiOp::NOTEQ:
                fcmpop = IR::FCMPOP::one;
                break;
            case BiOp::EQ:
                fcmpop = IR::FCMPOP::oeq;
                break;
            default:
                Err::unreachable();
            }
            auto inst = std::make_shared<IR::FCMPInst>(get_irval_name(), fcmpop, lhs, rhs);
            curr_insts.emplace_back(inst);
            curr_val = inst;
        }
        return;
    }

    // Logical -> I1
    if (node.getOp() == BiOp::AND || node.getOp() == BiOp::OR)
    {
        Err::gassert(oprtype->getInner() == IR::IRBTYPE::I1, "Invalid && or ||.");
        switch (node.getOp())
        {
        case BiOp::AND:
            curr_val = std::make_shared<IR::ANDValue>(lhs, rhs);
            break;
        case BiOp::OR:
            curr_val = std::make_shared<IR::ORValue>(lhs, rhs);
            break;
        default:
            Err::unreachable();
        }
        return;
    }
}

void IRGenerator::visit(UnaryOp& node) {
    node.getExp()->accept(*this);

    auto opreandtype = IR::toBType(curr_val->getType());
    Err::gassert(opreandtype != nullptr
        && (opreandtype->getInner() == IR::IRBTYPE::I32
            || opreandtype->getInner() == IR::IRBTYPE::I1
            || opreandtype->getInner() == IR::IRBTYPE::FLOAT),
        "Unary operation be performed on integer or float.");
    switch (node.getOp())
    {
    case UnOp::ADD:
        break;
    case UnOp::SUB:
        if (opreandtype->getInner() == IR::IRBTYPE::I32)
        {
            if (auto ci = std::dynamic_pointer_cast<IR::ConstantInt>(curr_val))
                curr_val = constant_pool.getConst(-ci->getVal());
            else
            {
                auto neg = std::make_shared<IR::BinaryInst>(get_irval_name(), IR::OP::SUB,
                    constant_pool.getConst(0), curr_val);
                curr_insts.emplace_back(neg);
                curr_val = neg;
            }
        }
        else if (opreandtype->getInner() == IR::IRBTYPE::FLOAT)
        {
            if (auto cf = std::dynamic_pointer_cast<IR::ConstantFloat>(curr_val))
                curr_val = constant_pool.getConst(-cf->getVal());
            else
            {
                auto neg = std::make_shared<IR::FNEGInst>(get_irval_name(), curr_val);
                curr_insts.emplace_back(neg);
                curr_val = neg;
            }
        }
        else Err::not_implemented("SUB on unsupported type.");
        break;
    case UnOp::NOT:
        curr_val = type_cast(curr_val, IR::IRBTYPE::I1);
        std::function<std::shared_ptr<IR::Value>(const std::shared_ptr<IR::Value>&)> make_not;
        make_not = [this, &make_not](const std::shared_ptr<IR::Value>& val) -> std::shared_ptr<IR::Value> {
            if (auto ci1 = std::dynamic_pointer_cast<IR::ConstantI1>(val))
                return constant_pool.getConst(!ci1->getVal());
            else if (auto icmp = std::dynamic_pointer_cast<IR::ICMPInst>(val))
            {
                icmp->condFlip();
                return val;
            }
            else if (auto fcmp = std::dynamic_pointer_cast<IR::FCMPInst>(val))
            {
                fcmp->condFlip();
                return val;
            }
            // Below is not in the spec ?
            else if (auto and_helper = std::dynamic_pointer_cast<IR::ANDValue>(val))
            {
                auto lhs = and_helper->getLHS();
                auto rhs = and_helper->getRHS();
                return std::make_shared<IR::ORValue>(make_not(lhs), make_not(rhs));
            }
            else if (auto or_helper = std::dynamic_pointer_cast<IR::ORValue>(val))
            {
                auto lhs = and_helper->getLHS();
                auto rhs = and_helper->getRHS();
                return std::make_shared<IR::ANDValue>(make_not(lhs), make_not(rhs));
            }

            Err::unreachable("Invalid not.");
            return nullptr;
        };
        curr_val = make_not(curr_val);
        break;
    }
}

void IRGenerator::visit(ParenExp& node) {
    node.getExp()->accept(*this);
}

void IRGenerator::visit(IntLiteral& node) {
    curr_val = constant_pool.getConst(node.getValue());
}

void IRGenerator::visit(FloatLiteral& node) {
    curr_val = constant_pool.getConst(node.getValue());
}

void IRGenerator::visit(CompStmt& node) {
    symbol_table.initScope();

    for (auto& item : node.getItems()) {
        item->accept(*this);
    }

    symbol_table.finishScope();
}

void IRGenerator::visit(IfStmt& node) {
    node.getCond()->accept(*this);
    auto cond = curr_val;
    cond = type_cast(cond, IR::IRBTYPE::I1);

    std::vector<std::shared_ptr<IR::Instruction>> before_if_insts;
    std::vector<std::shared_ptr<IR::Instruction>> body_insts;
    std::vector<std::shared_ptr<IR::Instruction>> else_insts;

    std::swap(before_if_insts, curr_insts);

    node.getBody()->accept(*this);
    std::swap(body_insts, curr_insts);

    if(node.hasElse()) {
        node.getElseBody()->accept(*this);
        std::swap(else_insts, curr_insts);
    }

    auto if_inst = std::make_shared<IR::IFInst>(std::move(cond), std::move(body_insts), std::move(else_insts));
    std::swap(before_if_insts, curr_insts);
    curr_insts.emplace_back(if_inst);
}

void IRGenerator::visit(WhileStmt& node) {
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

    auto while_inst = std::make_shared<IR::WHILEInst>(std::move(cond),
        std::move(cond_insts), std::move(body_insts));

    std::swap(before_while_insts, curr_insts);
    curr_insts.emplace_back(while_inst);
}

void IRGenerator::visit(NullStmt& node) { }

void IRGenerator::visit(BreakStmt& node) {
    curr_insts.emplace_back(std::make_shared<IR::BREAKInst>());
}

void IRGenerator::visit(ContinueStmt& node) {
    curr_insts.emplace_back(std::make_shared<IR::CONTINUEInst>());
}

void IRGenerator::visit(ReturnStmt& node) {
    auto expected = IR::toBType(IR::toFunctionType(curr_func->getType())->getRet())->getInner();
    if (!node.isVoid()) {
        node.getReturnVal()->accept(*this);
        auto ret = type_cast(curr_val, expected);
        curr_insts.emplace_back(std::make_shared<IR::RETInst>(ret));
    }
    else
    {
        Err::gassert(expected == IR::IRBTYPE::VOID, "Invalid return.");
        curr_insts.emplace_back(std::make_shared<IR::RETInst>());
    }
}

std::string IRGenerator::get_irval_name() {
    return "%undefined";
}

// I32 <-> FLOAT
// I32 -> I1
// FLOAT -> I1
std::shared_ptr<IR::Value> IRGenerator::type_cast(std::shared_ptr<IR::Value> val, IR::IRBTYPE dest) {
    const std::string bad_cast_err = "Cannot cast type from '" + val->getType()->toString() +
        "' to '" + IR::makeBType(dest)->toString() + "'.";

    Err::gassert(val->getType()->getTrait() == IR::IRCTYPE::BASIC, bad_cast_err);
    IR::IRBTYPE src = toBType(val->getType())->getInner();
    if (src == IR::IRBTYPE::I32 && dest == IR::IRBTYPE::FLOAT)
    {
        if (auto ci = std::dynamic_pointer_cast<IR::ConstantInt>(val))
            return constant_pool.getConst(static_cast<float>(ci->getVal()));

        Err::gassert(curr_func != nullptr, "Invalid implicit type conversion in global.");
        auto conv = std::make_shared<IR::SITOFPInst>(get_irval_name(), val);
        curr_insts.emplace_back(conv);
        return conv;
    }
    else if (src == IR::IRBTYPE::FLOAT && dest == IR::IRBTYPE::I32)
    {
        if (auto cf = std::dynamic_pointer_cast<IR::ConstantFloat>(val))
            return constant_pool.getConst(static_cast<int>(cf->getVal()));

        Err::gassert(curr_func != nullptr, "Invalid implicit type conversion in global.");
        auto conv = std::make_shared<IR::FPTOSIInst>(get_irval_name(), val);
        curr_insts.emplace_back(conv);
        return conv;
    }
    else if (src == IR::IRBTYPE::I32 && dest == IR::IRBTYPE::I1)
    {
        if (auto ci = std::dynamic_pointer_cast<IR::ConstantInt>(val))
            return constant_pool.getConst(static_cast<bool>(ci->getVal()));

        Err::gassert(curr_func != nullptr, "Invalid implicit type conversion in global.");
        auto conv = std::make_shared<IR::ICMPInst>(get_irval_name(), IR::ICMPOP::ne,
            val, constant_pool.getConst(0));
        curr_insts.emplace_back(conv);
        return conv;
    }
    else if (src == IR::IRBTYPE::FLOAT && dest == IR::IRBTYPE::I1)
    {
        if (auto cf = std::dynamic_pointer_cast<IR::ConstantFloat>(val))
            return constant_pool.getConst(static_cast<bool>(cf->getVal()));

        Err::gassert(curr_func != nullptr, "Invalid implicit type conversion in global.");
        auto conv = std::make_shared<IR::FCMPInst>(get_irval_name(), IR::FCMPOP::one,
            val, constant_pool.getConst(0.0f));
        curr_insts.emplace_back(conv);
        return conv;
    }

    Err::gassert(src == dest, bad_cast_err);
    return val;
}
}
