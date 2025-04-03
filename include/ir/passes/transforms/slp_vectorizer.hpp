// SLP Vectorizer
// Reference:
//   - "Exploiting Superword Level Parallelism with Multimedia Instruction Sets"
//       https://groups.csail.mit.edu/cag/slp/SLP-PLDI-2000.pdf
//   - "Proceedings of the GCC Developers’ Summit"
//       http://gcc.gnu.org/wiki/HomePage?action=AttachFile&do=get&target=GCC2007-Proceedings.pdf
#pragma once
#ifndef GNALC_IR_PASSES_TRANSFORMS_SLP_VECTORIZER_HPP
#define GNALC_IR_PASSES_TRANSFORMS_SLP_VECTORIZER_HPP

#include "../pass_manager.hpp"

namespace IR {
class SLPVectorizerPass : public PM::PassInfo<SLPVectorizerPass> {
public:
    PM::PreservedAnalyses run(Function &function, FAM &manager);
};

} // namespace IR
#endif
