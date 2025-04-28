#include "ir/passes/transforms/vectorizer.hpp"

namespace IR {
PM::PreservedAnalyses VectorizerPass::run(Function &function, FAM &fam) {
    bool vectorizer_inst_modified = false;

    return vectorizer_inst_modified ? PreserveCFGAnalyses() : PreserveAll();
}
} // namespace IR