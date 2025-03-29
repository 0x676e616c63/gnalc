#pragma once
#ifndef GNALC_IR_BLOCK_UTILS_HPP
#define GNALC_IR_BLOCK_UTILS_HPP

#include "basic_block.hpp"
#include "passes/pass_manager.hpp"
#include "instructions/control.hpp"

#include <memory>
#include <set>

namespace IR {
// Only handles CFG.
void linkBB(const pBlock &prebb, const pBlock &nxtbb);

void unlinkBB(const pBlock &prebb, const pBlock &nxtbb);

// Safely disconnects two basic blocks in CFG while maintaining SSA consistency
//
// This function performs three key operations:
// 1. Removes CFG edges between the `prebb` and `nxtbb` blocks
// 2. Updates relevant BRInst (won't delete it)
// 3. Fix and collects invalidated PHIInst that need removal
// 4. Returns whether the BRInst should be removed or not
//
// Why returns the dead PHI rather than delete them in place:
//     Dead phis can be in a cycle, and might involve multiple blocks.
//     In other word, when `safeUnlinkBB` is called within a function,
//     the returned dead phis might have users(also a phi) in other blocks of the function.
//     To help `delInstIf` check if we delete right instructions,
//     we return them to be gathered and deleted at once.
//
// WARNING: This function won't delete dead instructions unless `perform_dce` is set.
//          But the BRInst or PHIInst requires the caller to delete.
//          When `safeUnlinkBB` is called within a function, the returned dead phis should be
//          gathered for all basic blocks, and deleted at once.
struct UnlinkOptions {
    friend bool safeUnlinkBB(const pBlock &prebb, const pBlock &nxtbb, std::set<pPhi> &dead_phis, UnlinkOptions options);
private:
    bool perform_dce = false;
    FAM *fam = nullptr;

    UnlinkOptions(bool perform_dce_, FAM* fam_) : perform_dce(perform_dce_), fam(fam_) {}
public:
    static UnlinkOptions performDCE(FAM* fam) {
        return {true, fam};
    }
    static UnlinkOptions unlinkOnly() {
        return { false, nullptr };
    }
};
bool safeUnlinkBB(const pBlock &prebb, const pBlock &nxtbb,
    std::set<pPhi> &dead_phis, UnlinkOptions options = UnlinkOptions::unlinkOnly());

// Move `bb` to `new_func`'s `location`
// This deletes `bb` from its parent, and insert it before `new_func`'s location
void moveBlock(const pBlock &bb, const pFunc &new_func, FunctionBBIter location);
void moveBlocks(FunctionBBIter beg, FunctionBBIter end, const pFunc &new_func, FunctionBBIter location);
// The following two functions move `bb` to `new_func`'s end
void moveBlock(const pBlock &bb, const pFunc &new_func);
void moveBlocks(FunctionBBIter beg, FunctionBBIter end, const pFunc &new_func);

// Since phi can have another phi as its operand,
// the following two functions should be called in a Reverse Post Order.

// Replace single entry or same value phi with its operand
// This also deletes trivially dead phis with no user.
void foldPHI(const pBlock &bb, bool preserve_lcssa = false);
// Remove phi with identical operands
void removeIdenticalPhi(const pBlock &bb);

// Break critical edges,
// returns the generated basic block if there is a critical edge, or nullptr for not.
pBlock breakCriticalEdge(const pBlock &pred, const pBlock &succ);
// Break all critical edges in a function, return true if the function is modified.
bool breakAllCriticalEdges(const Function &function);

// Check if a phi is LCSSA phi for `target_val`
bool isLCSSAPhi(const pPhi &phi, pVal target_val = nullptr);
// Find if there is a LCSSA phi in `block` for `value`
pPhi findLCSSAPhi(const pBlock &block, const pVal &value);

// Eliminate dead instructions through use-def chain from the worklist
// If fam is nullptr, this function won't eliminate dead non-side-effect function call.
bool eliminateDeadInsts(std::vector<pInst>& worklist, FAM *fam = nullptr);
bool eliminateDeadInsts(pInst inst, FAM *fam = nullptr);
// Convenient wrapper for safeUnlinkBB
bool eliminateDeadInsts(const std::set<pPhi>& dead_phis, FAM *fam = nullptr);

// In LoopSimplified Form, the header has two predecessors, one is the preheader, the other is the latch.
// The phis in header are induction variables, the two incoming values, from the preheader and the latch,
// must be loop invariant and variant respectively.
// Note that the invariant one is the initial value of that induction variable.
// This function returns the invariant and variant values in the phi.
// Return Value: (invariant, variant)
std::tuple<pVal, pVal> analyzeHeaderPhi(const pLoop &loop, const pPhi &header_phi);
std::tuple<Value *, Value *> analyzeHeaderPhi(const Loop *loop, const PHIInst *header_phi);
} // namespace IR

#endif