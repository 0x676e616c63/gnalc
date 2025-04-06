#include "ir/passes/transforms/slp_vectorizer.hpp"

namespace IR {
PM::PreservedAnalyses SLPVectorizerPass::run(Function &function, FAM &fam) {
    bool slp_vectorizer_inst_modified = false;

    return slp_vectorizer_inst_modified ? PreserveCFGAnalyses() : PreserveAll();
}
} // namespace IR