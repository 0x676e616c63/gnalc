#include "../../../include/mir/builder/lowering.hpp"
#include "../../../include/mir/instructions/copy.hpp"
#include "../../../include/mir/instructions/memory.hpp"

using namespace MIR;

Lowering::Lowering(const IR::Module &midEnd_module) : module(midEnd_module.getName()) {
    (*this)(midEnd_module);
}

void Lowering::operator()(const IR::Module &midEnd_module) {
    ///@brief 处理全局变量
    for (auto &midEnd_glo : midEnd_module.getGlobalVars()) {
        std::shared_ptr<GlobalObj> obj =
            std::make_shared<GlobalObj>(*midEnd_glo);
        module.addGlobal(obj);
    }

    for (auto &midEnd_func : midEnd_module.getFunctions()) {
        module.addFunc(lower(*midEnd_func));
    }
}

std::shared_ptr<Function> Lowering::lower(const IR::Function &midEnd_function) {
    std::shared_ptr<Function> func =
        std::make_shared<Function>(midEnd_function.getName());

    func->editInfo().args = midEnd_function.getParams().size();

    OperandLowering operlower{module.getConstPool(), func->editInfo().varpool,
                              func->editInfo().StackObjs};

    /// @brief 函数参数加载到varpool里, 并且适当添加ldr指令
    unsigned int cnt = 0;  // int 或者 地址(数组退化而来)
    unsigned int fcnt = 0; // float
    std::list<std::shared_ptr<Instruction>> arg_insts;

    for (const auto &arg : midEnd_function.getParams()) {
        auto arg_type = arg->getType();

        if (std::dynamic_pointer_cast<IR::PtrType>(arg_type) ||
            std::dynamic_pointer_cast<IR::BType>(arg_type)->getInner() ==
                IR::IRBTYPE::I32) {
            if (cnt <= 4) {
                auto arg_in_reg =
                    operlower.getPreColored(static_cast<CoreRegister>(cnt));
                auto val = operlower.mkOP(*arg, RegisterBank::gpr);
                auto copy = std::make_shared<COPY>(val, arg_in_reg);
                arg_insts.emplace_back(copy);
            } else {
                // 参数在内存中
                auto val = operlower.mkOP(*arg, RegisterBank::gpr);
                auto arg_in_stack = operlower.mkStackOP(cnt);
                auto ldr = std::make_shared<ldrInst>(SourceOperandType::a, 4,
                                                     val, arg_in_stack);
                arg_insts.emplace_back(ldr);
            }
            ++cnt;
        } else if (std::dynamic_pointer_cast<IR::BType>(arg_type)->getInner() ==
                   IR::IRBTYPE::FLOAT) {
            if (fcnt <= 32) {
                auto arg_in_freg =
                    operlower.getPreColored(static_cast<CoreRegister>(cnt));
                auto val = operlower.mkOP(*arg, RegisterBank::spr);
                auto copy = std::make_shared<COPY>(val, arg_in_freg);
                arg_insts.emplace_back(copy);
            } else {
                Err::unreachable("functionLower: too many float args for functioon");
            }
            ++fcnt;
        } else {
            Err::unreachable("functionLower: unknown arg type encountered!");
        }
    }

    /// @brief blocklowering
    for (auto &midEnd_bb : midEnd_function.getBlocks()) {
        auto basicblock = lower(*midEnd_bb, operlower);
        if (func->getBlocks().empty()) {
            basicblock->addInsts_front(arg_insts);
        }
        /// @brief 构建block_list, block_pool
        func->addBlock(midEnd_function.getName(), basicblock);
    }

    for (const auto &midEnd_bb : midEnd_function.getBlocks()) {
        auto &backEnd_bb = func->getBlock(midEnd_bb->getName());

        /// @brief 填写block的前驱后继关系
        for (auto &midEnd_pre : midEnd_bb->getPreBB()) {
            backEnd_bb->addPre(func->getBlock(midEnd_pre->getName()));
        }

        for (auto &midEnd_succ : midEnd_bb->getNextBB()) {
            backEnd_bb->addSucc(func->getBlock(midEnd_succ->getName()));
        }

        /// @brief 填LiveIn, LiveOuts
        /// @todo
    }

    return func;
}

std::shared_ptr<BasicBlock> Lowering::lower(const IR::BasicBlock &midEnd_bb,
                                            OperandLowering &operlower) {
    std::shared_ptr<BasicBlock> basicblock =
        std::make_shared<BasicBlock>(midEnd_bb.getName(), !(midEnd_bb.getPhiInsts().empty())); // 最终的asm中可能重名

    InstLowering instlower{operlower};

    ///@note lowering 中没有填写pres, succs以及活跃信息, 应该在phi消除中会填

    for (auto &midEnd_inst : midEnd_bb.getInsts()) {
        auto insts = instlower(midEnd_inst);
        basicblock->addInsts_back(insts);
    }

    return basicblock;
}

std::list<std::shared_ptr<Instruction>>
InstLowering::operator()(const std::shared_ptr<IR::Instruction> &midEnd_inst) {
    std::list<std::shared_ptr<Instruction>> insts;
    if (auto binary = std::dynamic_pointer_cast<IR::BinaryInst>(midEnd_inst)) {
        if (IR::toBType(binary->getType())->getInner() == IR::IRBTYPE::I32)
            insts = binaryLower(binary);
        else {
            insts = binaryLower_v(binary);
        }
    } else if (auto icmp = std::dynamic_pointer_cast<IR::ICMPInst>(midEnd_inst)) {

        insts = icmpLower(icmp);

    } else if (auto fcmp = std::dynamic_pointer_cast<IR::FCMPInst>(midEnd_inst)) {

        insts = fcmpLower(fcmp);

    } else if (auto ret = std::dynamic_pointer_cast<IR::RETInst>(midEnd_inst)) {

        insts = retLower(ret);

    } else if (auto br = std::dynamic_pointer_cast<IR::BRInst>(midEnd_inst)) {

        insts = brLower(br);

    } else if (auto call = std::dynamic_pointer_cast<IR::CALLInst>(midEnd_inst)) {

        insts = callLower(call);

    } else if (auto fptosi = std::dynamic_pointer_cast<IR::FPTOSIInst>(midEnd_inst)) {

        insts = fptosiLower(fptosi);

    } else if (auto sitofp = std::dynamic_pointer_cast<IR::SITOFPInst>(midEnd_inst)) {

        insts = sitofpLower(sitofp);

    } else if (auto zext = std::dynamic_pointer_cast<IR::ZEXTInst>(midEnd_inst)) {

        insts = zextLower(zext);

    } else if (auto bitcast = std::dynamic_pointer_cast<IR::BITCASTInst>(midEnd_inst)) {

        insts = bitcastLower(bitcast);

    } else if (auto alloca = std::dynamic_pointer_cast<IR::ALLOCAInst>(midEnd_inst)) {

        insts = allocaLower(alloca);

    } else if (auto load = std::dynamic_pointer_cast<IR::LOADInst>(midEnd_inst)) {
        if (std::dynamic_pointer_cast<IR::BType>(load->getType())->getInner() == IR::IRBTYPE::I32) {
            insts = loadLower(load);
        } else {
            insts = loadLower_v(load);
        }
    } else if (auto store = std::dynamic_pointer_cast<IR::STOREInst>(midEnd_inst)) {
        /// @warning 这里假设非SIMD的store指令的BaseType只会是BType, 否则会SEGV
        if (std::dynamic_pointer_cast<IR::BType>(store->getBaseType())
                ->getInner() == IR::IRBTYPE::I32) {
            insts = storeLower(store);
        } else {
            insts = storeLower_v(store);
        }
    } else if (auto gep = std::dynamic_pointer_cast<IR::GEPInst>(midEnd_inst)) {
        insts = gepLower(gep);
    } else if (auto phi = std::dynamic_pointer_cast<IR::PHIInst>(midEnd_inst)) {
        insts = phiLower(phi);
    } else {
        Err::unreachable("instLowering: unknown IR instruction");
    }

    return insts;
}

// ===============
// operlower
// ===============
std::shared_ptr<Operand>
OperandLowering::fastFind(const std::shared_ptr<IR::Value> &midEnd_val) {
    /// variablePool find
    if (auto ptr = varpool.getValue(*midEnd_val))
        return ptr;

    /// constPool find or insert, 但实际上似乎用不到, 因为对是否是常量的判断提前到instlower了
    if (auto ci1 = std::dynamic_pointer_cast<IR::ConstantI1>(midEnd_val)) {

        auto constPtr = constpool.getConstant(ci1->getVal());
        auto constOper = std::make_shared<ConstantIDX>(constPtr);
        return constOper;

    } else if (auto ci8 =
                   std::dynamic_pointer_cast<IR::ConstantI8>(midEnd_val)) {

        auto constPtr = constpool.getConstant(ci8->getVal());
        auto constOper = std::make_shared<ConstantIDX>(constPtr);
        return constOper;

    } else if (auto ci32 =
                   std::dynamic_pointer_cast<IR::ConstantInt>(midEnd_val)) {

        auto constPtr = constpool.getConstant(ci32->getVal());
        auto constOper = std::make_shared<ConstantIDX>(constPtr);
        return constOper;

    } else if (auto cf =
                   std::dynamic_pointer_cast<IR::ConstantFloat>(midEnd_val)) {

        auto constPtr = constpool.getConstant(cf->getVal());
        auto constOper = std::make_shared<ConstantIDX>(constPtr);
        return constOper;

    } else if (auto glb =
                   std::dynamic_pointer_cast<IR::GlobalVariable>(midEnd_val)) {
        auto constPtr = constpool.getConstant(glb->getName());
        auto constOper = std::make_shared<ConstantIDX>(constPtr);
        return constOper;
    }

    // else
    else {
        Err::unreachable("operLower: fast find an operand failed");
        return nullptr;
    }
}

std::shared_ptr<BindOnVirOP>
OperandLowering::mkOP(const std::shared_ptr<IR::Type> &type,
                      RegisterBank bank) {
    auto virtual_val =
        std::make_shared<IR::Value>("%" + std::to_string(varpool.size()), type,
                                    IR::ValueTrait::ORDINARY_VARIABLE);
    auto ptr = std::make_shared<BindOnVirOP>(bank, virtual_val->getName());
    varpool.addValue(*virtual_val, ptr);

    return ptr;
}

std::shared_ptr<BindOnVirOP> OperandLowering::mkOP(const IR::Value &val,
                                                   RegisterBank bank) {
    auto ptr = std::make_shared<BindOnVirOP>(bank, val.getName());
    varpool.addValue(val, ptr);
    return ptr;
}

std::shared_ptr<GlobalADROP>
OperandLowering::mkBaseOP(const std::string &global_name,
                          const std::shared_ptr<BindOnVirOP> &base) {
    auto virtual_val = std::make_shared<IR::Value>(
        "%" + std::to_string(varpool.size()), IR::makeBType(IR::IRBTYPE::I32),
        IR::ValueTrait::ORDINARY_VARIABLE);
    auto ptr = std::make_shared<GlobalADROP>(global_name,
                                             virtual_val->getName(), 0, base);
    varpool.addValue(*virtual_val, ptr);
    return ptr;
}

std::shared_ptr<GlobalADROP>
OperandLowering::mkBaseOP(const IR::Value &val, const std::string &val_name,
                          unsigned int constOffset,
                          const std::shared_ptr<BindOnVirOP> &varOffset) {
    /* global_name, name, offset*/
    auto ptr = std::make_shared<GlobalADROP>(val.getName(), val_name,
                                             constOffset, varOffset);
    varpool.addValue(val, ptr);
    return ptr;
}

std::shared_ptr<BaseADROP>
OperandLowering::mkBaseOP(const IR::Value &val,
                          const std::shared_ptr<BaseADROP> &base,
                          unsigned int add_offset) {

    if (base->getTrait() == BaseAddressTrait::Global) {
        auto ptr = std::make_shared<GlobalADROP>(
            base->getName(), val.getName(), base->getConstOffset() + add_offset,
            base->getBase());

        varpool.addValue(val, ptr);
        return ptr;
    } else if (base->getTrait() == BaseAddressTrait::Local) {
        auto ptr = std::make_shared<StackADROP>(
            std::dynamic_pointer_cast<StackADROP>(base)->getObj(),
            val.getName(), base->getConstOffset() + add_offset,
            base->getBase());

        varpool.addValue(val, ptr);
        return ptr;
    } else {
        auto ptr = std::make_shared<BaseADROP>(BaseAddressTrait::Runtime, val.getName(), base->getConstOffset() + add_offset, base->getBase());

        varpool.addValue(val, ptr);
        return ptr;
    }
}

std::shared_ptr<BaseADROP> OperandLowering::mkBaseOP(const IR::Value &val) {
    auto ptr = std::make_shared<BaseADROP>(BaseAddressTrait::Runtime, val.getName(), 0, nullptr);

    varpool.addValue(val, ptr);

    return ptr;
}

std::shared_ptr<StackADROP> OperandLowering::mkStackOP(const IR::Value &val,
                                                       unsigned int size) {
    auto obj = std::make_shared<FrameObj>(FrameTrait::Alloca, size);
    StackObjs.emplace_back(obj);

    auto r7 = getPreColored(CoreRegister::r7);

    std::shared_ptr<StackADROP> ptr =
        std::make_shared<StackADROP>(obj, val.getName(), 0, r7);

    varpool.addValue(val, ptr);
    return ptr;
}

std::shared_ptr<StackADROP> OperandLowering::mkStackOP(unsigned int seq) {
    auto obj = std::make_shared<FrameObj>(FrameTrait::Arg, 4);
    StackObjs.emplace_back(obj);

    auto sp = getPreColored(CoreRegister::sp);

    std::shared_ptr<StackADROP> ptr = std::make_shared<StackADROP>(
        obj, "%fix-stack." + std::to_string(seq - 4), 0, sp);

    return ptr;
}

std::shared_ptr<StackADROP> OperandLowering::mkStackOP() {
    auto obj = std::make_shared<FrameObj>(FrameTrait::Spill, 4);
    StackObjs.emplace_back(obj);

    auto sp = getPreColored(CoreRegister::sp);

    std::shared_ptr<StackADROP> ptr =
        std::make_shared<StackADROP>(obj, "%spill-stack", 0, sp);

    return ptr;
}