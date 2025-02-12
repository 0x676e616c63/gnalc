#include "../../../../include/ir/passes/transforms/dse.hpp"
#include "../../../../include/ir/instructions/memory.hpp"
#include "../../../../include/ir/passes/analysis/alias_analysis.hpp"
#include "../../../../include/ir/passes/analysis/domtree_analysis.hpp"

#include <algorithm>

namespace IR {
// TODO, optimization
std::shared_ptr<DomTree::Node> getDomTreeNode(const DomTree& tree, const std::shared_ptr<BasicBlock>& block) {
    auto dfv = tree.getDFVisitor();
    for (const auto& n : dfv) {
        if (n->bb == block.get())
            return n;
    }
    return nullptr;
}
PM::PreservedAnalyses DSEPass::run(Function &function, FAM &fam) {
    auto aliasResult = fam.getResult<AliasAnalysis>(function);
    auto domtree = fam.getResult<DomTreeAnalysis>(function);
    std::set<std::shared_ptr<Instruction>> eraseSet;
    for (const auto & store_block: function) {
        for (auto it = store_block->begin(); it != store_block->end(); ++it) {
            auto store = std::dynamic_pointer_cast<STOREInst>(*it);
            if (store == nullptr) continue;
            auto store_ptr = store->getPtr().get();

            bool overwritten = false;
            bool referenced = false;

            // Eliminate a store if overwritten
            for (auto inst_it = std::next(it); inst_it != store_block->end(); ++inst_it) {
                auto modref = aliasResult.getInstModRefInfo(inst_it->get(), store_ptr, fam);
                if (modref == AliasAnalysisResult::ModRefInfo::Ref || modref == AliasAnalysisResult::ModRefInfo::ModRef) {
                    referenced = true;
                    break;
                }
                if (modref == AliasAnalysisResult::ModRefInfo::Mod)
                    overwritten = true;
            }

            // Already referenced within the block, alive, go for the next store
            if (referenced)
                continue;

            // No referenced but overwritten within the block, dead, delete it
            if (overwritten)
                eraseSet.insert(store);
            // No referenced and no written, check other blocks to see if there is reference
            else {
                auto node = getDomTreeNode(domtree, store_block);
                DomTree::NodeDFVisitor dfv{node};
                for (const auto& candidate : dfv) {
                    for (const auto& inst : *candidate->bb) {
                        auto modref = aliasResult.getInstModRefInfo(inst.get(), store_ptr, fam);
                        if (modref == AliasAnalysisResult::ModRefInfo::Ref || modref == AliasAnalysisResult::ModRefInfo::ModRef) {
                            referenced = true;
                            break;
                        }
                    }
                    if (referenced) break;
                }
                if (!referenced)
                    eraseSet.emplace(store);
            }
        }
    }

    bool dse_inst_modified = false;

    // erase dead inst
    for (auto &block : function) {
        dse_inst_modified |= block->delInstIf([&eraseSet](const auto &inst) {
            return eraseSet.find(inst) != eraseSet.end();
        });
    }

    if (dse_inst_modified) {
        PM::PreservedAnalyses pa;
        pa.preserve<DomTreeAnalysis>();
        pa.preserve<PostDomTreeAnalysis>();
        return pa;
    }

    return PM::PreservedAnalyses::all();
}

} // namespace IR