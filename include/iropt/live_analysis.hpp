/**
 * @brief live varable analysis
 * @brief 对instruction分析，记录livein, liveout.
 * @brief basicblock对其包含的instruction.begin->livein, end->liveout做转发
 */

#pragma once
#ifndef GNALC_LIVE_ANALYSIS_HPP
#define GNALC_LIVE_ANALYSIS_HPP

#include "../ir/visitor.hpp"
#include <vector>
#include <algorithm>

namespace IR {

class LiveAnalyser {
private:
    // 使用DFS遍历CFG
    void genDFSStack(const std::shared_ptr<BasicBlock>& bb);
    struct BBStack {
        std::vector<std::shared_ptr<BasicBlock>> stack;
        int index = -1;
        bool visited(const std::shared_ptr<BasicBlock>& bb) {
            return std::find(stack.begin(), stack.end(), bb) != stack.end();
        }
        std::shared_ptr<BasicBlock> pop() {
            if (index == -1) return nullptr;
            return stack[index--];
        }
        void push(const std::shared_ptr<BasicBlock>& bb) {
            stack.push_back(bb);
            index++;
        }
        bool spush(const std::shared_ptr<BasicBlock>& bb) {
            if (visited(bb)) return false;
            push(bb);
            return true;
        }
        bool empty() {
            return index == -1;
        }
        void restore() {
            index = stack.size() - 1;
        }
        void reset() {
            stack.clear();
            index = -1;
        }
    } bb_stack;
public:
    void processModule(const Module& module);
    bool processFunc(const std::shared_ptr<Function>& func); // 处理单个func
    bool processBB(const std::shared_ptr<BasicBlock>& bb); // 处理单个BB
    bool processInst(const std::shared_ptr<Instruction>& inst); // 处理单个inst

    void cleanLiveInfo(const Module& module);
};

}

#endif