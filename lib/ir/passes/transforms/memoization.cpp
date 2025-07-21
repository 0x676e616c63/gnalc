// Copyright (c) 2025 0x676e616c63
// SPDX-License-Identifier: MIT

#include "ir/passes/transforms/memoization.hpp"

#include "config/config.hpp"
#include "ir/block_utils.hpp"
#include "ir/instructions/binary.hpp"
#include "ir/instructions/compare.hpp"
#include "ir/instructions/control.hpp"
#include "ir/instructions/converse.hpp"
#include "ir/instructions/memory.hpp"
#include "ir/irbuilder.hpp"
#include "ir/passes/analysis/alias_analysis.hpp"
#include "ir/passes/analysis/basic_alias_analysis.hpp"
#include "ir/passes/analysis/domtree_analysis.hpp"
#include "ir/passes/analysis/target_analysis.hpp"
#include "utils/logger.hpp"

#include <algorithm>
#include <string>
#include <vector>

namespace IR {
// Memoization Plan
// For function with small arguments, we usually have a more optimized way to
// compute the LUT key. (`SmallIntsFloatsMemo`, ...)
// However, For large arguments, we still have a fallback way to compute the LUT key. (See `ArbitraryMemo`)
//
// For example:
// For func(i32) or func(i32, i32), we can use a bijective hash function to make an i64 hash key.
// This avoids storing arguments to LUT, since identical key guarantees identical arguments.
// But for func(i32, i32, i32, i32, i32), only `ArbitraryMemo` is suitable.
//
// The key difference is how they build the `key`.
class MemoPlan {
public:
    virtual ~MemoPlan() = default;
    virtual pVal buildKey(const pBlock &bb, const std::vector<pFormalParam> &args) = 0;
    virtual bool isBijection() const = 0;
    virtual size_t getKeyBytes(const std::vector<pFormalParam> &args) const = 0;
};

pVal cast_if_float(const pBlock &bb, BBInstIter insert_point, const pVal &source) {
    static size_t name_cnt = 0;

    if (source->getType()->isF32()) {
        auto f2ibc =
            std::make_shared<BITCASTInst>("%memo.f2ibc." + std::to_string(name_cnt++), source, makeBType(IRBTYPE::I32));
        bb->addInst(insert_point, f2ibc);
        return f2ibc;
    }
    return source;
}

// Not bijective
// func(int, int, int ...) -> i64 hash
// The hash function comes from:
// https://stackoverflow.com/questions/20511347/a-good-hash-function-for-a-vector
class ArbitraryIntsFloatsMemo : public MemoPlan {
public:
    pVal buildKey(const pBlock &bb, const std::vector<pFormalParam> &args) final {
        auto insert_point = bb->begin();
        while (insert_point != bb->end() && (*insert_point)->getOpcode() == OP::ALLOCA)
            ++insert_point;

        IRBuilder builder(bb, insert_point);

        std::vector<pInst> zexts;
        zexts.reserve(args.size());
        for (const auto &arg : args) {
            auto i32_arg = cast_if_float(bb, insert_point, arg);
            auto zext = builder.makeZext(i32_arg, IRBTYPE::I64);
            zexts.emplace_back(zext);
        }

        // size_t seed = vec.size();
        // for(auto& i : vec)
        //     seed ^= i + 0x9e3779b9 + (seed << 6) + (seed >> 2);
        auto &cpool = bb->getParent()->getConstantPool();
        pVal hash_val = cpool.getConst(static_cast<int64_t>(args.size()));
        auto x9e3779b9 = cpool.getConst(static_cast<int64_t>(0x9e3779b9));
        auto x6 = cpool.getConst(static_cast<int64_t>(6));
        auto x2 = cpool.getConst(static_cast<int64_t>(2));
        for (const auto &zext : zexts) {
            auto shl = builder.makeShl(hash_val, x6);
            auto lshr = builder.makeLShr(hash_val, x2);
            auto add0 = builder.makeAdd(shl, lshr);
            auto add1 = builder.makeAdd(add0, x9e3779b9);
            auto add2 = builder.makeAdd(add1, zext);
            hash_val = builder.makeXor(hash_val, add2);
        }

        hash_val->setName("%memo.curr_key");
        return hash_val;
    }
    bool isBijection() const final { return false; }
    size_t getKeyBytes(const std::vector<pFormalParam> &) const final { return 8; }
};

// Bijective
// func(int) -> i32
// func(int, int) -> i64 hash
// The hash function comes from:
// https://stackoverflow.com/questions/664014/what-integer-hash-function-are-good-that-accepts-an-integer-hash-key/12996028#12996028
class SmallIntsFloatsMemo : public MemoPlan {
public:
    pVal buildKey(const pBlock &bb, const std::vector<pFormalParam> &args) final {
        Err::gassert(args.size() < 3);

        auto insert_point = bb->begin();
        while (insert_point != bb->end() && (*insert_point)->getOpcode() == OP::ALLOCA)
            ++insert_point;

        IRBuilder builder(bb, insert_point);

        std::vector<pVal> i32_args;
        std::transform(args.begin(), args.end(), std::back_inserter(i32_args),
                       [&](const pVal &arg) { return cast_if_float(bb, insert_point, arg); });

        auto &cpool = bb->getParent()->getConstantPool();

        if (i32_args.size() == 1) {
            auto x16 = cpool.getConst(static_cast<int64_t>(16));
            auto x45d9f3bu = cpool.getConst(static_cast<int64_t>(0x45d9f3bu));
            // uint32_t hash(uint32_t x) {
            //     x = ((x >> 16) ^ x) * 0x45d9f3bu;
            //     x = ((x >> 16) ^ x) * 0x45d9f3bu;
            //     x = (x >> 16) ^ x;
            //     return x;
            // }

            auto lshr16 = builder.makeLShr(i32_args[0], x16);
            auto xor0 = builder.makeXor(i32_args[0], lshr16);
            auto mul0 = builder.makeMul(xor0, x45d9f3bu);
            auto lshr16_1 = builder.makeLShr(mul0, x16);
            auto xor1 = builder.makeXor(mul0, lshr16_1);
            auto mul1 = builder.makeMul(xor1, x45d9f3bu);
            auto lshr16_2 = builder.makeLShr(mul1, x16);
            auto hash_val = builder.makeXor(mul1, lshr16_2);
            hash_val->setName("%memo.curr_key");
            return hash_val;
        }

        Err::gassert(i32_args.size() == 2);
        auto x27 = cpool.getConst(static_cast<int64_t>(27));
        auto x30 = cpool.getConst(static_cast<int64_t>(30));
        auto x31 = cpool.getConst(static_cast<int64_t>(31));
        auto x32 = cpool.getConst(static_cast<int64_t>(32));
        auto xbf58476d1ce4e5b9 = cpool.getConst(static_cast<int64_t>(0xbf58476d1ce4e5b9));
        auto x94d049bb133111eb = cpool.getConst(static_cast<int64_t>(0x94d049bb133111eb));

        auto zext0 = builder.makeZext(i32_args[0], IRBTYPE::I64);
        auto zext1 = builder.makeZext(i32_args[1], IRBTYPE::I64);
        auto shl = builder.makeShl(zext0, x32);
        auto i64 = builder.makeOr(shl, zext1);

        // uint64_t hash(uint64_t x) {
        //     x = (x ^ (x >> 30)) * UINT64_C(0xbf58476d1ce4e5b9);
        //     x = (x ^ (x >> 27)) * UINT64_C(0x94d049bb133111eb);
        //     x = x ^ (x >> 31);
        //     return x;
        // }

        auto lshr30 = builder.makeLShr(i64, x30);
        auto xor0 = builder.makeXor(i64, lshr30);
        auto mul0 = builder.makeMul(xor0, xbf58476d1ce4e5b9);
        auto lshr27 = builder.makeLShr(mul0, x27);
        auto xor1 = builder.makeXor(mul0, lshr27);
        auto mul1 = builder.makeMul(xor1, x94d049bb133111eb);
        auto lshr31 = builder.makeLShr(mul1, x31);
        auto hash_val = builder.makeXor(mul1, lshr31);
        hash_val->setName("%memo.curr_key");
        return hash_val;
    }
    bool isBijection() const final { return true; }
    size_t getKeyBytes(const std::vector<pFormalParam> &args) const final { return args.size() * 4; }
};

// Memoization can be an optimization if a pure function is called with identical arguments
// many times. Determine a function's execution frequency is already too hard, if not impossible,
// for us, not to mention questioning its arguments. Therefore, we only memoize functions
// that are most possible to fit into such cases.
// A function worth memoization usually have overlapping subproblems. In other words,
// different paths depend on the solution to the same subproblem.
// Here we try to figure out if a function has overlapping subproblems.
// FIXME: More precise cost model
bool isProfitableToMemoize(const Function &func) {
    // First find all recursive calls
    std::vector<pCall> self_calls;
    for (const auto &bb : func) {
        for (const auto &inst : *bb) {
            if (auto call = inst->as<CALLInst>()) {
                if (call->getFunc().get() == &func)
                    self_calls.emplace_back(call);
            }
        }
    }

    // Overlapping subproblems at least have two paths
    if (self_calls.size() < 2)
        return false;

    // See if there are shared arguments
    // Independent calls cannot have overlapping subproblems
    const auto &params = func.getParams();
    size_t num_shared_calls = self_calls.size();
    for (const auto &call : self_calls) {
        auto call_args = call->getArgs();
        auto has_use = [&]() -> bool {
            for (const auto &arg : call_args) {
                if (auto arg_inst = arg->as<Instruction>()) {
                    for (const auto &fp : params) {
                        if (AhasUseToB(arg_inst, fp))
                            return true;
                    }
                }
            }
            return false;
        }();

        if (!has_use)
            --num_shared_calls;
    }

    if (num_shared_calls < 2)
        return false;

    return true;
}

std::shared_ptr<MemoPlan> selectMemoPlan(Function &func) {
    const auto &params = func.getParams();

    for (const auto &fp : params) {
        if (!fp->getType()->isI32() && !fp->getType()->isF32()) {
            Logger::logDebug("[Memo]: Skip recursive function with unsupported args '", func.getName(), "'.");
            return nullptr;
        }
    }

    if (params.size() < 3)
        return std::make_shared<SmallIntsFloatsMemo>();

    return std::make_shared<ArbitraryIntsFloatsMemo>();
}

PM::PreservedAnalyses MemoizePass::run(Function &function, FAM &fam) {
    auto& target = fam.getResult<TargetAnalysis>(function);
    if (!target->isBitwiseOpSupported() || !target->isTypeSupported(IRBTYPE::I64))
        return PreserveAll();

    // Memoize pure recursive functions
    if (!function.isRecursive() || !isPure(fam, &function))
        return PreserveAll();

    if (!isProfitableToMemoize(function))
        return PreserveAll();

    // Skip functions with pointer arguments
    auto params = function.getParams();
    for (const auto &fp : params) {
        if (!fp->getType()->is<BType>()) {
            Logger::logDebug("[Memo]: Skip non-BType arguments function '", function.getName(), "'.");
            return PreserveAll();
        }
    }

    auto ret_type = function.getType()->as<FunctionType>()->getRet();
    Err::gassert(ret_type->is<BType>(), "Expected BType in Ret.");
    // Skip void function
    if (ret_type->isVoid()) {
        Logger::logDebug("[Memo]: Skip void function '", function.getName(), "'.");
        return PreserveAll();
    }

    // Select the best plan
    auto plan = selectMemoPlan(function);
    if (!plan)
        return PreserveAll();

    // Bijection MemoLUT Entry                   |      Non-Bijection MemoLUT Entry
    // struct MemoLUTEntry {                     |      struct MemoLUTEntry {
    //     int32_t has_val;                      |          int32_t has_val;
    //     RetT ret;                             |          RetT ret;
    //     KeyT keyT;                            |          ... Args ...
    // }                                         |      }
    // Size: 4 + sizeof(RetT) + sizeof(KeyT)     |      Size: 4 + sizeof(RetT) + sizeof...(Args)
    auto is_bijection = plan->isBijection();
    size_t lut_entry_size = 4 + ret_type->getBytes();
    if (!is_bijection) {
        for (const auto &fp : params)
            lut_entry_size += fp->getType()->getBytes();
    }
    auto lut_type = makeArrayType(makeBType(IRBTYPE::I8), lut_entry_size * Config::IR::MEMOIZATION_LUT_SIZE);
    auto lut = std::make_shared<GlobalVariable>(
        STOCLASS::GLOBAL, lut_type,
        std::string{Config::IR::MEMOIZATION_LUT_NAME_PREFIX} + "." + function.getName().substr(1), GVIniter(lut_type));
    auto module = function.getParent();
    module->addGlobalVar(lut);

    // FIXME: Find the best position to start memo.
    //        currently we always split the entry block.

    // Split entry block to entry_front and entry_behind:
    auto entry_behind = *function.begin();
    entry_behind->setName("%memo.entry_behind");
    std::vector<pAlloca> allocas;
    for (const auto &inst : *entry_behind) {
        if (auto alloc = inst->as<ALLOCAInst>())
            allocas.emplace_back(alloc);
        else
            break;
    }
    auto entry_front = std::make_shared<BasicBlock>("%memo.entry_front");
    for (const auto &alloc : allocas)
        moveInst(alloc, entry_front, entry_front->begin());
    function.addBlockAsEntry(entry_front);

    // Add the lookup routine
    //
    // entry_front:
    //   ... allocas ...
    //   %key = ... build key ...
    //   %key_rem = urem %key, i32 lut size
    //   %byte_offset = mul i32 %key_rem, i32 sizeof(MemoLUTEntry)
    //   %base_gep = getelementptr [xxx x i8]* @memo.lut, i32 0, i32 %byte_offset
    //   %base_bc = bitcast i8* %base_gep to i32*
    //   %has_val = load i32* %base_bc
    //   %key_gep = getelementptr i8* %base_gep, i32 (4 + sizeof(RetT)) ; a manual PRE
    //   %cmp = icmp ne i32 %has_val, i32 0
    //   br %cmp %has_val_bb, %entry_behind
    // has_val_bb:
    //   %found = ... compare key ...  ; use %key_gep here
    //   br %found %found_bb, %entry_behind
    // found_bb:
    //    %cached_ret_gep = getelementptr i8* %base_gep, i32 4
    //    %cached_ret_bc = bitcast i32* %cached_ret_gep to RetT*
    //    %cached_ret = load i32* %cached_ret_bc
    //    ret %cached_ret
    // entry_behind:
    //   ...
    //
    // For every return block:
    //   ...
    //   store i32 1, i32* %base_bc
    //   ... store key ...  ; use %key_gep here
    //   %exit_ret_gep = getelementptr i8* %base_gep, i32 4
    //   %exit_ret_bc = bitcast i32* %exit_ret_gep to RetT*
    //   store i32 %ret, i32* %exit_ret_bc
    //   ret %ret

    auto has_val_bb = std::make_shared<BasicBlock>("%memo.has_val_bb");
    auto found_bb = std::make_shared<BasicBlock>("%memo.found_bb");
    function.addBlock(entry_behind->getIter(), has_val_bb);
    function.addBlock(entry_behind->getIter(), found_bb);

    auto &cpool = function.getConstantPool();
    // Entry Front
    auto curr_key = plan->buildKey(function.getBlocks().front(), params);
    IRBuilder e_builder("%memo", entry_front);
    auto curr_key_rem = e_builder.makeURem(curr_key, function.getConst(Config::IR::MEMOIZATION_LUT_SIZE));
    auto byte_offset = e_builder.makeMul(curr_key_rem, function.getConst(static_cast<int>(lut_entry_size)));
    auto base_gep = e_builder.makeGep(lut, cpool.getConst(0), byte_offset);
    auto base_bc = e_builder.makeBitcast(base_gep, makePtrType(makeBType(IRBTYPE::I32)));
    auto has_val = e_builder.makeLoad(base_bc);
    auto key_gep =
        e_builder.makeGep(base_gep, cpool.getConst(static_cast<int>(4 + ret_type->getBytes()))); // a manual PRE
    auto cmp = e_builder.makeIcmp(ICMPOP::ne, has_val, cpool.getConst(0));
    auto entry_br = e_builder.makeBr(cmp, has_val_bb, entry_behind);

    // Has Val BB
    IRBuilder hv_builder("%memo", has_val_bb);
    pBr found_br;
    if (is_bijection) {
        auto key_bc = hv_builder.makeBitcast(key_gep, makePtrType(curr_key->getType()));
        auto key_ld = hv_builder.makeLoad(key_bc);
        auto found = hv_builder.makeIcmp(ICMPOP::eq, key_ld, curr_key);
        found_br = hv_builder.makeBr(found, found_bb, entry_behind);
    } else {
        pVal prev_cond = nullptr;
        pGep curr_gep = key_gep;
        for (const auto &param : params) {
            auto arg_bc = hv_builder.makeBitcast(curr_gep, makePtrType(param->getType()));
            auto arg_ld = hv_builder.makeLoad(arg_bc);
            pInst arg_cmp;
            if (arg_ld->getType()->isInteger())
                arg_cmp = hv_builder.makeIcmp(ICMPOP::eq, arg_ld, param);
            else
                arg_cmp = hv_builder.makeFcmp(FCMPOP::oeq, arg_ld, param);

            if (prev_cond) {
                auto cond_and = hv_builder.makeAnd(prev_cond, arg_cmp);
                prev_cond = cond_and;
            } else
                prev_cond = arg_cmp;
            curr_gep = hv_builder.makeGep(curr_gep, function.getConst(static_cast<int>(param->getType()->getBytes())));
        }
        found_br = hv_builder.makeBr(prev_cond, found_bb, entry_behind);
    }

    IRBuilder f_builder("%memo", found_bb);
    // Found BB
    auto ret_gep = f_builder.makeGep(base_gep, cpool.getConst(4));
    auto ret_bc = f_builder.makeBitcast(ret_gep, makePtrType(ret_type));
    auto cached_ret = f_builder.makeLoad(ret_bc);
    auto ret = f_builder.makeRet(cached_ret);

    if (emit_debug_inst) {
        IRBuilder dbg_builder(has_val_bb, found_br->iter());
        auto putch_fn = function.getParent()->lookupFunction("@putch");

        // entry_front:
        // X -> to Has Val BB, M -> Miss
        auto front_select = dbg_builder.makeSelect(entry_br->getCond(), function.getConst('X'), function.getConst('M'));
        auto putch_select0 = dbg_builder.makeCall(putch_fn, std::vector<pVal>{front_select});

        // has_val_bb:
        // H -> Hit, R -> Rewrite
        auto has_val_select =
            dbg_builder.makeSelect(found_br->getCond(), function.getConst('H'), function.getConst('R'));
        auto putch_select1 = dbg_builder.makeCall(putch_fn, std::vector<pVal>{has_val_select});
    }

    // Attention!
    // Update CFG here so that `getExitBBs` is correct.
    function.updateCFG();

    auto exit_bbs = function.getExitBBs();
    for (const auto &exit_bb : exit_bbs) {
        if (exit_bb == found_bb)
            continue;

        auto exit_ret = exit_bb->getRETInst();

        IRBuilder r_builder(exit_bb, exit_ret->iter());
        // Store has_val
        auto store_has_val = r_builder.makeStore(function.getConst(1), base_bc);

        // Store key
        if (is_bijection) {
            auto key_bc = r_builder.makeBitcast(key_gep, makePtrType(curr_key->getType()));
            (void)r_builder.makeStore(curr_key, key_bc);
        } else {
            pGep curr_gep = key_gep;
            for (const auto &param : params) {
                auto curr_bc = r_builder.makeBitcast(curr_gep, makePtrType(param->getType()));
                (void)r_builder.makeStore(param, curr_bc);
                curr_gep =
                    r_builder.makeGep(curr_gep, function.getConst(static_cast<int>(param->getType()->getBytes())));
            }
        }

        auto exit_ret_gep = r_builder.makeGep(base_gep, function.getConst(4));

        // Store return value
        auto exit_ret_bc = r_builder.makeBitcast(exit_ret_gep, makePtrType(ret_type));
        (void)r_builder.makeStore(exit_ret->getRetVal(), exit_ret_bc);
    }

    Logger::logDebug("[Memo]: Memoization on '", function.getName(), "' done.");

    return PreserveNone();
}
} // namespace IR