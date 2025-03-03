#pragma once
#ifndef GNALC_IR_PASSES_TRANSFORMS_INSTSIMPLIFY_HPP
#define GNALC_IR_PASSES_TRANSFORMS_INSTSIMPLIFY_HPP

#include "../pass_manager.hpp"

namespace IR {
class InstSimplifyPass : public PM::PassInfo<InstSimplifyPass> {
public:
    PM::PreservedAnalyses run(Function &function, FAM &manager);
private:
    size_t name_cnt = 0;
    std::string getTmp();
};

} // namespace IR
#endif
