/**
 * @brief 基本块划分，生成CFG
 * @attention !!!需要尽量确保第一个BB是entry, 最后一个是return
 */

#pragma once

#ifndef GNALC_CFGBUILDER_HPP
#define GNALC_CFGBUILDER_HPP

#include "../ir/visitor.hpp"
#include <stack>

namespace IR {

// 通过Func中的insts划分基本块
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
        unsigned int ifendidx = 1; // 结束后的块
        unsigned int whcondidx = 1;
        unsigned int whbodyidx = 1;
        unsigned int whendidx = 1;
        unsigned int landltidx = 1;
        unsigned int lorlfidx = 1;
        std::string getIfthen() { return "%if.then" + idxtos(ifthenidx++); }
        std::string getIfelse() { return "%if.else" + idxtos(ifelseidx++); }
        std::string getIfend() { return "%if.end" + idxtos(ifendidx++); }
        std::string getWhcond() { return "%while.cond" + idxtos(whcondidx++); }
        std::string getWhbody() { return "%while.body" + idxtos(whbodyidx++); }
        std::string getWhend() { return "%while.end" + idxtos(whendidx++); }
        std::string getLandlt() { return "%land.lhs.true" + idxtos(landltidx++); }
        std::string getLorlf() { return "%lor.lhs.false" + idxtos(lorlfidx++); }
        void reset() {
            ifthenidx = 1;
            ifelseidx = 1;
            ifendidx = 1;
            whcondidx = 1;
            whbodyidx = 1;
            whendidx = 1;
            landltidx = 1;
            lorlfidx = 1;
        }
    } nam; // new BB index or name
    std::shared_ptr<BasicBlock> cur_blk;
    std::shared_ptr<Function> cur_func;
    std::stack<std::shared_ptr<BasicBlock>> _while_cond_for_continue;
    std::stack<std::shared_ptr<BasicBlock>> _while_end_for_break;

    bool adder(std::vector<std::shared_ptr<IR::Instruction> >::const_iterator &it
               , const std::vector<std::shared_ptr<IR::Instruction> >::const_iterator &end
               , bool allow_break); // 将inst加进cur_blk，返回值为是否已插入br
    void newIf(const std::shared_ptr<IFInst>& ifinst);
    void newWh(const std::shared_ptr<WHILEInst>& whinst);

    void short_circuit_process(const std::shared_ptr<CONDValue> &cond,
                           const std::shared_ptr<BasicBlock> &true_blk,
                           const std::shared_ptr<BasicBlock> &false_blk);
    void divider();
    void linker() const;
public:
    void build(const Module& module);
};

}

#endif