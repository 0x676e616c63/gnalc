#include "ir/passes/transforms/memoization.hpp"

#include "config/config.hpp"
#include "ir/instructions/binary.hpp"
#include "ir/instructions/compare.hpp"
#include "ir/instructions/control.hpp"
#include "ir/instructions/converse.hpp"
#include "ir/instructions/memory.hpp"
#include "ir/passes/analysis/alias_analysis.hpp"
#include "ir/passes/analysis/basic_alias_analysis.hpp"
#include "mirA32/instruction.hpp"

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
// Note that the key at least have one item. Identical key shall guarantee the same return value.
class MemoPlan {
public:
    virtual ~MemoPlan() = default;
    virtual std::vector<pVal> buildKey(const pBlock &entry_front, const std::vector<pFormalParam> &args) = 0;
    virtual size_t getKeyBytes(const std::vector<pFormalParam> &args) = 0;
};

// func(int, int, int ...) -> i64 hash + args...
class ArbitraryIntsFloatsMemo : public MemoPlan {
public:
    std::vector<pVal> buildKey(const pBlock &entry, const std::vector<pFormalParam> &args) final {
        auto insert_point = entry->begin();
        while (insert_point != entry->end() && (*insert_point)->getOpcode() == OP::ALLOCA)
            ++insert_point;

        std::vector<pInst> sexts;
        for (size_t i = 0; i < args.size(); ++i) {
            pVal real_arg = args[i];
            if (real_arg->getType()->isF32()) {
                auto f2ibc = std::make_shared<BITCASTInst>("%memo.f2ibc." + std::to_string(i), real_arg,
                                                           makeBType(IRBTYPE::I32));
                entry->addInst(insert_point, f2ibc);
                real_arg = f2ibc;
            }
            auto sext = std::make_shared<SEXTInst>("%memo.sext" + std::to_string(i), real_arg, IRBTYPE::I64);
            entry->addInst(insert_point, sext);
            sexts.emplace_back(sext);
        }

        // Hash:
        // i64 hash = args[0]
        // for (i = 1; i < args.size(); ++i)
        //     hash ^= args[i] << ((13 * i) % 64)
        pInst hash_val = sexts[0];
        for (size_t i = 1; i < sexts.size(); ++i) {
            auto shifted =
                std::make_shared<BinaryInst>("%memo.shift" + std::to_string(i), OP::SHL, sexts[i],
                                             entry->getParent()->getConst(static_cast<int64_t>(13 * i % 64)));
            hash_val = std::make_shared<BinaryInst>("%memo.xor" + std::to_string(i), OP::XOR, hash_val, shifted);
            entry->addInst(insert_point, shifted);
            entry->addInst(insert_point, hash_val);
        }

        std::vector<pVal> keys{hash_val};
        for (const auto &arg : args)
            keys.emplace_back(arg);

        return keys;
    }
    size_t getKeyBytes(const std::vector<pFormalParam> &args) final { return 8 + args.size() * 4; }
};

// func(int) -> i32
// func(int, int) -> i64
// func(int, int, int) -> i64, i32
// func(int, int, int, int) -> i64, i64
// FIXME: i128?
class SmallIntsFloatsMemo : public MemoPlan {
public:
    std::vector<pVal> buildKey(const pBlock &entry, const std::vector<pFormalParam> &args) final {
        Err::gassert(args.size() < 5);

        auto insert_point = entry->begin();
        while (insert_point != entry->end() && (*insert_point)->getOpcode() == OP::ALLOCA)
            ++insert_point;

        std::vector<pVal> keys;
        size_t i = 0;
        for (; i + 1 < args.size(); i += 2) {
            pVal real_arg0 = args[i];
            pVal real_arg1 = args[i + 1];
            if (real_arg0->getType()->isF32()) {
                auto f2ibc = std::make_shared<BITCASTInst>("%memo.f2ibc." + std::to_string(i), real_arg0,
                                                           makeBType(IRBTYPE::I32));
                entry->addInst(insert_point, f2ibc);
                real_arg0 = f2ibc;
            }
            if (real_arg1->getType()->isF32()) {
                auto f2ibc = std::make_shared<BITCASTInst>("%memo.f2ibc." + std::to_string(i + 1), real_arg1,
                                                           makeBType(IRBTYPE::I32));
                entry->addInst(insert_point, f2ibc);
                real_arg1 = f2ibc;
            }

            auto sext0 = std::make_shared<SEXTInst>("%memo.sext0." + std::to_string(i), real_arg0, IRBTYPE::I64);
            auto sext1 = std::make_shared<SEXTInst>("%memo.sext1." + std::to_string(i + 1), real_arg1, IRBTYPE::I64);
            auto shl = std::make_shared<BinaryInst>("%memo.shl." + std::to_string(i), OP::SHL, sext0,
                                                    entry->getParent()->getConst(static_cast<int64_t>(32)));
            auto i64_or = std::make_shared<BinaryInst>("%memo.or." + std::to_string(i), OP::OR, shl, sext1);
            entry->addInst(insert_point, sext0);
            entry->addInst(insert_point, sext1);
            entry->addInst(insert_point, shl);
            entry->addInst(insert_point, i64_or);
            keys.emplace_back(i64_or);
        }

        for (; i < args.size(); ++i) {
            if (args[i]->getType()->isF32()) {
                auto f2ibc =
                    std::make_shared<BITCASTInst>("%memo.f2ibc." + std::to_string(i), args[i], makeBType(IRBTYPE::I32));
                entry->addInst(insert_point, f2ibc);
                keys.emplace_back(f2ibc);
            } else
                keys.emplace_back(args[i]);
        }

        return keys;
    }
    size_t getKeyBytes(const std::vector<pFormalParam> &args) final { return 4 * args.size(); }
};

std::shared_ptr<MemoPlan> selectMemoPlan(Function &func) {
    const auto &params = func.getParams();

    for (const auto &fp : params) {
        if (!fp->getType()->isI32() && !fp->getType()->isF32())
            return nullptr;
    }

    if (params.size() < 5)
        return std::make_shared<SmallIntsFloatsMemo>();

    return std::make_shared<ArbitraryIntsFloatsMemo>();
}

PM::PreservedAnalyses MemoizePass::run(Function &function, FAM &fam) {
    // Memoize pure recursive functions
    if (!function.isRecursive())
        return PreserveAll();

    if (!isPure(fam, &function)) {
        Logger::logDebug("[Memo]: Skip non-pure recursive function '", function.getName(), "'.");
        return PreserveAll();
    }

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
        Logger::logDebug("[Memo]: Skip void recursive function '", function.getName(), "'.");
        return PreserveAll();
    }

    // Select the best plan
    auto plan = selectMemoPlan(function);
    if (!plan) {
        Logger::logDebug("[Memo]: Failed to select a plan for recursive function '", function.getName(), "'.");
        return PreserveAll();
    }

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

    entry_front->addInst(curr_key_rem);
    entry_front->addInst(byte_offset);
    entry_front->addInst(base_gep);
    entry_front->addInst(base_bc);
    entry_front->addInst(has_val);
    entry_front->addInst(key_gep);
    entry_front->addInst(cmp);
    entry_front->addInst(entry_br);

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
        has_val_bb->addInst(key_bc);
        has_val_bb->addInst(key);
        has_val_bb->addInst(key_cmp);

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
    found_bb->addInst(ret_gep);
    found_bb->addInst(ret_bc);
    found_bb->addInst(cached_ret);
    found_bb->addInst(ret);

    // Attention!
    // Update CFG here so that `getExitBBs` is correct.
    function.updateCFG();

    auto exit_bbs = function.getExitBBs();
    for (const auto & exit_bb : exit_bbs) {
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