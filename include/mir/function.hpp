#pragma once
#ifndef GNALC_MIR_FUNCTION_HPP
#define GNALC_MIR_FUNCTION_HPP
#include <utility>

#include "base.hpp"
#include "basicblock.hpp"
#include "misc.hpp"

namespace MIR {

class Function;

/// @warning Infos只选可能有用的
class FunctionInfo {
public: // 接口太多, 还不如直接访问
    std::pair<bool, std::weak_ptr<Function>> hasTailCall; // TCO优化

    bool hasCall{}; // 除了TC之外的调用, 可以视情况节省一两条指令

    size_t stackSize{};
    unsigned int maxAlignment = 4;
    std::vector<std::shared_ptr<FrameObj>> StackObjs;

    std::list<std::shared_ptr<ConstObj>> ConstPool;

    std::list<std::shared_ptr<Operand>> LiveIns; // 参数, 暂时这么写

public:
    FunctionInfo() = default;

    std::string toString() const; // print info
    ~FunctionInfo() = default;
};

class Function : public Value {

private:
    FunctionInfo info;
    std::list<std::shared_ptr<BasicBlock>> blocks;

public:
    Function() = delete;
    explicit Function(std::string _name)

        : Value(ValueTrait::Function, std::move(_name)) {}

    FunctionInfo getInfo() const { return info; }
    FunctionInfo &editInfo() { return info; }

    void addBlock(std::shared_ptr<BasicBlock> _block) {
        blocks.emplace_back(std::move(_block));
    }

    void delBlock(const std::string &_name);

    const std::list<std::shared_ptr<BasicBlock>> &getBlocks() { return blocks; }

    std::string toString() const override;
    ~Function() override = default;
};

}; // namespace MIR

#endif