// Copyright (c) 2025 0x676e616c63
// SPDX-License-Identifier: MIT

/**
 * @brief 基本块划分，生成CFG
 * @attention !!!需要尽量确保第一个BB是entry, 最后一个是return
 */

#pragma once

#ifndef GNALC_IR_PASSES_TRANSFORMS_CFGBUILDER_HPP
#define GNALC_IR_PASSES_TRANSFORMS_CFGBUILDER_HPP

#include "../sir/base.hpp"
#include "base.hpp"
#include "basic_block.hpp"
#include "function.hpp"
#include "instructions/control.hpp"
#include "instructions/helper.hpp"
#include "module.hpp"

#include <stack>

namespace IR {
// 通过 Func 中的 insts 划分基本块
class CFGBuilder {
private:
    struct _idx {
    private:
        static std::string idxtos(const unsigned int idx) {
            if (idx == 1)
                return "";
            else
                return std::to_string(idx);
        };

    public:
        unsigned int ifthenidx = 1; // if, elif 的 body
        unsigned int ifelseidx = 1; // elif 就是判断条件, else 就是 elsebody
        unsigned int ifendidx = 1;  // 结束后的块
        unsigned int whcondidx = 1;
        unsigned int whbodyidx = 1;
        unsigned int whendidx = 1;
        unsigned int forcondidx = 1;
        unsigned int forbodyidx = 1;
        unsigned int forendidx = 1;
        unsigned int forindvaridx = 1;
        unsigned int landltidx = 1;
        unsigned int lorlfidx = 1;
        std::string getIfThen() { return "%if.then" + idxtos(ifthenidx++); }
        std::string getIfElse() { return "%if.else" + idxtos(ifelseidx++); }
        std::string getIfEnd() { return "%if.end" + idxtos(ifendidx++); }
        std::string getWhCond() { return "%while.cond" + idxtos(whcondidx++); }
        std::string getWhBody() { return "%while.body" + idxtos(whbodyidx++); }
        std::string getWhEnd() { return "%while.end" + idxtos(whendidx++); }
        std::string getForCond() { return "%for.cond" + idxtos(forcondidx++); }
        std::string getForBody() { return "%for.body" + idxtos(forbodyidx++); }
        std::string getForEnd() { return "%for.end" + idxtos(forendidx++); }
        std::string getForIndVar() { return "%for.indvar" + idxtos(forindvaridx++); }
        std::string getLandlt() { return "%land.lhs.true" + idxtos(landltidx++); }
        std::string getLorlf() { return "%lor.lhs.false" + idxtos(lorlfidx++); }
        void reset() {
            ifthenidx = 1;
            ifelseidx = 1;
            ifendidx = 1;
            whcondidx = 1;
            whbodyidx = 1;
            whendidx = 1;
            forcondidx = 1;
            forbodyidx = 1;
            forendidx = 1;
            forindvaridx = 1;
            landltidx = 1;
            lorlfidx = 1;
        }
    } nam; // new BB index or name
    pLFunc cur_linear_func;
    pFunc cur_making_func;
    pBlock cur_blk;
    std::stack<pBlock> loop_cond_for_continue;
    std::stack<pBlock> loop_end_for_break;
    std::stack<pPhi> iv_for_contine;
    std::stack<pVal> iv_update_for_contine;

    bool adder(std::list<pInst>::const_iterator &it,
               const std::list<pInst>::const_iterator &end,
               bool allow_break); // 将inst加进cur_blk，返回值为是否已插入终结语句ret,
                                  // br
    void newIf(const pIfInst &);
    void newWh(const pWhileInst &);
    void newFor(const pForInst &);

    void short_circuit_process(const pCondValue &cond, const pBlock &true_blk,
                               const pBlock &false_blk);
    // 包含了短路cond和普通cond两种处理
    void addCondBr(const pVal &cond, const pBlock &true_blk, const pBlock &false_blk);
    void divider();

public:
    void build(Module &);
};

} // namespace IR

#endif