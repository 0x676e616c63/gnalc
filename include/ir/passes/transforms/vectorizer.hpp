// SLP Vectorizer
// Reference:
//   - "Exploiting Superword Level Parallelism with Multimedia Instruction Sets"
//       https://groups.csail.mit.edu/cag/slp/SLP-PLDI-2000.pdf
//   - "Loop-Aware SLP in GCC - Proceedings of the GCC Developers’ Summit"
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
    // Currently we only vectorize int and float, so the element size is a constant 4.
    static constexpr int ElementSize = 4;

    struct Pack {
        // Cache front instruction for speed.
        pInst front_inst;
        std::vector<pInst> stmts;
        std::unordered_set<pInst> stmt_set;

        Pack(const pInst& a, const pInst& b);
        Pack(const Pack& a, const Pack& b);

        bool contains(const pInst& stmt) const;

        bool isPair() const;
        pInst getLeft() const;
        pInst getRight() const;
        size_t size() const;

        const pInst& front() const;
    };

    pBlock curr_block;
    std::list<Pack> pack_set;
    // Use for Packs
    std::unordered_map<const Pack*, std::vector<Pack*>> user_pack_map;
    std::unordered_map<const Pack*, std::vector<Pack*>> operand_pack_map;
    std::unordered_map<const Pack*, pInst> scheduled_packs;
    void computePackUseDef();

    bool stmtCanPack(const pInst& a, const pInst& b, int align);
    int estimateSavings(const pInst &stmt1, const pInst &stmt2);

    bool followUseDefs(const Pack& pack);
    bool followDefUses(const Pack& pack);
    void findAdjacentReferences();
    void extendPackList();
    void combinePacks();
    void splitDependencyCycle();
    pVal gatherVector(Pack* user_pack, const std::function<pVal(const pInst&)>& proj);
    std::vector<Pack*> computeTopologicalOrder();
    bool schedule();
    void cleanup();
    void reset();

    friend std::ostream &operator<<(std::ostream &os, const Pack &expr);
    friend std::ostream &operator<<(std::ostream &os, const VectorizerPass &expr);
public:
    PM::PreservedAnalyses run(Function &function, FAM &manager);
};

} // namespace IR
#endif
