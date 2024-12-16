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
    /// @note 仅Fneg使用
    void operator()(InstArgs insts, BB& BasicBlock) const{
        assert(insts.size() == 1);

        IR::FNEGInst &midEnd_inst = dynamic_cast<IR::FNEGInst&>(insts.begin()->get());
        
        Operand *Def = new Operand(midEnd_inst.getName());

        BasicBlock.Func.VirRegOperandMap[Def->VirReg] = Def;

        if(typeid(midEnd_inst.GetVal()) != typeid(IR::ConstantFloat*)){
            
            int midEnd_virReg = std::stoi(midEnd_inst.GetVal()->getName().substr(1)); // 去掉%

            Operand *Use = BasicBlock.Func.VirRegOperandMap[midEnd_virReg];
            
            
            Instruction* backEnd_inst = new Instruction(
                OperCode::VNEG_F32, nullptr, BasicBlock, {std::ref(*Def)}, {std::ref(*Use)}
                );
        }
        else {
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
            IR::BRInst &midEnd_Branch = dynamic_cast<IR::BRInst&>(insts.begin()->get());
            IR::BasicBlock &destBlock = *midEnd_Branch.getDest();
            
            Imm *backEnd_label = new Imm(OperandType::LABEL, destBlock.getName());

            Instruction *backEnd_b = new Instruction(
                OperCode::B, backEnd_label, BasicBlock, {}, {}
            );

            BasicBlock.InstList.push_back(backEnd_b);

        }
        else{
            // <result> = icmp <cond> <ty> <op1>, <op2>
            // br i1 <cond>, label <iftrue>, label <iffalse>
            
            auto &midEnd_cmp = insts.begin()->get();
            Instruction *backEnd_cmp = nullptr;
            OperCode backEnd_branch_opcode;
            
            if(midEnd_cmp.getOpcode() == IR::OP::ICMP){
                IR::ICMPInst &midEnd_icmp = dynamic_cast<IR::ICMPInst&>(midEnd_cmp);
                
                // set backEnd_branch_opcode
                switch(midEnd_icmp.GetCond()){
                    case IR::ICMPOP::eq:
                        backEnd_branch_opcode = OperCode::BEQ;
                        break;
                    case IR::ICMPOP::ne:
                        backEnd_branch_opcode = OperCode::BNQ;
                        break;
                    case IR::ICMPOP::sge:
                        backEnd_branch_opcode = OperCode::BGE;
                        break;
                    case IR::ICMPOP::sgt:
                        backEnd_branch_opcode = OperCode::BGT;
                        break;
                    case IR::ICMPOP::sle:
                        backEnd_branch_opcode = OperCode::BLE;
                        break;
                    case IR::ICMPOP::slt:
                        backEnd_branch_opcode = OperCode::BLT;
                        break;
                    default:
                        assert(false);    
                }

                int midEnd_virReg1 = std::stoi(midEnd_icmp.GetLHS()->getName().substr(1));
                int midEnd_virReg2 = std::stoi(midEnd_icmp.GetRHS()->getName().substr(1));

                Operand *Use1 = BasicBlock.Func.VirRegOperandMap[midEnd_virReg1];
                Operand *Use2 = BasicBlock.Func.VirRegOperandMap[midEnd_virReg2];

                backEnd_cmp = new Instruction(
                    OperCode::CMP, nullptr, BasicBlock, {}, {std::ref(*Use1), std::ref(*Use2)}
                );

            }
            else{
                IR::FCMPInst &midEnd_fcmp = dynamic_cast<IR::FCMPInst&>(midEnd_cmp);
                
                // set backend opcode
                switch(midEnd_fcmp.GetCond()){
                    case IR::FCMPOP::oeq:
                        backEnd_branch_opcode = OperCode::BEQ;
                        break;
                    case IR::FCMPOP::one:
                        backEnd_branch_opcode = OperCode::BNQ;
                        break;
                    case IR::FCMPOP::oge:
                        backEnd_branch_opcode = OperCode::BGE;
                        break;
                    case IR::FCMPOP::ogt:
                        backEnd_branch_opcode = OperCode::BGT;
                        break;
                    case IR::FCMPOP::ole:
                        backEnd_branch_opcode = OperCode::BLE;
                        break;
                    case IR::FCMPOP::olt:
                        backEnd_branch_opcode = OperCode::BLT;
                        break;
                    case IR::FCMPOP::ord: // not a NaN
                        assert(false);
                        /// @todo waiting
                        break;
                    default:
                        assert(false);
                        break;
                }
                
                int midEnd_virReg1 = std::stoi(midEnd_fcmp.GetLHS()->getName().substr(1));
                int midEnd_virReg2 = std::stoi(midEnd_fcmp.GetRHS()->getName().substr(1));

                Operand *Use1 = BasicBlock.Func.VirRegOperandMap[midEnd_virReg1];
                Operand *Use2 = BasicBlock.Func.VirRegOperandMap[midEnd_virReg2];

                backEnd_cmp = new Instruction(
                    OperCode::VCMP_F32, nullptr, BasicBlock, {}, {std::ref(*Use1), std::ref(*Use2)}
                );
            }
            
            BasicBlock.InstList.push_back(backEnd_cmp);

            IR::BRInst &midEnd_Branch = dynamic_cast<IR::BRInst&>(insts.end()->get());
            
            Imm *TrueBlock = new Imm(OperandType::LABEL, "L" + midEnd_Branch.getTrueDest()->getName());
            Imm *FalseBlock = new Imm(OperandType::LABEL, "L" + midEnd_Branch.getFalseDest()->getName());

            Instruction *backEnd_BranchTrue = new Instruction(
                backEnd_branch_opcode, TrueBlock, BasicBlock, {}, {}
            );    // b<cond> %true
            Instruction *backEnd_BranchFalse = new Instruction{
                OperCode::B, nullptr, BasicBlock, {}, {}
            };   // b ...
            
            BasicBlock.InstList.push_back(backEnd_BranchTrue);
            BasicBlock.InstList.push_back(backEnd_BranchFalse);
        }

    }
};

struct FPTOSIMatch{
    void operator()(InstArgs InstArgs, BB& BasicBlock) const{
        assert(InstArgs.size() == 1);
        auto &midEnd_converse = dynamic_cast<IR::FPTOSIInst&>(InstArgs.begin()->get());

        Operand *Def = new Operand(midEnd_converse.getName());
        BasicBlock.Func.VirRegOperandMap[Def->VirReg] = Def;

        unsigned long midEnd_VirReg = std::stoull(midEnd_converse.getOVal()->getName().substr(1));

        Operand *Use = BasicBlock.Func.VirRegOperandMap[midEnd_VirReg];
        
        Instruction *backEnd_converse = new Instruction(
            OperCode::VCVT_S32_F32, nullptr, BasicBlock, {std::ref(*Def)}, {std::ref(*Use)}
        );
        
        BasicBlock.InstList.push_back(backEnd_converse);
    }   
};

struct SITOFPMatch{
    void operator()(InstArgs InstArgs, BB& BasicBlock) const{
        assert(InstArgs.size() == 1);
        auto &midEnd_converse = dynamic_cast<IR::FPTOSIInst&>(InstArgs.begin()->get());

        Operand *Def = new Operand(midEnd_converse.getName());
        BasicBlock.Func.VirRegOperandMap[Def->VirReg] = Def;

        unsigned long midEnd_VirReg = std::stoull(midEnd_converse.getOVal()->getName().substr(1));

        Operand *Use = BasicBlock.Func.VirRegOperandMap[midEnd_VirReg];
        
        Instruction *backEnd_converse = new Instruction(
            OperCode::VCVT_F32_S32, nullptr, BasicBlock, {std::ref(*Def)}, {std::ref(*Use)}
        );
        
        BasicBlock.InstList.push_back(backEnd_converse);
    }
};

struct CallMatch{
    void operator()(InstArgs InstArgs, BB& BasicBlock) const{
        assert(InstArgs.size() == 1);
        auto &midEnd_call = dynamic_cast<IR::CALLInst&>(InstArgs.begin()->get());

        ///@brief 生成可能冗余的mov保护指令(core)
        ///@brief fpu得另想法子, 比较正常的办法是传参都用core寄存器或者栈空间(便于参数管理)
        ///@brief Def为一个虚拟寄存器, Use则需要预着色为相应的寄存器
        for(int i = 0; i < 4; ++i){
            ///@brief new...
        }

        ///@brief 加载参数
        auto argc_list = midEnd_call.getArgs();
        unsigned int cnt = 0;
        
        for(auto midEnd_argc = argc_list.begin(); midEnd_argc != argc_list.end(); ++cnt, ++midEnd_argc){
            unsigned long long midEnd_VirReg = std::stoull(argc_list[cnt]->getName().substr(1));

            Operand *Use = BasicBlock.Func.VirRegOperandMap[midEnd_VirReg];

            if(cnt > 4){
                MMptr *backEnd_spillArgc = new MMptr(
                    "[sp, #" + std::to_string((cnt - 5)*4) + "]"
                );
                
                Instruction *backEnd_str_argx = new Instruction(
                    OperCode::STR, backEnd_spillArgc, BasicBlock, {}, {std::ref(*Use)}
                );

                BasicBlock.InstList.push_back(backEnd_str_argx);
            }
            else{
                Operand *backEnd_RegArgc = new Operand(cnt);
                
                Instruction *backEnd_str_rx = new Instruction(
                    OperCode::MOV, nullptr, BasicBlock, {std::ref(*backEnd_RegArgc)}, {std::ref(*Use)}
                );

                BasicBlock.InstList.push_back(backEnd_str_rx);
            }
        }

        BasicBlock.Func.setParamSize(std::max(BasicBlock.Func.getParamSize(), (cnt - 4)*4));

        ///@brief arm后端bl语句
        Imm *backEnd_callee = new Imm(
            OperandType::LABEL, midEnd_call.getFuncName()
        );

        Instruction *backEnd_bl = new Instruction(
            OperCode::BL, backEnd_callee, BasicBlock, {}, {}
        );

        ///@brief 寄存器恢复指令(冗余)
        for(int i = 0; i < 4; ++i){
            ///@brief new ...
        }
    }
};

struct PhiMatch{
    ///@note 这个学期估计还用不到
};

///@note AllocMatch, LoadMatch以及StroeMatch需要能取代MkFrameInit, 因为后者无法查表和分发
struct AllocaMatch{
    ///@note 需要考虑数组以及多重数组的情况
    void operator()(InstArgs insts, BB& BasicBlock) const{
    }
};

struct GepMatch{

};

struct LoadMatch{
    void operator()(InstArgs insts, BB& BasicBlock) const{
    }
};  

struct StoreMatch{
    void operator()(InstArgs insts, BB& BasicBlock) const{

    }
};

/// @note BinaryMatch需要考虑imm的encoding是否合理
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
                BasicBlock.Func.VirRegOperandMap[Def->VirReg] = Def;
                
                unsigned long long midEnd_virReg1 = std::stoull(midEnd_inst.GetLHS()->getName().substr(1));
                unsigned long long midEnd_virReg2 = std::stoull(midEnd_inst.GetRHS()->getName().substr(1));
                Operand* Use1 = BasicBlock.Func.VirRegOperandMap[midEnd_virReg1];  // IR operand ptr
                Operand* Use2 = BasicBlock.Func.VirRegOperandMap[midEnd_virReg2];

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