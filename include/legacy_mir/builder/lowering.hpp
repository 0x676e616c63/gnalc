#ifdef GNALC_EXTENSION_ARMv7
#pragma once
#ifndef GNALC_LEGACY_MIR_BUILDER_LOWERING_HPP
#define GNALC_LEGACY_MIR_BUILDER_LOWERING_HPP
#include "ir/basic_block.hpp"
#include "ir/function.hpp"
#include "ir/instruction.hpp"
#include "ir/instructions/binary.hpp"
#include "ir/instructions/compare.hpp"
#include "ir/instructions/control.hpp"
#include "ir/instructions/converse.hpp"
#include "ir/instructions/memory.hpp"
#include "ir/instructions/phi.hpp"
#include "ir/module.hpp"
#include "legacy_mir/base.hpp"
#include "legacy_mir/function.hpp"
#include "legacy_mir/instruction.hpp"
#include "legacy_mir/module.hpp"
#include "legacy_mir/operand.hpp"
#include "legacy_mir/varpool.hpp"

namespace LegacyMIR {

struct OperandLowering;

struct splited {
    unsigned int exp1;
    unsigned int exp2;
    enum class oper { singlePos, singleNeg, addPos, addNeg, sub, none } cul;
};

splited SplitTo2PowX(int);

std::list<std::shared_ptr<Instruction>> mulOpt(const std::shared_ptr<BindOnVirOP> &target,
                                               const std::shared_ptr<IR::Value> &virRegVal,
                                               const std::shared_ptr<IR::ConstantInt> &constVal,
                                               OperandLowering &operlower, const std::shared_ptr<BasicBlock> &blk);

struct multiplication {
    int mul;
    int shift;
};

multiplication ChooseMultipler(int);

std::list<std::shared_ptr<Instruction>> divOpt(const std::shared_ptr<BindOnVirOP> &target,
                                               const std::shared_ptr<IR::Value> &virRegVal,
                                               const std::shared_ptr<IR::ConstantInt> &constVal,
                                               OperandLowering &operlower, const std::shared_ptr<BasicBlock> &blk);

struct OperandLowering {
    ///@note 由于操作数不是透过依赖关系获得的,
    /// 所以和常量一样需要一个池来查找和存放
    const size_t med_val_cnt;

    ConstPool &constpool;
    VarPool &varpool;
    unsigned arg_in_use; // function中将会使用的过程调用的参数的最大数
    std::deque<std::shared_ptr<FrameObj>> &StackObjs;

    /// when use
    std::shared_ptr<Operand> fastFind(const std::shared_ptr<IR::Value> &);

    /// when phi use
    std::shared_ptr<Operand> fastFind_phi(const std::shared_ptr<IR::Value> &);
    std::shared_ptr<Operand> search_phi(const IR::Value &);

    /// 仅返回注册过的存有字面量的virop, 在fix-pass中补全mov
    template <typename T_variant>
    std::shared_ptr<BindOnVirOP> LoadedFind(const T_variant &constVal, const std::shared_ptr<BasicBlock> &blk) {
        auto constPtr = constpool.getConstant(constVal); // get wrapper

        ///@note getLoaded 用于访问load池
        auto loadPtr = varpool.getLoaded(*constPtr, blk); // maybe nullptr
        if (loadPtr != nullptr)
            /// use old
            return loadPtr;
        else {
            /// create a new obj
            using U_variant = std::remove_cv_t<std::remove_reference_t<T_variant>>;
            if constexpr (std::is_same_v<U_variant, float>) {
                loadPtr = mkOP(IR::makeBType(IR::IRBTYPE::FLOAT), RegisterBank::gpr);
                varpool.addLoaded(*constPtr, loadPtr, blk);
            } else if constexpr (std::is_same_v<U_variant, int>) {
                loadPtr = mkOP(IR::makeBType(IR::IRBTYPE::I32), RegisterBank::gpr);
                varpool.addLoaded(*constPtr, loadPtr, blk);
            } else {
                // 需函数外手动 std::dynamic_pointer_cast
                // 全局变量的第一个地址操作数, varoffset为其自身
                loadPtr = mkBaseOP(constVal, nullptr);
                std::dynamic_pointer_cast<BaseADROP>(loadPtr)->setBase(loadPtr);
                varpool.addLoaded(*constPtr, loadPtr, blk);
            }
            return loadPtr;
        }
    }

    template <typename T_variant> std::shared_ptr<Operand> fastFind(const T_variant &constVal) {
        auto constPtr = constpool.getConstant(constVal);
        auto constOper = std::make_shared<ConstantIDX>(constPtr);
        return constOper;
    }

    template <typename T_Reg> std::shared_ptr<PreColedOP> getPreColored(T_Reg color) { return varpool.getValue(color); }
    /// 绑定, 一个 MIR::Operand 可能对应 IR::Value
    /// 常见于对于后端来说没必要的转换
    void mkBind(const IR::Value &mid, const std::shared_ptr<BindOnVirOP> &bkd);

    /// def时建立键值对
    std::shared_ptr<BindOnVirOP> mkOP(const IR::Value &, RegisterBank);

    /// 添加一般中介变量
    std::shared_ptr<BindOnVirOP> mkOP(const std::shared_ptr<IR::Type> &, RegisterBank);

    /// store/load中创建临时GlobalADROP
    std::shared_ptr<GlobalADROP> mkBaseOP(const std::string &, const std::shared_ptr<BindOnVirOP> &);
    // 全局变量第一次Gep
    std::shared_ptr<GlobalADROP> mkBaseOP(const IR::Value &, const std::string &, unsigned int,
                                          const std::shared_ptr<BindOnVirOP> &);
    // ldr时解引用多重指针以得到一个指针
    std::shared_ptr<BaseADROP> mkBaseOP(const IR::Value &, const std::shared_ptr<BaseADROP> &ptr);
    // Gep, 传递寄存器偏移, 加常量偏移
    std::shared_ptr<BaseADROP> mkBaseOP(const IR::Value &, const std::shared_ptr<BaseADROP> &, unsigned int add_offset);
    // 仅绑定IR::Value, ::Runtime
    std::shared_ptr<BaseADROP> mkBaseOP(const IR::Value &);
    // 开辟栈空间(alloca)
    std::shared_ptr<StackADROP> mkStackOP(const IR::Value &, unsigned int size);
    // 开辟栈空间(arg fix-stack)
    std::shared_ptr<StackADROP> mkStackOP(unsigned int seq);
    // 开辟栈空间(arg)
    std::shared_ptr<StackADROP> mkStackOP_arg(unsigned int seq);
    // 开辟栈空间(spill)
    std::shared_ptr<StackADROP> mkStackOP();
};

struct InstLowering {
    OperandLowering operlower;
    Function *cur_func;

    std::list<std::shared_ptr<Instruction>> operator()(const std::shared_ptr<IR::Instruction> &,
                                                       const std::shared_ptr<BasicBlock> &self);

    std::list<std::shared_ptr<Instruction>> binaryLower(const std::shared_ptr<IR::BinaryInst> &,
                                                        const std::shared_ptr<BasicBlock> &self);

    std::list<std::shared_ptr<Instruction>> icmpLower(const std::shared_ptr<IR::ICMPInst> &,
                                                      const std::shared_ptr<BasicBlock> &self);

    std::list<std::shared_ptr<Instruction>> retLower(const std::shared_ptr<IR::RETInst> &,
                                                     const std::shared_ptr<BasicBlock> &self);

    std::list<std::shared_ptr<Instruction>> brLower(const std::shared_ptr<IR::BRInst> &,
                                                    const std::shared_ptr<BasicBlock> &self);

    std::list<std::shared_ptr<Instruction>> callLower(const std::shared_ptr<IR::CALLInst> &,
                                                      const std::shared_ptr<BasicBlock> &self);

    std::list<std::shared_ptr<Instruction>> callLower_memset(const std::shared_ptr<IR::CALLInst> &,
                                                             const std::shared_ptr<BasicBlock> &self);

    std::list<std::shared_ptr<Instruction>> zextLower(const std::shared_ptr<IR::ZEXTInst> &,
                                                      const std::shared_ptr<BasicBlock> &self);

    std::list<std::shared_ptr<Instruction>> bitcastLower(const std::shared_ptr<IR::BITCASTInst> &,
                                                         const std::shared_ptr<BasicBlock> &self);

    std::list<std::shared_ptr<Instruction>> allocaLower(const std::shared_ptr<IR::ALLOCAInst> &,
                                                        const std::shared_ptr<BasicBlock> &self);

    std::list<std::shared_ptr<Instruction>> loadLower(const std::shared_ptr<IR::LOADInst> &,
                                                      const std::shared_ptr<BasicBlock> &self);

    std::list<std::shared_ptr<Instruction>> storeLower(const std::shared_ptr<IR::STOREInst> &,
                                                       const std::shared_ptr<BasicBlock> &self);

    std::list<std::shared_ptr<Instruction>> gepLower(const std::shared_ptr<IR::GEPInst> &,
                                                     const std::shared_ptr<BasicBlock> &self);

    std::list<std::shared_ptr<Instruction>> phiLower(const std::shared_ptr<IR::PHIInst> &,
                                                     const std::shared_ptr<BasicBlock> &self);

    // Neon SIMD
    std::list<std::shared_ptr<Instruction>> fptosiLower(const std::shared_ptr<IR::FPTOSIInst> &,
                                                        const std::shared_ptr<BasicBlock> &self);

    std::list<std::shared_ptr<Instruction>> sitofpLower(const std::shared_ptr<IR::SITOFPInst> &,
                                                        const std::shared_ptr<BasicBlock> &self);

    std::list<std::shared_ptr<Instruction>> fcmpLower(const std::shared_ptr<IR::FCMPInst> &,
                                                      const std::shared_ptr<BasicBlock> &self);

    std::list<std::shared_ptr<Instruction>> binaryLower_v(const std::shared_ptr<IR::BinaryInst> &,
                                                          const std::shared_ptr<BasicBlock> &self);

    std::list<std::shared_ptr<Instruction>> fnegLower(const std::shared_ptr<IR::FNEGInst> &,
                                                      const std::shared_ptr<BasicBlock> &self);

    std::list<std::shared_ptr<Instruction>> loadLower_v(const std::shared_ptr<IR::LOADInst> &,
                                                        const std::shared_ptr<BasicBlock> &self);

    std::list<std::shared_ptr<Instruction>> storeLower_v(const std::shared_ptr<IR::STOREInst> &,
                                                         const std::shared_ptr<BasicBlock> &self);

    ///@note 补充

    // load一个指针
    std::list<std::shared_ptr<Instruction>> loadLower_p(const std::shared_ptr<IR::LOADInst> &,
                                                        const std::shared_ptr<BasicBlock> &self);
    // store一个指针
    std::list<std::shared_ptr<Instruction>> storeLower_p(const std::shared_ptr<IR::STOREInst> &,
                                                         const std::shared_ptr<BasicBlock> &self);
    //
    std::list<std::shared_ptr<Instruction>> gepLower_p(const std::shared_ptr<IR::GEPInst> &,
                                                       const std::shared_ptr<BasicBlock> &self);
};

class Lowering {
private:
    Module module;
    Function *cur_func;

public:
    Lowering() = delete;
    explicit Lowering(const IR::Module &);

    void operator()(const IR::Module &);
    std::shared_ptr<Function> lower(const IR::Function &);
    std::shared_ptr<BasicBlock> lower(const IR::BasicBlock &, OperandLowering &);

    Module &getModule();
    ~Lowering() = default;
};

} // namespace MIR

#endif
#endif