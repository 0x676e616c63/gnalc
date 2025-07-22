// Copyright (c) 2025 0x676e616c63
// SPDX-License-Identifier: MIT

#include "../../../../include/ir/passes/transforms/gep_flatten.hpp"

#include "../../../../include/ir/instructions/converse.hpp"
#include "../../../../include/ir/irbuilder.hpp"

#include <vector>

namespace IR {
PM::PreservedAnalyses GEPFlattenPass::run(Function &function, FAM &manager) {
    std::vector<pGep> geps;
    for (const auto& bb : function) {
        for (const auto& inst : *bb) {
            if (auto gep = inst->as<GEPInst>())
                geps.emplace_back(gep);
        }
    }

    if (geps.empty())
        return PreserveAll();

    // Here we don't care about constant offsets, redundant `ptrtoint`+`inttoptr`, ...
    // but let other passes to handle them.
    IRBuilder builder;
    for (const auto& gep : geps) {
        builder.setInsertPoint(gep);
        auto base = builder.makePtrToInt(gep->getPtr(), IRBTYPE::I64);
        auto indices = gep->getIdxs();
        auto curr_type = gep->getBaseType();
        auto offset = function.getZero(makeBType(IRBTYPE::I64));
        for (const auto& idx : indices) {
            Err::gassert(curr_type != nullptr, "Bad Gep");
            auto i64_idx = idx;
            if (!idx->getType()->isI64())
                i64_idx = builder.makeZext(idx, IRBTYPE::I64);
            auto i64_bytes = function.getConst(static_cast<int64_t>(curr_type->getBytes()));
            auto mul = builder.makeMul(i64_idx, i64_bytes);
            offset = builder.makeAdd(offset, mul);
            curr_type = getElm(curr_type);
        }
        auto dest = builder.makeAdd(base, offset);
        auto ptr = builder.makeIntToPtr(dest, gep->getType());
        gep->replaceSelf(ptr);
    }

    return PreserveCFGAnalyses();
}
} // namespace IR