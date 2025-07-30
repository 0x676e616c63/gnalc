// Copyright (c) 2025 0x676e616c63
// SPDX-License-Identifier: MIT

#include "ir/passes/transforms/instsimplify.hpp"
#include "ir/base.hpp"
#include "ir/block_utils.hpp"
#include "ir/instructions/compare.hpp"
#include "ir/instructions/converse.hpp"
#include "ir/irbuilder.hpp"
#include "ir/match.hpp"
#include "ir/passes/analysis/basic_alias_analysis.hpp"
#include "ir/passes/analysis/domtree_analysis.hpp"
#include "ir/passes/helpers/constant_fold.hpp"
#include "mir/tools.hpp"

#include <algorithm>
#include <memory>
#include <string>
#include <vector>

namespace IR {
PM::PreservedAnalyses InstSimplifyPass::run(Function &function, FAM &fam) {
    bool instsimplify_inst_modified = false;
    this->fam = &fam;
    this->func = &function;

    pVal x, y, z;
    int c1, c2, c3;
    float fc1, fc2, fc3;
    auto i32_zero = function.getConst(0);
    auto i32_one = function.getConst(1);
    auto f32_zero = function.getConst(0.0f);
    auto f32_one = function.getConst(1.0f);
    auto i1_true = function.getConst(true);
    auto i1_false = function.getConst(false);

#define REPLACE(pattern, replacement)                                                                                  \
    if (match(inst, (pattern))) {                                                                                      \
        Logger::logDebug("[InstSimplify]: Replaced ", GNALC_STRINGFY(pattern), " with ", GNALC_STRINGFY(replacement)); \
        inst->replaceSelf((replacement));                                                                              \
        instsimplify_inst_modified = true;                                                                             \
        continue;                                                                                                      \
    }

    // First, simplify basic instruction patterns without adding any instruction
    for (const auto &bb : function) {
        instsimplify_inst_modified |= foldPHI(bb, preserve_lcssa);
        for (const auto &inst : *bb) {
            // Fold Constant
            auto fold = foldConstant(function.getConstantPool(), inst);
            if (fold != inst) {
                inst->replaceSelf(fold);
                continue;
            }

            // x + 0 = x
            REPLACE(M::Add(M::Bind(x), M::IsIntegerVal(0)), x)

            // 0 + x -> x
            REPLACE(M::Add(M::IsIntegerVal(0), M::Bind(x)), x)

            // x - 0 = x
            REPLACE(M::Sub(M::Bind(x), M::IsIntegerVal(0)), x)

            // x / 1 = x
            REPLACE(M::Div(M::Bind(x), M::IsIntegerVal(1)), x)

            // x * 1 = x
            REPLACE(M::Mul(M::Bind(x), M::IsIntegerVal(1)), x)

            // 1 * x = x
            REPLACE(M::Mul(M::IsIntegerVal(1), M::Bind(x)), x)

            // x * 1.0f = x
            REPLACE(M::Fmul(M::Bind(x), M::Is(1.0f)), x)

            // 1.0f * x = x
            REPLACE(M::Fmul(M::Is(1.0f), M::Bind(x)), x)

            // x - x = 0
            REPLACE(M::Sub(M::Bind(x), M::Is(x)), i32_zero)

            // x - x = 0.0f
            REPLACE(M::Fsub(M::Bind(x), M::Is(x)), f32_zero)

            // x * 0 = 0
            REPLACE(M::Mul(M::Val(), M::IsIntegerVal(0)), i32_zero)

            // 0 * x = 0
            REPLACE(M::Mul(M::IsIntegerVal(0), M::Val()), i32_zero)

            // 0 / x = 0
            REPLACE(M::Div(M::IsIntegerVal(0), M::Val()), i32_zero)

            // 0 % x = 0
            REPLACE(M::Rem(M::IsIntegerVal(0), M::Val()), i32_zero)

            // x % 1 = 0
            REPLACE(M::Rem(M::Val(), M::IsIntegerVal(1)), i32_zero)

            // x / x = 1
            REPLACE(M::Div(M::Bind(x), M::Is(x)), i32_one)

            // x / x = 1.0f
            REPLACE(M::Fdiv(M::Bind(x), M::Is(x)), f32_one)

            // x + -x = 0
            REPLACE(M::Add(M::Bind(x), M::Sub(M::IsIntegerVal(0), M::Is(x))), i32_zero)

            // x + -x = 0.0f
            REPLACE(M::Fadd(M::Bind(x), M::Fneg(M::Is(x))), f32_zero)

            // x + (y - x) = y
            REPLACE(M::Add(M::Bind(x), M::Sub(M::Bind(y), M::Is(x))), y)

            // (y - x) + x = y
            REPLACE(M::Add(M::Sub(M::Bind(y), M::Bind(x)), M::Is(x)), y)

            // select x, y, y = y
            REPLACE(M::Select(M::Bind(x), M::Bind(y), M::Is(y)), y)

            // icmp x, x
            REPLACE(M::Icmp(M::Bind(x), M::Is(x)), isTrueWhenEqual(x->as<ICMPInst>()->getCond()) ? i1_true : i1_false)

            // fcmp x, x
            REPLACE(M::Fcmp(M::Bind(x), M::Is(x)), isTrueWhenEqual(x->as<FCMPInst>()->getCond()) ? i1_true : i1_false)

            // ptrtoint inttoptr x = x
            // int -> ptr -> int
            REPLACE(M::PtrToInt(M::IntToPtr(M::Bind(x))), x)
        }
    }

    // Then combine more complex instruction patterns
    std::vector<pInst> worklist;

    // Take a reverse post order traversal of the CFG to handle sub expressions first.
    auto rpodfv = function.getDFVisitor<Util::DFVOrder::ReversePostOrder>();
    for (const auto &bb : rpodfv) {
        for (const auto &inst : *bb) {
            if (inst->getVTrait() == ValueTrait::ORDINARY_VARIABLE)
                worklist.emplace_back(inst);
        }
    }

#define REWRITE_BEG(...)                                                                                               \
    if (match(inst, __VA_ARGS__)) {                                                                                    \
        Logger::logDebug("[InstSimplify]: Rewrite ", GNALC_STRINGFY((__VA_ARGS__)));

#define REWRITE_END(a)                                                                                                 \
    inst->replaceSelf(a);                                                                                              \
    instsimplify_inst_modified = true;                                                                                 \
    continue;                                                                                                          \
    }

    while (!worklist.empty()) {
        auto inst = worklist.back();
        IRBuilder builder("%isim", inst->getParent(), inst->iter());
        worklist.pop_back();

        // inttoptr ptrtoint x = x or bitcast x
        // ptr -> int -> ptr
        if (match(inst, M::IntToPtr(M::PtrToInt(M::Bind(x))))) {
            auto i2p = inst->as<INTTOPTRInst>();
            auto p2i = i2p->getOVal()->as<PTRTOINTInst>();
            if (isSameType(p2i->getOType(), i2p->getTType()))
                inst->replaceSelf(x);
            else {
                auto bc = builder.makeBitcast(x, i2p->getTType());
                inst->replaceSelf(bc);
            }
            Logger::logDebug("[InstSimplify]: Rewrite M::IntToPtr(M::PtrToInt(M::Bind(x)))) with type check.");
            instsimplify_inst_modified = true;
            continue;
        }

        // x % (2^n) == t
        if (inst->getSingleUser() && match(inst->getSingleUser(),
            M::Icmp(M::Rem(M::Bind(x), M::PowerOfTwo(M::Bind(c1))), M::Bind(c2)))) {
            auto cond = inst->getSingleUser()->as<ICMPInst>()->getCond();
            if (cond == ICMPOP::eq) {
                // x % (2^n) == 0 -> x & (2^n - 1) == 0
                if (c2 == 0) {
                    auto mask_val = static_cast<int64_t>((static_cast<uint64_t>(1) << ctz_wrapper(c1)) - 1);
                    auto mask = function.getInteger(mask_val, inst->getType());
                    auto and_inst = builder.makeAnd(x, mask);
                    inst->replaceSelf(and_inst);
                    Logger::logDebug("[InstSimplify]: Rewrite x % (2^n) to x & (2^n - 1)");
                    instsimplify_inst_modified = true;
                }
                // x % 2 == 1 -> x & min == 1
                else if (c1 == 2 && c2 == 1) {
                    auto mask_val = -((static_cast<intmax_t>(1) << (x->getType()->getBytes() * 8 - 1)) - 1);
                    auto mask = function.getInteger(mask_val, inst->getType());
                    auto and_inst = builder.makeAnd(x, mask);
                    inst->replaceSelf(and_inst);
                    Logger::logDebug("[InstSimplify]: Rewrite (x % 2) to (x & min)");
                    instsimplify_inst_modified = true;
                }
            }
        }

        // x + c1 + c2 = x + (c1 + c2)
        REWRITE_BEG(M::Add(M::Add(M::Bind(x), M::Bind(c1)), M::Bind(c2)))
        auto add = builder.makeAdd(x, function.getInteger(c1 + c2, x->getType()));
        REWRITE_END(add)

        // gep (gep x, c1), c2 = gep x, (c1 + c2)
        REWRITE_BEG(M::Gep(M::Gep(M::Bind(x), M::Bind(c1)), M::Bind(c2)))
        auto gep = builder.makeGep(x, function.getConst(c1 + c2));
        REWRITE_END(gep)

        // select i1 x, i32 1, i32 0 = zext x
        REWRITE_BEG(M::Select(M::Bind(x), M::Is(1), M::Is(0)))
        auto zext = builder.makeZext(x, IRBTYPE::I32);
        REWRITE_END(zext)

        // select i1 x, i64 1, i64 0 = zext x
        REWRITE_BEG(M::Select(M::Bind(x), M::Is(static_cast<int64_t>(1)), M::Is(static_cast<int64_t>(0))))
        auto zext = builder.makeZext(x, IRBTYPE::I64);
        REWRITE_END(zext)

        // select x, y, false = x & y
        REWRITE_BEG(M::Select(M::Bind(x), M::Bind(y), M::Is(false)))
        auto andi = builder.makeAnd(x, y);
        REWRITE_END(andi)

        // select x, y, true = !x | y
        REWRITE_BEG(M::Select(M::Bind(x), M::Bind(y), M::Is(true)))
        auto xori = builder.makeXor(function.getConst(true), x);
        auto ori = builder.makeOr(xori, y);
        REWRITE_END(ori)

        // select x, false, y = !x & y
        REWRITE_BEG(M::Select(M::Bind(x), M::Is(false), M::Bind(y)))
        auto xori = builder.makeXor(function.getConst(false), x);
        auto andi = builder.makeAnd(xori, y);
        REWRITE_END(andi)

        // select x, true, y = x | y
        REWRITE_BEG(M::Select(M::Bind(x), M::Is(true), M::Bind(y)))
        auto ori = builder.makeOr(x, y);
        REWRITE_END(ori)

        // x - -y -> x + y
        REWRITE_BEG(M::Sub(M::Bind(x), M::Sub(M::IsIntegerVal(0), M::Bind(y))))
        auto add = builder.makeAdd(x, y);
        REWRITE_END(add)

        // x * y - x * z -> x * (y - z)
        REWRITE_BEG(M::Sub(M::Mul(M::Bind(x), M::Bind(y)), M::Mul(M::Is(x), M::Bind(z))))
        auto sub = builder.makeSub(y, z);
        auto mul = builder.makeMul(x, sub);
        REWRITE_END(mul)

        // (x * x) - (y * y) -> (x + y) * (x - y)
        REWRITE_BEG(M::Sub(M::Mul(M::Bind(x), M::Is(x)), M::Mul(M::Bind(y), M::Is(y))))
        auto add = builder.makeAdd(x, y);
        auto sub = builder.makeSub(x, y);
        auto mul = builder.makeMul(add, sub);
        REWRITE_END(mul)

        // float: -x + y -> y - x
        REWRITE_BEG(M::Fadd(M::Fneg(M::Bind(x)), M::Bind(y)))
        auto fsub = builder.makeFSub(y, x);
        REWRITE_END(fsub)

        // float: (-x * y) + z -> z - (x * y)
        REWRITE_BEG(M::Fadd(M::Fmul(M::Fneg(M::Bind(x)), M::Bind(y)), M::Bind(z)))
        auto fmul = builder.makeFMul(x, y);
        auto fsub = builder.makeFSub(z, fmul);
        REWRITE_END(fsub)

        // float: (-x / y) + z or (x / -y) + z -> z - (x / y)
        REWRITE_BEG(M::Fadd(M::Fdiv(M::Fneg(M::Bind(x)), M::Bind(y)), M::Bind(z)),
                    M::Fadd(M::Fdiv(M::Bind(x), M::Fneg(M::Bind(y))), M::Bind(z)))
        auto fdiv = builder.makeFDiv(x, y);
        auto fsub = builder.makeFSub(z, fdiv);
        REWRITE_END(fsub)

        // float: (sitofp x) + (sitofp y) -> sitofp(x + y)
        REWRITE_BEG(M::Fadd(M::Sitofp(M::Bind(x)), M::Sitofp(M::Bind(y))))
        auto fadd = builder.makeFAdd(x, y);
        auto sitofp = builder.makeSitofp(fadd);
        REWRITE_END(sitofp)

        // float: -(x * c) -> x * -c
        REWRITE_BEG(M::Fneg(M::OneUse(M::Fmul(M::Bind(x), M::Bind(fc1)))))
        auto fmul = builder.makeFMul(x, function.getConst(-fc1));
        REWRITE_END(fmul)

        // float: -(x / c) -> x / -c
        REWRITE_BEG(M::Fneg(M::OneUse(M::Fdiv(M::Bind(x), M::Bind(fc1)))))
        auto fdiv = builder.makeFDiv(x, function.getConst(-fc1));
        REWRITE_END(fdiv)

        // float: -(c / x) -> -c / x
        REWRITE_BEG(M::Fneg(M::OneUse(M::Fdiv(M::Bind(fc1), M::Bind(x)))))
        auto fdiv = builder.makeFDiv(function.getConst(-fc1), x);
        REWRITE_END(fdiv)

        // float: -(x * y) -> (-x * y)
        REWRITE_BEG(M::Fneg(M::Fmul(M::Bind(x), M::Bind(y))))
        auto fneg = std::make_shared<FNEGInst>(getTmpName(), x);
        auto fmul = std::make_shared<BinaryInst>(getTmpName(), OP::FMUL, fneg, y);
        REWRITE_END(fmul)

        // float: -(x / y)  -> (-x / y)
        REWRITE_BEG(M::Fneg(M::Fdiv(M::Bind(x), M::Bind(y))))
        auto fneg = builder.makeFNeg(x);
        auto fdiv = builder.makeFDiv(fneg, y);
        REWRITE_END(fdiv)

        // float: fsub -0.0, x -> fneg x
        REWRITE_BEG(M::Fsub(M::Is(-0.0f), M::Bind(x)))
        auto fneg = builder.makeFNeg(x);
        REWRITE_END(fneg)

        // float: x - (-y) -> x + y
        REWRITE_BEG(M::Fsub(M::Bind(x), M::Fneg(M::Bind(y))))
        auto fadd = builder.makeFAdd(x, y);
        REWRITE_END(fadd)

        // float: x - (-y * z) -> x + (y * z)
        REWRITE_BEG(M::Fsub(M::Bind(x), M::Fmul(M::Fneg(M::Bind(y)), M::Bind(z))))
        auto fmul = builder.makeFMul(y, z);
        auto fadd = builder.makeFAdd(x, fmul);
        REWRITE_END(fadd)

        // float: x - (-y / z) -> x + (y / z)
        REWRITE_BEG(M::Fsub(M::Bind(x), M::Fdiv(M::Fneg(M::Bind(y)), M::Bind(z))))
        auto fdiv = builder.makeFDiv(y, z);
        auto fadd = builder.makeFAdd(x, fdiv);
        REWRITE_END(fadd)

        // x * -1 -> sub 0 x
        REWRITE_BEG(M::Mul(M::Bind(x), M::IsIntegerVal(-1)), M::Mul(M::IsIntegerVal(-1), M::Bind(x)))
        auto sub = builder.makeSub(function.getConst(0), x);
        REWRITE_END(sub)

        // float: x * -1.0f or -1.0f * x -> fneg x
        REWRITE_BEG(M::Fmul(M::Bind(x), M::Is(-1.0f)), M::Fmul(M::Is(-1.0f), M::Bind(x)))
        auto fneg = builder.makeFNeg(x);
        REWRITE_END(fneg)

        // -x * -y -> x * y
        // -x / -y -> x / y
        // float: -x * -y -> x * y
        //        -x / -y -> x / y
        REWRITE_BEG(M::Mul(M::Sub(M::IsIntegerVal(0), M::Bind(x)), M::Sub(M::IsIntegerVal(0), M::Bind(y))),
                    M::Div(M::Sub(M::IsIntegerVal(0), M::Bind(x)), M::Sub(M::IsIntegerVal(0), M::Bind(y))),
                    M::Fmul(M::Fneg(M::Bind(x)), M::Fneg(M::Bind(y))),
                    M::Fdiv(M::Fneg(M::Bind(x)), M::Fneg(M::Bind(y))))
        auto binary = builder.makeBinary(inst->getOpcode(), x, y);
        REWRITE_END(binary)

        // x / (x * y) -> 1 / y
        REWRITE_BEG(M::Div(M::Bind(x), M::Mul(M::Is(x), M::Bind(y))))
        auto div = builder.makeDiv(i32_one, y);
        REWRITE_END(div)

        // ((x * c2) + c1) / c2 -> x + c1 / c2
        REWRITE_BEG(M::Div(M::Add(M::Mul(M::Bind(x), M::Bind(c2)), M::Bind(c1)), M::Is(c2)))
        auto add = builder.makeAdd(x, function.getConst(c1 / c2));
        REWRITE_END(add)

        if (inst->getOpcode() == OP::PHI) {
            auto phi = inst->as<PHIInst>();
            instsimplify_inst_modified |= foldBinary(phi);
            instsimplify_inst_modified |= foldGEP(phi);
            instsimplify_inst_modified |= foldLoad(phi);
        }
    }

    name_cnt = 0;

    return instsimplify_inst_modified ? PreserveCFGAnalyses() : PreserveAll();
}

// TODO: more meaningful names
std::string InstSimplifyPass::getTmpName() { return "%instsim" + std::to_string(name_cnt++); }

// fold PHI of BinaryInst
// Before:
//   %phi = phi [add(%a, %b), %bb1], [add(%a, %c), %bb2]
// After:
//   %phi1 = phi [%b, %bb1], [%c, %bb2]
//   %new_add = add %a, %phi1
bool InstSimplifyPass::foldBinary(const pPhi &phi) {
    auto phi_opers = phi->getPhiOpers();

    auto temp = phi_opers[0].value->as<BinaryInst>();
    if (!temp)
        return false;
    OP common_op = temp->getOpcode();
    auto common_lhs = temp->getLHS();
    auto common_rhs = temp->getRHS();

    for (const auto &[val, bb] : phi_opers) {
        auto bin = val->as<BinaryInst>();
        if (!bin || common_op != bin->getOpcode())
            return false;

        common_lhs = (common_lhs == bin->getLHS()) ? bin->getLHS() : nullptr;
        common_rhs = (common_rhs == bin->getRHS()) ? bin->getRHS() : nullptr;

        if (!common_lhs && !common_rhs)
            return false;
    }

    // Don't bother with identical instructions, they'll be hoisted by GVN-PRE.
    if (common_lhs && common_rhs)
        return false;

    // Create a phi to merge the uncommon operands
    auto uncommon_phi = std::make_shared<PHIInst>(getTmpName(), phi->getType());
    if (common_lhs) {
        for (const auto &[val, bb] : phi_opers)
            uncommon_phi->addPhiOper(val->as<BinaryInst>()->getRHS(), bb);
        auto new_bin = std::make_shared<BinaryInst>(getTmpName(), common_op, common_lhs, uncommon_phi);
        phi->getParent()->addInstAfterPhi(new_bin);
        phi->replaceSelf(new_bin);
    } else if (common_rhs) {
        for (const auto &[val, bb] : phi_opers)
            uncommon_phi->addPhiOper(val->as<BinaryInst>()->getLHS(), bb);
        auto new_bin = std::make_shared<BinaryInst>(getTmpName(), common_op, uncommon_phi, common_rhs);
        phi->getParent()->addInstAfterPhi(new_bin);
        phi->replaceSelf(new_bin);
    } else
        Err::unreachable();
    phi->getParent()->addPhiInst(uncommon_phi);
    Logger::logDebug("[InstSimplify]: folded phi of binary '", phi->getName(), "'.");
    return true;
}

// fold PHI of Getelementptr
// Before:
//   %phi = phi [gep(%a, %b, ...), %bb1], [gep(%a, %c, ...), %bb2]
// After:
//   %phi1 = phi [%b, %bb1], [%c, %bb2]
//   %new_add = gep %a, %phi1, ...
// Note that we don't fold it if there is any alloca or different constant index.
bool InstSimplifyPass::foldGEP(const pPhi &phi) {
    auto phi_opers = phi->getPhiOpers();

    auto temp = phi_opers[0].value->as<GEPInst>();
    if (!temp)
        return false;

    // Note that the back is the PTR
    auto commons = temp->getIdxs();
    commons.emplace_back(temp->getPtr());

    size_t uncommon_cnt = 0;
    for (const auto &[val, bb] : phi_opers) {
        auto gep = val->as<GEPInst>();
        if (!gep || gep->isConstantOffset())
            return false;

        // Different number of operands
        auto indices = gep->getIdxs();
        if (indices.size() != commons.size() - 1)
            return false;

        // Don't merge with ALLOCAInsts, load from them sometimes can be eliminated.
        if (gep->getPtr()->is<ALLOCAInst>())
            return false;

        if (commons.back() != nullptr && commons.back() != gep->getPtr()) {
            commons.back() = nullptr;
            ++uncommon_cnt;
        }

        for (size_t i = 0; i < commons.size() - 1; ++i) {
            if (commons[i] == nullptr || commons[i] == indices[i])
                continue;

            // Don't merge with constant.
            // In general, they are cheaper to compute.
            if (indices[i]->getVTrait() == ValueTrait::CONSTANT_LITERAL ||
                commons[i]->getVTrait() == ValueTrait::CONSTANT_LITERAL)
                return false;

            commons[i] = nullptr;
            ++uncommon_cnt;
        }

        // We only insert one phi. So if there is another uncommon operand, give up.
        if (uncommon_cnt > 1)
            return false;
    }

    // Don't bother with identical instructions, they'll be hoisted by GVN-PRE.
    if (uncommon_cnt == 0)
        return false;

    auto uncommon_it = std::find(commons.begin(), commons.end(), nullptr);
    size_t uncommon_index = uncommon_it - commons.begin();
    Err::gassert(uncommon_it != commons.end());

    auto uncommon_phi = std::make_shared<PHIInst>(getTmpName(), phi->getType());

    // Handle ptrs
    if (uncommon_index == commons.size() - 1) {
        for (const auto &[val, bb] : phi_opers) {
            auto gep = val->as<GEPInst>();
            uncommon_phi->addPhiOper(gep->getPtr(), bb);
        }
        commons.pop_back();
        auto new_gep = std::make_shared<GEPInst>(getTmpName(), uncommon_phi, commons);
        phi->replaceSelf(new_gep);
    } else {
        for (const auto &[val, bb] : phi_opers) {
            auto gep = val->as<GEPInst>();
            uncommon_phi->addPhiOper(gep->getIdxs()[uncommon_index], bb);
        }
        auto ptr = commons.back();
        commons.pop_back();
        commons[uncommon_index] = uncommon_phi;
        auto new_gep = std::make_shared<GEPInst>(getTmpName(), ptr, commons);
        phi->replaceSelf(new_gep);
    }
    phi->getParent()->addPhiInst(uncommon_phi);
    Logger::logDebug("[InstSimplify]: folded phi of gep '", phi->getName(), "'.");
    return true;
}

bool InstSimplifyPass::isLoadSuitableForSinking(const pLoad &load) const {
    auto &aa_res = fam->getResult<BasicAliasAnalysis>(*func);

    // If there is some modifying after the load in the block, we cannot sink it.
    for (auto it = load->iter(); it != load->getParent()->end(); ++it) {
        auto modref = aa_res.getInstModRefInfo(*it, load->getPtr(), *fam);
        if (modref == ModRefInfo::Mod || modref == ModRefInfo::ModRef)
            return false;
    }

    // If the load has its address taken, (which means the user of that memory is all store/loads )
    // it's not profitable to sink it. Because we may promote it to register later.
    if (auto alloc = load->getPtr()->as<ALLOCAInst>()) {
        bool isAddressTaken = false;
        for (const auto &user : alloc->users()) {
            if (auto load2 = user->as<LOADInst>())
                continue;
            if (auto storeInst = user->as<STOREInst>()) {
                if (storeInst->getPtr() == alloc)
                    continue;
            }
            isAddressTaken = true;
            break;
        }
        if (!isAddressTaken)
            return false;
    }

    // If it's a load from a constant GEP, don't sink for better codegen.
    if (auto gep = load->getPtr()->as<GEPInst>()) {
        if (gep->isConstantOffset())
            return false;
    }
    return true;
}

// fold PHI of Load
// Before:
//   %phi = phi [load(%a), %bb1], [load(%b), %bb2]
// After:
//   %phi1 = phi [%a, %bb1], [%b, %bb2]
//   %new_add = load %phi1
bool InstSimplifyPass::foldLoad(const pPhi &phi) {
    auto phi_opers = phi->getPhiOpers();
    auto temp = phi_opers[0].value->as<LOADInst>();
    if (!temp)
        return false;

    auto min_align = temp->getAlign();

    for (const auto &[val, bb] : phi_opers) {
        auto load = val->as<LOADInst>();
        if (!load || load->getUseCount() != 1)
            return false;
        // We cannot sink if the loaded value could be modified between load and phi
        if (load->getParent() != bb || !isLoadSuitableForSinking(load))
            return false;
        min_align = std::min(min_align, load->getAlign());
    }

    auto merged_ptr = std::make_shared<PHIInst>(getTmpName(), temp->getPtr()->getType());

    for (const auto &[val, bb] : phi_opers) {
        auto load = val->as<LOADInst>();
        merged_ptr->addPhiOper(load->getPtr(), bb);
    }

    auto merged_load = std::make_shared<LOADInst>(getTmpName(), merged_ptr, min_align);

    phi->replaceSelf(merged_load);
    phi->getParent()->addPhiInst(merged_ptr);
    phi->getParent()->addInstAfterPhi(merged_load);
    Logger::logDebug("[InstSimplify]: folded phi of load '", phi->getName(), "'.");
    return true;
}
} // namespace IR
#undef REPLACE
#undef REWRITE_BEG
#undef REWRITE_END
