#pragma once
#ifndef GNALC_MIR_VARPOOL_HPP
#define GNALC_MIR_VARPOOL_HPP
#include "../ir/base.hpp"
#include "basicblock.hpp"
#include "operand.hpp"
#include <unordered_map>

namespace MIR {
class VarPool {
private:
    struct IRValueWrapper {
        /// @brief 为IR::Value添加 operator ==
        const IR::Value &val;
        bool operator==(const IRValueWrapper &another) const {
            return &(this->val) == &(another.val); // 比较地址
        }
    };

    struct VarPoolHash {
        size_t operator()(const IRValueWrapper &val) const {
            return std::hash<std::string>()(val.val.getName()); // Value名唯一
        }
    };

    std::unordered_map<IRValueWrapper, std::shared_ptr<Operand>, VarPoolHash> pool;

    // for const2reg
    struct LoadMapHash {
        size_t operator()(const ConstObj &obj) const { return (size_t)obj.getId(); }
    };
    std::unordered_map<ConstObj, std::shared_ptr<BindOnVirOP>, LoadMapHash> const2vir;

    std::unordered_map<ConstObj, std::unordered_set<std::shared_ptr<BasicBlock>>, LoadMapHash> const2blks;

    // 两类预着色操作数
    std::unordered_map<CoreRegister, std::shared_ptr<PreColedOP>> gpr_pool;
    std::unordered_map<FPURegister, std::shared_ptr<PreColedOP>> spr_pool;

public:
    VarPool() = default;

    std::shared_ptr<Operand> getValue(const IR::Value &); // Use

    std::shared_ptr<PreColedOP> getValue(CoreRegister _color);
    std::shared_ptr<PreColedOP> getValue(FPURegister _color);

    /// fast
    template <typename T_variant>
    std::pair<std::shared_ptr<BindOnVirOP>, std::shared_ptr<ConstObj>>
    getLoaded(const T_variant &literal, const std::shared_ptr<BasicBlock> &blk) {
        unsigned int cnt = 0;
        for (const auto &[const_obj, ptr] : const2vir) {
            if (literal ==
                std::get<std::remove_cv_t<std::remove_reference_t<decltype(literal)>>>(const_obj.getLiteral()))
                return {getLoaded(const_obj, blk), nullptr};
            ++cnt;
        }
        auto obj = std::make_shared<ConstObj>(cnt, literal);

        auto op = addValue_anonymously(false);
        addLoaded(*obj, op, blk); // obj 析构? blk 析构?
        return {op, obj};         // a new const obj maybe in use ?
    }

    std::shared_ptr<BindOnVirOP> getLoaded(const ConstObj &obj, const std::shared_ptr<BasicBlock> &blk) {
        if (const2blks.find(obj) == const2blks.end() || const2vir.find(obj) == const2vir.end())
            return nullptr;

        const2blks[obj].insert(blk);
        return const2vir[obj];
    }

    const auto &getConst2Vir() { return const2vir; }
    const auto &getConst2blks() { return const2blks; } // blks use current constant

    void addValue(const IR::Value &, std::shared_ptr<Operand>); // Def

    std::shared_ptr<BindOnVirOP> addValue_anonymously(bool isFloat); // 用于添加一个新的BindOnVirOP

    std::shared_ptr<StackADROP>
    addStackValue_anonymously(const std::shared_ptr<FrameObj> &); // 用于获得一个空的栈空间(4bytes)
                                                                  // 寄存器分配用
    void addLoaded(const ConstObj &, const std::shared_ptr<BindOnVirOP> &, const std::shared_ptr<BasicBlock> &);
    size_t size() const { return pool.size(); }

    ~VarPool() = default;
};

} // namespace MIR

#endif