#pragma once
#ifndef GNALC_IR_BLOCK_UTILS_HPP
#define GNALC_IR_BLOCK_UTILS_HPP

#include "base.hpp"
#include "instruction.hpp"
#include "instructions/phi.hpp"
#include "instructions/control.hpp"
#include "basic_block.hpp"

#include <memory>
#include <set>

namespace IR {
// Only handles CFG.
void linkBB(const std::shared_ptr<BasicBlock> &prebb,
            const std::shared_ptr<BasicBlock> &nxtbb);

void unlinkBB(const std::shared_ptr<BasicBlock> &prebb,
              const std::shared_ptr<BasicBlock> &nxtbb);

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
// WARNING: This function won't delete instructions. The BRInst or PHIInst requires the caller to delete.
//          When `safeUnlinkBB` is called within a function, the returned dead phis should be
//          gathered for all basic blocks, and deleted at once.
bool safeUnlinkBB(const std::shared_ptr<BasicBlock> &prebb,
                  const std::shared_ptr<BasicBlock> &nxtbb,
                  std::set<std::shared_ptr<PHIInst>>& dead_phis);

// Move `bb` to `new_func`'s `location`
// This deletes `bb` from its parent, and insert it before `new_func`'s location
void moveBlock(const std::shared_ptr<BasicBlock>& bb,
    const std::shared_ptr<Function>& new_func, FunctionBBIter location);
void moveBlocks(FunctionBBIter beg, FunctionBBIter end,
    const std::shared_ptr<Function>& new_func, FunctionBBIter location);
// The following two functions move `bb` to `new_func`'s end
void moveBlock(const std::shared_ptr<BasicBlock>& bb,
    const std::shared_ptr<Function>& new_func);
void moveBlocks(FunctionBBIter beg, FunctionBBIter end,
    const std::shared_ptr<Function>& new_func);

// Replace single entry or same value phi with its operand
void foldPHI(const std::shared_ptr<BasicBlock> &bb, bool preserve_lcssa = false);

// Break critical edges,
// returns the generated basic block if there is a critical edge, or nullptr for not.
std::shared_ptr<BasicBlock> breakCriticalEdge(
    const std::shared_ptr<BasicBlock>& pred, const std::shared_ptr<BasicBlock>& succ);
} // namespace IR

#endif