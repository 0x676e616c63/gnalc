// SLP Vectorizer
// Reference:
//   - "Exploiting Superword Level Parallelism with Multimedia Instruction Sets"
//       https://groups.csail.mit.edu/cag/slp/SLP-PLDI-2000.pdf
//   - "Proceedings of the GCC Developers’ Summit"
//       http://gcc.gnu.org/wiki/HomePage?action=AttachFile&do=get&target=GCC2007-Proceedings.pdf
//   - "VeGen: a vectorizer generator for SIMD and beyond"
//       https://dl.acm.org/doi/10.1145/3445814.3446692
#pragma once
#ifndef GNALC_IR_PASSES_TRANSFORMS_VECTORIZER_HPP
#define GNALC_IR_PASSES_TRANSFORMS_VECTORIZER_HPP

#include "ir/passes/pass_manager.hpp"

namespace IR {
class VectorizerPass : public PM::PassInfo<VectorizerPass> {
private:
    struct Pack {
        std::vector<pInst> stmts;

        Pack(const pInst& a, const pInst& b);
        Pack(const Pack& a, const Pack& b);

        void addStmt(const pInst& stmt);

        bool isPair() const;
        pInst getLeft() const;
        pInst getRight() const;
    };

    pBlock curr_block;
    std::list<Pack> pack_set;

    bool stmtCanPack(const pInst& a, const pInst& b, int align);
    int estimateSavings(const pInst &stmt1, const pInst &stmt2);

    bool followUseDefs(const Pack& pack);
    bool followDefUses(const Pack& pack);
    void findAdjacentReferences();
    void extendPackList();
    void combinePacks();
    bool schedule();
    void reset();

    friend std::ostream &operator<<(std::ostream &os, const Pack &expr);
    friend std::ostream &operator<<(std::ostream &os, const VectorizerPass &expr);
public:
    PM::PreservedAnalyses run(Function &function, FAM &manager);
};

} // namespace IR
#endif
