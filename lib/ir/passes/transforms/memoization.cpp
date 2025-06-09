#include "ir/passes/transforms/memoization.hpp"

#include "config/config.hpp"
#include "ir/instructions/binary.hpp"
#include "ir/instructions/compare.hpp"
#include "ir/instructions/control.hpp"
#include "ir/instructions/converse.hpp"
#include "ir/instructions/memory.hpp"
#include "ir/passes/analysis/alias_analysis.hpp"
#include "ir/passes/analysis/basic_alias_analysis.hpp"

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
// The key difference is how they handle the `key`.
class MemoPlan {
public:
    virtual ~MemoPlan() = default;
    virtual pVal buildKey(const pBlock &entry_front, const std::vector<pFormalParam> &args) = 0;
    virtual pVal compareKey(const pBlock &has_val_bb, const pGep &key_gep, const pVal &curr_key) = 0;
    virtual void storeKey(const pBlock &ret_block, const pGep &key_gep, const pVal &curr_key) = 0;
    virtual size_t getKeyBytes() = 0;
};

class ArbitraryMemo : public MemoPlan {
public:
    pVal buildKey(const pBlock &entry, const std::vector<pFormalParam> &args) final {
        Err::todo();
        return nullptr;
    }
    pVal compareKey(const pBlock &has_val_bb, const pGep &key_gep, const pVal &curr_key) final {
        Err::todo();
        return nullptr;
    }
    void storeKey(const pBlock &ret_block, const pGep &key_gep, const pVal &curr_key) final { Err::todo(); }
    size_t getKeyBytes() final {
        Err::todo();
        return 0;
    }
};

class Intx2Memo : public MemoPlan {
public:
    pVal buildKey(const pBlock &entry, const std::vector<pFormalParam> &args) final {
        Err::gassert(args.size() == 2, "Expected two arguments.");
        Err::gassert(args[0]->getType()->isI32() && args[1]->getType()->isI32(), "Expected two int arguments.");

        auto sext0 = std::make_shared<SEXTInst>("%memo.sext0", args[0], IRBTYPE::I64);
        auto sext1 = std::make_shared<SEXTInst>("%memo.sext1", args[1], IRBTYPE::I64);

        auto tmp = std::make_shared<BinaryInst>("%memo.tmp", OP::SHL, sext0, entry->getParent()->getConst(static_cast<int64_t>(32)));
        auto curr_key = std::make_shared<BinaryInst>("%memo.curr_key", OP::OR, tmp, sext1);
        entry->addInstAfterAlloca(curr_key);
        entry->addInstAfterAlloca(tmp);
        entry->addInstAfterAlloca(sext1);
        entry->addInstAfterAlloca(sext0);
        return curr_key;
    }

    pVal compareKey(const pBlock &has_val_bb, const pGep &key_gep, const pVal &curr_key) final {
        auto key_bc = std::make_shared<BITCASTInst>("%memo.key.bc", key_gep, makePtrType(makeBType(IRBTYPE::I64)));
        auto key = std::make_shared<LOADInst>("%memo.key.ld", key_bc);
        auto icmp = std::make_shared<ICMPInst>("%memo.found", ICMPOP::eq, key, curr_key);
        has_val_bb->addInst(key_bc);
        has_val_bb->addInst(key);
        has_val_bb->addInst(icmp);
        return icmp;
    }

    void storeKey(const pBlock &ret_block, const pGep &key_gep, const pVal &curr_key) final {
        auto key_bc = std::make_shared<BITCASTInst>("%memo.key.bc." + ret_block->getName().substr(1), key_gep,
                                                    makePtrType(makeBType(IRBTYPE::I64)));
        auto store = std::make_shared<STOREInst>(curr_key, key_bc);
        ret_block->addInstBeforeTerminator(key_bc);
        ret_block->addInstBeforeTerminator(store);
        return;
    }

    size_t getKeyBytes() final { return 8; }
};

// Currently only support two int arguments for debug.
// TODO: Extend it to arbitrary arguments.
std::shared_ptr<MemoPlan> selectMemoPlan(Function &func) {
    const auto &params = func.getParams();
    if (params.size() == 2 && params[0]->getType()->isI32() && params[1]->getType()->isI32())
        return std::make_shared<Intx2Memo>();

    // TODO: Arbitrary Plan is WIP.
    return nullptr;
}

PM::PreservedAnalyses MemoizePass::run(Function &function, FAM &fam) {
    // Memoize pure recursive functions
    if (!function.isRecursive() || !isPure(fam, &function))
        return PreserveAll();

    // Skip functions with pointer arguments
    auto params = function.getParams();
    for (const auto &fp : params) {
        if (!fp->getType()->is<BType>())
            return PreserveAll();
    }

    auto ret_type = function.getType()->as<FunctionType>()->getRet();
    Err::gassert(ret_type->is<BType>(), "Expected BType in Ret.");
    // Skip void function
    if (ret_type->isVoid())
        return PreserveAll();

    // Select the best provider
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
    size_t lut_entry_size = 4 + ret_type->getBytes() + plan->getKeyBytes();

    auto lut_type = makeArrayType(makeBType(IRBTYPE::I8), lut_entry_size * Config::IR::MEMOIZATION_LUT_SIZE);
    auto lut = std::make_shared<GlobalVariable>(STOCLASS::GLOBAL, lut_type, "@memo.lut." + function.getName().substr(1),
                                                GVIniter(lut_type));
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
    //   %key_rem = srem %key, i32 lut size
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
    auto curr_key_rem = std::make_shared<BinaryInst>("%memo.curr_keyrem", OP::UREM, curr_key,
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
    auto found = plan->compareKey(has_val_bb, key_gep, curr_key);
    auto found_br = std::make_shared<BRInst>(found, found_bb, entry_behind);
    has_val_bb->addInst(found_br);

    // Found BB
    auto ret_gep = std::make_shared<GEPInst>("%memo.gep.ret", base_gep,
                                             function.getConst(static_cast<int>(4 + plan->getKeyBytes())));
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
    for (size_t i = 0; i < exit_bbs.size(); i++) {
        const auto &exit_bb = exit_bbs[i];
        if (exit_bb == found_bb)
            continue;

        auto store_has_val = std::make_shared<STOREInst>(function.getConst(1), base_bc);
        exit_bb->addInstBeforeTerminator(store_has_val);
        plan->storeKey(exit_bb, key_gep, curr_key);

        auto exit_ret = exit_bb->getRETInst();
        auto exit_ret_gep = std::make_shared<GEPInst>("%memo.gep.ret.exit" + std::to_string(i), base_gep,
                                                      function.getConst(static_cast<int>(4 + plan->getKeyBytes())));
        auto exit_ret_bc =
            std::make_shared<BITCASTInst>("%memo.bc.ret.exit" + std::to_string(i), exit_ret_gep, makePtrType(ret_type));
        auto str = std::make_shared<STOREInst>(exit_ret->getRetVal(), exit_ret_bc);
        exit_bb->addInstBeforeTerminator(exit_ret_gep);
        exit_bb->addInstBeforeTerminator(exit_ret_bc);
        exit_bb->addInstBeforeTerminator(str);
    }

    Logger::logDebug("[Memo]: Memoization on '", function.getName(), "' done.");

    return PreserveNone();
}
} // namespace IR