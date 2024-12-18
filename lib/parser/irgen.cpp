#include <ir/instructions/compare.hpp>

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
    IR::IRTYPE ty;
    switch (node.getType())
    {
    case dtype::INT:
        ty = IR::IRTYPE::I32;
        break;
    case dtype::FLOAT:
        ty = IR::IRTYPE::FLOAT;
        break;
    default:
        Err::error("VarDef should always be int or float.");
        break;
    }

    if (curr_func != nullptr)    // Check if global
    {
        std::shared_ptr<IR::ALLOCAInst> alloca_inst;
        if (node.isArray()) {
            std::vector<std::shared_ptr<IR::Value>> val_sizes;
            std::vector<int> static_sizes;
            for (auto& ss : node.getSubscripts()) {
                ss->accept(*this);
                val_sizes.emplace_back(curr_val);
            }

            static_sizes.reserve(val_sizes.size());

            // First we check the end of the Subscripts to see whether
            // the ALLOCAInst's type is an array or int (dynamic).
            // For example:
            // int a[c][2]; -> [2 x i32]
            // int a[2][a]; -> i32
            auto it = val_sizes.rbegin();
            for (; it != val_sizes.rend(); it++)
            {
                if (auto const_int = std::dynamic_pointer_cast<IR::ConstantInt>(*it))
                    static_sizes.insert(static_sizes.begin(), const_int->getVal());
                else break;
            }

            // TODO?: maybe VLA Support

            // All Subscripts are constant or Simply no Subscripts
            // int a[2][3]; int a[] = { xxx };
            if (it == val_sizes.rend())
            {
                Err::assert(node.isInited() || !static_sizes.empty());
                alloca_inst = std::make_shared<IR::ALLOCAInst>(node.getId(), ty, static_sizes);
            }
            // have dynamic Subscripts and ended with dynamics
            // int a[2][c][3][c]
            else if (static_sizes.empty())
            {
                Err::not_implemented("Variable Length Arrays");
            }
            // have dynamic Subscripts but ended with constants
            // int a[2][c][3][2]
            else
            {
                Err::not_implemented("Variable Length Arrays");
            }
        }
        else
        {
            alloca_inst = std::make_shared<IR::ALLOCAInst>(node.getId(), ty);
        }

        curr_func->addInst(alloca_inst);

        curr_init_val.clear();
        if (node.isInited())
        {
            // TODO: nested initializer
            node.getInitVal()->accept(*this);
            if (curr_init_val.empty())
            {
                // TODO: zero initializer
                Err::todo("Zero init");
            }
            else if (!node.getInitVal()->isList())
            {
                Err::assert(curr_init_val.size() == 1);
                Err::assert(!alloca_inst->isArray());
                // TODO: type check
                curr_func->addInst(std::make_shared<IR::STOREInst>(alloca_inst->getBaseType(),
                    curr_init_val[0], alloca_inst));
            }
            else
            {
                Err::assert(alloca_inst->isArray());
                int which_init_type = -1;
                // ConstantInt -> 0
                // ConstantFloat -> 1
                // With ALLOCAInst(s) -> 2, For example:
                //      int c = 1;
                //      int a[] = { c, c, 1 };
                for (auto&& val : curr_init_val)
                {
                    if (auto cint = std::dynamic_pointer_cast<IR::ConstantInt>(val))
                        which_init_type = 0;
                    else if (auto cfloat = std::dynamic_pointer_cast<IR::ConstantFloat>(val))
                        which_init_type = 1;
                    else if (auto alloc = std::dynamic_pointer_cast<IR::ALLOCAInst>(val))
                    {
                        Err::todo("Initializer with GEP");
                        which_init_type = 2;
                        break;
                    }
                }

                // Note that when `which_init_type` is 0 or 1,
                // the `curr_init_val` is expected to be all ConstantInts or ConstantFloats, which is pure constant.
                // Dividing it from initializers mixed with `DeclStmt`
                //  (which is now LOADInst, such as `int c = 1; int a[2] = { c , 1 };) is for future use,
                // such as moving the pure constant initializers to global for performance.

                // TODO: nested initializer
                if (alloca_inst->getStaticArraySize().size() != 1
                    || alloca_inst->getStaticArraySize()[0] != curr_init_val.size())
                    Err::todo("Nested Initializer");

                switch (which_init_type)
                {
                case 0: // Expect ConstantInt Only
                {
                    // TODO: move the array to global according to its size.

                    // type check
                    for (auto&& val : curr_init_val)
                    {
                        auto cint = std::dynamic_pointer_cast<IR::ConstantInt>(val);
                        Err::assert(cint != nullptr, "Inconsistent initializer's type");
                    }

                    for (int i = 0; i < curr_init_val.size(); i++)
                    {
                        auto gep_inst = std::make_shared<IR::GEPInst>(get_temp_name(), IR::IRTYPE::I32,
                            alloca_inst->getStaticArraySize(), alloca_inst,
                            std::list{std::dynamic_pointer_cast<IR::Value>(std::make_shared<IR::ConstantInt>(i))});
                        auto str_inst = std::make_shared<IR::STOREInst>(IR::IRTYPE::I32,
                            curr_init_val[i], gep_inst);
                        curr_func->addInst(gep_inst);
                        curr_func->addInst(str_inst);
                    }
                }
                    break;
                case 1: // Expect ConstantFloat Only
                {
                    // TODO: move the array to global according to its size.

                    // type check
                    for (auto&& val : curr_init_val)
                    {
                        auto cfloat = std::dynamic_pointer_cast<IR::ConstantFloat>(val);
                        Err::assert(cfloat != nullptr, "Inconsistent initializer's type");
                    }

                    for (int i = 0; i < curr_init_val.size(); i++)
                    {
                        auto gep_inst = std::make_shared<IR::GEPInst>(get_temp_name(), IR::IRTYPE::FLOAT,
                            alloca_inst->getStaticArraySize(), alloca_inst,
                            std::list{std::dynamic_pointer_cast<IR::Value>(std::make_shared<IR::ConstantFloat>(i))});
                        auto str_inst = std::make_shared<IR::STOREInst>(IR::IRTYPE::FLOAT,
                            curr_init_val[i], gep_inst);
                        curr_func->addInst(gep_inst);
                        curr_func->addInst(str_inst);
                    }
                }
                    break;
                case 2: // Expect Initializers mixed with ALLOCAInst(s)
                {
                    // type check
                    int type = -1; // 0 for int, 1 for float
                    for (int i = 0; i < curr_init_val.size(); i++)
                    {
                        auto& val = curr_init_val[i];
                        if (auto cint = std::dynamic_pointer_cast<IR::ConstantInt>(val))
                        {
                            Err::assert(type == -1 || type == 0, "Inconsistent initializer's type");
                            type = 0;
                        }
                        else if (auto cfloat = std::dynamic_pointer_cast<IR::ConstantFloat>(val))
                        {
                            Err::assert(type == -1 || type == 1, "Inconsistent initializer's type");
                            type = 1;
                        }
                        else if (auto load_inst = std::dynamic_pointer_cast<IR::LOADInst>(val))
                        {
                            if (load_inst->getType() == IR::IRTYPE::I32)
                            {
                                Err::assert(type == -1 || type == 0, "Inconsistent initializer's type");
                                type = 0;
                            }
                            else if (load_inst->getType() == IR::IRTYPE::FLOAT)
                            {
                                Err::assert(type == -1 || type == 1, "Inconsistent initializer's type");
                                type = 1;
                            }
                            else
                                Err::error("Invalid type in array initializer.");
                        }

                        auto irtype = type == 0 ? IR::IRTYPE::I32 : IR::IRTYPE::FLOAT;
                        auto gep_inst = std::make_shared<IR::GEPInst>(get_temp_name(), irtype,
                            alloca_inst->getStaticArraySize(), alloca_inst,
                            std::list{std::dynamic_pointer_cast<IR::Value>(std::make_shared<IR::ConstantFloat>(i))});
                        auto str_inst = std::make_shared<IR::STOREInst>(irtype,
                            curr_init_val[i], gep_inst);
                        curr_func->addInst(gep_inst);
                        curr_func->addInst(str_inst);
                    }
                }
                    break;
                default:
                    Err::unreachable();
                }
            }
        }
        symbol_table.insert(node.getId(), alloca_inst);
    }
    else
    {
        Err::todo("Global Variable");
    }
}

void IRGenerator::visit(InitVal& node) {
    if (node.isList()) {
        if (!curr_init_val.empty())
        {
            Err::todo("Nested Initializer");
        }
        curr_init_val.clear();
        if (!node.isEmpty()) {
            for (auto& iv : node.getInner()) {
                iv->accept(*this);
                curr_init_val.emplace_back(curr_val);
            }
        }
    } else {
        node.getExp()->accept(*this);
        curr_init_val.emplace_back(curr_val);
        curr_val = nullptr;
    }
}

void IRGenerator::visit(ArraySubscript& node) {
    node.getExp()->accept(*this);
}

// FunctionDef: 'func' int32
void IRGenerator::visit(FuncDef& node) {
    IR::IRTYPE ty;
    switch (node.getType())
    {
    case dtype::INT:
        ty = IR::IRTYPE::I32;
        break;
    case dtype::FLOAT:
        ty = IR::IRTYPE::FLOAT;
        break;
    default:
        Err::error("Function should always return int or float.");
        break;
    }

    curr_func = std::make_shared<IR::Function>(node.getId(), ty);
    // TODO: Function Params
    if (!node.isEmptyParam()) {
        // for (auto& p : node.getParams()) {
        //     p->accept(*this);
        //     curr_func->addParam(curr_val);
        // }
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
void IRGenerator::visit(DeclRef& node) {
    auto ref = symbol_table.lookup(node.getId());
    Err::assert(ref != nullptr,
        "Invalid reference to '" + node.getId() + "', not found.");


    // TODO: Prevent potential bugs
    if (auto alloca_inst = std::dynamic_pointer_cast<IR::ALLOCAInst>(ref))
    {
        if (alloca_inst->isArray())
            curr_val = alloca_inst;
        else
            curr_val = std::make_shared<IR::LOADInst>(get_temp_name(), alloca_inst->getBaseType(), alloca_inst);
    }
    else if (auto gv = std::dynamic_pointer_cast<IR::GlobalVariable>(ref))
        curr_val = gv;
    else
        Err::error("Unexpected reference type.");
}

// a[2][1]
// ArrayExp: 'a' [2][1]
void IRGenerator::visit(ArrayExp& node) {
    node.getRef()->accept(*this);
    auto base = curr_val;

    std::list<std::shared_ptr<IR::Value>> idx;
    for (auto& ss : node.getIndices()) {
        ss->accept(*this);
        Err::assert(curr_val->getType() == IR::IRTYPE::I32, "Array subscripts must be integers.");
        idx.emplace_back(curr_val);
    }

    if (auto alloca_inst = std::dynamic_pointer_cast<IR::ALLOCAInst>(base))
    {
        if (!alloca_inst->isStatic())
        {
            Err::not_implemented("Variable Length Array");
        }

        curr_val = std::make_shared<IR::GEPInst>(get_temp_name(), alloca_inst->getBaseType(),
            alloca_inst->getStaticArraySize(), base, idx);
    }
    else if (auto gv = std::dynamic_pointer_cast<IR::GlobalVariable>(base))
    {
        curr_val = std::make_shared<IR::GEPInst>(get_temp_name(), gv->getVarType(),
            gv->getArraySize(), base, idx);
    }
}

// a(1, 2, 3)
// CallExp: 'a' (1, 2, 3, )
void IRGenerator::visit(CallExp& node) {
    node.getRef()->accept(*this);

    auto func = std::dynamic_pointer_cast<IR::Function>(curr_func);
    Err::assert(func != nullptr, "Invalid to call '" + node.getId() + "', which is not a function.");

    // TODO: type chek

    std::vector<std::shared_ptr<IR::Value>> args;
    if (!node.isEmptyParam()) {
        for (auto& p : node.getParams()) {
            p->accept(*this);
            args.emplace_back(curr_val);
        }
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

    auto irtype = rhs->getType();
    switch (node.getOp())
    {
    case BiOp::ASSIGN:
        // TODO: type check
        curr_func->addInst(std::make_shared<IR::STOREInst>(rhs->getType(), rhs, lhs));
        curr_val = lhs;
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
            if (irtype == IR::IRTYPE::I32)
                op = IR::OP::ADD;
            else
                op= IR::OP::FADD;
            break;
        case BiOp::SUB:
            if (irtype == IR::IRTYPE::I32)
                op = IR::OP::SUB;
            else
                op = IR::OP::FSUB;
            break;
        case BiOp::MUL:
            if (irtype == IR::IRTYPE::I32)
                op = IR::OP::MUL;
            else
                op = IR::OP::FMUL;
            break;
        case BiOp::DIV:
            if (irtype == IR::IRTYPE::I32)
                op = IR::OP::DIV;
            else
                op = IR::OP::FDIV;
            break;
        case BiOp::MOD:
            if (irtype == IR::IRTYPE::I32)
                op = IR::OP::REM;
            else
                op = IR::OP::FREM;
            break;
        }
        auto inst = std::make_shared<IR::BinaryInst>(get_temp_name(), op, lhs, rhs);
        curr_func->addInst(inst);
        curr_val = inst;
    }
    case BiOp::LESSEQ:
    case BiOp::GREATEQ:
    case BiOp::GREAT:
    case BiOp::NOTEQ:
    case BiOp::EQ: {
        Err::todo("Finish cmp");
        IR::ICMPOP icmpop;
        IR::FCMPOP fcmpop;
        switch (node.getOp())
        {
        case BiOp::LESSEQ:
            break;
        case BiOp::GREATEQ:
            break;
        case BiOp::GREAT:
            break;
        case BiOp::NOTEQ:
            break;
        case BiOp::EQ:
            break;
        }
        if (irtype == IR::IRTYPE::I32)
        {
            auto inst = std::make_shared<IR::ICMPInst>(get_temp_name(), icmpop, lhs, rhs);
            curr_func->addInst(inst);
            curr_val = inst;
        }
        else
        {
            auto inst = std::make_shared<IR::FCMPInst>(get_temp_name(), fcmpop, lhs, rhs);
            curr_func->addInst(inst);
            curr_val = inst;
        }
    }
        break;
    case BiOp::AND:
    case BiOp::OR:
        Err::todo("Finish and or");
        break;
    }
}

void IRGenerator::visit(UnaryOp& node) {
    node.getExp()->accept(*this);
}

void IRGenerator::visit(ParenExp& node) {
    node.getExp()->accept(*this);
}

void IRGenerator::visit(IntLiteral& node) {
    curr_val = std::make_shared<IR::ConstantInt>(node.getValue());
}

void IRGenerator::visit(FloatLiteral& node) {
    curr_val = std::make_shared<IR::ConstantFloat>(node.getValue());
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
    return "__tmp" + std::to_string(next_temp_id++);
}
}