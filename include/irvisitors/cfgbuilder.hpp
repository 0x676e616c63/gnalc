/**
 * @brief 基本块划分，生成CFG
 */

#pragma once

#ifndef GNALC_CFGBUILDER_HPP
#define GNALC_CFGBUILDER_HPP

#include "../ir/visitor.hpp"

namespace IR {

// 通过Func中的insts划分基本块
class CFGBuilder {
private:
    unsigned int bb_idx = 0; // 之后可能会分为while_cond_idx, if_body_idx...
    std::vector<std::shared_ptr<IR::Instruction>>::iterator inst_it;
    std::string getNewBBName();
    void resetBBIdx();
    bool isTerminator();
public:
    void build(Module& module);
    void divider(Function& func);
    void linker(Function& func);
};

}

#endif