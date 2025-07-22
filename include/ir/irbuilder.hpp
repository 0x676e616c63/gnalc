// Copyright (c) 2025 0x676e616c63
// SPDX-License-Identifier: MIT

#pragma once
#ifndef GNALC_IR_BUILDER_HPP
#define GNALC_IR_BUILDER_HPP

#include "basic_block.hpp"
#include "constant.hpp"
#include "instruction.hpp"
#include "ir/instructions/binary.hpp"
#include "ir/instructions/compare.hpp"
#include "ir/instructions/control.hpp"
#include "ir/instructions/converse.hpp"
#include "ir/instructions/memory.hpp"
#include "ir/instructions/phi.hpp"
#include "ir/instructions/vector.hpp"
#include "type_alias.hpp"

#include <memory>
#include <string>
#include <utility>
#include <vector>

namespace IR {
class IRBuilder {
    friend class InsertPointGuard;
private:
    BBInstIter insert_point;
    pBlock block;
    std::string name_prefix;

public:
    IRBuilder() = default;
    explicit IRBuilder(std::string name_prefix_, const pBlock &bb)
        : block(bb), insert_point(bb->end()), name_prefix(std::move(name_prefix_)) {}
    IRBuilder(std::string name_prefix_, pBlock bb, BBInstIter insert_point_)
        : insert_point(insert_point_), block(std::move(bb)), name_prefix(std::move(name_prefix_)) {}

    explicit IRBuilder(const pBlock &bb) : block(bb), insert_point(bb->end()) {}
    IRBuilder(pBlock bb, BBInstIter insert_point_) : insert_point(insert_point_), block(std::move(bb)) {}

    void setNamePrefix(const std::string &name_prefix_);
    void setInsertPoint(const pBlock &bb, BBInstIter insert_point_);
    void setInsertPoint(const pInst &inst);

    pBinary makeBinary(OP op, const pVal &lhs, const pVal &rhs, const std::string &name = "") const;
    pBinary makeAdd(const pVal &lhs, const pVal &rhs, const std::string &name = "") const;
    pBinary makeSub(const pVal &lhs, const pVal &rhs, const std::string &name = "") const;
    pBinary makeMul(const pVal &lhs, const pVal &rhs, const std::string &name = "") const;
    pBinary makeDiv(const pVal &lhs, const pVal &rhs, const std::string &name = "") const;
    pBinary makeURem(const pVal &lhs, const pVal &rhs, const std::string &name = "") const;
    pBinary makeSRem(const pVal &lhs, const pVal &rhs, const std::string &name = "") const;
    pBinary makeAnd(const pVal &lhs, const pVal &rhs, const std::string &name = "") const;
    pBinary makeOr(const pVal &lhs, const pVal &rhs, const std::string &name = "") const;
    pBinary makeXor(const pVal &lhs, const pVal &rhs, const std::string &name = "") const;
    pBinary makeShl(const pVal &lhs, const pVal &rhs, const std::string &name = "") const;
    pBinary makeLShr(const pVal &lhs, const pVal &rhs, const std::string &name = "") const;
    pBinary makeAShr(const pVal &lhs, const pVal &rhs, const std::string &name = "") const;
    pBinary makeFAdd(const pVal &lhs, const pVal &rhs, const std::string &name = "") const;
    pBinary makeFSub(const pVal &lhs, const pVal &rhs, const std::string &name = "") const;
    pBinary makeFMul(const pVal &lhs, const pVal &rhs, const std::string &name = "") const;
    pBinary makeFDiv(const pVal &lhs, const pVal &rhs, const std::string &name = "") const;
    pBinary makeFRem(const pVal &lhs, const pVal &rhs, const std::string &name = "") const;

    pCast makeCast(OP op, const pVal &val, const pType &type, const std::string &name = "") const;
    pZext makeZext(const pVal &val, IRBTYPE type, const std::string &name = "") const;
    pSext makeSext(const pVal &val, IRBTYPE type, const std::string &name = "") const;
    pBitcast makeBitcast(const pVal &val, const pType &type, const std::string &name = "") const;
    pPtrToInt makePtrToInt(const pVal &val, IRBTYPE type, const std::string &name = "") const;
    pIntToPtr makeIntToPtr(const pVal &val, const pType &type, const std::string &name = "") const;
    pFptosi makeFptosi(const pVal &val, const std::string &name = "") const;
    pSitofp makeSitofp(const pVal &val, const std::string &name = "") const;

    pGep makeGep(const pVal &ptr, const pVal &idx, const std::string &name = "") const;
    pGep makeGep(const pVal &ptr, const pVal &idx1, const pVal &idx2, const std::string &name = "") const;
    pGep makeGep(const pVal &ptr, const std::vector<pVal> &indices, const std::string &name = "") const;

    pAlloca makeAlloca(const pType &type, int align = 4, const std::string &name = "") const;
    pLoad makeLoad(const pVal &ptr, int align = 4, const std::string &name = "") const;
    pStore makeStore(const pVal &val, const pVal &ptr, int align = 4) const;

    pIcmp makeIcmp(ICMPOP op, const pVal &lhs, const pVal &rhs, const std::string &name = "");
    pFcmp makeFcmp(FCMPOP op, const pVal &lhs, const pVal &rhs, const std::string &name = "");

    pBr makeBr(const pBlock &dest);
    pBr makeBr(const pVal &cond, const pBlock &true_dest, const pBlock &false_dest);
    pRet makeRet();
    pRet makeRet(const pVal &val);

    pSelect makeSelect(const pVal &cond, const pVal &true_val, const pVal &false_val, const std::string &name = "");
    pPhi makePhi(const pType &type, const std::string &name = "");
    pCall makeCall(const pFuncDecl &func, const std::vector<pVal> &args, const std::string &name = "");

    pExtract makeExtract(const pVal &vector, const pVal &idx, const std::string &name = "");
    pInsert makeInsert(const pVal &vector, const pVal &element, const pVal &idx, const std::string &name = "");
    pShuffle makeShuffle(const pVal &v1, const pVal &v2, const pConstI32Vec &mask, const std::string &name = "") const;

    pFneg makeFNeg(const pVal &val, const std::string &name = "") const;

private:
    template <typename Type, typename... Args>
    std::shared_ptr<Type> makeInst(const std::string &name, const std::string &default_prefix, Args &&...args) const {
        static size_t name_cnt = 0;
        std::string real_name;

        if (!name_prefix.empty())
            real_name += name_prefix + ".";

        if (name.empty())
            real_name += (real_name.empty() ? "%" : "") + default_prefix + "." + std::to_string(name_cnt++);
        else
            real_name += name;

        auto inst = std::make_shared<Type>(real_name, std::forward<Args>(args)...);
        if constexpr (std::is_same_v<Type, PHIInst>) {
            block->addPhiInst(std::dynamic_pointer_cast<PHIInst>(inst));
        }
        else {
            block->addInst(insert_point, std::dynamic_pointer_cast<Instruction>(inst));
        }
        return inst;
    }
    template <typename Type, typename... Args> std::shared_ptr<Type> makeNamelessInst(Args &&...args) const {
        auto inst = std::make_shared<Type>(std::forward<Args>(args)...);
        block->addInst(insert_point, std::dynamic_pointer_cast<Instruction>(inst));
        return inst;
    }
};

// RAII Object to restore insert point when it is destroyed
class InsertPointGuard {
private:
    IRBuilder* builder;
    BBInstIter insert_point;
    pBlock block;
public:
    InsertPointGuard(IRBuilder& builder_)
        : builder(&builder_), insert_point(builder_.insert_point), block(builder_.block) {}

    ~InsertPointGuard() {
        builder->setInsertPoint(block, insert_point);
    }
};
} // namespace IR

#endif
