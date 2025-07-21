// Copyright (c) 2025 0x676e616c63
// SPDX-License-Identifier: MIT

#pragma once
#ifndef GNALC_IR_BLOCK_UTILS_HPP
#define GNALC_IR_BLOCK_UTILS_HPP

#include "basic_block.hpp"
#include "passes/pass_manager.hpp"
#include "instructions/control.hpp"

#include <memory>
#include <optional>
#include <set>

namespace IR {
// Only handles CFG.
void linkBB(const pBlock &prebb, const pBlock &nxtbb);

// deprecated
void unlinkBB(const pBlock &prebb, const pBlock &nxtbb);

// Use the following two instead
// Only unlink one edge
void unlinkOneEdge(const pBlock &prebb, const pBlock &nxtbb);
// Unlink all such edges
size_t unlinkAllEdges(const pBlock &prebb, const pBlock &nxtbb);

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

// See if this phi have a common value for every predecessor. (i.e. LCSSA phi)
pVal getCommonValue(const pPhi &phi);
// See if two phi is the same
bool isIdenticalPhi(const pPhi &phi1, const pPhi &phi2);
// Replace single entry or same value phi with its operand
// This also deletes trivially dead phis with no user.
bool foldPHI(const pBlock &bb, bool preserve_lcssa = false);
// Remove phi with identical operands
bool removeIdenticalPhi(const pBlock &bb);

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
// The phis in header are usually induction variables, the two incoming values,
// from the preheader and the latch, are loop invariant and variant respectively.
// Note that the invariant one is the initial value of that induction variable.
// This function returns the invariant and variant values in the phi.
// Return Value: (invariant, variant)
// However, in certain cases, (after TailCallOpt), the two incoming values can both be invariant.
// In this case, the function returns std::nullopt.
std::optional<std::tuple<pVal, pVal>> analyzeHeaderPhi(const pLoop &loop, const pPhi &header_phi);
std::optional<std::tuple<Value *, Value *>> analyzeHeaderPhi(const Loop *loop, const PHIInst *header_phi);

bool AhasUseToB(const pInst &a, const pVal &b);
std::vector<pInst> collectUsers(const pVal &val);
std::vector<pVal> collectOperands(const pInst &inst);

bool isReachableFrom(const pBlock &from, const pBlock &to);
} // namespace IR

#endif