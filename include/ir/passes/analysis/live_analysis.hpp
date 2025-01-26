/**
 * @brief live varable analysis
 * @brief 对instruction分析，记录livein, liveout.
 * @brief basicblock对其包含的instruction.begin->livein, end->liveout做转发
 */

#pragma once
#ifndef GNALC_IR_PASSES_ANALYSIS_LIVE_ANALYSIS_HPP
#define GNALC_IR_PASSES_ANALYSIS_LIVE_ANALYSIS_HPP

#include "../../base.hpp"
#include "../../visitor.hpp"
#include "../pass_manager.hpp"

#include <vector>
#include <unordered_map>
#include <algorithm>

namespace IR {
// FIXME: Raw pointer
class Liveness {
    using LiveSet = std::set<Value*>;
    std::unordered_map<const Value*, LiveSet> livein;
    std::unordered_map<const Value*, LiveSet> liveout;
    public:
    LiveSet& getLiveIn(const Value* v) {
        return livein.find(v)->second;
    }
    LiveSet& getLiveOut(const Value* v) {
        return liveout.find(v)->second;
    }

    void setLiveIn(const Value* v, const LiveSet& live) {
        livein[v] = live;
    }

    void setLiveOut(const Value* v, const LiveSet& live) {
        liveout[v] = live;
    }

    void reset() {
        livein.clear();
        liveout.clear();
    }
};

class LiveAnalyser : public PM::AnalysisInfo<LiveAnalyser> {
private:
    // 使用DFS遍历CFG
    void genDFSStack(const BasicBlock* bb);
    struct BBStack {
        std::vector<const BasicBlock*> stack;
        int index = -1;
        bool visited(const BasicBlock* bb) {
            return std::find(stack.begin(), stack.end(), bb) != stack.end();
        }
        const BasicBlock* pop() {
            if (index == -1) return nullptr;
            return stack[index--];
        }
        void push(const BasicBlock* bb) {
            stack.push_back(bb);
            index++;
        }
        bool spush(const BasicBlock* bb) {
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
    Liveness run(Function& f, FAM& fpm);
private:
    Liveness liveness;
    bool processFunc(const Function* func); // 处理单个func
    bool processBB(const BasicBlock* bb); // 处理单个BB
    bool processInst(const Instruction* inst); // 处理单个inst

public:
    using Result = Liveness;
private:
    friend AnalysisInfo<LiveAnalyser>;
    static PM::UniqueKey Key;
};

}

#endif