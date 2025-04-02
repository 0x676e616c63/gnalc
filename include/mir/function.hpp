#pragma once
#ifndef GNALC_MIR_FUNCTION_HPP
#define GNALC_MIR_FUNCTION_HPP
#include <deque>
#include <utility>

#include "base.hpp"
#include "basicblock.hpp"
#include "constpool.hpp"
#include "misc.hpp"
#include "varpool.hpp"

namespace MIR {

///@note 存储live info & 填写映射表 & 计算interval ranges & 算loop counts
struct Liveness {
    std::map<std::shared_ptr<BasicBlock>, std::unordered_set<std::shared_ptr<Operand>>> liveIn;
    std::map<std::shared_ptr<BasicBlock>, std::unordered_set<std::shared_ptr<Operand>>> liveOut;

    enum class relatedType { Use, Def };

    struct tempHash {
        std::size_t operator()(const std::shared_ptr<Operand> &ptr) const;

        std::size_t operator()(const std::shared_ptr<Instruction> &ptr) const;
    };

    std::map<std::shared_ptr<Operand>,
             std::unordered_set<std::pair<std::shared_ptr<Instruction>, relatedType>, tempHash>, tempHash>
        use_def_Insts;

    std::map<std::shared_ptr<Operand>, size_t> intervalLengths;

    std::map<std::shared_ptr<Operand>, size_t> loopCounts;

    void clear() {
        liveIn.clear();
        liveOut.clear();
        use_def_Insts.clear();
        intervalLengths.clear();
        loopCounts.clear();
    }
};

class Function;

/// @warning Infos只选可能有用的
class FunctionInfo {
public:                                                   // 接口太多, 还不如直接访问
    std::pair<bool, std::weak_ptr<Function>> hasTailCall; // TCO优化

    bool hasCall = false; // 是否是过程调用的叶结点

    bool isPureFunc = false;

    size_t stackSize{};
    unsigned int maxAlignment = 8;                   // 8 or 16, 16字节对齐时需要特殊处理
    std::deque<std::shared_ptr<FrameObj>> StackObjs; // arg ret local spill
    VarPool varpool;
    ConstPool &constpool; // get from module

    unsigned arg_in_use;
    unsigned int args; // livein args

    VarPool &getPool();
    const VarPool &getPool() const;

    Liveness liveinfo;

    ///@note 因为pass之间无法传递数据, 所以这个信息只能耦合在这个地方
    ///@note 其次, 这是全局的available, 因为图着色的分析不深入到单个inst
    std::set<unsigned int> availableSRegisters;

    std::set<unsigned int> regdit;
    std::set<unsigned int> regdit_s;

    unsigned int spilltimes = 0;

public:
    explicit FunctionInfo(ConstPool &_constpool, size_t _countbase);

    std::string toString() const; // print info
    ~FunctionInfo() = default;
};

class Function : public Value {
private:
private:
    FunctionInfo info;
    std::list<std::shared_ptr<BasicBlock>> blocks;

    std::unordered_map<std::string, std::shared_ptr<BasicBlock>> blockpool; // 对象池

public:
    Function() = delete;
    explicit Function(std::string _name, ConstPool &_constpool, size_t _countbase);

    FunctionInfo getInfo() const;
    FunctionInfo &editInfo();

    void addBlock(const std::string &_block_name, const std::shared_ptr<BasicBlock> &_block);

    std::shared_ptr<BasicBlock> getBlock(const std::string &_name);

    const std::list<std::shared_ptr<BasicBlock>> &getBlocks() const;

    void delBlock(std::shared_ptr<BasicBlock>);

    std::string toString() const override;

    std::string toString_Debug();
    ~Function() override = default;
};

}; // namespace MIR

#endif