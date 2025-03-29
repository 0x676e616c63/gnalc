#include "../../../include/mir/builder/lowering.hpp"
#include "../../../include/mir/instructions/branch.hpp"
#include "../../../include/mir/instructions/copy.hpp"
#include "../../../include/mir/instructions/memory.hpp"
#include <iostream>

using namespace MIR;

Lowering::Lowering(const IR::Module &midEnd_module) : module(midEnd_module.getName()) { (*this)(midEnd_module); }

void Lowering::operator()(const IR::Module &midEnd_module) {
    ///@brief 处理全局变量
    for (auto &midEnd_glo : midEnd_module.getGlobalVars()) {
        std::shared_ptr<GlobalObj> obj = std::make_shared<GlobalObj>(*midEnd_glo);
        module.addGlobal(obj);
    }

    for (auto &midEnd_func : midEnd_module.getFunctions()) {
        module.addFunc(lower(*midEnd_func));
    }
}

std::shared_ptr<Function> Lowering::lower(const IR::Function &midEnd_function) {
    std::shared_ptr<Function> func = std::make_shared<Function>(midEnd_function.getName(), module.getConstPool());

    func->editInfo().args = midEnd_function.getParams().size();
    // func->editInfo().constpool = module.getConstPool();

    OperandLowering operlower{midEnd_function.getInstCount() + midEnd_function.getBlocks().size() +
                                  func->getInfo().args,
                              module.getConstPool(), func->editInfo().varpool, func->editInfo().arg_in_use,
                              func->editInfo().StackObjs}; // first: med_val_cnt

    /// @brief 函数参数加载到varpool里, 并且适当添加ldr指令
    unsigned int cnt = 0;  // int 或者 地址(数组退化而来)
    unsigned int fcnt = 0; // float
    std::list<std::shared_ptr<Instruction>> arg_insts;

    for (const auto &arg : midEnd_function.getParams()) {
        auto arg_type = arg->getType();

        if (std::dynamic_pointer_cast<IR::PtrType>(arg_type)) {
            if (cnt <= 4) {
                auto arg_in_reg = operlower.getPreColored(static_cast<CoreRegister>(cnt));
                // auto val = operlower.mkOP(*arg, RegisterBank::gpr);
                auto val = operlower.mkBaseOP(*arg);
                auto copy = std::make_shared<COPY>(val, arg_in_reg);
                arg_insts.emplace_back(copy);
            } else {
                // 参数在内存中
                auto val = operlower.mkBaseOP(*arg);
                auto arg_in_stack = operlower.mkStackOP(cnt);
                auto ldr = std::make_shared<ldrInst>(SourceOperandType::a, 4, val, arg_in_stack);
                arg_insts.emplace_back(ldr);
            }
            ++cnt;
        } else if (std::dynamic_pointer_cast<IR::BType>(arg_type)->getInner() == IR::IRBTYPE::I32) {
            if (cnt <= 4) {
                auto arg_in_reg = operlower.getPreColored(static_cast<CoreRegister>(cnt));
                auto val = operlower.mkOP(*arg, RegisterBank::gpr);
                auto copy = std::make_shared<COPY>(val, arg_in_reg);
                arg_insts.emplace_back(copy);
            } else {
                // 参数在内存中
                auto val = operlower.mkOP(*arg, RegisterBank::gpr);
                auto arg_in_stack = operlower.mkStackOP(cnt);
                auto ldr = std::make_shared<ldrInst>(SourceOperandType::a, 4, val, arg_in_stack);
                arg_insts.emplace_back(ldr);
            }
            ++cnt;
        } else if (std::dynamic_pointer_cast<IR::BType>(arg_type)->getInner() == IR::IRBTYPE::FLOAT) {
            if (fcnt <= 32) {
                auto arg_in_freg = operlower.getPreColored(static_cast<CoreRegister>(cnt));
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

    auto begin_blk = *(midEnd_function.getBlocks().begin());

    auto br = std::make_shared<branchInst>(OpCode::B, begin_blk, begin_blk->getName());
    arg_insts.emplace_back(br);

    ///@brief 打包到initialize blk
    auto initialize_blk = std::make_shared<BasicBlock>("%initialize", false);
    initialize_blk->addInsts_front(arg_insts);
    func->addBlock("%initialize", initialize_blk);

    ///@brief 获取逆后序blks
    auto blocks = midEnd_function.getDFVisitor<Util::DFVOrder::ReversePostOrder>();

    for (auto &midEnd_bb : blocks) {
        auto basicblock = lower(*midEnd_bb, operlower);

        /// @brief 构建block_list, block_pool
        func->addBlock(midEnd_bb->getName(), basicblock);
    }

    /// @brief 填写block的前驱后继关系
    initialize_blk->addSucc(func->getBlock(blocks.begin()->get()->getName()));
    auto original = *(std::next(func->getBlocks().begin()));
    original->addPred(initialize_blk);

    for (const auto &midEnd_bb : midEnd_function.getBlocks()) {
        auto backEnd_bb = func->getBlock(midEnd_bb->getName());

        for (auto &midEnd_pre : midEnd_bb->getPreBB()) {
            backEnd_bb->addPred(func->getBlock(midEnd_pre->getName()));
        }

        for (auto &midEnd_succ : midEnd_bb->getNextBB()) {
            backEnd_bb->addSucc(func->getBlock(midEnd_succ->getName()));
        }
    }

    return func;
}

std::shared_ptr<BasicBlock> Lowering::lower(const IR::BasicBlock &midEnd_bb, OperandLowering &operlower) {
    std::shared_ptr<BasicBlock> basicblock =
        std::make_shared<BasicBlock>(midEnd_bb.getName(), !(midEnd_bb.getPhiInsts().empty())); // 最终的asm中可能重名

    InstLowering instlower{operlower};

    ///@note lowering 中没有填写pres, succs以及活跃信息, 应该在phi消除中会填

    for (auto &midEnd_inst : midEnd_bb.getAllInsts()) {
        auto insts = instlower(midEnd_inst, basicblock);
        basicblock->addInsts_back(insts); // maybe empty
    }

    return basicblock;
}

std::list<std::shared_ptr<Instruction>> InstLowering::operator()(const std::shared_ptr<IR::Instruction> &midEnd_inst,
                                                                 const std::shared_ptr<BasicBlock> &blk) {
    std::list<std::shared_ptr<Instruction>> insts;
    if (auto binary = std::dynamic_pointer_cast<IR::BinaryInst>(midEnd_inst)) {
        if (IR::toBType(binary->getType())->getInner() == IR::IRBTYPE::I32)
            insts = binaryLower(binary, blk);
        else {
            insts = binaryLower_v(binary, blk);
        }
    } else if (auto icmp = std::dynamic_pointer_cast<IR::ICMPInst>(midEnd_inst)) {

        insts = icmpLower(icmp, blk);

    } else if (auto fcmp = std::dynamic_pointer_cast<IR::FCMPInst>(midEnd_inst)) {

        insts = fcmpLower(fcmp, blk);

    } else if (auto ret = std::dynamic_pointer_cast<IR::RETInst>(midEnd_inst)) {

        blk->isRetBlk = true;
        insts = retLower(ret, blk);

    } else if (auto br = std::dynamic_pointer_cast<IR::BRInst>(midEnd_inst)) {

        insts = brLower(br, blk);

    } else if (auto call = std::dynamic_pointer_cast<IR::CALLInst>(midEnd_inst)) {

        insts = callLower(call, blk);

    } else if (auto fptosi = std::dynamic_pointer_cast<IR::FPTOSIInst>(midEnd_inst)) {

        insts = fptosiLower(fptosi, blk);

    } else if (auto sitofp = std::dynamic_pointer_cast<IR::SITOFPInst>(midEnd_inst)) {

        insts = sitofpLower(sitofp, blk);

    } else if (auto zext = std::dynamic_pointer_cast<IR::ZEXTInst>(midEnd_inst)) {

        insts = zextLower(zext, blk);

    } else if (auto bitcast = std::dynamic_pointer_cast<IR::BITCASTInst>(midEnd_inst)) {

        insts = bitcastLower(bitcast, blk);

    } else if (auto alloca = std::dynamic_pointer_cast<IR::ALLOCAInst>(midEnd_inst)) {

        insts = allocaLower(alloca, blk);

    } else if (auto load = std::dynamic_pointer_cast<IR::LOADInst>(midEnd_inst)) {
        if (std::dynamic_pointer_cast<IR::PtrType>(load->getType())) {
            insts = loadLower_p(load, blk);
        } else if (std::dynamic_pointer_cast<IR::BType>(load->getType())->getInner() == IR::IRBTYPE::I32) {
            insts = loadLower(load, blk);
        } else {
            insts = loadLower_v(load, blk);
        }
    } else if (auto store = std::dynamic_pointer_cast<IR::STOREInst>(midEnd_inst)) {
        /// @warning Btype, PtrType
        if (std::dynamic_pointer_cast<IR::PtrType>(store->getBaseType())) { // getValue->getType
            insts = storeLower_p(store, blk);
        } else if (std::dynamic_pointer_cast<IR::BType>(store->getBaseType())->getInner() == IR::IRBTYPE::I32) {
            insts = storeLower(store, blk);
        } else {
            insts = storeLower_v(store, blk);
        }
    } else if (auto gep = std::dynamic_pointer_cast<IR::GEPInst>(midEnd_inst)) {
        // if (std::dynamic_pointer_cast<IR::BType>(gep->getPtr()->getType())) ///@bug ???
        //     insts = gepLower(gep, blk);
        // else
        //     insts = gepLower_p(gep, blk);

        insts = gepLower(gep, blk);

    } else if (auto phi = std::dynamic_pointer_cast<IR::PHIInst>(midEnd_inst)) {

        insts = phiLower(phi, blk);

    } else {
        Err::unreachable("instLowering: unknown IR instruction");
    }

    return insts;
}

// ===============
// operlower
// ===============
std::shared_ptr<Operand> OperandLowering::fastFind(const std::shared_ptr<IR::Value> &midEnd_val) {
    /// variablePool find
    if (auto ptr = varpool.getValue(*midEnd_val))
        return ptr;

    /// constPool find or insert, 但实际上似乎用不到, 因为对是否是常量的判断提前到instlower了
    if (auto ci1 = std::dynamic_pointer_cast<IR::ConstantI1>(midEnd_val)) {

        auto constPtr = constpool.getConstant((int)ci1->getVal()); ///
        auto constOper = std::make_shared<ConstantIDX>(constPtr);
        return constOper;

    } else if (auto ci8 = std::dynamic_pointer_cast<IR::ConstantI8>(midEnd_val)) {

        auto constPtr = constpool.getConstant((int)ci8->getVal()); ///
        auto constOper = std::make_shared<ConstantIDX>(constPtr);
        return constOper;

    } else if (auto ci32 = std::dynamic_pointer_cast<IR::ConstantInt>(midEnd_val)) {

        auto constPtr = constpool.getConstant(ci32->getVal());
        auto constOper = std::make_shared<ConstantIDX>(constPtr);
        return constOper;

    } else if (auto cf = std::dynamic_pointer_cast<IR::ConstantFloat>(midEnd_val)) {

        auto constPtr = constpool.getConstant(cf->getVal());
        auto constOper = std::make_shared<ConstantIDX>(constPtr);
        return constOper;

    } else if (auto glb = std::dynamic_pointer_cast<IR::GlobalVariable>(midEnd_val)) {
        auto constPtr = constpool.getConstant(glb->getName());
        auto constOper = std::make_shared<ConstantIDX>(constPtr);
        return constOper;
    }

    else {
        Err::unreachable("operLower: fast find an operand failed");
    }
    return nullptr; // just to make clang happy
}

std::shared_ptr<Operand> OperandLowering::search_phi(const IR::Value &midEnd_phi_val) {
    if (auto ptr = varpool.getValue(midEnd_phi_val))
        return ptr;
    else
        return nullptr;
}

std::shared_ptr<Operand> OperandLowering::fastFind_phi(const std::shared_ptr<IR::Value> &midEnd_phi_val) {
    /// variablePool find
    if (auto ptr = varpool.getValue(*midEnd_phi_val))
        return ptr;

    /// constPool find or insert, 但实际上似乎用不到, 因为对是否是常量的判断提前到instlower了
    if (auto ci1 = std::dynamic_pointer_cast<IR::ConstantI1>(midEnd_phi_val)) {

        auto constPtr = constpool.getConstant((int)ci1->getVal()); ///
        auto constOper = std::make_shared<ConstantIDX>(constPtr);
        return constOper;

    } else if (auto ci8 = std::dynamic_pointer_cast<IR::ConstantI8>(midEnd_phi_val)) {

        auto constPtr = constpool.getConstant((int)ci8->getVal()); ///
        auto constOper = std::make_shared<ConstantIDX>(constPtr);
        return constOper;

    } else if (auto ci32 = std::dynamic_pointer_cast<IR::ConstantInt>(midEnd_phi_val)) {

        auto constPtr = constpool.getConstant(ci32->getVal());
        auto constOper = std::make_shared<ConstantIDX>(constPtr);
        return constOper;

    } else if (auto cf = std::dynamic_pointer_cast<IR::ConstantFloat>(midEnd_phi_val)) {

        auto constPtr = constpool.getConstant(cf->getVal());
        auto constOper = std::make_shared<ConstantIDX>(constPtr);
        return constOper;

    } else if (auto glb = std::dynamic_pointer_cast<IR::GlobalVariable>(midEnd_phi_val)) {
        auto constPtr = constpool.getConstant(glb->getName());
        auto constOper = std::make_shared<ConstantIDX>(constPtr);
        return constOper;
    }
    ///@note 顺序遍历blk时, 遇到存在循环的CFG和phi, 极有可能出现use before def的情况
    else {
        ///@note 这里可以考虑加一个能打印的warning
        if (auto btype = std::dynamic_pointer_cast<IR::BType>(midEnd_phi_val->getType())) {
            if (btype->getInner() == IR::IRBTYPE::I32) {
                return mkOP(*midEnd_phi_val, RegisterBank::gpr);
            } else if (btype->getInner() == IR::IRBTYPE::FLOAT) {
                return mkOP(*midEnd_phi_val, RegisterBank::spr);
            } else {
                Err::unreachable("phiLower: target value with unknown btype");
            }
        } else {
            return mkBaseOP(*midEnd_phi_val);
        }
        return nullptr; // just make clang happy
    }
}

std::shared_ptr<BindOnVirOP> OperandLowering::mkOP(const std::shared_ptr<IR::Type> &type, RegisterBank bank) {

    auto virtual_val = std::make_shared<IR::Value>("%" + std::to_string(varpool.size() + med_val_cnt + 1), type,
                                                   IR::ValueTrait::ORDINARY_VARIABLE);
    auto ptr = std::make_shared<BindOnVirOP>(bank, virtual_val->getName());
    varpool.addValue(*virtual_val, ptr);

    return ptr;
}

std::shared_ptr<BindOnVirOP> OperandLowering::mkOP(const IR::Value &val, RegisterBank bank) {
    // 处理phi时提前添加的def
    if (auto phi_mk = std::dynamic_pointer_cast<BindOnVirOP>(search_phi(val)))
        return phi_mk;

    auto ptr = std::make_shared<BindOnVirOP>(bank, val.getName());
    varpool.addValue(val, ptr);
    return ptr;
}

std::shared_ptr<GlobalADROP> OperandLowering::mkBaseOP(const std::string &global_name,
                                                       const std::shared_ptr<BindOnVirOP> &base) {
    auto virtual_val = std::make_shared<IR::Value>("%" + std::to_string(varpool.size() + med_val_cnt + 1),
                                                   IR::makeBType(IR::IRBTYPE::I32), IR::ValueTrait::ORDINARY_VARIABLE);
    auto ptr = std::make_shared<GlobalADROP>(global_name, virtual_val->getName(), 0, base);
    varpool.addValue(*virtual_val, ptr);
    return ptr;
}

std::shared_ptr<GlobalADROP> OperandLowering::mkBaseOP(const IR::Value &val, const std::string &val_name,
                                                       unsigned int constOffset,
                                                       const std::shared_ptr<BindOnVirOP> &varOffset) {
    /* global_name, name, offset*/
    auto ptr = std::make_shared<GlobalADROP>(val_name, val.getName(), constOffset, varOffset);
    varpool.addValue(val, ptr);
    return ptr;
}

std::shared_ptr<BaseADROP> OperandLowering::mkBaseOP(const IR::Value &val, const std::shared_ptr<BaseADROP> &ptr) {
    if (ptr->getTrait() == BaseAddressTrait::Global) {
        auto new_ptr = std::make_shared<GlobalADROP>(std::dynamic_pointer_cast<GlobalADROP>(ptr)->getGloName(),
                                                     val.getName(), 0, nullptr);
        new_ptr->setBase(new_ptr);

        varpool.addValue(val, new_ptr);
        return new_ptr;
    } else if (ptr->getTrait() == BaseAddressTrait::Local) {
        auto new_ptr = std::make_shared<StackADROP>(std::dynamic_pointer_cast<StackADROP>(ptr)->getObj(), val.getName(),
                                                    0, nullptr);
        new_ptr->setBase(new_ptr);

        varpool.addValue(val, new_ptr);
        return new_ptr;
    } else {
        auto new_ptr = std::make_shared<BaseADROP>(BaseAddressTrait::Runtime, val.getName(), 0, nullptr);
        new_ptr->setBase(new_ptr);

        varpool.addValue(val, new_ptr);
        return new_ptr;
    }
}

std::shared_ptr<BaseADROP> OperandLowering::mkBaseOP(const IR::Value &val, const std::shared_ptr<BaseADROP> &base,
                                                     unsigned int add_offset) {

    if (base->getTrait() == BaseAddressTrait::Global) {
        auto ptr = std::make_shared<GlobalADROP>(std::dynamic_pointer_cast<GlobalADROP>(base)->getGloName(),
                                                 val.getName(), base->getConstOffset() + add_offset, base->getBase());

        varpool.addValue(val, ptr);
        return ptr;
    } else if (base->getTrait() == BaseAddressTrait::Local) {
        auto ptr = std::make_shared<StackADROP>(std::dynamic_pointer_cast<StackADROP>(base)->getObj(), val.getName(),
                                                base->getConstOffset() + add_offset, base->getBase());

        varpool.addValue(val, ptr);
        return ptr;
    } else {
        auto ptr = std::make_shared<BaseADROP>(BaseAddressTrait::Runtime, val.getName(),
                                               base->getConstOffset() + add_offset, base->getBase());

        varpool.addValue(val, ptr);
        return ptr;
    }
}

std::shared_ptr<BaseADROP> OperandLowering::mkBaseOP(const IR::Value &val) {
    if (auto phi_mk = std::dynamic_pointer_cast<BaseADROP>(search_phi(val)))
        return phi_mk;

    auto ptr = std::make_shared<BaseADROP>(BaseAddressTrait::Runtime, val.getName(), 0, nullptr);
    ptr->setBase(ptr);

    varpool.addValue(val, ptr);

    return ptr;
}

std::shared_ptr<StackADROP> OperandLowering::mkStackOP(const IR::Value &val, unsigned int size) {
    auto obj = std::make_shared<FrameObj>(FrameTrait::Alloca, size);
    obj->setId(StackObjs.size());

    StackObjs.emplace_back(obj);

    auto sp = getPreColored(CoreRegister::sp);

    std::shared_ptr<StackADROP> ptr = std::make_shared<StackADROP>(obj, val.getName(), 0, sp);

    varpool.addValue(val, ptr);
    return ptr;
}

std::shared_ptr<StackADROP> OperandLowering::mkStackOP(unsigned int seq) {
    auto obj = std::make_shared<FrameObj>(FrameTrait::FixStack, 4, seq);
    obj->setId(StackObjs.size());
    StackObjs.emplace_back(obj);

    auto sp = getPreColored(CoreRegister::sp);

    std::shared_ptr<StackADROP> ptr = std::make_shared<StackADROP>(obj, "%fix-stack." + std::to_string(seq), 0, sp);

    return ptr;
}

std::shared_ptr<StackADROP> OperandLowering::mkStackOP_arg(unsigned int seq) {
    std::shared_ptr<FrameObj> obj = nullptr;
    for (auto &_obj : StackObjs) {
        if (_obj->getTrait() == FrameTrait::Arg && _obj->getSeq() == seq) {
            obj = _obj;
            break;
        }
    }

    if (!obj) {
        obj = std::make_shared<FrameObj>(FrameTrait::Arg, 4, seq);
        obj->setId(StackObjs.size());
        StackObjs.emplace_back(obj);
    }

    auto sp = getPreColored(CoreRegister::sp);

    std::shared_ptr<StackADROP> ptr = std::make_shared<StackADROP>(obj, "%arg." + std::to_string(seq), 0, sp);

    return ptr;
}

std::shared_ptr<StackADROP> OperandLowering::mkStackOP() {
    auto obj = std::make_shared<FrameObj>(FrameTrait::Spill, 4);
    obj->setId(StackObjs.size());
    StackObjs.emplace_back(obj);

    auto sp = getPreColored(CoreRegister::sp);

    std::shared_ptr<StackADROP> ptr = std::make_shared<StackADROP>(obj, "%spill-stack", 0, sp);

    return ptr;
}
