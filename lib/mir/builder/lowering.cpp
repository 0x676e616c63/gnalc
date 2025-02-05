#include "../../../include/mir/builder/lowering.hpp"
#include <cassert>

using namespace MIR;

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

    for (auto &midEnd_bb : midEnd_function.getBlocks()) {
        func->addBlock(lower(*midEnd_bb, func->editInfo().varpool,
                             func->editInfo().StackObjs));
    }

    ///@brief 整合栈帧, 但是还没有栈帧相关或者返回指令
    func->culStackFrame();

    return func;
}

std::shared_ptr<BasicBlock>
Lowering::lower(const IR::BasicBlock &midEnd_bb, VarPool &varpool,
                std::vector<std::shared_ptr<FrameObj>> &stackobjs) {
    std::shared_ptr<BasicBlock> basicblock =
        std::make_shared<BasicBlock>(midEnd_bb.getName());

    OperandLowering operlower{module.getConstPool(), varpool, stackobjs};
    InstLowering instlower{operlower};

    ///@note lowering 中没有填写pres, succs以及活跃信息, 应该在phi消除中会填

    for (auto &midEnd_inst : midEnd_bb.getInsts()) {
        auto insts = instlower(midEnd_inst);
        basicblock->addInsts(insts);
    }

    return basicblock;
}

std::list<std::shared_ptr<Instruction>>
InstLowering::operator()(const std::shared_ptr<IR::Instruction> &midEnd_inst) {
    std::list<std::shared_ptr<Instruction>> inst{};
    if (auto binary = std::dynamic_pointer_cast<IR::BinaryInst>(midEnd_inst)) {

        if (std::dynamic_pointer_cast<IR::BType>(binary->getType())
                ->getInner() == IR::IRBTYPE::I32)
            inst = binaryLower(binary);
        else {
            /// SIMD
        }

    } else if (auto icmp =
                   std::dynamic_pointer_cast<IR::ICMPInst>(midEnd_inst)) {
        inst = icmpLower(icmp);
        // } else if (auto fcmp =
        //                std::dynamic_pointer_cast<IR::FCMPInst>(midEnd_inst)) {
        //     inst = fcmpLower(fcmp);
    } else if (auto ret = std::dynamic_pointer_cast<IR::RETInst>(midEnd_inst)) {

        inst = retLower(ret);

    } else if (auto br = std::dynamic_pointer_cast<IR::BRInst>(midEnd_inst)) {

        inst = brLower(br);

    } else if (auto call =
                   std::dynamic_pointer_cast<IR::CALLInst>(midEnd_inst)) {

        inst = callLower(call);

    } else if (auto zext =
                   std::dynamic_pointer_cast<IR::ZEXTInst>(midEnd_inst)) {

        inst = zextLower(zext);

    } else if (auto bitcast =
                   std::dynamic_pointer_cast<IR::BITCASTInst>(midEnd_inst)) {

        inst = bitcastLower(bitcast);

    } else if (auto alloca =
                   std::dynamic_pointer_cast<IR::ALLOCAInst>(midEnd_inst)) {

        inst = allocaLower(alloca);

    } else if (auto load =
                   std::dynamic_pointer_cast<IR::LOADInst>(midEnd_inst)) {

        if (std::dynamic_pointer_cast<IR::BType>(load->getType())->getInner() ==
            IR::IRBTYPE::I32) {
            inst = loadLower(load);
        } else {
            /// SIMD
        }

    } else if (auto store =
                   std::dynamic_pointer_cast<IR::STOREInst>(midEnd_inst)) {

        /// @warning 这里假设非SIMD的store指令的BaseType只会是BType, 否则会SEGV
        if (std::dynamic_pointer_cast<IR::BType>(store->getBaseType())
                ->getInner() == IR::IRBTYPE::I32) {
            inst = storeLower(store);
        } else {
            /// SIMD
        }
    } else if (auto gep = std::dynamic_pointer_cast<IR::GEPInst>(midEnd_inst)) {
        inst = gepLower(gep);
    } else if (auto phi = std::dynamic_pointer_cast<IR::PHIInst>(midEnd_inst)) {
        inst = phiLower(phi);
    } else {
        assert(false && "ir lowering to mir failed\n");
    }

    return inst;
}

// ===============
// operlower
// ===============
std::shared_ptr<Operand>
OperandLowering::fastFind(const std::shared_ptr<IR::Value> &midEnd_val) {
    /// varibelPool find
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
        assert(false && "fast find an operand failed\n");
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

std::shared_ptr<GlobalADROP> OperandLowering::mkBaseOP(const IR::Value &val,
                                                       const std::string &name,
                                                       unsigned int offset) {
    /* global_name, name, offset*/
    auto ptr = std::make_shared<GlobalADROP>(val.getName(), name, offset);
    varpool.addValue(val, ptr);
    return ptr;
}

// std::shared_ptr<StackADROP>
// OperandLowering::mkBaseOP(const IR::Value &val,
//                           const std::shared_ptr<FrameObj> &obj,
//                           unsigned int offset) {
//     auto ptr = std::make_shared<StackADROP>(obj, val.getName(), offset);
//     VarPool.addValue(val, ptr);
//     return ptr;
// }

std::shared_ptr<BaseADROP>
OperandLowering::mkBaseOP(const IR::Value &val,
                          const std::shared_ptr<BaseADROP> &base,
                          unsigned int add_offset) {

    if (base->getTrait() == BaseAddressTrait::Global) {
        auto ptr =
            std::make_shared<GlobalADROP>(base->getName(), val.getName(),
                                          base->getConstOffset() + add_offset);

        varpool.addValue(val, ptr);
        return ptr;
    } else {
        auto ptr = std::make_shared<StackADROP>(
            std::dynamic_pointer_cast<StackADROP>(base)->getObj(),
            val.getName(), base->getConstOffset() + add_offset);

        varpool.addValue(val, ptr);
        return ptr;
    }
}

std::shared_ptr<StackADROP> OperandLowering::mkStackOP(const IR::Value &val,
                                                       unsigned int size) {
    auto obj = std::make_shared<FrameObj>(FrameTrait::Alloca, size);
    StackObjs.emplace_back(obj);

    std::shared_ptr<StackADROP> ptr =
        std::make_shared<StackADROP>(obj, val.getName(), 0);

    varpool.addValue(val, ptr);
    return ptr;
}