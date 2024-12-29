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
        for (auto& ss : node.getSubscripts()) {
            ss->accept(*this);

            auto subty = toBType(curr_val->getType());
            Err::gassert(subty != nullptr && subty->getInner() == IR::IRBTYPE::I32,
                "Array Dimensions should be Integers.");

            array_sizes.emplace_back(std::dynamic_pointer_cast<IR::ConstantInt>(curr_val)->getVal());
        }

        irtype = makeBType(node_type);
        for (auto rit = array_sizes.rbegin(); rit != array_sizes.rend(); rit++)
            irtype = makeArrayType(irtype, *rit);
    }
    else
        irtype = makeBType(node_type);

    if (curr_func != nullptr)    // Check if global
    {
        auto alloca_inst = std::make_shared<IR::ALLOCAInst>("%" + node.getId(), irtype);

        curr_func->addInst(alloca_inst);

        curr_initializer.reset(node_type);
        curr_making_initializer = &curr_initializer;

        if (node.isInited())
        {
            node.getInitVal()->accept(*this);
            auto flatten_initializer = curr_initializer.flatten(irtype);
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
                        for (size_t i = 0; i < arrtype->getArraySize(); ++i)
                        {
                            auto gep_inst = std::make_shared<IR::GEPInst>(get_temp_name(), base,
                               std::vector<std::shared_ptr<IR::Value>>{
                                   constant_pool.getConst(0),
                                   constant_pool.getConst(static_cast<int>(i))});

                            curr_func->addInst(gep_inst);
                            init_array(arrtype->getElmType(), gep_inst);
                        }
                    }
                    else if (arrtype->getElmType()->getTrait() == IR::IRCTYPE::BASIC)
                    {
                        for (size_t i = 0; i < arrtype->getArraySize(); ++i)
                        {
                            auto gep_inst = std::make_shared<IR::GEPInst>(get_temp_name(), base,
                               std::vector<std::shared_ptr<IR::Value>>{
                                   constant_pool.getConst(0),
                                   constant_pool.getConst(static_cast<int>(i))});

                            auto str_inst = std::make_shared<IR::STOREInst>
                            (toIRValue(flatten_initializer[init_pos++]), gep_inst);
                            curr_func->addInst(gep_inst);
                            curr_func->addInst(str_inst);
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
                curr_func->addInst(str_inst);
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

            auto isZero = [this](const Initializer::val_t& a) -> bool {
                if (a.index() == 0)
                    return std::get<0>(a) == 0;
                if (a.index() == 1)
                    return std::get<1>(a) == 0.0f;
                Err::error("Invalid global initializer.");
                return false;
            };


            if (node.isArray())
            {
                auto curr_type = toArrayType(irtype);
                size_t init_pos = 0;
                std::function<void(const std::shared_ptr<IR::Type>& type, IR::GVIniter& base)> init_array;
                init_array = [this, &toIRValue, &flatten_initializer, &init_pos, &init_array, isZero]
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
            curr_val = try_type_cast(curr_val, curr_initializer.base_type);
            if (auto ci = std::dynamic_pointer_cast<IR::ConstantInt>(curr_val))
                curr_initializer.setVal(ci->getVal());
            else if (auto cf = std::dynamic_pointer_cast<IR::ConstantFloat>(curr_val))
                curr_initializer.setVal(cf->getVal());
            else
                curr_initializer.setVal(curr_val);
        }
        else // Not TOP LEVEL
        {
            curr_val = try_type_cast(curr_val, curr_making_initializer->base_type);
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
    IR::IRBTYPE ty = IR::IRBTYPE::UNDEFINED;
    switch (node.getType())
    {
    case dtype::INT:
        ty = IR::IRBTYPE::I32;
        break;
    case dtype::FLOAT:
        ty = IR::IRBTYPE::FLOAT;
        break;
    default:
        Err::error("Function should always return int or float.");
        break;
    }

    curr_func = std::make_shared<IR::Function>(node.getId(), IR::makeBType(ty));
    // TODO: Function Params
    if (!node.isEmptyParam()) {
        for (auto& p : node.getParams()) {
            p->accept(*this);
            curr_func->addParam(curr_val);
        }
    }
    node.getBody()->accept(*this);
    module.addFunction(curr_func);
}

// FuncFParam: 'a' int32[][2] \n
void IRGenerator::visit(FuncFParam& node) {
    if (node.isArray() && !node.isOneDim()) {
        for (auto& ss : node.getSubscripts()) {
            ss->accept(*this);
        }
    }
}

// DeclRefExp: 'a' \n
// Warning: NOT always LOADInst
void IRGenerator::visit(DeclRef& node) {
    Err::gassert(curr_func != nullptr, "Global initializer is not a compile-time constant");

    auto ref = symbol_table.lookup(node.getId());
    Err::gassert(ref != nullptr,
        "Invalid reference to '" + node.getId() + "', not found.");

    // TODO: Prevent potential bugs
    if (auto alloca_inst = std::dynamic_pointer_cast<IR::ALLOCAInst>(ref))
    {
        if (alloca_inst->isArray())
            curr_val = alloca_inst;
        else
        {
            auto load = std::make_shared<IR::LOADInst>(get_temp_name(), alloca_inst);
            curr_func->addInst(load);
            curr_val = load;
        }
    }
    else if (auto gv = std::dynamic_pointer_cast<IR::GlobalVariable>(ref))
    {
        auto load = std::make_shared<IR::LOADInst>(get_temp_name(), gv);
        curr_func->addInst(load);
        curr_val = load;
    }
    else
        Err::error("Unexpected reference type.");
}

// a[2][1]
// ArrayExp: 'a' [2][1]
void IRGenerator::visit(ArrayExp& node) {
    node.getRef()->accept(*this);
    auto base = curr_val;

    std::vector<std::shared_ptr<IR::Value>> idx;
    for (auto& ss : node.getIndices()) {
        ss->accept(*this);
        auto idxty = toBType(curr_val->getType());
        Err::gassert(idxty != nullptr && idxty->getInner() == IR::IRBTYPE::I32,
            "Array subscripts must be integers.");
        idx.emplace_back(curr_val);
    }

    if (std::dynamic_pointer_cast<IR::ALLOCAInst>(base) != nullptr
        || std::dynamic_pointer_cast<IR::GlobalVariable>(base) != nullptr)
    {
        auto gep_inst = std::make_shared<IR::GEPInst>(get_temp_name(), base, idx);
        auto load_inst = std::make_shared<IR::LOADInst>(get_temp_name(), gep_inst);
        curr_func->addInst(gep_inst);
        curr_func->addInst(load_inst);
        curr_val = load_inst;
    }
    else Err::error("NOT an array.");
}

// a(1, 2, 3)
// CallExp: 'a' (1, 2, 3, )
void IRGenerator::visit(CallExp& node) {
    node.getRef()->accept(*this);

    auto func = std::dynamic_pointer_cast<IR::Function>(curr_val);
    Err::gassert(func != nullptr, "Invalid to call '" + node.getId() + "', which is not a function.");

    std::vector<std::shared_ptr<IR::Value>> args;
    if (!node.isEmptyParam()) {
        for (auto& p : node.getParams()) {
            p->accept(*this);
            args.emplace_back(curr_val);
        }
    }

    auto expected = func->getParams();
    if (expected.size() != args.size())
        Err::error("Invalid call.");

    for (size_t i = 0; i < args.size(); ++i)
    {
        if (IR::isSameType(expected[i]->getType(), args[i]->getType()))
            continue;
        else if (expected[i]->getType()->getTrait() == IR::IRCTYPE::BASIC
            && expected[i]->getType()->getTrait() == args[i]->getType()->getTrait())
        {
            auto arg_bty = IR::toBType(args[i]->getType())->getInner();
            args[i] = try_type_cast(args[i], arg_bty);
        }
        else
            Err::error("Invalid call.");
    }

    curr_val = std::make_shared<IR::CALLInst>(func, args);
}

void IRGenerator::visit(FuncRParam& node) {
    node.getExp()->accept(*this);
}

void IRGenerator::visit(BinaryOp& node) {
    node.getLHS()->accept(*this);
    auto lhs = curr_val;
    node.getRHS()->accept(*this);
    auto rhs = curr_val;
    std::shared_ptr<IR::BType> opreandtype;
    {
        auto rhstype = IR::toBType(rhs->getType());
        auto lhstype = IR::toBType(lhs->getType());
        Err::gassert(lhstype != nullptr && rhstype != nullptr
            && (lhstype->getInner() == IR::IRBTYPE::I32
                || lhstype->getInner() == IR::IRBTYPE::FLOAT)
            && (rhstype->getInner() == IR::IRBTYPE::I32
                || rhstype->getInner() == IR::IRBTYPE::FLOAT),
            "Binary operation must be integers or floats.");

        if (node.getOp() == BiOp::ASSIGN)
        {
            opreandtype = lhstype;
            rhs = try_type_cast(rhs, lhstype->getInner());
        }
        else
        {
            if (lhstype->getInner() == IR::IRBTYPE::FLOAT || rhstype->getInner() == IR::IRBTYPE::FLOAT)
            {
                opreandtype = IR::makeBType(IR::IRBTYPE::FLOAT);
                lhs = try_type_cast(lhs, IR::IRBTYPE::FLOAT);
                rhs = try_type_cast(rhs, IR::IRBTYPE::FLOAT);
            }
            else opreandtype = IR::makeBType(IR::IRBTYPE::I32);
        }
    }

    bool is_int = opreandtype->getInner() == IR::IRBTYPE::I32;

    switch (node.getOp())
    {
    case BiOp::ASSIGN: {
        curr_func->addInst(std::make_shared<IR::STOREInst>(rhs, lhs));
        curr_val = lhs;
    }
        break;
    case BiOp::ADD:
    case BiOp::SUB:
    case BiOp::MUL:
    case BiOp::DIV:
    case BiOp::MOD: {
        IR::OP op;
        switch (node.getOp())
        {
        case BiOp::ADD:
            if (is_int)
                op = IR::OP::ADD;
            else
                op= IR::OP::FADD;
            break;
        case BiOp::SUB:
            if (is_int)
                op = IR::OP::SUB;
            else
                op = IR::OP::FSUB;
            break;
        case BiOp::MUL:
            if (is_int)
                op = IR::OP::MUL;
            else
                op = IR::OP::FMUL;
            break;
        case BiOp::DIV:
            if (is_int)
                op = IR::OP::DIV;
            else
                op = IR::OP::FDIV;
            break;
        case BiOp::MOD:
            if (is_int)
                op = IR::OP::REM;
            else
                op = IR::OP::FREM;
            break;
        default:
                Err::unreachable();
        }
        auto inst = std::make_shared<IR::BinaryInst>(get_temp_name(), op, lhs, rhs);
        curr_func->addInst(inst);
        curr_val = inst;
        break;
    }
    case BiOp::LESSEQ:
    case BiOp::GREATEQ:
    case BiOp::GREAT:
    case BiOp::LESS:
    case BiOp::NOTEQ:
    case BiOp::EQ: {
        if (is_int)
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
            auto inst = std::make_shared<IR::ICMPInst>(get_temp_name(), icmpop, lhs, rhs);
            curr_func->addInst(inst);
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
            auto inst = std::make_shared<IR::FCMPInst>(get_temp_name(), fcmpop, lhs, rhs);
            curr_func->addInst(inst);
            curr_val = inst;
        }
    }
        break;
    case BiOp::AND:
    case BiOp::OR:
        Err::todo("AND OR");
        break;
    }
}

void IRGenerator::visit(UnaryOp& node) {
    node.getExp()->accept(*this);

    auto opreandtype = IR::toBType(curr_val->getType());
    Err::gassert(opreandtype != nullptr
        && (opreandtype->getInner() == IR::IRBTYPE::I32
            || opreandtype->getInner() == IR::IRBTYPE::FLOAT),
        "Unary operation be performed on integer or float.");
    switch (node.getOp())
    {
    case UnOp::ADD:
        break;
    case UnOp::SUB:
        if (opreandtype->getInner() == IR::IRBTYPE::I32)
        {
            auto neg = std::make_shared<IR::BinaryInst>(get_temp_name(), IR::OP::SUB,
                constant_pool.getConst(0), curr_val);
            curr_func->addInst(neg);
            curr_val = neg;
        }
        else
        {
            auto neg = std::make_shared<IR::FNEGInst>(get_temp_name(), curr_val);
            curr_func->addInst(neg);
            curr_val = neg;
        }
        break;
    case UnOp::NOT:
        Err::todo("NOT");
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
    node.getBody()->accept(*this);
    if(node.hasElse()) {
        node.getElseBody()->accept(*this);
    }
}

void IRGenerator::visit(WhileStmt& node) {
    node.getCond()->accept(*this);
    node.getBody()->accept(*this);
}

void IRGenerator::visit(NullStmt& node) {
}

void IRGenerator::visit(BreakStmt& node) {
}

void IRGenerator::visit(ContinueStmt& node) {
}

void IRGenerator::visit(ReturnStmt& node) {
    if (!node.isVoid()) {
        node.getReturnVal()->accept(*this);
        curr_func->addInst(std::make_shared<IR::RETInst>(curr_val));
    }
    else
    {
        curr_func->addInst(std::make_shared<IR::RETInst>());
    }
}

std::string IRGenerator::get_temp_name() {
    return "%" + std::to_string(next_temp_id++);
}

std::shared_ptr<IR::Value> IRGenerator::try_type_cast(std::shared_ptr<IR::Value> val, IR::IRBTYPE dest) {
    if (val->getType()->getTrait() != IR::IRCTYPE::BASIC)
        return val;
    IR::IRBTYPE src = toBType(val->getType())->getInner();
    if (src == IR::IRBTYPE::I32 && dest == IR::IRBTYPE::FLOAT)
    {
        if (auto ci = std::dynamic_pointer_cast<IR::ConstantInt>(val))
        {
            return constant_pool.getConst(static_cast<float>(ci->getVal()));
        }
        else
        {
            Err::gassert(curr_func != nullptr, "Invalid implicit type conversion in global.");
            auto conv = std::make_shared<IR::SITOFPInst>(get_temp_name(), val);
            curr_func->addInst(conv);
            return conv;
        }
    }
    else if (src == IR::IRBTYPE::FLOAT && dest == IR::IRBTYPE::I32)
    {
        if (auto cf = std::dynamic_pointer_cast<IR::ConstantFloat>(val))
        {
            return constant_pool.getConst(static_cast<int>(cf->getVal()));
        }
        else
        {
            Err::gassert(curr_func != nullptr, "Invalid implicit type conversion in global.");
            auto conv = std::make_shared<IR::FPTOSIInst>(get_temp_name(), val);
            curr_func->addInst(conv);
            return conv;
        }
    }
    Err::gassert(src == dest);
    return val;
}

}
