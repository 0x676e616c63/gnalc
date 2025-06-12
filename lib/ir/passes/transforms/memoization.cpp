#include "ir/passes/transforms/memoization.hpp"

#include "config/config.hpp"
#include "ir/block_utils.hpp"
#include "ir/instructions/binary.hpp"
#include "ir/instructions/compare.hpp"
#include "ir/instructions/control.hpp"
#include "ir/instructions/converse.hpp"
#include "ir/instructions/memory.hpp"
#include "ir/passes/analysis/alias_analysis.hpp"
#include "ir/passes/analysis/basic_alias_analysis.hpp"
#include "ir/passes/analysis/domtree_analysis.hpp"
#include "utils/int128.hpp"
#include "utils/logger.hpp"

#include <algorithm>
#include <string>
#include <vector>

namespace IR {
// Memoization Plan
// For function with small arguments, we usually have a more optimized way to
// compute the LUT key. (`Intx2Memo`, ...)
// However, For large arguments, we still have a fallback way to compute the LUT key. (See `ArbitraryMemo`)
//
// For example:
// For `func(i32, i32)`, we can use an i64 as its LUT key (`Intx2Memo`)
// But for func(i32, i32, i32, i32, i32), only `ArbitraryMemo` is suitable.
//
// The key difference is how they build the `key`.
// The return value is a list of key, the first is used as an index.
// Identical list of key shall guarantee the same return value.
class MemoPlan {
public:
    virtual ~MemoPlan() = default;
    virtual std::vector<pVal> buildKey(const pBlock &bb, const std::vector<pFormalParam> &args) = 0;
    virtual size_t getKeyBytes(const std::vector<pFormalParam> &args) = 0;
};

pZext make_zext(const pBlock &bb, BBInstIter insert_point, const pVal &source, IRBTYPE to_type) {
    static size_t name_cnt = 0;

    auto zext = std::make_shared<ZEXTInst>("%memo.zext" + std::to_string(name_cnt++), source, to_type);
    bb->addInst(insert_point, zext);
    return zext;
}

pBinary make_shl(const pBlock &bb, BBInstIter insert_point, const pVal &source, int bits) {
    static size_t name_cnt = 0;

    auto shl = std::make_shared<BinaryInst>("%memo.shl" + std::to_string(name_cnt++), OP::SHL, source,
                                            bb->getParent()->getConst(bits));
    bb->addInst(insert_point, shl);
    return shl;
}

pBinary make_or(const pBlock &bb, BBInstIter insert_point, const pVal &lhs, const pVal &rhs) {
    static size_t name_cnt = 0;

    auto or_val = std::make_shared<BinaryInst>("%memo.or" + std::to_string(name_cnt++), OP::OR, lhs, rhs);
    bb->addInst(insert_point, or_val);
    return or_val;
}

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

// func(int, int, int ...) -> i64 hash + args...
class ArbitraryIntsFloatsMemo : public MemoPlan {
public:
    std::vector<pVal> buildKey(const pBlock &bb, const std::vector<pFormalParam> &args) final {
        auto insert_point = bb->begin();
        while (insert_point != bb->end() && (*insert_point)->getOpcode() == OP::ALLOCA)
            ++insert_point;

        std::vector<pInst> zexts;
        zexts.reserve(args.size());
        for (const auto &arg : args) {
            auto i32_arg = cast_if_float(bb, insert_point, arg);
            auto zext = make_zext(bb, insert_point, i32_arg, IRBTYPE::I128);
            zexts.emplace_back(zext);
        }

        std::vector<pInst> shls;
        int num_shls = (static_cast<int>(zexts.size()) / 4) * 4;
        shls.reserve(num_shls);
        shls.emplace_back(zexts[0]);
        for (int i = 1; i < num_shls; ++i)
            shls.emplace_back(make_shl(bb, insert_point, zexts[i], i * 32));

        auto composed_i128_cnt = num_shls / 4;
        std::vector<pInst> i128_args;
        for (int i = 0; i < composed_i128_cnt; ++i) {
            auto base_val = shls[i * 4];
            for (int j = 1; j < 4; ++j)
                base_val = make_or(bb, insert_point, base_val, shls[i * 4 + j]);
            i128_args.emplace_back(base_val);
        }

        for (int i = num_shls; i < zexts.size(); ++i)
            i128_args.emplace_back(zexts[i]);

        // Hash:
        // i128 hash = args[0]
        // for (i = 1; i < args.size(); ++i)
        //     hash ^= args[i] << ((31 * i) % 128)
        pInst hash_val = i128_args[0];
        for (size_t i = 1; i < zexts.size(); ++i) {
            auto shifted = std::make_shared<BinaryInst>("%memo.shift" + std::to_string(i), OP::SHL, zexts[i],
                                                        bb->getParent()->getConst(static_cast<int64_t>(31 * i % 128)));
            hash_val = std::make_shared<BinaryInst>("%memo.xor" + std::to_string(i), OP::XOR, hash_val, shifted);
            bb->addInst(insert_point, shifted);
            bb->addInst(insert_point, hash_val);
        }

        hash_val->setName("%memo.curr_key");

        std::vector<pVal> keys{hash_val};
        for (const auto &arg : args)
            keys.emplace_back(arg);

        return keys;
    }
    size_t getKeyBytes(const std::vector<pFormalParam> &args) final { return 16 + args.size() * 4; }
};

// func(int) -> i32
// func(int, int) -> i64
// func(int, int, int) -> i128
// func(int, int, int, int) -> i128
class SmallIntsFloatsMemo : public MemoPlan {
public:
    std::vector<pVal> buildKey(const pBlock &bb, const std::vector<pFormalParam> &args) final {
        Err::gassert(args.size() < 5);

        auto insert_point = bb->begin();
        while (insert_point != bb->end() && (*insert_point)->getOpcode() == OP::ALLOCA)
            ++insert_point;

        std::vector<pVal> i32_args;
        std::transform(args.begin(), args.end(), std::back_inserter(i32_args),
                       [&](const pVal &arg) { return cast_if_float(bb, insert_point, arg); });

        if (i32_args.size() == 1)
            return i32_args;

        std::vector<pVal> zexts;
        zexts.reserve(i32_args.size());
        std::transform(i32_args.begin(), i32_args.end(), std::back_inserter(zexts), [&](const pVal &arg) {
            return make_zext(bb, insert_point, arg, i32_args.size() == 2 ? IRBTYPE::I64 : IRBTYPE::I128);
        });

        std::vector<pVal> shls;
        shls.reserve(zexts.size());
        shls.emplace_back(zexts[0]);
        for (int i = 1; i < zexts.size(); ++i)
            shls.emplace_back(make_shl(bb, insert_point, zexts[i], i * 32));

        pVal base_val = shls[0];
        for (int i = 1; i < shls.size(); ++i)
            base_val = make_or(bb, insert_point, base_val, shls[i]);

        base_val->setName("%memo.curr_key");
        return {base_val};
    }
    size_t getKeyBytes(const std::vector<pFormalParam> &args) final {
        return args.size() == 3 ? 16 : (4 * args.size());
    }
};

// Memoization can be an optimization if a pure function is called with identical arguments
// many times. Determine a function's execution frequency is already too hard, if not impossible,
// for us, not to mention questioning its arguments. Therefore, we only memoize functions
// that are most possible to fit into such cases.
// A function worth memoization usually have overlapping subproblems. In other words,
// different paths depend on the solution to the same subproblem.
// Here we try to figure out if a function has overlapping subproblems.
// FIXME: More precise cost model
bool isProfitableToMemoize(Function &func) {
    std::vector<pCall> self_calls;
    for (const auto &bb : func) {
        for (const auto &inst : *bb) {
            if (auto call = inst->as<CALLInst>()) {
                if (call->getFunc().get() == &func)
                    self_calls.emplace_back(call);
            }
        }
    }

    // Overlapping subproblems at least have too paths
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

    if (params.size() < 5)
        return std::make_shared<SmallIntsFloatsMemo>();

    return std::make_shared<ArbitraryIntsFloatsMemo>();
}

PM::PreservedAnalyses MemoizePass::run(Function &function, FAM &fam) {
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

    // MemoLUT Entry
    // struct MemoLUTEntry {
    //     int32_t has_val;
    //     KeyT key;
    //     RetT ret;
    // }
    // Size: 4 + sizeof(KeyT) + sizeof(RetT)
    size_t lut_entry_size = 4 + ret_type->getBytes() + plan->getKeyBytes(params);

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
    //   %key_gep = getelementptr i8* %base_gep, i32 4  ; a manual PRE
    //   %cmp = icmp ne i32 %has_val, i32 0
    //   br %cmp %has_val_bb, %entry_behind
    // has_val_bb:
    //   %found = ... compare key ...  ; use %key_gep here
    //   br %found %found_bb, %entry_behind
    // found_bb:
    //    %cached_ret_gep = getelementptr i8* %base_gep, i32 (4 + sizeof(KeyT))
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
    //   %exit_ret_gep = getelementptr i8* %base_gep, i32 (4 + sizeof(KeyT))
    //   %exit_ret_bc = bitcast i32* %exit_ret_gep to RetT*
    //   store i32 %ret, i32* %exit_ret_bc
    //   ret %ret

    auto has_val_bb = std::make_shared<BasicBlock>("%memo.has_val_bb");
    auto found_bb = std::make_shared<BasicBlock>("%memo.found_bb");
    function.addBlock(entry_behind->getIter(), has_val_bb);
    function.addBlock(entry_behind->getIter(), found_bb);

    // Entry Front
    auto curr_key = plan->buildKey(function.getBlocks().front(), params);
    auto curr_key_rem = std::make_shared<BinaryInst>("%memo.curr_keyrem", OP::UREM, curr_key[0],
                                                     function.getConst(Config::IR::MEMOIZATION_LUT_SIZE));
    auto byte_offset = std::make_shared<BinaryInst>("%memo.byte_offset", OP::MUL, curr_key_rem,
                                                    function.getConst(static_cast<int>(lut_entry_size)));

    auto base_gep = std::make_shared<GEPInst>("%memo.gep.base", lut, function.getConst(0), byte_offset);
    auto base_bc = std::make_shared<BITCASTInst>("%memo.bc.base", base_gep, makePtrType(makeBType(IRBTYPE::I32)));
    auto has_val = std::make_shared<LOADInst>("%memo.hasval", base_bc);
    auto key_gep = std::make_shared<GEPInst>("%memo.gep.key", base_gep, function.getConst(4));
    auto cmp = std::make_shared<ICMPInst>("%memo.cmp", ICMPOP::ne, has_val, function.getConst(0));
    auto entry_br = std::make_shared<BRInst>(cmp, has_val_bb, entry_behind);

    entry_front->addInsts({curr_key_rem, byte_offset, base_gep, base_bc, has_val, key_gep, cmp, entry_br});

    // Has Val BB
    pVal prev_cond = nullptr;
    for (size_t i = 0; i < curr_key.size(); ++i) {
        const auto &key_item = curr_key[i];
        auto key_bc = std::make_shared<BITCASTInst>("%memo.key.bc" + std::to_string(i), key_gep,
                                                    makePtrType(key_item->getType()));
        auto key = std::make_shared<LOADInst>("%memo.key.ld" + std::to_string(i), key_bc);
        pInst key_cmp;
        if (key->getType()->isInteger())
            key_cmp = std::make_shared<ICMPInst>("%memo.found" + std::to_string(i), ICMPOP::eq, key, key_item);
        else
            key_cmp = std::make_shared<FCMPInst>("%memo.found" + std::to_string(i), FCMPOP::oeq, key, key_item);
        has_val_bb->addInsts({key_bc, key, key_cmp});

        if (prev_cond) {
            auto cond_and = std::make_shared<BinaryInst>("%memo.and" + std::to_string(i), OP::AND, prev_cond, key_cmp);
            has_val_bb->addInst(cond_and);
            prev_cond = cond_and;
        } else
            prev_cond = key_cmp;
    }
    auto found_br = std::make_shared<BRInst>(prev_cond, found_bb, entry_behind);
    has_val_bb->addInst(found_br);

    // Found BB
    auto ret_gep = std::make_shared<GEPInst>("%memo.gep.ret", base_gep,
                                             function.getConst(static_cast<int>(4 + plan->getKeyBytes(params))));
    auto ret_bc = std::make_shared<BITCASTInst>("%memo.bc.ret", ret_gep, makePtrType(ret_type));
    auto cached_ret = std::make_shared<LOADInst>("%memo.ret", ret_bc);
    auto ret = std::make_shared<RETInst>(cached_ret);
    found_bb->addInsts({ret_gep, ret_bc, cached_ret, ret});

    if (emit_debug_inst) {
        auto putch_fn = function.getParent()->lookupFunction("@putch");

        // entry_front:
        // X -> to Has Val BB, M -> Miss
        auto front_select = std::make_shared<SELECTInst>("%memo.debug0", entry_br->getCond(), function.getConst('X'),
                                                         function.getConst('M'));
        auto putch_select0 = std::make_shared<CALLInst>(putch_fn, std::vector<pVal>{front_select});
        entry_front->addInstBeforeTerminator(front_select);
        entry_front->addInstBeforeTerminator(putch_select0);

        // has_val_bb:
        // H -> Hit, R -> Rewrite
        auto has_val_select = std::make_shared<SELECTInst>("%memo.debug1", found_br->getCond(), function.getConst('H'),
                                                           function.getConst('R'));
        auto putch_select1 = std::make_shared<CALLInst>(putch_fn, std::vector<pVal>{has_val_select});
        has_val_bb->addInstBeforeTerminator(has_val_select);
        has_val_bb->addInstBeforeTerminator(putch_select1);
    }

    // Attention!
    // Update CFG here so that `getExitBBs` is correct.
    function.updateCFG();

    auto exit_bbs = function.getExitBBs();
    for (const auto &exit_bb : exit_bbs) {
        if (exit_bb == found_bb)
            continue;

        // Store has_val
        auto store_has_val = std::make_shared<STOREInst>(function.getConst(1), base_bc);
        exit_bb->addInstBeforeTerminator(store_has_val);

        auto bbname = exit_bb->getName().substr(1);
        // Store key
        for (size_t j = 0; j < curr_key.size(); ++j) {
            const auto &key_item = curr_key[j];
            auto key_bc = std::make_shared<BITCASTInst>("%memo.bc." + bbname + ".key" + std::to_string(j), key_gep,
                                                        makePtrType(key_item->getType()));
            auto store = std::make_shared<STOREInst>(key_item, key_bc);
            exit_bb->addInstBeforeTerminator(key_bc);
            exit_bb->addInstBeforeTerminator(store);
        }

        auto exit_ret = exit_bb->getRETInst();
        auto exit_ret_gep = std::make_shared<GEPInst>(
            "%memo.gep.ret." + bbname, base_gep, function.getConst(static_cast<int>(4 + plan->getKeyBytes(params))));

        // Store return value
        auto exit_ret_bc = std::make_shared<BITCASTInst>("%memo.bc.ret." + bbname, exit_ret_gep, makePtrType(ret_type));
        auto str = std::make_shared<STOREInst>(exit_ret->getRetVal(), exit_ret_bc);
        exit_bb->addInstBeforeTerminator(exit_ret_gep);
        exit_bb->addInstBeforeTerminator(exit_ret_bc);
        exit_bb->addInstBeforeTerminator(str);
    }

    Logger::logDebug("[Memo]: Memoization on '", function.getName(), "' done.");

    return PreserveNone();
}
} // namespace IR