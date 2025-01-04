#include <list>
#include <cassert>
#include "../../Arm.hpp"
#include "../../include/tools/ArmTools.hpp"
#include "../../include/ArmComplexMIRStruct/ArmOperand.hpp"
#include "../../include/ArmComplexMIRStruct/ArmFunction.hpp"
#include "../../include/ArmComplexMIRStruct/ArmBB.hpp"
#include "../../include/ArmComplexMIRStruct/ArmInstruction.hpp"
#include "../../../include/ir/instruction.hpp"
#include "../../../include/ir/type.hpp"
#include "../../../include/ir/instructions/binary.hpp"
#include "../../../include/ir/instructions/compare.hpp"
#include "../../../include/ir/instructions/control.hpp"
#include "../../../include/ir/instructions/converse.hpp"
#include "../../../include/ir/instructions/helper.hpp"
#include "../../../include/ir/instructions/memory.hpp"
#include "../../../include/ir/instructions/phi.hpp"

using namespace ArmTools;
using namespace ArmStruct;
 
extern std::vector<ArmStruct::Operand*> RegisterPool;
extern std::vector<ArmStruct::Operand*> FPURegisterPool;
extern std::vector<ArmStruct::Imm*> ConstPool;

void MovtwMatch::operator()(float imme, unsigned long long &temp_VirReg) {
    int Ieee754 = *reinterpret_cast<unsigned int*>(&imme);
    
    if(isImmCanBeEncodedInText(imme)){
        /// @brief mov %temp1  #imm
        /// @brief vmov %temp2 %temp1
        
        Imm *backEnd_imm = new Imm(OperandType::FLOAT, std::to_string(Ieee754));
        ConstPool.push_back(backEnd_imm);
        
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
        ConstPool.push_back(backEnd_imm_high16);
        ConstPool.push_back(backEnd_imm_low16);

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

void MovtwMatch::operator()(int imme, unsigned long long &temp_VirReg) {
    
    if(isImmCanBeEncodedInText((unsigned long long)imme)){
        ///@brief mov %temp #imm
        Imm *backEnd_imm = new Imm(OperandType::INT, std::to_string(imme));
        ConstPool.push_back(backEnd_imm);

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
        ConstPool.push_back(backEnd_imm_high16);
        ConstPool.push_back(backEnd_imm_low16);

        Operand *backEnd_temp_def = new Operand(OperandType::INT, "%" + std::to_string(temp_VirReg));
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

bool MovtwMatch::isImmCanBeEncodedInText(unsigned long long imme){
    for (int shift = 0; shift <= 32; shift += 2){
        if ((((imme << shift) | (imme >> (32 - shift))) & ~0xff) == 0){
            return true;
        }
    }
    return false;
}

bool MovtwMatch::isImmCanBeEncodedInText(float imme){
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

void RetMatch::operator()(InstArgs insts){
    assert(insts.size() == 1);

    IR::RETInst &midEnd_ret = dynamic_cast<IR::RETInst&>(insts.begin()->get());

    auto &midEnd_retVal = *midEnd_ret.getRetVal().get();

    Operand *backEnd_ret_register = nullptr;
    Operand *backEnd_ret_use = nullptr;
    Instruction *backEnd_ret_mov = nullptr;

    if(typeid(midEnd_retVal) != typeid(IR::ConstantFloat&)
        && typeid(midEnd_retVal) != typeid(IR::ConstantInt&)){
        unsigned long long idx = std::stoull(midEnd_ret.getRetVal().get()->getName().substr(1));
        Operand *backEnd_ret_use = BasicBlock.Func.VirRegOperandMap[idx];
        Operand *backEnd_ret_register = nullptr;
        
        if(midEnd_ret.getRetType() == IR::IRBTYPE::I32){
            
            backEnd_ret_register = RegisterPool[CoreRegisterName::r0];

            backEnd_ret_mov = new Instruction(
                OperCode::MOV, nullptr, BasicBlock, {std::ref(*backEnd_ret_register)}, {std::ref(*backEnd_ret_use)}
            );
        }
        else{
            
            backEnd_ret_register = FPURegisterPool[ExtensionRegisterName::s0];
            
            backEnd_ret_mov = new Instruction(
                OperCode::VMOV_F32, nullptr, BasicBlock, {std::ref(*backEnd_ret_register)}, {std::ref(*backEnd_ret_use)}
            );
        }
            BasicBlock.InstList.push_back(backEnd_ret_mov);
    }
    else{
        if(typeid(midEnd_retVal) == typeid(IR::ConstantInt&)){
            int imme = dynamic_cast<IR::ConstantInt&>(midEnd_retVal).getVal();
            backEnd_ret_register = RegisterPool[CoreRegisterName::r0];
            
            if(immeMatch.isImmCanBeEncodedInText((unsigned long long)imme)){
                Imm *backEnd_imme = new Imm(OperandType::INT, std::to_string(imme));
                ConstPool.push_back(backEnd_imme);
                backEnd_ret_mov = new Instruction(
                    OperCode::MOV, backEnd_imme, BasicBlock, {std::ref(*backEnd_ret_register)}, {}
                );
            }
            else{
                immeMatch(imme, BasicBlock.Func.VRegNum);
                backEnd_ret_use = BasicBlock.Func.VirRegOperandMap[BasicBlock.Func.VRegNum - 1];
                backEnd_ret_mov = new Instruction(
                    OperCode::MOV, nullptr, BasicBlock, {std::ref(*backEnd_ret_register)}, {std::ref(*backEnd_ret_use)}
                );
            }
        }
        else{
            float imme = dynamic_cast<IR::ConstantFloat&>(midEnd_retVal).getVal();
            backEnd_ret_register = RegisterPool[ExtensionRegisterName::s0];
            
            if(immeMatch.isImmCanBeEncodedInText((unsigned long long)imme)){
                Imm *backEnd_imme = new Imm(OperandType::INT, std::to_string(imme));
                ConstPool.push_back(backEnd_imme);
                backEnd_ret_mov = new Instruction(
                    OperCode::VMOV, backEnd_imme, BasicBlock, {std::ref(*backEnd_ret_register)}, {}
                );
            }
            else{
                immeMatch(imme, BasicBlock.Func.VRegNum);
                backEnd_ret_use = BasicBlock.Func.VirRegOperandMap[BasicBlock.Func.VRegNum - 1];
                backEnd_ret_mov = new Instruction(
                    OperCode::VMOV, nullptr, BasicBlock, {std::ref(*backEnd_ret_register)}, {std::ref(*backEnd_ret_use)}
                );
            }

        }
    }
    
    BasicBlock.InstList.push_back(backEnd_ret_mov);
    
    return;
}

void UnaryMatch::operator()(InstArgs insts){
    assert(insts.size() == 1);

    IR::FNEGInst &midEnd_inst = dynamic_cast<IR::FNEGInst&>(insts.begin()->get());
    
    Operand *Def = new Operand(OperandType::FLOAT, midEnd_inst.getName());

    BasicBlock.Func.VirRegOperandMap[Def->VirReg] = Def;

    if(dynamic_cast<IR::ConstantFloat*>(midEnd_inst.getVal().get()) != nullptr){ //
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
        
        float minEnd_FPimm = dynamic_cast<IR::ConstantFloat&>(*midEnd_inst.getVal()).getVal();

        immeMatch(minEnd_FPimm, BasicBlock.Func.VRegNum); // vmov

        Operand *Use = BasicBlock.Func.VirRegOperandMap[BasicBlock.Func.VRegNum - 1];

        Instruction *backEnd_vneg = new Instruction(
            OperCode::VNEG_F32, nullptr, BasicBlock, {std::ref(*Def)}, {std::ref(*Use)}
        );

        BasicBlock.InstList.push_back(backEnd_vneg);

    }
    return ;
}

void BranchMatch::operator()(InstArgs insts) const{
    assert(insts.end()->get().getOpcode() == IR::OP::BR);
    
    if(insts.size() == 1){
        // br label <dest>
        IR::BRInst &midEnd_Branch = dynamic_cast<IR::BRInst&>(insts.begin()->get());
        IR::BasicBlock &destBlock = *midEnd_Branch.getDest();
        
        Imm *backEnd_label = new Imm(OperandType::LABEL, destBlock.getName());
        ConstPool.push_back(backEnd_label);

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
        ConstPool.push_back(TrueBlock);
        ConstPool.push_back(FalseBlock);

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

void FPTOSIMatch::operator()(InstArgs InstArgs) const{
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
void SITOFPMatch::operator()(InstArgs InstArgs) const{
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

void CallMatch::operator()(InstArgs InstArgs) const{
    assert(InstArgs.size() == 1);
    auto &midEnd_call = dynamic_cast<IR::CALLInst&>(InstArgs.begin()->get());

    ///@warning 这里部分应该理论上应该放在phi之后, 寄存器分配之前, 这里的Use没有被Def过
    ///@brief 生成可能冗余的mov保护指令(core)
    ///@brief fpu得另想法子, 比较正常的办法是传参都用core寄存器或者栈空间(便于参数管理)
    ///@brief Def为一个虚拟寄存器, Use则需要预着色为相应的寄存器
    std::vector<unsigned long long> backEnd_temp_VReg = {};

    for(int i = 0; i < midEnd_call.getArgs().size(); ++i){
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
        auto &argc = argc_list[cnt];
        
        Operand *Use = nullptr;
        Imm *imme_Use = nullptr;
        /// imme
        if(dynamic_cast<IR::ConstantFloat*>(argc.get()) != nullptr
            || dynamic_cast<IR::ConstantInt*>(argc.get()) != nullptr){
            
            if(dynamic_cast<IR::ConstantInt*>(argc.get()) != nullptr){
                imme_Use = new Imm(OperandType::INT, std::to_string(dynamic_cast<IR::ConstantInt*>(argc.get())->getVal()));
                ConstPool.push_back(imme_Use);
            }
            else{
                imme_Use = new Imm(OperandType::FLOAT, std::to_string(dynamic_cast<IR::ConstantFloat*>(argc.get())->getVal()));
                ConstPool.push_back(imme_Use);
            }
        }
        else{
            unsigned long long midEnd_VirReg = std::stoull(argc->getName().substr(1));

            Operand *Use = BasicBlock.Func.VirRegOperandMap[midEnd_VirReg];
        }

        if(cnt > 4){
            Imm *backEnd_spillArgc = new Imm(OperandType::LABEL,
                "[sp, #" + std::to_string((cnt - 5)*4) + "]"
            );
            
            Instruction *backEnd_str_argx = nullptr;
            
            if(Use) backEnd_str_argx = new Instruction(OperCode::STR, backEnd_spillArgc, BasicBlock, {}, {std::ref(*Use)});
            else backEnd_str_argx = new Instruction(OperCode::PUSH, imme_Use, BasicBlock, {}, {});

            BasicBlock.InstList.push_back(backEnd_str_argx);
        }
        else{
            Operand *backEnd_RegArgc = RegisterPool[cnt];
            
            Instruction *backEnd_str_rx = nullptr;
            if(Use) backEnd_str_rx = new Instruction(OperCode::MOV, nullptr, BasicBlock, {std::ref(*backEnd_RegArgc)}, {std::ref(*Use)});
            else backEnd_str_rx = new Instruction(OperCode::MOV, imme_Use, BasicBlock, {std::ref(*backEnd_RegArgc)}, {});

            BasicBlock.InstList.push_back(backEnd_str_rx);
        }
    }

    BasicBlock.Func.setParamSize(std::max(BasicBlock.Func.getParamSize(), (cnt - 4)*4));

    ///@brief 后端bl语句
    Imm *backEnd_callee = new Imm(OperandType::LABEL, midEnd_call.getFuncName().substr(1));
    ConstPool.push_back(backEnd_callee);

    Instruction *backEnd_bl = new Instruction(
        OperCode::BL, backEnd_callee, BasicBlock, {}, {}
    );
    BasicBlock.InstList.push_back(backEnd_bl);


    ///@brief 保存返回值
    if(!midEnd_call.isVoid()){
        Operand *Def = nullptr;
        Instruction *backEnd_retVal = nullptr;

        // 当前返回值仅支持Btype
        IR::IRBTYPE midEnd_retType = dynamic_cast<IR::BType*>(midEnd_call.getType().get())->getInner();

        if(midEnd_retType == IR::IRBTYPE::I32){
            Def = new Operand(OperandType::INT, midEnd_call.getName());
            Operand *Use = RegisterPool[CoreRegisterName::r0];
            
            backEnd_retVal = new Instruction(
                OperCode::MOV, nullptr, BasicBlock, {std::ref(*Def)}, {std::ref(*Use)}
            );
        }
        else{
            Def = new Operand(OperandType::FLOAT, midEnd_call.getName());
            Operand *Use = FPURegisterPool[ExtensionRegisterName::s0];
            
            backEnd_retVal = new Instruction(
                OperCode::MOV, nullptr, BasicBlock, {std::ref(*Def)}, {std::ref(*Use)}
            );
        }
        BasicBlock.Func.VirRegOperandMap[Def->VirReg] = Def;
        BasicBlock.InstList.push_back(backEnd_retVal);
    }

    ///@brief 寄存器恢复指令(冗余)
    for(int i = 0; i < midEnd_call.getArgs().size(); ++i){
        ///@brief mov rx, %temp
        Operand *Def = RegisterPool[i];
        Operand *Use = BasicBlock.Func.VirRegOperandMap[backEnd_temp_VReg[i]];

        Instruction *backEnd_callee_rx = new Instruction(
            OperCode::MOV, nullptr, BasicBlock, {std::ref(*Def)}, {std::ref(*Use)}
        );

        BasicBlock.InstList.push_back(backEnd_callee_rx);
    }
}

// struct PhiMatch{
//     ///@note 这个学期估计还用不到
//     BB& BasicBlock;

// };


void AllocaMatch::operator()(InstArgs insts){
    assert(insts.size() == 1);

    auto &midEnd_alloca = dynamic_cast<IR::ALLOCAInst&>(insts.begin()->get());

    if(midEnd_alloca.isStatic()) staticMemory(midEnd_alloca); 
    else dynamicMemory(midEnd_alloca);
    
}
void AllocaMatch::staticMemory(IR::ALLOCAInst& midEnd_alloca){
    unsigned int ObjSize = 4;
    OperandType valType;
    unsigned long long VirPtr = std::stoull(midEnd_alloca.getName().substr(1));
    
    auto midEnd_valCType = midEnd_alloca.getBaseType()->getTrait();

    if(midEnd_valCType == IR::IRCTYPE::BASIC){

        auto midEnd_basicType = dynamic_cast<IR::BType*>(midEnd_alloca.getBaseType().get())->getInner();
        switch(midEnd_basicType){
            case IR::IRBTYPE::I32: valType = OperandType::INT; break;
            case IR::IRBTYPE::FLOAT: valType = OperandType::FLOAT; break;
            // to be continued
        }
        // ObjSize = ...
        FrameObj *backEnd_stackVal = new FrameObj(
            BasicBlock.Func.getLocal(), valType, ObjSize, VirPtr
        );  // 开辟一个FrameObj, 同时保存alloca的name
    }

    else if(midEnd_valCType == IR::IRCTYPE::ARRAY){
        auto midEnd_arrayType = dynamic_cast<IR::ArrayType&>(*midEnd_alloca.getBaseType().get()); //shared_ptr
        
        IR::Type *midEnd_elem = midEnd_arrayType.getElmType().get(); // maybe a do-while will be more suitable

        std::vector<unsigned long long> arrayDims = {};
        arrayDims.push_back(midEnd_arrayType.getArraySize());

        while(midEnd_elem->getTrait() != IR::IRCTYPE::BASIC){
            auto midEnd_elem_array = dynamic_cast<IR::ArrayType*>(midEnd_elem);
            arrayDims.push_back(midEnd_elem_array->getArraySize());
            midEnd_elem = midEnd_elem_array->getElmType().get();
        }
    
        switch(dynamic_cast<IR::BType*>(midEnd_elem)->getInner()){
            case IR::IRBTYPE::I32: valType = OperandType::INT; break;
            case IR::IRBTYPE::FLOAT: valType = OperandType::FLOAT; break;
        }

        ArrayObj *backEnd_stackArray = new ArrayObj(
            BasicBlock.Func.getLocal(), valType, VirPtr, arrayDims
        );
    }

    // else // IRCTYPE::PTR 不太清楚会在哪里使用

    return;
}

void AllocaMatch::dynamicMemory(IR::ALLOCAInst& midEnd_alloca){
    // 等等中端
}

void GepMatch::operator()(InstArgs insts){
    /// @brief insts可能为一个语句或者几个语句, 取决于index有几层
    /// @brief 假设多条的gep最终的结果一定是一个简单数据(i32 f32等), 一般也是如此
    /// @brief MIR不设置alloca语句, 但要填写FrameObj
    
    /// @note GEP的四种情况
    /// @note 1. ptr的base为sp, idx为constant
    /// @note 2. ptr的base为sp, idx为VirReg
    /// @note 3. ptr的base为VirReg, idx为constant
    /// @note 4. ptr的base为VirReg, idx为VirReg

    auto &midEnd_Gep = dynamic_cast<IR::GEPInst&>(insts.begin()->get());
    unsigned long long VirReg = std::stoull(midEnd_Gep.getPtr()->getName().substr(1));
    
    MMptr *backEnd_mmptr = BasicBlock.Func.getLocal()->findMMptr(VirReg);
    auto &arrayIdx = *midEnd_Gep.getIdxs()[1].get();    // 假设0位置默认为0

    if(backEnd_mmptr->isStatic() && typeid(arrayIdx) == typeid(IR::ConstantInt&))
        StaticBaseConstOffset(backEnd_mmptr, midEnd_Gep);
    else if(backEnd_mmptr->isStatic())
        StaticBaseVarOffset(backEnd_mmptr, midEnd_Gep);
    else if(!backEnd_mmptr->isStatic() && typeid(arrayIdx) == typeid(IR::ConstantInt&))
        DynamicBaseConstOffset(backEnd_mmptr, midEnd_Gep);
    else 
        DynamicBaseVarOffset(backEnd_mmptr, midEnd_Gep);
}

void GepMatch::StaticBaseConstOffset(MMptr* ptr, IR::GEPInst& midEnd_Gep){
    
    auto &arrayIdx = dynamic_cast<IR::ConstantInt&>(*midEnd_Gep.getIdxs()[1].get());
    unsigned long long VirReg = std::stoull(midEnd_Gep.getName().substr(1));

    unsigned int elemSize = getPreElemSize(midEnd_Gep.getBaseTypePtr());

    unsigned int constOffset = elemSize * arrayIdx.getVal();

    MMptr *backEnd_ptr_def = new MMptr(ptr->getFrameObj(), ptr->getType(), VirReg, constOffset);
    return;
}

void GepMatch::StaticBaseVarOffset(MMptr* ptr, IR::GEPInst& midEnd_Gep){
    ///@note %1 = gep <ty> [sp, #offset] %2
    /// mul %2.5 %2 #imm=elemPerSize(mov %x #imm)
    /// adds %3 %2.5 sp(为了保持SSA)
    /// (%1.baseReg = %3)
    /// ......
    /// load/store #imm [%3, #offset](%1)
    
    auto &arrayIdx = *midEnd_Gep.getIdxs()[1].get();    // IR::Value
    unsigned int perElemSize = getPreElemSize(midEnd_Gep.getBaseTypePtr());
    unsigned long long idx = std::stoull(arrayIdx.getName().substr(1));
    Operand *midEnd_varIdx = BasicBlock.Func.VirRegOperandMap[idx]; // %2
    
    // movinst
    Operand *backEnd_mov_def = new Operand(OperandType::INT, "%" + std::to_string(BasicBlock.Func.VRegNum)); // %x
    BasicBlock.Func.VirRegOperandMap[BasicBlock.Func.VRegNum++] = backEnd_mov_def;
    
    Imm *backEnd_imm = new Imm(OperandType::INT, std::to_string(perElemSize));
    ConstPool.push_back(backEnd_imm);
    
    Instruction *backEnd_mov = new Instruction( // 
        OperCode::MOV, backEnd_imm, BasicBlock, {std::ref(*backEnd_mov_def)}, {}
    );
    BasicBlock.InstList.push_back(backEnd_mov);

    // mul
    Operand *backEnd_mul_def = new Operand(OperandType::INT, "%" + std::to_string(BasicBlock.Func.VRegNum)); // %2.5
    BasicBlock.Func.VirRegOperandMap[BasicBlock.Func.VRegNum++] = backEnd_mul_def;

    Instruction *backEnd_mul = new Instruction(
        OperCode::MUL, nullptr, BasicBlock, {std::ref(*backEnd_mul_def)}, {std::ref(*midEnd_varIdx), std::ref(*backEnd_mov_def)}
    );
    BasicBlock.InstList.push_back(backEnd_mul);

    // adds
    Operand *backEnd_adds_def = new Operand(OperandType::INT, "%" + std::to_string(BasicBlock.Func.VRegNum)); // %3
    BasicBlock.Func.VirRegOperandMap[BasicBlock.Func.VRegNum++] = backEnd_adds_def;

    Operand *backEnd_sp = RegisterPool[CoreRegisterName::r7];

    Instruction *backEnd_add = new Instruction(
        OperCode::ADD, nullptr, BasicBlock, {std::ref(*backEnd_adds_def)}, {std::ref(*midEnd_varIdx), std::ref(*backEnd_sp)} // 7 = r7
    );
    BasicBlock.InstList.push_back(backEnd_add);

    unsigned long long VirReg = std::stoull(midEnd_Gep.getName().substr(1));

    MMptr *newPtr = new MMptr(ptr->getFrameObj(), ptr->getType(), VirReg, ptr->getOffset());
    newPtr->setBase(backEnd_adds_def);

    return;
}
void GepMatch::DynamicBaseConstOffset(MMptr* ptr, IR::GEPInst& midEnd_Gep){
    ///@note %1 = gep <ty> [%2, #offset] #imm
    /// (%1.offset = offset0 + imm)
    /// ......
    /// load/store #imm [%2, #offset](%1)
    auto arrayIdx = dynamic_cast<IR::ConstantInt&>(*midEnd_Gep.getIdxs()[1].get()).getVal();
    
    unsigned long long VirReg = std::stoull(midEnd_Gep.getName().substr(1));

    unsigned int elemSize = getPreElemSize(midEnd_Gep.getBaseTypePtr());

    MMptr *newPtr = new MMptr(ptr->getFrameObj(), ptr->getType(), VirReg, ptr->getOffset() + arrayIdx*elemSize);
    newPtr->setBase(ptr->getBase());
    
    return;
}
void GepMatch::DynamicBaseVarOffset(MMptr* ptr, IR::GEPInst& midEnd_Gep){
    ///@note %1 = gep <ty> [%2, #offset] %3
    /// mul %3.5 %3 #imm=elemPerSize(mov %x #imm)
    /// adds %4 %2 %3.5
    /// (%1.baseReg = %4)
    /// ......
    /// load/store #imm [%4, #offset](%1)
    auto &arrayIdx = *midEnd_Gep.getIdxs()[1].get();
    unsigned int perElemSize = getPreElemSize(midEnd_Gep.getBaseTypePtr());
    unsigned long long idx = std::stoull(arrayIdx.getName().substr(1));
    Operand *midEnd_varIdx = BasicBlock.Func.VirRegOperandMap[idx]; // %3

    // mov
    Operand *backEnd_mov_def = new Operand(OperandType::INT, "%" + std::to_string(BasicBlock.Func.VRegNum)); // %x
    BasicBlock.Func.VirRegOperandMap[BasicBlock.Func.VRegNum++] = backEnd_mov_def;
    
    Imm *backEnd_imm = new Imm(OperandType::INT, std::to_string(perElemSize));
    ConstPool.push_back(backEnd_imm);
    
    Instruction *backEnd_mov = new Instruction( // 
        OperCode::MOV, backEnd_imm, BasicBlock, {std::ref(*backEnd_mov_def)}, {}
    );
    BasicBlock.InstList.push_back(backEnd_mov);

    // mul
    Operand *backEnd_mul_def = new Operand(OperandType::INT, "%" + std::to_string(BasicBlock.Func.VRegNum)); // %3.5
    BasicBlock.Func.VirRegOperandMap[BasicBlock.Func.VRegNum++] = backEnd_mul_def;

    Instruction *backEnd_mul = new Instruction(
        OperCode::MUL, nullptr, BasicBlock, {std::ref(*backEnd_mul_def)}, {std::ref(*midEnd_varIdx), std::ref(*backEnd_mov_def)}
    );
    BasicBlock.InstList.push_back(backEnd_mul);

    // add
    Operand *backEnd_adds_def = new Operand(OperandType::INT, "%" + std::to_string(BasicBlock.Func.VRegNum)); // %4
    BasicBlock.Func.VirRegOperandMap[BasicBlock.Func.VRegNum++] = backEnd_adds_def;

    Instruction *backEnd_adds = new Instruction(
        OperCode::ADD, nullptr, BasicBlock, {std::ref(*backEnd_adds_def)}, {std::ref(*midEnd_varIdx), std::ref(*ptr->getBase())}
    );
    BasicBlock.InstList.push_back(backEnd_adds);

    unsigned long long VirReg = std::stoull(midEnd_Gep.getName().substr(1));

    MMptr *newPtr = new MMptr(ptr->getFrameObj(), ptr->getType(), VirReg, ptr->getOffset());
    newPtr->setBase(backEnd_adds_def);
    
    return;
}

unsigned int GepMatch::getPreElemSize(std::shared_ptr<IR::Type> ArrayType){    
    auto &midEnd_elem = *(dynamic_cast<IR::ArrayType&>(*ArrayType).getElmType()); // 计算一个elem的size(bytes)
    if(midEnd_elem.getTrait() == IR::IRCTYPE::BASIC) return 4;
    else{
        auto &midEnd_array_elem = dynamic_cast<IR::ArrayType&>(midEnd_elem);
        return midEnd_array_elem.getBytes();
    }
}

void LoadMatch::operator()(InstArgs insts) const{
    assert(insts.size() == 1);
    auto &midEnd_load = dynamic_cast<IR::LOADInst&>(insts.begin()->get());

    // 局部变量 MMptr, 假设中端传来的是简单ptr(不带gep)
    auto idx = std::stoull(midEnd_load.getPtr()->getName().substr(1));
    MMptr *ptr = BasicBlock.Func.getLocal()->findMMptr(idx);
    assert(ptr);

    OperCode backEnd_ldrCode;
    if(ptr->getType() == OperandType::INT) backEnd_ldrCode = OperCode::LDR;
    else backEnd_ldrCode = OperCode::VLDR_32;
    
    Operand *Def = new Operand(ptr->getType(), midEnd_load.getName());
    BasicBlock.Func.VirRegOperandMap[Def->VirReg] = Def;

    MemInstruction *backEnd_ldr = new MemInstruction(
        backEnd_ldrCode, ptr, BasicBlock, Def
    );

    BasicBlock.InstList.push_back(backEnd_ldr);

    // 全局变量 Label
}

void StoreMatch::operator()(InstArgs insts) const{
    assert(insts.size() == 1);
    auto &midEnd_store = dynamic_cast<IR::STOREInst&>(insts.begin()->get());

    // 局部变量 MMptr, 假设中端传来的是简单ptr(不带gep)
    auto mm_idx = std::stoull(midEnd_store.getPtr()->getName().substr(1));
    MMptr *ptr = BasicBlock.Func.getLocal()->findMMptr(mm_idx);
    assert(ptr);

    OperCode backEnd_StrCode;
    if(ptr->getType() == OperandType::INT) backEnd_StrCode = OperCode::STR;
    else backEnd_StrCode = OperCode::VSTR_32;
    
    unsigned long long idx = std::stoull(midEnd_store.getValue()->getName().substr(1));
    Operand *Use = BasicBlock.Func.VirRegOperandMap[idx];

    MemInstruction *backEnd_str = new MemInstruction(
        backEnd_StrCode, ptr, BasicBlock, Use
    );

    BasicBlock.InstList.push_back(backEnd_str);

    // 全局变量 Label
}


void BinaryMatch::operator()(InstArgs insts){
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

void BinaryMatch::IntOrdinaryMatch(IR::BinaryInst& midEnd_binary, OperCode backEnd_opcode){
    // <binary> %1 %2 %3
    // <bianry> %1 %2 #imm
    // mov  %1 #imm
    auto &LHS = *midEnd_binary.getLHS();
    auto &RHS = *midEnd_binary.getRHS();

    // 常量拦截
    if(typeid(LHS) == typeid(IR::ConstantInt&) && typeid(RHS) == typeid(IR::ConstantInt)){
        //转mov
        immeIntercept(dynamic_cast<IR::ConstantInt&>(LHS).getVal(), dynamic_cast<IR::ConstantInt&>(RHS).getVal(), backEnd_opcode);
        return;
    }

    // 一个imme
    if(typeid(LHS) == typeid(IR::ConstantInt&) || typeid(RHS) == typeid(IR::ConstantInt&)){
        Operand *Def = new Operand(OperandType::INT, midEnd_binary.getName());
        BasicBlock.Func.VirRegOperandMap[Def->VirReg] = Def;

        Operand *Use = nullptr;
        int imme;

        if(typeid(LHS) == typeid(IR::ConstantInt&)){
            imme = dynamic_cast<IR::ConstantInt&>(LHS).getVal();
            
            unsigned long long idx = std::stoull(RHS.getName().substr(1)); 
            Use = BasicBlock.Func.VirRegOperandMap[idx];
        }
        else{
            imme = dynamic_cast<IR::ConstantInt&>(RHS).getVal();
            
            unsigned long long idx = std::stoull(LHS.getName().substr(1)); 
            Use = BasicBlock.Func.VirRegOperandMap[idx];
        }
        
        Instruction *backEnd_binary = nullptr;
        if(immeMatch.isImmCanBeEncodedInText((unsigned long long)imme)){
            Imm *backEnd_imme = new Imm(OperandType::INT, std::to_string(imme));
            ConstPool.push_back(backEnd_imme);
            
            backEnd_binary = new Instruction(
                backEnd_opcode, backEnd_imme, BasicBlock, {std::ref(*Def)}, {std::ref(*Use)}
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
    unsigned long long idx2 = std::stoull(RHS.getName().substr(1));
    Operand *Use1 = BasicBlock.Func.VirRegOperandMap[idx1];
    Operand *Use2 = BasicBlock.Func.VirRegOperandMap[idx2];

    Operand *Def = new Operand(OperandType::INT, midEnd_binary.getName());
    BasicBlock.Func.VirRegOperandMap[Def->VirReg] = Def;

    Instruction *backEnd_binary = new Instruction(
        backEnd_opcode, nullptr, BasicBlock, {std::ref(*Def)}, {std::ref(*Use1), std::ref(*Use2)}
    );
    BasicBlock.InstList.push_back(backEnd_binary);
}

void BinaryMatch::SMulMatch(IR::BinaryInst& midEnd_binary){
    auto &LHS = *midEnd_binary.getLHS();
    auto &RHS = *midEnd_binary.getRHS();
    
    ///
    if(typeid(LHS) == typeid(IR::ConstantInt) && typeid(RHS) == typeid(IR::ConstantInt)){
        immeIntercept(dynamic_cast<IR::ConstantInt&>(LHS).getVal(), dynamic_cast<IR::ConstantInt&>(RHS).getVal(), OperCode::MUL);
        return ;
    }

    ///
    if(typeid(LHS) == typeid(IR::ConstantInt) || typeid(RHS) == typeid(IR::ConstantInt)){
        /// smul %def, %use, #imme
        /// 先不考虑优化
        
        int imme;
        Operand *Def_smul = new Operand(OperandType::INT, midEnd_binary.getName());
        BasicBlock.Func.VirRegOperandMap[Def_smul->VirReg] = Def_smul; 

        Operand *Use1 = nullptr;

        if(typeid(LHS) == typeid(IR::ConstantInt)){
            imme = dynamic_cast<IR::ConstantInt&>(LHS).getVal();
            unsigned long long idx = std::stoull(RHS.getName().substr(1));
            Use1 = BasicBlock.Func.VirRegOperandMap[idx];
        }
        else{
            imme = dynamic_cast<IR::ConstantInt&>(RHS).getVal();
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

void BinaryMatch::SDivMatch(IR::BinaryInst& midEnd_binary){
    auto &LHS = *midEnd_binary.getLHS();
    auto &RHS = *midEnd_binary.getRHS();
    
    ///
    if(typeid(LHS) == typeid(IR::ConstantInt) && typeid(RHS) == typeid(IR::ConstantInt)){
        immeIntercept(dynamic_cast<IR::ConstantInt&>(LHS).getVal(), dynamic_cast<IR::ConstantInt&>(RHS).getVal(), OperCode::DIV);
        return ;
    }

    ///
    if(typeid(LHS) == typeid(IR::ConstantInt) || typeid(RHS) == typeid(IR::ConstantInt)){
        /// sdiv %def, %use, #imme
        /// 先不考虑优化
        
        int imme;
        Operand *Def_sdiv = new Operand(OperandType::INT, midEnd_binary.getName());
        BasicBlock.Func.VirRegOperandMap[Def_sdiv->VirReg] = Def_sdiv; 

        Operand *Use_l = nullptr;
        Operand *Use_r = nullptr;

        if(typeid(LHS) == typeid(IR::ConstantInt)){
            imme = dynamic_cast<IR::ConstantInt&>(LHS).getVal();
            unsigned long long idx = std::stoull(RHS.getName().substr(1));
            Use_r = BasicBlock.Func.VirRegOperandMap[idx];
        }
        else{
            imme = dynamic_cast<IR::ConstantInt&>(RHS).getVal();
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

void BinaryMatch::FloatOrdinaryMatch(IR::BinaryInst& midEnd_binary, OperCode backEnd_opcode){
    // <binary> %1 %2 %3
    // <bianry> %1 %2 #imm
    // vmov  %1 #imm

    auto &LHS = *midEnd_binary.getLHS();
    auto &RHS = *midEnd_binary.getRHS();

    // 常量拦截
    if(typeid(LHS) == typeid(IR::ConstantFloat&) && typeid(RHS) == typeid(IR::ConstantFloat)){
        //转mov
        immeIntercept(dynamic_cast<IR::ConstantFloat&>(LHS).getVal(), dynamic_cast<IR::ConstantFloat&>(RHS).getVal(), backEnd_opcode);
        return;
    }

    // 一个imme
    if(typeid(LHS) == typeid(IR::ConstantFloat&) || typeid(RHS) == typeid(IR::ConstantFloat&)){
        Operand *Def = new Operand(OperandType::FLOAT, midEnd_binary.getName());
        BasicBlock.Func.VirRegOperandMap[Def->VirReg] = Def;

        Operand *Use = nullptr;
        bool is_lval = false; // Use is_lval or not
        float imme;

        if(typeid(LHS) == typeid(IR::ConstantFloat&)){
            imme = dynamic_cast<IR::ConstantFloat&>(LHS).getVal();
            is_lval = true;

            unsigned long long idx = std::stoull(RHS.getName().substr(1)); 
            Use = BasicBlock.Func.VirRegOperandMap[idx];
        }
        else{
            imme = dynamic_cast<IR::ConstantFloat&>(RHS).getVal();
            
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
    unsigned long long idx2 = std::stoull(RHS.getName().substr(1));
    Operand *Use1 = BasicBlock.Func.VirRegOperandMap[idx1];
    Operand *Use2 = BasicBlock.Func.VirRegOperandMap[idx2];

    Operand *Def = new Operand(OperandType::INT, midEnd_binary.getName());
    BasicBlock.Func.VirRegOperandMap[Def->VirReg] = Def;

    Instruction *backEnd_binary = new Instruction(
        backEnd_opcode, nullptr, BasicBlock, {std::ref(*Def)}, {std::ref(*Use1), std::ref(*Use2)}
    );
    BasicBlock.InstList.push_back(backEnd_binary);
}

void BinaryMatch::RegMatch(IR::BinaryInst& midEnd_binary){
    // %1 = reg %2, %3
    // %4 = div %2, %3  sdiv %4, %2, %3 
    // %5 = mul %4, %3  mul %5, %4, %3
    // %1 = sub %2, %5  sub %1, %2, %5
    auto &LHS = *midEnd_binary.getLHS();
    auto &RHS = *midEnd_binary.getRHS();

    // 常量拦截
    if(typeid(LHS) == typeid(IR::ConstantInt&) && typeid(RHS) == typeid(IR::ConstantInt)){
        //转mov
        int imme = dynamic_cast<IR::ConstantInt&>(LHS).getVal() % dynamic_cast<IR::ConstantInt&>(RHS).getVal();
        immeMatch(imme, BasicBlock.Func.VRegNum);
        return;
    }
    
    // 不能为寄存器
    // sdiv
    Operand *Def_sdiv = new Operand(OperandType::INT, "%" + std::to_string(BasicBlock.Func.VRegNum));
    BasicBlock.Func.VirRegOperandMap[BasicBlock.Func.VRegNum++] = Def_sdiv;

    Operand *Use_sdiv_l = nullptr;
    Operand *Use_sdiv_r = nullptr;
    if(typeid(LHS) == typeid(IR::ConstantInt&)){
        immeMatch(dynamic_cast<IR::ConstantInt&>(LHS).getVal(), BasicBlock.Func.VRegNum);
        Use_sdiv_l = BasicBlock.Func.VirRegOperandMap[BasicBlock.Func.VRegNum];
        unsigned long long idx_r = std::stoull(RHS.getName().substr(1));
        Use_sdiv_r = BasicBlock.Func.VirRegOperandMap[idx_r];
    }
    else if(typeid(RHS) == typeid(IR::ConstantInt)){
        immeMatch(dynamic_cast<IR::ConstantInt&>(RHS).getVal(), BasicBlock.Func.VRegNum);
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

void BinaryMatch::FRegMatch(IR::BinaryInst& midEnd_binary){
    // %1 = reg %2, %3
    // %4 = div %2, %3  vdiv.f32 %4, %2, %3 
    // %5 = mul %4, %3  vmul.f32 %5, %4, %3
    // %1 = sub %2, %5  vsub.f32 %1, %2, %5
    auto &LHS = *midEnd_binary.getLHS();
    auto &RHS = *midEnd_binary.getRHS();

    // 常量拦截
    if(typeid(LHS) == typeid(IR::ConstantFloat&) && typeid(RHS) == typeid(IR::ConstantFloat)){
        float lval = dynamic_cast<IR::ConstantFloat&>(LHS).getVal();
        float rval = dynamic_cast<IR::ConstantFloat&>(RHS).getVal();

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
    if(typeid(LHS) == typeid(IR::ConstantFloat&)){
        immeMatch(dynamic_cast<IR::ConstantFloat&>(LHS).getVal(), BasicBlock.Func.VRegNum);
        Use_sdiv_l = BasicBlock.Func.VirRegOperandMap[BasicBlock.Func.VRegNum];
        unsigned long long idx_r = std::stoull(RHS.getName().substr(1));
        Use_sdiv_r = BasicBlock.Func.VirRegOperandMap[idx_r];
    }
    else if(typeid(RHS) == typeid(IR::ConstantFloat)){
        immeMatch(dynamic_cast<IR::ConstantFloat&>(RHS).getVal(), BasicBlock.Func.VRegNum);
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

void BinaryMatch::immeIntercept(float lval, float rval, OperCode backEnd_opcode){
    float imme;
    switch(backEnd_opcode){
        case OperCode::ADD: imme = lval + rval; break;
        case OperCode::SUB: imme = lval - rval; break;
        case OperCode::MUL: imme = lval * rval; break;
        case OperCode::DIV: imme = lval / rval; break;
    }
    immeMatch(imme, BasicBlock.Func.VRegNum);
}

void BinaryMatch::immeIntercept(int lval, int rval, OperCode backEnd_opcode){
    int imme;
    switch(backEnd_opcode){
        case OperCode::VADD_F32: imme = lval + rval; break;
        case OperCode::VSUB_F32: imme = lval - rval; break;
        case OperCode::VMUL_F32: imme = lval * rval; break;
        case OperCode::VDIV_F32: imme = lval / rval; break;
    }
    immeMatch(imme, BasicBlock.Func.VRegNum);
}