#include "../../include/mir/function.hpp"
#include <algorithm>

using namespace MIR;

std::size_t Liveness::tempHash::operator()(const std::shared_ptr<Operand> &ptr) const {
    return std::hash<size_t>()((size_t)(ptr.get()));
}

std::size_t Liveness::tempHash::operator()(const std::shared_ptr<Instruction> &ptr) const {
    return std::hash<size_t>()((size_t)(ptr.get()));
}

VarPool &FunctionInfo::getPool() { return varpool; }
const VarPool &FunctionInfo::getPool() const { return varpool; }

std::string FunctionInfo::toString() const {
    std::string str;

    str += "maxalignment: " + std::to_string(maxAlignment) + '\n';

    if (hasTailCall.first)
        str += "hasTailCall: true - @" + hasTailCall.second.lock()->getName() + '\n';
    else
        str += "hasTailCall: false\n";

    str += "stackobjs: \n";
    for (const auto &obj : StackObjs) {
        str += obj->toString();
        str += '\n';
    }

    str += "spilltimes: " + std::to_string(spilltimes) + '\n';

    return str;
}

FunctionInfo::FunctionInfo(ConstPool &_constpool) : constpool(_constpool) {}

Function::Function(std::string _name, ConstPool &_constpool)
    : Value(ValueTrait::Function, std::move(_name)), info(FunctionInfo{_constpool}) {}

FunctionInfo Function::getInfo() const { return info; }
FunctionInfo &Function::editInfo() { return info; }

void Function::addBlock(const std::string &_block_name, const std::shared_ptr<BasicBlock> &_block) {
    blocks.emplace_back(_block);
    blockpool[_block_name] = _block;
}

std::shared_ptr<BasicBlock> Function::getBlock(const std::string &_name) { return blockpool[_name]; }

const std::list<std::shared_ptr<BasicBlock>> &Function::getBlocks() const { return blocks; }

std::string Function::toString() const {
    std::string str;

    str += "name: " + getName() + '\n';

    str += info.toString();

    str += "body:\n";

    for (const auto &basicblock : blocks) {
        str += "    ";
        str += basicblock->toString() + '\n';
    }

    return str;
}

void Function::delBlock(std::shared_ptr<BasicBlock> blk) {
    auto lambda = [&blk](const auto &other) { return other == blk; };

    ;
    auto it = std::find_if(blocks.begin(), blocks.end(), lambda);

    if (it != blocks.end())
        blocks.erase(it);
}

std::string Function::toString_Debug() {
    std::string str;

    str += "name: " + getName() + '\n';

    str += info.toString();

    str += "body:\n";

    for (auto &basicblock : blocks) {
        str += "    ";
        str += basicblock->toString_debug(info.liveinfo.liveIn[basicblock], info.liveinfo.liveOut[basicblock]) + '\n';
    }

    return str;
}