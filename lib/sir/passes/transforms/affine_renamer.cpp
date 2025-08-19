// Copyright (c) 2025 0x676e616c63
// SPDX-License-Identifier: MIT

#include "sir/passes/transforms/affine_renamer.hpp"

#include "ir/instructions/memory.hpp"
#include "sir/passes/analysis/affine_alias_analysis.hpp"
#include "sir/visitor.hpp"

namespace SIR {
// Don't use greek names to avoid conflict with names in the Omega Solver.
constexpr const char *iv_names[] = {"i",  "j",  "k",   "x",    "y",  "z",  "u",   "v",    "w",   "ii", "iii",
                                    "iv", "vi", "vii", "viii", "ix", "xi", "xii", "xiii", "xiv", "xv"};
constexpr const char *iv_bound_names[] = {"n", "m",  "r",  "s",  "t",  "a",  "b", "c",
                                          "d", "ab", "mn", "cd", "st", "rs", "mr"};

struct IVRenameVisitor : Visitor {
    size_t next_iv_name = 0;
    size_t next_iv_bound_name = 0;

    size_t trivial_iv_name_cnt = 0;
    size_t trivial_iv_bound_name_cnt = 0;

    void visit(FORInst &for_inst) override {
        auto iv = for_inst.getIndVar();
        auto iv_bound = for_inst.getBound();

        if (next_iv_name < std::size(iv_names))
            iv->setName(std::string{"%"} + iv_names[next_iv_name++]);
        else {
            Logger::logDebug("[AffineRenamer]: Add more iv names for better debugging.");
            iv->setName("%i" + std::to_string(trivial_iv_name_cnt++));
        }

        if (iv_bound->getVTrait() != ValueTrait::CONSTANT_LITERAL && iv_bound->getVTrait() != ValueTrait::FORMAL_PARAMETER) {
            if (next_iv_bound_name < std::size(iv_bound_names))
                iv_bound->setName(std::string{"%"} + iv_bound_names[next_iv_bound_name++]);
            else {
                Logger::logDebug("[AffineRenamer]: Add more iv bound names for better debugging.");
                iv_bound->setName("%n" + std::to_string(trivial_iv_bound_name_cnt++));
            }
        }

        Visitor::visit(for_inst);
    }
};

struct GEPRenameVisitor : Visitor {
    AffineAAResult *affine_aa;
    std::unordered_map<std::string, size_t> name_cnts;

    explicit GEPRenameVisitor(AffineAAResult *affine_aa_) : affine_aa(affine_aa_) {}

    void visit(Instruction &inst) override {
        auto gep = inst.as<GEPInst>();
        if (!gep) {
            Visitor::visit(inst);
            return;
        }

        if (auto aa = affine_aa->queryPointer(gep)) {
            if (aa->isArray()) {
                auto acc = aa->array();

                auto name = [&]() -> std::string {
                    std::string ret = "%";
                    auto base_name = acc.base->getName();
                    if (Util::endsWith(base_name, ".alloc"))
                        base_name = base_name.substr(0, base_name.size() - 6);
                    ret += base_name.substr(1);

                    for (auto &idx : acc.indices) {
                        if (!idx.isLinear())
                            return "";
                        auto [coe, iv] = idx.getLinear();
                        if (coe != 1)
                            return "";
                        ret += "_" + iv->getName().substr(1);
                    }
                    return ret;
                }();

                if (!name.empty()) {
                    if (name_cnts[name]++ != 0)
                        name += "_" + std::to_string(name_cnts[name]);
                    gep->setName(name);

                    if (gep->getUseCount() == 1) {
                        if (auto ld = gep->getSingleUser()->as<LOADInst>())
                            ld->setName(name + ".ld");
                        else if (auto st = gep->getSingleUser()->as<STOREInst>())
                            st->setName(name + ".st");
                    }
                }
            }
        }
    }
};

PM::PreservedAnalyses AffineRenamePass::run(LinearFunction &function, LFAM &lfam) {
    auto &affine_aa = lfam.getResult<AffineAliasAnalysis>(function);

    IVRenameVisitor iv_visitor;
    function.accept(iv_visitor);

    GEPRenameVisitor gep_visitor(&affine_aa);
    function.accept(gep_visitor);

    return PreserveAll();
}
} // namespace SIR