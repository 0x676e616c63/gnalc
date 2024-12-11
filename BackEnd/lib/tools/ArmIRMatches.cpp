#include <list>
#include <cassert>
#include "../../Arm.hpp"
#include "../../include/tools/ArmTools.hpp"
#include "../../include/ArmComplexMIRStruct/ArmOperand.hpp"
#include "../../include/ArmComplexMIRStruct/ArmFunction.hpp"
#include "../../include/ArmComplexMIRStruct/ArmBB.hpp"
#include "../../include/ArmComplexMIRStruct/ArmInstruction.hpp"
#include "../../../include/ir/instruction.hpp"
#include "../../../include/ir/instructions/binary.hpp"
#include "../../../include/ir/instructions/compare.hpp"
#include "../../../include/ir/instructions/control.hpp"
#include "../../../include/ir/instructions/converse.hpp"
#include "../../../include/ir/instructions/helper.hpp"
#include "../../../include/ir/instructions/memory.hpp"
#include "../../../include/ir/instructions/phi.hpp"

using namespace ArmTools;
using namespace ArmStruct;

struct UnaryMatch{
    void operator()(InstArgs insts, BB& BasicBlock) const{
        assert(insts.size() == 1);

        IR::FNEGInst &midEnd_inst = dynamic_cast<IR::FNEGInst&>(insts.begin()->get());

        OperCode backEnd_opcode = OperCode::VNEG_F32;
        
        Operand *Def = new Operand(midEnd_inst.getName());
        
        if(typeid(midEnd_inst.GetVal()) != typeid(IR::ConstantFloat*)){
            Operand *Use = new Operand(midEnd_inst.GetVal());
            BasicBlock.Func.VirRegOperandMap[Use->VirReg] = Use;
            Instruction* backEnd_inst = new Instruction(
                backEnd_opcode, nullptr, BasicBlock, {std::ref(*Def)}, {std::ref(*Use)});
        }
        else{
            // 转化为movt和movw
            // Imm *newAttach = new Imm();
        }
        return ;
    }
};

struct BranchMatch{
    void operator()(InstArgs insts, BB& BasicBlock) const{
        assert(insts.end()->get().getOpcode() == IR::OP::BR);
        
        if(insts.size() == 1){
            // br label <dest> 
        }
        else{
            // <result> = icmp <cond> <ty> <op1>, <op2>
            // br i1 <cond>, label <iftrue>, label <iffalse>
        }

    }
};

struct BinaryMatch{
    void operator()(InstArgs insts, BB& BasicBlock) const{
        assert(insts.size() == 1);

        IR::BinaryInst &midEnd_inst = dynamic_cast<IR::BinaryInst&>(insts.begin()->get());

        OperCode backEnd_opcode;

        if(midEnd_inst.getOpcode() != IR::OP::FREM && midEnd_inst.getOpcode() != IR::OP::REM){
            ///@note if1 single inst
            switch(midEnd_inst.getOpcode()){
            case IR::OP::ADD:
                backEnd_opcode = ADD;
                break;
            case IR::OP::FADD:
                backEnd_opcode = VADD_F32;
                break;
            case IR::OP::SUB:
                backEnd_opcode = SUB;
                break;
            case IR::OP::FSUB:
                backEnd_opcode = VSUB_F32;
                break;
            case IR::OP::DIV:
                backEnd_opcode = DIV;
                break;
            case IR::OP::FDIV:
                backEnd_opcode = VDIV_F32;
                break;
            default:
                assert(false);
            }
            ///@note 两个Operand均为虚拟寄存器
            if(typeid(midEnd_inst.GetLHS()) != typeid(IR::ConstantInt*)
            && typeid(midEnd_inst.GetLHS()) != typeid(IR::ConstantFloat*)
            && typeid(midEnd_inst.GetRHS()) != typeid(IR::ConstantFloat*)
            && typeid(midEnd_inst.GetRHS()) != typeid(IR::ConstantInt*)){
                Operand* Def = new Operand(midEnd_inst.getName());
                Operand* Use1 = new Operand(midEnd_inst.GetLHS());  // IR operand ptr
                Operand* Use2 = new Operand(midEnd_inst.GetRHS());

                BasicBlock.Func.VirRegOperandMap[Def->VirReg] = Def;
                BasicBlock.Func.VirRegOperandMap[Use1->VirReg] = Use1;
                BasicBlock.Func.VirRegOperandMap[Use2->VirReg] = Use2;

                Instruction *backEnd_binary = new Instruction(
                    backEnd_opcode, nullptr, BasicBlock, {std::ref(*Def)}, {std::ref(*Use1), std::ref(*Use2)}
                    );

                BasicBlock.InstList.push_back(backEnd_binary);

                return;
            }
            ///@note 存在两个立即量, 常量拦截
            else if(typeid(midEnd_inst.GetLHS()) == typeid(IR::ConstantInt*)
            && typeid(midEnd_inst.GetRHS()) == typeid(IR::ConstantInt*)
            || typeid(midEnd_inst.GetLHS()) != typeid(IR::ConstantFloat*)
            && typeid(midEnd_inst.GetRHS()) != typeid(IR::ConstantFloat*)){
                
                if(typeid(midEnd_inst.GetLHS()) == typeid(IR::ConstantInt*)){
                    // int
                    auto LHS = dynamic_cast<IR::CI32*>(midEnd_inst.GetLHS());
                    auto RHS = dynamic_cast<IR::CI32*>(midEnd_inst.GetRHS());
                    int temp = LHS->getVal() + RHS->getVal();

                    /// @todo 简单合法化, break into two 
                    
                    // Imm* newAttach = new Imm(OperandType::INT, );

                    // or Imm* newAttach2 = new Imm(OperandType::INT, ); 

                    // Operand *Def = new Operand(midEnd_inst.getName());

                    // BasicBlock.Func.VirRegOperandMap[Def->VirReg] = Def;

                    // Instruction *backEnd_movw = new Instrction(Operand::MOVT, newAttach, BasicBlock, {std::ref(*Def)}, {});

                    // Instruction *backEnd_movt = new 

                    // BasicBlock.InstList.push_back(backEnd_movw);

                    // BasicBlock.InstList.push_back(backEnd_movt);
                    return;

                }
                if(typeid(midEnd_inst.GetLHS()) == typeid(IR::ConstantFloat*)){
                    // float
                    auto LHS = dynamic_cast<IR::CF32*>(midEnd_inst.GetLHS());
                    auto RHS = dynamic_cast<IR::CF32*>(midEnd_inst.GetRHS());
                    float temp = LHS->getVal() + RHS->getVal();

                    /// @todo 简单合法化, 简化为,break into mov 
                    
                    // Imm* newAttach = new Imm(OperandType::FLOAT, );

                    // or Imm* newAttach = new Imm(OperandType::FLOAT, ); 

                    // Operand *Def = new Operand(midEnd_inst.getName());

                    // BasicBlock.Func.VirRegOperandMap[Def->VirReg] = Def;

                    // Instruction *backEnd_movw = new Instrction(Operand::MOVT, newAttach, BasicBlock, {std::ref(*Def)}, {});

                    // BasicBlock.InstList.push_back(backEnd_movw);
                }

            }
            ///@note 一个立即量
            else{
                Imm* newAttach = nullptr;
                if(typeid(midEnd_inst.GetLHS()) == typeid(IR::CI32*)
                || typeid(midEnd_inst.GetLHS()) == typeid(IR::CF32*)){
                    // LHS
                    if(typeid(midEnd_inst.GetLHS()) == typeid(IR::CI32*)){
                        auto LHS = dynamic_cast<IR::CI32*>(midEnd_inst.GetLHS());
                        // 不用合法化, 转换为一条add指令

                        // 需要合法化, 转化为两条add指令(注意保存SSA形式)
                        //eg: %3 = add %2 114514
                        //mir:  add %3, %2, #114176
                        //      add %4, %3, #338
                        // 需要多出一个 %4 虚拟寄存器

                        // 注意虚拟寄存器添加映射, 以及inst入链
                    }
                    else{
                        auto LHS = dynamic_cast<IR::CF32*>(midEnd_inst.GetLHS());
                        // 同上


                    }

                }
                else{
                    if(typeid(midEnd_inst.GetRHS()) == typeid(IR::CI32*)){
                        auto RHS = dynamic_cast<IR::CI32*>(midEnd_inst.GetRHS());
                        //同上

                    }
                    else{
                        auto RHS = dynamic_cast<IR::CF32*>(midEnd_inst.GetRHS());
                        // 同上

                    }
                }
            }

            return;   
        }

        else{
            ///@note if1 FREM or REM
            if(midEnd_inst.getOpcode() == IR::OP::REM){
                // %3 = REM %1, %2
                // sdiv %4_new, %1, %2
	            // mul %5_new, %4_new, %2
	            // sub %3, %1, %5_new
                
                ///@todo 常量拦截, 一组movt, movw
                if(typeid(midEnd_inst.GetLHS()) == typeid(IR::CI32)
                && typeid(midEnd_inst.GetRHS()) == typeid(IR::CI32)){
                    // 
                }
                ///@todo 存在一个常量, 需要添加一组movt, movw
                else if(typeid(midEnd_inst.GetLHS()) == typeid(IR::CI32)
                && typeid(midEnd_inst.GetRHS()) == typeid(IR::CI32)){
                    
                }
                ///@todo 两个虚拟寄存器
                else{

                }
            }
            else{
                // FREM转换同上

                ///@todo 常量拦截, 一组movt, movw
                if(typeid(midEnd_inst.GetLHS()) == typeid(IR::CF32)
                && typeid(midEnd_inst.GetRHS()) == typeid(IR::CF32)){
                    // 
                }
                ///@todo 存在一个常量, 需要添加一组movt, movw
                else if(typeid(midEnd_inst.GetLHS()) == typeid(IR::CF32)
                && typeid(midEnd_inst.GetRHS()) == typeid(IR::CF32)){
                    
                }
                ///@todo 两个虚拟寄存器
                else{

                }
            }
        }
    }
};