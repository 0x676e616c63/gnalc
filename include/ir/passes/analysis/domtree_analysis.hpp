#pragma once
#ifndef GNALC_IR_PASSES_ANALYSIS_DOMTREE_ANALYSIS_HPP
#define GNALC_IR_PASSES_ANALYSIS_DOMTREE_ANALYSIS_HPP

#include "../../base.hpp"
#include "../pass_manager.hpp"

namespace IR {

// TODO

class DomTree {

};

class DomTreeAnalysis : public PM::AnalysisInfo<DomTreeAnalysis> {
public:
    DomTree run(Function& f, FAM& fpm);
};

}

#endif