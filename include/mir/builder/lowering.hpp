#ifndef GNALC_MIRBUILDER_LOWERING_HPP
#define GNALC_MIRBUILDER_LOWERING_HPP
#include "../../ir/basic_block.hpp"
#include "../../ir/function.hpp"
#include "../../ir/instruction.hpp"
#include "../../ir/instructions/binary.hpp"
#include "../../ir/instructions/compare.hpp"
#include "../../ir/instructions/control.hpp"
#include "../../ir/instructions/converse.hpp"
#include "../../ir/instructions/memory.hpp"
#include "../../ir/instructions/phi.hpp"
#include "../../ir/module.hpp"
#include "../../mir/base.hpp"
#include "../../mir/function.hpp"
#include "../../mir/instruction.hpp"
#include "../../mir/module.hpp"
#include "../../mir/operand.hpp"
#include "../../mir/varpool.hpp"

namespace MIR {

struct OperandLowering {
    ///@note 由于操作数不是透过依赖关系获得的,
    /// 所以和常量一样需要一个池来查找和存放
    const size_t med_val_cnt;

    ConstPool &constpool;
    VarPool &varpool;
    std::vector<std::shared_ptr<FrameObj>> &StackObjs;

    /// when use
    std::shared_ptr<Operand> fastFind(const std::shared_ptr<IR::Value> &);

    /// when phi use
    std::shared_ptr<Operand> fastFind_phi(const std::shared_ptr<IR::Value> &);
    std::shared_ptr<Operand> search_phi(const IR::Value &);

    /// 在需要获得常数/地址时, 先使用这个
    /// 如果返回不为false, 万事大吉
    /// 如果返回为false, 在instlower环境中手动加mov/vmov
    template <typename T_variant> std::pair<bool, std::shared_ptr<BindOnVirOP>> LoadedFind(const T_variant &constVal) {
        auto constPtr = constpool.getConstant(constVal);
        auto loadPtr = varpool.getLoaded(*constPtr);
        if (loadPtr)
            return {true, loadPtr};
        else {
            using U_variant = std::remove_cv_t<std::remove_reference_t<T_variant>>;
            if constexpr (std::is_same_v<U_variant, float>) {
                loadPtr = mkOP(IR::makeBType(IR::IRBTYPE::FLOAT), RegisterBank::spr);
                varpool.addLoaded(*constPtr, loadPtr);
            } else if constexpr (std::is_same_v<U_variant, int>) {
                loadPtr = mkOP(IR::makeBType(IR::IRBTYPE::I32), RegisterBank::gpr);
                varpool.addLoaded(*constPtr, loadPtr);
            } else {
                // 需函数外手动 std::dynamic_pointer_cast
                // 全局变量的第一个地址操作数, varoffset为其自身
                loadPtr = mkBaseOP(constVal, nullptr);
                std::dynamic_pointer_cast<BaseADROP>(loadPtr)->setBase(loadPtr);
                varpool.addLoaded(*constPtr, loadPtr);
            }
            return {false, loadPtr};
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
    void mkBind(const IR::Value &mid, const std::shared_ptr<BindOnVirOP> &bkd) { varpool.addValue(mid, bkd); }

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
    // 开辟栈空间(spill)
    std::shared_ptr<StackADROP> mkStackOP();
};

struct InstLowering {
    OperandLowering operlower;

    std::list<std::shared_ptr<Instruction>> operator()(const std::shared_ptr<IR::Instruction> &);

    std::list<std::shared_ptr<Instruction>> binaryLower(const std::shared_ptr<IR::BinaryInst> &);

    std::list<std::shared_ptr<Instruction>> icmpLower(const std::shared_ptr<IR::ICMPInst> &);

    std::list<std::shared_ptr<Instruction>> retLower(const std::shared_ptr<IR::RETInst> &);

    std::list<std::shared_ptr<Instruction>> brLower(const std::shared_ptr<IR::BRInst> &);

    std::list<std::shared_ptr<Instruction>> callLower(const std::shared_ptr<IR::CALLInst> &);

    std::list<std::shared_ptr<Instruction>> zextLower(const std::shared_ptr<IR::ZEXTInst> &) {
        std::list<std::shared_ptr<Instruction>> insts;
        Err::todo("InstLowering: encounter zext inst in IR");
        return insts;
    };

    std::list<std::shared_ptr<Instruction>> bitcastLower(const std::shared_ptr<IR::BITCASTInst> &);

    std::list<std::shared_ptr<Instruction>> allocaLower(const std::shared_ptr<IR::ALLOCAInst> &);

    std::list<std::shared_ptr<Instruction>> loadLower(const std::shared_ptr<IR::LOADInst> &);

    std::list<std::shared_ptr<Instruction>> storeLower(const std::shared_ptr<IR::STOREInst> &);

    std::list<std::shared_ptr<Instruction>> gepLower(const std::shared_ptr<IR::GEPInst> &);

    std::list<std::shared_ptr<Instruction>> phiLower(const std::shared_ptr<IR::PHIInst> &);

    // Neon SIMD
    std::list<std::shared_ptr<Instruction>> fptosiLower(const std::shared_ptr<IR::FPTOSIInst> &);

    std::list<std::shared_ptr<Instruction>> sitofpLower(const std::shared_ptr<IR::SITOFPInst> &);

    std::list<std::shared_ptr<Instruction>> fcmpLower(const std::shared_ptr<IR::FCMPInst> &);

    std::list<std::shared_ptr<Instruction>> binaryLower_v(const std::shared_ptr<IR::BinaryInst> &);

    std::list<std::shared_ptr<Instruction>> loadLower_v(const std::shared_ptr<IR::LOADInst> &);

    std::list<std::shared_ptr<Instruction>> storeLower_v(const std::shared_ptr<IR::STOREInst> &);

    ///@note 补充

    // load一个指针
    std::list<std::shared_ptr<Instruction>> loadLower_p(const std::shared_ptr<IR::LOADInst> &);
    // store一个指针
    std::list<std::shared_ptr<Instruction>> storeLower_p(const std::shared_ptr<IR::STOREInst> &);
    //
    std::list<std::shared_ptr<Instruction>> gepLower_p(const std::shared_ptr<IR::GEPInst> &);
};

class Lowering {
private:
    Module module;

public:
    Lowering() = delete;
    explicit Lowering(const IR::Module &);

    void operator()(const IR::Module &);
    std::shared_ptr<Function> lower(const IR::Function &);
    std::shared_ptr<BasicBlock> lower(const IR::BasicBlock &, OperandLowering &);

    Module &getModule() { return module; }
    ~Lowering() = default;
};

} // namespace MIR

#endif