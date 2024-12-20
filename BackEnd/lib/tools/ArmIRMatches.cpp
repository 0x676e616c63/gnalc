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

struct ArmTools::MovtwMatch{
    /// @brief 用于操作数不能为立即数, 或者立即数不合法的指令
    BB& BasicBlock;
    void operator()(float imme, unsigned long long &temp_VirReg) {
        int Ieee754 = *reinterpret_cast<unsigned int*>(&imme);
        
        if(isImmCanBeEncodedInText(imme)){
            /// @brief mov %temp1  #imm
            /// @brief vmov %temp2 %temp1
            
            Imm *backEnd_imm = new Imm(OperandType::FLOAT, std::to_string(Ieee754));
            
            Operand *backEnd_temp1_def = new Operand(OperandType::FLOAT, temp_VirReg);
            BasicBlock.Func.VirRegOperandMap[temp_VirReg++] = backEnd_temp1_def;
            Operand *backEnd_temp2_def = new Operand(OperandType::FLOAT, temp_VirReg);
            BasicBlock.Func.VirRegOperandMap[temp_VirReg++] = backEnd_temp2_def;

            Instruction *backEnd_mov = new Instruction(
                OperCode::MOV, backEnd_imm, BasicBlock, {std::ref(*backEnd_temp1_def)}, {}
            );
            
            Instruction *backEnd_vmov = new Instruction(
              OperCode::VMOV, backEnd_imm, BasicBlock, {std::ref(*backEnd_temp2_def)}, {std::ref(*backEnd_temp1_def)}
            );
            BasicBlock.InstList.push_back(backEnd_mov);
            BasicBlock.InstList.push_back(backEnd_vmov);

        }
        else{
            /// @warning 这个拆分成两个mov的步骤, 还是应该phi之后做, 因为这里违反了ssa
            /// @brief movw %temp #low
            /// @brief movt %temp #high
            /// @brief vmov %temp2, %temp
            
            Imm *backEnd_imm_low16 = new Imm(OperandType::FLOAT, std::to_string(Ieee754 & 0xffff));
            Imm *backEnd_imm_high16 = new Imm(OperandType::FLOAT, std::to_string(Ieee754 >> 16));
            
            Operand *backEnd_temp1_def = new Operand(OperandType::INT, temp_VirReg);
            BasicBlock.Func.VirRegOperandMap[temp_VirReg++] = backEnd_temp1_def;
            Operand *backEnd_temp2_def = new Operand(OperandType::FLOAT, temp_VirReg);
            BasicBlock.Func.VirRegOperandMap[temp_VirReg++] = backEnd_temp2_def;

            Instruction *backEnd_movw = new Instruction(
                OperCode::MOVW, backEnd_imm_low16, BasicBlock, {std::ref(*backEnd_temp1_def)}, {}
            );
            Instruction *backEnd_movt = new Instruction(
                OperCode::MOVT, backEnd_imm_high16, BasicBlock, {std::ref(*backEnd_temp1_def)}, {}
            );
            Instruction *backEnd_vmov = new Instruction(
                OperCode::VMOV, nullptr, BasicBlock, {std::ref(*backEnd_temp2_def)}, {std::ref(*backEnd_temp1_def)}
            );
            BasicBlock.InstList.push_back(backEnd_movw);
            BasicBlock.InstList.push_back(backEnd_movt);
            BasicBlock.InstList.push_back(backEnd_vmov);

        }
    }

    void operator()(int imme, unsigned long long &temp_VirReg) {
        
        if(isImmCanBeEncodedInText((unsigned long long)imme)){
            ///@brief mov %temp #imm
            Imm *backEnd_imm = new Imm(OperandType::INT, std::to_string(imme));

            Operand *backEnd_temp_def = new Operand(OperandType::INT, temp_VirReg);
            BasicBlock.Func.VirRegOperandMap[temp_VirReg++] = backEnd_temp_def;

            Instruction *backEnd_mov = new Instruction(
                OperCode::MOV, backEnd_imm, BasicBlock, {std::ref(*backEnd_temp_def)}, {}
            );
            BasicBlock.InstList.push_back(backEnd_mov);

        }
        else{
            ///@brief movw %temp #imm
            ///@brief movt %temp #imm
            Imm *backEnd_imm_low16 = new Imm(OperandType::INT, std::to_string(imme & 0xffff));
            Imm *backEnd_imm_high16 = new Imm(OperandType::INT, std::to_string(imme >> 16));

            Operand *backEnd_temp_def = new Operand(OperandType::INT, temp_VirReg);
            BasicBlock.Func.VirRegOperandMap[temp_VirReg++] = backEnd_temp_def;

            Instruction *backEnd_movw = new Instruction(
                OperCode::MOVW, backEnd_imm_low16, BasicBlock, {std::ref(*backEnd_temp_def)}, {}
            );
            Instruction *backEnd_movt = new Instruction(
                OperCode::MOVT, backEnd_imm_high16, BasicBlock, {std::ref(*backEnd_temp_def)}, {}
            );
            BasicBlock.InstList.push_back(backEnd_movw);
            BasicBlock.InstList.push_back(backEnd_movt);

        }
    }
    
    bool isImmCanBeEncodedInText(unsigned long long imme){
        for (int shift = 0; shift <= 32; shift += 2){
            if ((((imme << shift) | (imme >> (32 - shift))) & ~0xff) == 0){
                return true;
            }
        }
        return false;
    }

    bool isImmCanBeEncodedInText(float imme){
        float eps = 1e-14f;
        float a = imme * 128;
        for (int r = 0; r < 8; ++r) {
            for (int n = 16; n < 32; ++n) {
                if ((abs((n * (1 << (7 - r)) - a)) < eps) ||
                        (abs((n * (1 << (7 - r)) + a)) < eps))
                    return true;
            }
        }
        return false;
    }

};

struct ArmTools::UnaryMatch{
    /// @note 仅Fneg使用
    BB& BasicBlock;
    MovtwMatch immeMatch;
    void operator()(InstArgs insts){
        assert(insts.size() == 1);

        IR::FNEGInst &midEnd_inst = dynamic_cast<IR::FNEGInst&>(insts.begin()->get());
        
        Operand *Def = new Operand(OperandType::FLOAT, midEnd_inst.getName());

        BasicBlock.Func.VirRegOperandMap[Def->VirReg] = Def;

        if(typeid(midEnd_inst.getVal()) != typeid(IR::ConstantFloat*)){
            // 虚拟寄存器

            int midEnd_virReg = std::stoi(midEnd_inst.getVal()->getName().substr(1)); // 去掉%

            Operand *Use = BasicBlock.Func.VirRegOperandMap[midEnd_virReg];
            
            Instruction* backEnd_inst = new Instruction(
                OperCode::VNEG_F32, nullptr, BasicBlock, {std::ref(*Def)}, {std::ref(*Use)}
                );
        }
        else {
            // 立即数
            // 转化为movt和movw
            // vneg.f32 %x, %temp
            ///@brief 将float * 强制转化为 unsigned int *
            
            float minEnd_FPimm = dynamic_cast<IR::ConstantFloat*>(midEnd_inst.getVal())->getVal();

            immeMatch(minEnd_FPimm, BasicBlock.Func.VRegNum); // vmov

            Operand *Use = BasicBlock.Func.VirRegOperandMap[BasicBlock.Func.VRegNum - 1];

            Instruction *backEnd_vneg = new Instruction(
                OperCode::VNEG_F32, nullptr, BasicBlock, {std::ref(*Def)}, {std::ref(*Use)}
            );

            BasicBlock.InstList.push_back(backEnd_vneg);

        }
        return ;
    }
};

struct ArmTools::BranchMatch{
    BB& BasicBlock;
    void operator()(InstArgs insts) const{
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
                switch(midEnd_icmp.getCond()){
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

                int midEnd_virReg1 = std::stoi(midEnd_icmp.getLHS()->getName().substr(1));
                int midEnd_virReg2 = std::stoi(midEnd_icmp.getRHS()->getName().substr(1));

                Operand *Use1 = BasicBlock.Func.VirRegOperandMap[midEnd_virReg1];
                Operand *Use2 = BasicBlock.Func.VirRegOperandMap[midEnd_virReg2];

                backEnd_cmp = new Instruction(
                    OperCode::CMP, nullptr, BasicBlock, {}, {std::ref(*Use1), std::ref(*Use2)}
                );

            }
            else{
                IR::FCMPInst &midEnd_fcmp = dynamic_cast<IR::FCMPInst&>(midEnd_cmp);
                
                // set backend opcode
                switch(midEnd_fcmp.getCond()){
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
                
                int midEnd_virReg1 = std::stoi(midEnd_fcmp.getLHS()->getName().substr(1));
                int midEnd_virReg2 = std::stoi(midEnd_fcmp.getRHS()->getName().substr(1));

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

struct ArmTools::FPTOSIMatch{
    BB& BasicBlock;
    void operator()(InstArgs InstArgs) const{
        assert(InstArgs.size() == 1);
        auto &midEnd_converse = dynamic_cast<IR::FPTOSIInst&>(InstArgs.begin()->get());

        Operand *Def = new Operand(OperandType::INT, midEnd_converse.getName());
        BasicBlock.Func.VirRegOperandMap[Def->VirReg] = Def;

        unsigned long midEnd_VirReg = std::stoull(midEnd_converse.getOVal()->getName().substr(1));

        Operand *Use = BasicBlock.Func.VirRegOperandMap[midEnd_VirReg];
        
        Instruction *backEnd_converse = new Instruction(
            OperCode::VCVT_S32_F32, nullptr, BasicBlock, {std::ref(*Def)}, {std::ref(*Use)}
        );
        
        BasicBlock.InstList.push_back(backEnd_converse);
    }   
};

struct ArmTools::SITOFPMatch{
    BB& BasicBlock;
    void operator()(InstArgs InstArgs) const{
        assert(InstArgs.size() == 1);
        auto &midEnd_converse = dynamic_cast<IR::FPTOSIInst&>(InstArgs.begin()->get());

        Operand *Def = new Operand(OperandType::FLOAT, midEnd_converse.getName());
        BasicBlock.Func.VirRegOperandMap[Def->VirReg] = Def;

        unsigned long midEnd_VirReg = std::stoull(midEnd_converse.getOVal()->getName().substr(1));

        Operand *Use = BasicBlock.Func.VirRegOperandMap[midEnd_VirReg];
        
        Instruction *backEnd_converse = new Instruction(
            OperCode::VCVT_F32_S32, nullptr, BasicBlock, {std::ref(*Def)}, {std::ref(*Use)}
        );
        
        BasicBlock.InstList.push_back(backEnd_converse);
    }
};

struct ArmTools::CallMatch{
    BB& BasicBlock;
    void operator()(InstArgs InstArgs) const{
        assert(InstArgs.size() == 1);
        auto &midEnd_call = dynamic_cast<IR::CALLInst&>(InstArgs.begin()->get());

        ///@warning 这里部分应该理论上应该放在phi之后, 寄存器分配之前, 这里的Use没有被Def过
        ///@brief 生成可能冗余的mov保护指令(core)
        ///@brief fpu得另想法子, 比较正常的办法是传参都用core寄存器或者栈空间(便于参数管理)
        ///@brief Def为一个虚拟寄存器, Use则需要预着色为相应的寄存器
        std::vector<unsigned long long> backEnd_temp_VReg = {};

        for(int i = 0; i < 4; ++i){
            ///@brief mov %temp(Def), rx(Use)
            Operand *Def = new Operand(OperandType::INT, "%" + std::to_string(BasicBlock.Func.VRegNum));
            backEnd_temp_VReg.push_back(BasicBlock.Func.VRegNum);
            BasicBlock.Func.VirRegOperandMap[BasicBlock.Func.VRegNum++] = Def; 
            
            Operand *Use = new Operand(OperandType::INT, i);

            Instruction *backEnd_callee_rx = new Instruction(
                OperCode::MOV, nullptr, BasicBlock, {std::ref(*Def)}, {std::ref(*Use)}
            );
            BasicBlock.InstList.push_back(backEnd_callee_rx);

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
                Operand *backEnd_RegArgc = new Operand(OperandType::INT, cnt);
                
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
            ///@brief mov rx, %temp
            Operand *Def = new Operand(OperandType::INT, i);
            Operand *Use = BasicBlock.Func.VirRegOperandMap[backEnd_temp_VReg[i]];

            Instruction *backEnd_callee_rx = new Instruction(
                OperCode::MOV, nullptr, BasicBlock, {std::ref(*Def)}, {std::ref(*Use)}
            );

            BasicBlock.InstList.push_back(backEnd_callee_rx);
        }
    }
};

struct ArmTools::PhiMatch{
    ///@note 这个学期估计还用不到
    BB& BasicBlock;

};


struct AllocaMatch{
    ///@note 需要考虑数组以及多重数组的情况
    BB& BasicBlock;
    void operator()(InstArgs insts){
        assert(insts.size() == 1);

        auto &midEnd_alloca = dynamic_cast<IR::ALLOCAInst&>(insts.begin()->get());

        if(midEnd_alloca.isStatic()) staticMemory(midEnd_alloca); 
        else dynamicMemory(midEnd_alloca);
        
    }
    void staticMemory(IR::ALLOCAInst& midEnd_alloca){
        unsigned int ObjSize = 4;
        unsigned long long VirPtr = std::stoull(midEnd_alloca.getName().substr(1));
        for(auto layer : midEnd_alloca.getStaticArraySize()){
            ObjSize *= layer;
        }
        
        FrameObj *backEnd_stackVal = new FrameObj(
            BasicBlock.Func.getLocal(), OperandType::INT, ObjSize, VirPtr
        );  // 开辟一个FrameObj, 同时保存alloca的name
        return;
    }

    void dynamicMemory(IR::ALLOCAInst& midEnd_alloca){
        // 不会做
    }
};

struct ArmTools::GepMatch{
    BB& BasicBlock;
    void operator()(InstArgs insts){
        /// @brief insts可能为一个语句或者几个语句, 取决于index有几层
        /// @brief MIR不设置alloca语句, 但要填写FrameObj
        /// @brief 最后的成品是将一个Obj的偏移绑定到一个MMptr上
        
    }
};

struct ArmTools::LoadMatch{
    BB& BasicBlock;
    // store #imm/rx %mmptr
    void operator()(InstArgs insts) const{
        assert(insts.size() == 1);
        auto &midEnd_store = dynamic_cast<IR::STOREInst&>(insts.begin()->get());

        // 局部变量 MMptr, 假设中端传来的是简单ptr(不带gep)
        auto idx = std::stoull(midEnd_store.getPtr()->getName().substr(1));
        MMptr *ptr = BasicBlock.Func.getLocal()->findMMptr(idx);
        

        // 全局变量 Label

    }
};  

struct ArmTools::StoreMatch{
    BB& BasicBlock;
    void operator()(InstArgs insts) const{
        assert(insts.size() == 1);
    }
};


struct ArmTools::BinaryMatch{
    BB& BasicBlock;
    
    MovtwMatch immeMatch;

    void operator()(InstArgs insts){
        assert(insts.size() == 1);
        
        auto &midEnd_binary = dynamic_cast<IR::BinaryInst&>(insts.begin()->get());

        switch(midEnd_binary.getOpcode()){
            /// @note 之后
            case IR::OP::ADD:   IntOrdinaryMatch(midEnd_binary, OperCode::ADD); return;
            case IR::OP::SUB:   IntOrdinaryMatch(midEnd_binary, OperCode::SUB); return;
            case IR::OP::MUL:   SMulMatch(midEnd_binary); return;
            case IR::OP::DIV:   SDivMatch(midEnd_binary); return;
            case IR::OP::FADD:  FloatOrdinaryMatch(midEnd_binary, OperCode::VADD_F32); return;
            case IR::OP::FSUB:  FloatOrdinaryMatch(midEnd_binary, OperCode::VSUB_F32); return;
            case IR::OP::FMUL:  FloatOrdinaryMatch(midEnd_binary, OperCode::VMUL_F32); return;
            case IR::OP::FDIV:  FloatOrdinaryMatch(midEnd_binary, OperCode::VDIV_F32); return;
            case IR::OP::REM:   RegMatch(midEnd_binary); return;
            case IR::OP::FREM:  FRegMatch(midEnd_binary); return;
        }
    }
    
    void IntOrdinaryMatch(IR::BinaryInst& midEnd_binary, OperCode backEnd_opcode){
        // <binary> %1 %2 %3
        // <bianry> %1 %2 #imm
        // mov  %1 #imm
        auto &LHS = *midEnd_binary.getLHS();
        auto &RHS = *midEnd_binary.getRHS();

        // 常量拦截
        if(typeid(LHS) == typeid(IR::CI32&) && typeid(RHS) == typeid(IR::CI32)){
            //转mov
            immeIntercept(dynamic_cast<IR::CI32&>(LHS).getVal(), dynamic_cast<IR::CI32&>(RHS).getVal(), backEnd_opcode);
            return;
        }

        // 一个imme
        if(typeid(LHS) == typeid(IR::CI32&) || typeid(RHS) == typeid(IR::CI32&)){
            Operand *Def = new Operand(OperandType::INT, midEnd_binary.getName());
            BasicBlock.Func.VirRegOperandMap[Def->VirReg] = Def;

            Operand *Use = nullptr;
            int imme;

            if(typeid(LHS) == typeid(IR::CI32&)){
                imme = dynamic_cast<IR::CI32&>(LHS).getVal();
                
                unsigned long long idx = std::stoull(RHS.getName().substr(1)); 
                Use = BasicBlock.Func.VirRegOperandMap[idx];
            }
            else{
                imme = dynamic_cast<IR::CI32&>(RHS).getVal();
                
                unsigned long long idx = std::stoull(LHS.getName().substr(1)); 
                Use = BasicBlock.Func.VirRegOperandMap[idx];
            }
            
            Instruction *backEnd_binary = nullptr;
            if(immeMatch.isImmCanBeEncodedInText((unsigned long long)imme)){
                Imm *backEnd_imme = new Imm(OperandType::INT, std::to_string(imme));
                backEnd_binary = new Instruction(
                    backEnd_opcode, backEnd_imme, BasicBlock, {std::ref(*Def)}, {}
                );
            }
            else{
                immeMatch(imme, BasicBlock.Func.VRegNum);
                Operand *Use = BasicBlock.Func.VirRegOperandMap[BasicBlock.Func.VRegNum - 1];
                backEnd_binary = new Instruction(
                    backEnd_opcode, nullptr, BasicBlock, {std::ref(*Def)}, {std::ref(*Use)}
                );
            }
            
            BasicBlock.InstList.push_back(backEnd_binary);
            return;
        }

        // 无imme
        unsigned long long idx1 = std::stoull(LHS.getName().substr(1));
        unsigned long long idx2 = std::stoull(LHS.getName().substr(1));
        Operand *Use1 = BasicBlock.Func.VirRegOperandMap[idx1];
        Operand *Use2 = BasicBlock.Func.VirRegOperandMap[idx2];

        Operand *Def = new Operand(OperandType::INT, midEnd_binary.getName());
        BasicBlock.Func.VirRegOperandMap[Def->VirReg] = Def;

        Instruction *backEnd_binary = new Instruction(
            backEnd_opcode, nullptr, BasicBlock, {std::ref(*Def)}, {std::ref(*Use1), std::ref(*Use2)}
        );
        BasicBlock.InstList.push_back(backEnd_binary);
    }
    
    void SMulMatch(IR::BinaryInst& midEnd_binary){
        auto &LHS = *midEnd_binary.getLHS();
        auto &RHS = *midEnd_binary.getRHS();
        
        ///
        if(typeid(LHS) == typeid(IR::CI32) && typeid(RHS) == typeid(IR::CI32)){
            immeIntercept(dynamic_cast<IR::CI32&>(LHS).getVal(), dynamic_cast<IR::CI32&>(RHS).getVal(), OperCode::MUL);
            return ;
        }

        ///
        if(typeid(LHS) == typeid(IR::CI32) || typeid(RHS) == typeid(IR::CI32)){
            /// smul %def, %use, #imme
            /// 先不考虑优化
            
            int imme;
            Operand *Def_smul = new Operand(OperandType::INT, midEnd_binary.getName());
            BasicBlock.Func.VirRegOperandMap[Def_smul->VirReg] = Def_smul; 

            Operand *Use1 = nullptr;

            if(typeid(LHS) == typeid(IR::CI32)){
                imme = dynamic_cast<IR::CI32&>(LHS).getVal();
                unsigned long long idx = std::stoull(RHS.getName().substr(1));
                Use1 = BasicBlock.Func.VirRegOperandMap[idx];
            }
            else{
                imme = dynamic_cast<IR::CI32&>(RHS).getVal();
                unsigned long long idx = std::stoull(LHS.getName().substr(1));
                Use1 = BasicBlock.Func.VirRegOperandMap[idx];
            }

            // mov or movwt
            immeMatch(imme, BasicBlock.Func.VRegNum);
            
            // smul
            Operand *Use2 = BasicBlock.Func.VirRegOperandMap[BasicBlock.Func.VRegNum];
            
            Instruction *backEnd_smul = new Instruction(
                OperCode::SMULL, nullptr, BasicBlock, {std::ref(*Def_smul)}, {std::ref(*Use1), std::ref(*Use2)}
            );

            BasicBlock.InstList.push_back(backEnd_smul);
            return;
        }
        
        ///
        Operand *Def = new Operand(OperandType::INT, midEnd_binary.getName());
        BasicBlock.Func.VirRegOperandMap[Def->VirReg] = Def; 
        unsigned long long idx1 = std::stoull(RHS.getName().substr(1));
        unsigned long long idx2 = std::stoull(LHS.getName().substr(1));
        Operand *Use1 = BasicBlock.Func.VirRegOperandMap[idx1];
        Operand *Use2 = BasicBlock.Func.VirRegOperandMap[idx2];
        
        Instruction *backEnd_smul = new Instruction(
                OperCode::SMULL, nullptr, BasicBlock, {std::ref(*Def)}, {std::ref(*Use1), std::ref(*Use2)}
            );

        BasicBlock.InstList.push_back(backEnd_smul);
        
    }
    
    void SDivMatch(IR::BinaryInst& midEnd_binary){
        auto &LHS = *midEnd_binary.getLHS();
        auto &RHS = *midEnd_binary.getRHS();
        
        ///
        if(typeid(LHS) == typeid(IR::CI32) && typeid(RHS) == typeid(IR::CI32)){
            immeIntercept(dynamic_cast<IR::CI32&>(LHS).getVal(), dynamic_cast<IR::CI32&>(RHS).getVal(), OperCode::DIV);
            return ;
        }

        ///
        if(typeid(LHS) == typeid(IR::CI32) || typeid(RHS) == typeid(IR::CI32)){
            /// sdiv %def, %use, #imme
            /// 先不考虑优化
            
            int imme;
            Operand *Def_sdiv = new Operand(OperandType::INT, midEnd_binary.getName());
            BasicBlock.Func.VirRegOperandMap[Def_sdiv->VirReg] = Def_sdiv; 

            Operand *Use_l = nullptr;
            Operand *Use_r = nullptr;

            if(typeid(LHS) == typeid(IR::CI32)){
                imme = dynamic_cast<IR::CI32&>(LHS).getVal();
                unsigned long long idx = std::stoull(RHS.getName().substr(1));
                Use_r = BasicBlock.Func.VirRegOperandMap[idx];
            }
            else{
                imme = dynamic_cast<IR::CI32&>(RHS).getVal();
                unsigned long long idx = std::stoull(LHS.getName().substr(1));
                Use_l = BasicBlock.Func.VirRegOperandMap[idx];
            }

            // mov or movwt
            immeMatch(imme, BasicBlock.Func.VRegNum);
            
            // sdiv
            if(!Use_r) Use_r = BasicBlock.Func.VirRegOperandMap[BasicBlock.Func.VRegNum];
            else Use_l = BasicBlock.Func.VirRegOperandMap[BasicBlock.Func.VRegNum];

            Instruction *backEnd_sdiv = new Instruction(
                OperCode::SMULL, nullptr, BasicBlock, {std::ref(*Def_sdiv)}, {std::ref(*Use_l), std::ref(*Use_r)}
            );

            BasicBlock.InstList.push_back(backEnd_sdiv);
            return;
        }
        
        ///
        Operand *Def = new Operand(OperandType::INT, midEnd_binary.getName());
        BasicBlock.Func.VirRegOperandMap[Def->VirReg] = Def; 
        unsigned long long idx1 = std::stoull(RHS.getName().substr(1));
        unsigned long long idx2 = std::stoull(LHS.getName().substr(1));
        Operand *Use1 = BasicBlock.Func.VirRegOperandMap[idx1];
        Operand *Use2 = BasicBlock.Func.VirRegOperandMap[idx2];
        
        Instruction *backEnd_smul = new Instruction(
                OperCode::SMULL, nullptr, BasicBlock, {std::ref(*Def)}, {std::ref(*Use1), std::ref(*Use2)}
            );

        BasicBlock.InstList.push_back(backEnd_smul);
        
    }

    void FloatOrdinaryMatch(IR::BinaryInst& midEnd_binary, OperCode backEnd_opcode){
        // <binary> %1 %2 %3
        // <bianry> %1 %2 #imm
        // vmov  %1 #imm

        auto &LHS = *midEnd_binary.getLHS();
        auto &RHS = *midEnd_binary.getRHS();

        // 常量拦截
        if(typeid(LHS) == typeid(IR::CF32&) && typeid(RHS) == typeid(IR::CF32)){
            //转mov
            immeIntercept(dynamic_cast<IR::CF32&>(LHS).getVal(), dynamic_cast<IR::CF32&>(RHS).getVal(), backEnd_opcode);
            return;
        }

        // 一个imme
        if(typeid(LHS) == typeid(IR::CF32&) || typeid(RHS) == typeid(IR::CF32&)){
            Operand *Def = new Operand(OperandType::FLOAT, midEnd_binary.getName());
            BasicBlock.Func.VirRegOperandMap[Def->VirReg] = Def;

            Operand *Use = nullptr;
            bool is_lval = false; // Use is_lval or not
            float imme;

            if(typeid(LHS) == typeid(IR::CF32&)){
                imme = dynamic_cast<IR::CF32&>(LHS).getVal();
                is_lval = true;

                unsigned long long idx = std::stoull(RHS.getName().substr(1)); 
                Use = BasicBlock.Func.VirRegOperandMap[idx];
            }
            else{
                imme = dynamic_cast<IR::CF32&>(RHS).getVal();
                
                unsigned long long idx = std::stoull(LHS.getName().substr(1)); 
                Use = BasicBlock.Func.VirRegOperandMap[idx];
            }
            
            immeMatch(imme, BasicBlock.Func.VRegNum); // 若干mov + vmov
            
            Instruction *backEnd_binary = nullptr;
            Operand *Use2 = BasicBlock.Func.VirRegOperandMap[BasicBlock.Func.VRegNum - 1];

            if(is_lval){
                backEnd_binary = new Instruction(
                    backEnd_opcode, nullptr, BasicBlock, {std::ref(*Def)}, {std::ref(*Use2), std::ref(*Use)}
                );
            }
            else{
                backEnd_binary = new Instruction(
                    backEnd_opcode, nullptr, BasicBlock, {std::ref(*Def)}, {std::ref(*Use), std::ref(*Use2)}
                );
            }

            BasicBlock.InstList.push_back(backEnd_binary);

            return;
        }

        // 无imme
        unsigned long long idx1 = std::stoull(LHS.getName().substr(1));
        unsigned long long idx2 = std::stoull(LHS.getName().substr(1));
        Operand *Use1 = BasicBlock.Func.VirRegOperandMap[idx1];
        Operand *Use2 = BasicBlock.Func.VirRegOperandMap[idx2];

        Operand *Def = new Operand(OperandType::INT, midEnd_binary.getName());
        BasicBlock.Func.VirRegOperandMap[Def->VirReg] = Def;

        Instruction *backEnd_binary = new Instruction(
            backEnd_opcode, nullptr, BasicBlock, {std::ref(*Def)}, {std::ref(*Use1), std::ref(*Use2)}
        );
        BasicBlock.InstList.push_back(backEnd_binary);
    }
    
    void RegMatch(IR::BinaryInst& midEnd_binary){
        // %1 = reg %2, %3
        // %4 = div %2, %3  sdiv %4, %2, %3 
        // %5 = mul %4, %3  mul %5, %4, %3
        // %1 = sub %2, %5  sub %1, %2, %5
        auto &LHS = *midEnd_binary.getLHS();
        auto &RHS = *midEnd_binary.getRHS();

        // 常量拦截
        if(typeid(LHS) == typeid(IR::CI32&) && typeid(RHS) == typeid(IR::CI32)){
            //转mov
            int imme = dynamic_cast<IR::CI32&>(LHS).getVal() % dynamic_cast<IR::CI32&>(RHS).getVal();
            immeMatch(imme, BasicBlock.Func.VRegNum);
            return;
        }
        
        // 不能为寄存器
        // sdiv
        Operand *Def_sdiv = new Operand(OperandType::INT, "%" + std::to_string(BasicBlock.Func.VRegNum));
        BasicBlock.Func.VirRegOperandMap[BasicBlock.Func.VRegNum++] = Def_sdiv;

        Operand *Use_sdiv_l = nullptr;
        Operand *Use_sdiv_r = nullptr;
        if(typeid(LHS) == typeid(IR::CI32&)){
            immeMatch(dynamic_cast<IR::CI32&>(LHS).getVal(), BasicBlock.Func.VRegNum);
            Use_sdiv_l = BasicBlock.Func.VirRegOperandMap[BasicBlock.Func.VRegNum];
            unsigned long long idx_r = std::stoull(RHS.getName().substr(1));
            Use_sdiv_r = BasicBlock.Func.VirRegOperandMap[idx_r];
        }
        else if(typeid(RHS) == typeid(IR::CI32)){
            immeMatch(dynamic_cast<IR::CI32&>(RHS).getVal(), BasicBlock.Func.VRegNum);
            Use_sdiv_r = BasicBlock.Func.VirRegOperandMap[BasicBlock.Func.VRegNum];
            unsigned long long idx_l = std::stoull(LHS.getName().substr(1));
            Use_sdiv_l = BasicBlock.Func.VirRegOperandMap[idx_l];
        }
        else{
            unsigned long long idx_l = std::stoull(LHS.getName().substr(1));
            unsigned long long idx_r = std::stoull(RHS.getName().substr(1));
            Use_sdiv_l = BasicBlock.Func.VirRegOperandMap[idx_l];
            Use_sdiv_r = BasicBlock.Func.VirRegOperandMap[idx_r];
        }
        
        Instruction *backEnd_sdiv = new Instruction(
            OperCode::SDIV, nullptr, BasicBlock, {std::ref(*Def_sdiv)}, {std::ref(*Use_sdiv_l), std::ref(*Use_sdiv_r)}
        );
        BasicBlock.InstList.push_back(backEnd_sdiv);

        // mul
        Operand *Def_mul = new Operand(OperandType::INT, "%" + std::to_string(BasicBlock.Func.VRegNum));
        BasicBlock.Func.VirRegOperandMap[BasicBlock.Func.VRegNum++] = Def_mul;

        Instruction *backEnd_mul = new Instruction(
            OperCode::MUL, nullptr, BasicBlock, {std::ref(*Def_mul)}, {std::ref(*Def_sdiv), std::ref(*Use_sdiv_r)}
        );
        BasicBlock.InstList.push_back(backEnd_mul);

        // sub
        Operand *Def_sub = new Operand(OperandType::INT, midEnd_binary.getName());
        BasicBlock.Func.VirRegOperandMap[Def_sub->VirReg] = Def_sub;

        Instruction *backEnd_sub = new Instruction(
            OperCode::SUB, nullptr, BasicBlock, {std::ref(*Def_sub)}, {std::ref(*Use_sdiv_l), std::ref(*Def_mul)}
        );
        BasicBlock.InstList.push_back(backEnd_sub);

    }
    
    void FRegMatch(IR::BinaryInst& midEnd_binary){
        // %1 = reg %2, %3
        // %4 = div %2, %3  vdiv.f32 %4, %2, %3 
        // %5 = mul %4, %3  vmul.f32 %5, %4, %3
        // %1 = sub %2, %5  vsub.f32 %1, %2, %5
        auto &LHS = *midEnd_binary.getLHS();
        auto &RHS = *midEnd_binary.getRHS();

        // 常量拦截
        if(typeid(LHS) == typeid(IR::CF32&) && typeid(RHS) == typeid(IR::CF32)){
            float lval = dynamic_cast<IR::CF32&>(LHS).getVal();
            float rval = dynamic_cast<IR::CF32&>(RHS).getVal();

            float imme = lval - (lval / rval) * rval; 
            immeMatch(imme, BasicBlock.Func.VRegNum);
            return;
        }
        
        // 不能为寄存器
        // sdiv
        Operand *Def_sdiv = new Operand(OperandType::FLOAT, "%" + std::to_string(BasicBlock.Func.VRegNum));
        BasicBlock.Func.VirRegOperandMap[BasicBlock.Func.VRegNum++] = Def_sdiv;

        Operand *Use_sdiv_l = nullptr;
        Operand *Use_sdiv_r = nullptr;
        if(typeid(LHS) == typeid(IR::CF32&)){
            immeMatch(dynamic_cast<IR::CF32&>(LHS).getVal(), BasicBlock.Func.VRegNum);
            Use_sdiv_l = BasicBlock.Func.VirRegOperandMap[BasicBlock.Func.VRegNum];
            unsigned long long idx_r = std::stoull(RHS.getName().substr(1));
            Use_sdiv_r = BasicBlock.Func.VirRegOperandMap[idx_r];
        }
        else if(typeid(RHS) == typeid(IR::CF32)){
            immeMatch(dynamic_cast<IR::CF32&>(RHS).getVal(), BasicBlock.Func.VRegNum);
            Use_sdiv_r = BasicBlock.Func.VirRegOperandMap[BasicBlock.Func.VRegNum];
            unsigned long long idx_l = std::stoull(LHS.getName().substr(1));
            Use_sdiv_l = BasicBlock.Func.VirRegOperandMap[idx_l];
        }
        else{
            unsigned long long idx_l = std::stoull(LHS.getName().substr(1));
            unsigned long long idx_r = std::stoull(RHS.getName().substr(1));
            Use_sdiv_l = BasicBlock.Func.VirRegOperandMap[idx_l];
            Use_sdiv_r = BasicBlock.Func.VirRegOperandMap[idx_r];
        }
        
        Instruction *backEnd_sdiv = new Instruction(
            OperCode::VDIV_F32, nullptr, BasicBlock, {std::ref(*Def_sdiv)}, {std::ref(*Use_sdiv_l), std::ref(*Use_sdiv_r)}
        );
        BasicBlock.InstList.push_back(backEnd_sdiv);

        // mul
        Operand *Def_mul = new Operand(OperandType::FLOAT, "%" + std::to_string(BasicBlock.Func.VRegNum));
        BasicBlock.Func.VirRegOperandMap[BasicBlock.Func.VRegNum++] = Def_mul;

        Instruction *backEnd_mul = new Instruction(
            OperCode::VMUL_F32, nullptr, BasicBlock, {std::ref(*Def_mul)}, {std::ref(*Def_sdiv), std::ref(*Use_sdiv_r)}
        );
        BasicBlock.InstList.push_back(backEnd_mul);

        // sub
        Operand *Def_sub = new Operand(OperandType::FLOAT, midEnd_binary.getName());
        BasicBlock.Func.VirRegOperandMap[Def_sub->VirReg] = Def_sub;

        Instruction *backEnd_sub = new Instruction(
            OperCode::VSUB_F32, nullptr, BasicBlock, {std::ref(*Def_sub)}, {std::ref(*Use_sdiv_l), std::ref(*Def_mul)}
        );
        BasicBlock.InstList.push_back(backEnd_sub);
    }

    void immeIntercept(float lval, float rval, OperCode backEnd_opcode){
        float imme;
        switch(backEnd_opcode){
            case OperCode::ADD: imme = lval + rval; break;
            case OperCode::SUB: imme = lval - rval; break;
            case OperCode::MUL: imme = lval * rval; break;
            case OperCode::DIV: imme = lval / rval; break;
        }
        immeMatch(imme, BasicBlock.Func.VRegNum);
    }

    void immeIntercept(int lval, int rval, OperCode backEnd_opcode){
        int imme;
        switch(backEnd_opcode){
            case OperCode::VADD_F32: imme = lval + rval; break;
            case OperCode::VSUB_F32: imme = lval - rval; break;
            case OperCode::VMUL_F32: imme = lval * rval; break;
            case OperCode::VDIV_F32: imme = lval / rval; break;
        }
        immeMatch(imme, BasicBlock.Func.VRegNum);
    }
};