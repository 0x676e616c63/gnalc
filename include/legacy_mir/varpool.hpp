#ifdef GNALC_EXTENSION_ARMv7
#pragma once
#ifndef GNALC_LEGACY_MIR_VARPOOL_HPP
#define GNALC_LEGACY_MIR_VARPOOL_HPP
#include "basicblock.hpp"
#include "ir/base.hpp"
#include "operand.hpp"
#include <unordered_map>

namespace LegacyMIR {
class VarPool {
private:
    struct IRValueWrapper {
        /// @brief 为IR::Value添加 operator ==
        const IR::Value &val;
        bool operator==(const IRValueWrapper &another) const;
    };

    struct VarPoolHash {
        size_t operator()(const IRValueWrapper &val) const;
    };

    std::unordered_map<IRValueWrapper, std::shared_ptr<Operand>, VarPoolHash> pool;

    // for const2reg
    struct LoadMapHash {
        size_t operator()(const ConstObj &obj) const;
    };

    std::unordered_map<ConstObj, std::shared_ptr<BindOnVirOP>, LoadMapHash> const2vir;

    std::unordered_map<ConstObj, std::unordered_set<std::shared_ptr<BasicBlock>>, LoadMapHash> const2blks;

    // 两类预着色操作数
    std::unordered_map<CoreRegister, std::shared_ptr<PreColedOP>> gpr_pool;
    std::unordered_map<FPURegister, std::shared_ptr<PreColedOP>> spr_pool;

public:
    VarPool() = delete;

    VarPool(size_t _countbase) : countbase(_countbase) {}

    std::shared_ptr<Operand> getValue(const IR::Value &); // Use

    std::shared_ptr<PreColedOP> getValue(CoreRegister _color);
    std::shared_ptr<PreColedOP> getValue(FPURegister _color);

    /// fast
    template <typename T_variant>
    std::pair<std::shared_ptr<BindOnVirOP>, std::shared_ptr<ConstObj>>
    getLoaded(const T_variant &literal, const std::shared_ptr<BasicBlock> &blk) {
        unsigned int cnt = 0;

        for (const auto &[const_obj, ptr] : const2vir) {
            // if (std::holds_alternative<T_variant>(const_obj.getLiteral()))
            if (std::holds_alternative<T_variant>(const_obj.getOriginal()))
                if (literal == std::get<T_variant>(const_obj.getOriginal()))
                    return {getLoaded(const_obj, blk), nullptr};
            ++cnt;
        }
        auto obj = std::make_shared<ConstObj>(cnt, literal);

        std::shared_ptr<LegacyMIR::BindOnVirOP> op;

        op = addValue_anonymously(false);
        addLoaded(*obj, op, blk); // obj 析构? blk 析构?
        return {op, obj};         // a new const obj maybe in use ?
    }

    std::shared_ptr<BindOnVirOP> getLoaded(const ConstObj &obj, const std::shared_ptr<BasicBlock> &blk);
    void addLoaded(const ConstObj &, const std::shared_ptr<BindOnVirOP> &, const std::shared_ptr<BasicBlock> &);

    bool isLoad(const std::shared_ptr<Operand> &); // 是否是一个装载地址/常数的寄存器

    const auto &getConst2Vir() { return const2vir; }
    const auto &getConst2blks() { return const2blks; }

    void addValue(const IR::Value &, std::shared_ptr<Operand>); // Def

    std::shared_ptr<BindOnVirOP> mkOP_backup(const std::shared_ptr<IR::Type> &, RegisterBank);

    std::shared_ptr<BindOnVirOP> addValue_anonymously(bool isFloat); // 用于添加一个新的BindOnVirOP

    std::shared_ptr<BaseADROP> addPtr_anonymously();
    std::shared_ptr<StackADROP>
    addStackValue_anonymously(const std::shared_ptr<FrameObj> &); // 用于获得一个空的栈空间(4bytes)
                                                                  // 寄存器分配用

    size_t size() const;

    const size_t countbase;

    ~VarPool() = default;
};

} // namespace MIR

#endif
#endif