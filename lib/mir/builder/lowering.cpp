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
        func->addBlock(lower(*midEnd_bb));
    }

    ///@brief 整合栈帧
    func->culStackFrame();

    return func;
}

std::shared_ptr<BasicBlock> Lowering::lower(const IR::BasicBlock &midEnd_bb) {
    std::shared_ptr<BasicBlock> basicblock =
        std::make_shared<BasicBlock>(midEnd_bb.getName());

    ///@note lowering 中没有填写pres, succs以及活跃信息, 应该在phi消除中会填

    for (auto &midEnd_inst : midEnd_bb.getInsts()) {
        if (auto inst = instlower(midEnd_inst))
            basicblock->addInst(inst);
    }

    return basicblock;
}

std::shared_ptr<Operand>
OperandLowering::fastFind(const std::shared_ptr<IR::Value> &midEnd_val) {
    /// varibelPool find
    if (auto ptr = VarPool.getValue(*midEnd_val))
        return ptr;

    /// constPool find or insert
    if (auto ci1 = std::dynamic_pointer_cast<IR::ConstantI1>(midEnd_val)) {

        auto constPtr = ConstPool.getConstant(ci1->getVal());
        auto constOper = std::make_shared<ConstantIDX>(constPtr);
        return constOper;

    } else if (auto ci8 =
                   std::dynamic_pointer_cast<IR::ConstantI8>(midEnd_val)) {

        auto constPtr = ConstPool.getConstant(ci8->getVal());
        auto constOper = std::make_shared<ConstantIDX>(constPtr);
        return constOper;

    } else if (auto ci32 =
                   std::dynamic_pointer_cast<IR::ConstantInt>(midEnd_val)) {

        auto constPtr = ConstPool.getConstant(ci32->getVal());
        auto constOper = std::make_shared<ConstantIDX>(constPtr);
        return constOper;

    } else if (auto cf =
                   std::dynamic_pointer_cast<IR::ConstantFloat>(midEnd_val)) {

        auto constPtr = ConstPool.getConstant(cf->getVal());
        auto constOper = std::make_shared<ConstantIDX>(constPtr);
        return constOper;

    } else if (auto glb =
                   std::dynamic_pointer_cast<IR::GlobalVariable>(midEnd_val)) {
        auto constPtr = ConstPool.getConstant(glb->getName());
        auto constOper = std::make_shared<ConstantIDX>(constPtr);
        return constOper;
    }

    // else
    else {
        assert(false && "fast find an operand failed\n");
        return nullptr;
    }
}

template <typename T_Reg>
std::shared_ptr<PreColedOP> OperandLowering::getPreColored(T_Reg color) {
    return VarPool.getValue(color);
}

std::shared_ptr<GlobalADROP> OperandLowering::mkBaseOP(const IR::Value &val,
                                                       const std::string &name,
                                                       unsigned int offset) {
    /* global_name, name, offset*/
    auto ptr = std::make_shared<GlobalADROP>(val.getName(), name, offset);
    VarPool.addValue(val, ptr);
    return ptr;
}

std::shared_ptr<StackADROP>
OperandLowering::mkBaseOP(const IR::Value &val,
                          const std::shared_ptr<FrameObj> &obj,
                          unsigned int offset) {
    auto ptr = std::make_shared<StackADROP>(obj, val.getName(), offset);
    VarPool.addValue(val, ptr);
    return ptr;
}

std::shared_ptr<BaseADROP>
OperandLowering::mkBaseOP(const IR::Value &val,
                          const std::shared_ptr<BaseADROP> &base,
                          unsigned int add_offset) {

    if (base->getTrait() == BaseAddressTrait::Global) {
        auto ptr =
            std::make_shared<GlobalADROP>(base->getName(), val.getName(),
                                          base->getConstOffset() + add_offset);

        VarPool.addValue(val, ptr);
        return ptr;
    } else {
        auto ptr = std::make_shared<StackADROP>(
            std::dynamic_pointer_cast<StackADROP>(base)->getObj(),
            val.getName(), base->getConstOffset() + add_offset);

        VarPool.addValue(val, ptr);
        return ptr;
    }
}
