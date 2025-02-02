#ifndef GNALC_MIR_LOWERING_HPP
#define GNALC_MIR_LOWERING_HPP
#include "../ir/basic_block.hpp"
#include "../ir/function.hpp"
#include "../ir/instruction.hpp"
#include "../ir/module.hpp"
#include "../mir/base.hpp"
#include "../mir/function.hpp"
#include "../mir/instruction.hpp"
#include "../mir/module.hpp"
#include "../mir/operand.hpp"
#include "../mir/varpool.hpp"

namespace MIR {

struct OperandLowering {
    ///@note 由于操作数不是透过依赖关系获得的,
    /// 所以和常量一样需要一个池来查找和存放
    ConstPool &ConstPool;
    VarPool &VarPool;

    /// when def
    std::shared_ptr<Operand> fastFind(const std::shared_ptr<IR::Value> &);

    /// when use
    template <typename T_Reg>
    std::shared_ptr<PreColedOP> getPreColored(T_Reg color);

    std::shared_ptr<GlobalADROP> mkBaseOP(const IR::Value &,
                                          const std::string &, unsigned int);
    std::shared_ptr<StackADROP> mkBaseOP(const IR::Value &,
                                         const std::shared_ptr<FrameObj> &,
                                         unsigned int);
    std::shared_ptr<BaseADROP> mkBaseOP(const IR::Value &,
                                        const std::shared_ptr<BaseADROP> &,
                                        unsigned int);
};

struct InstLowering {
    OperandLowering operlower;
    std::shared_ptr<Instruction>
    operator()(const std::shared_ptr<IR::Instruction> &);

    std::shared_ptr<Instruction> binaryLower();
    std::shared_ptr<Instruction> icmpLower();
    std::shared_ptr<Instruction> fcmpLower();
    std::shared_ptr<Instruction> retLower();
    std::shared_ptr<Instruction> brLower();
    std::shared_ptr<Instruction> callLower();
    std::shared_ptr<Instruction> zextLower();
    std::shared_ptr<Instruction> bitcastLower();
    std::shared_ptr<Instruction> allocaLower();
    std::shared_ptr<Instruction> loadLower();
    std::shared_ptr<Instruction> storeLower();
    std::shared_ptr<Instruction> gepLower();
    std::shared_ptr<Instruction> phiLower();
};

class Lowering {
private:
    Module module;
    InstLowering instlower;

public:
    Lowering();

    void operator()(const IR::Module &);
    std::shared_ptr<Function> lower(const IR::Function &);
    std::shared_ptr<BasicBlock> lower(const IR::BasicBlock &);

    void PhiEliminate();

    Module &getModule() { return module; }
    ~Lowering() = default;
};

} // namespace MIR

#endif