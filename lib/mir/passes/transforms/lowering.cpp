#include "mir/passes/transforms/lowering.hpp"
#include "ir/instructions/binary.hpp"
#include "ir/instructions/control.hpp"
#include "ir/instructions/converse.hpp"
#include "ir/instructions/memory.hpp"
#include "ir/instructions/phi.hpp"
#include "ir/module.hpp"
#include "ir/type.hpp"
#include "mir/passes/transforms/isel.hpp"
#include <algorithm>

using namespace MIR_new;

LoweringContext::LoweringContext(MIRModule &module, CodeGenContext &codeGenCtx, std::map<IRBlk_p, MIRBlk_p> &blkMap,
                                 std::map<string, MIRGlobal_p> &globalMap,
                                 std::map<IRVal_p, MIROperand_p> &valMap) noexcept
    : mModule(module), mCodeGenCtx(codeGenCtx), mBlkMap(blkMap), mGlobalMap(globalMap), mValMap(valMap) {
    mPtrType = OpT::Int64;
}

OpT MIR_new::btypeConvert(const IR::BType &type) {
    switch (type.getInner()) {
    case IR::IRBTYPE::I1:
    case IR::IRBTYPE::I8:
    case IR::IRBTYPE::I32:
        return OpT::Int32;
    case IR::IRBTYPE::FLOAT:
        return OpT::Float32;
    default:
        Err::unreachable("btypeConvert: try convert invalid btype");
    }
    return OpT::Int; // just to make clang happy
}

MIRBlk_p LoweringContext::mapBlk(const IRBlk_p &blk) const { return mBlkMap.at(blk); }

MIRGlobal_p LoweringContext::mapGlobal(const string &global) const { return mGlobalMap.at(global); }

MIROperand_p LoweringContext::mapOperand(const IRVal_p &value) {
    if (value->getVTrait() == IR::ValueTrait::ORDINARY_VARIABLE) {

        // get from mValMap
        return mValMap.at(value);
    } else if (value->getVTrait() == IR::ValueTrait::CONSTANT_LITERAL) {

        // get from mConstantMap
        if (auto ci32 = value->as<IR::ConstantInt>()) {
            auto imme = ci32->getVal();
            return mapOperand(imme);
        } else if (auto cf32 = value->as<IR::ConstantFloat>()) {
            auto imme = cf32->getVal();
            return mapOperand(imme);
        }

        ///@todo vectorize
    } else if (auto value_glo = value->as<IR::GlobalVariable>()) {

        // get from mValMap, but would insert loadInst
        ///@brief   adrp    x0, :got:arr
        ///@brief   ldr     x0, [x0, :got_lo12:arr]

        auto mReloc = mGlobalMap.at(value_glo->getName());

        auto mglo = MIROperand::asVReg(mCodeGenCtx.nextId(), OpT::Int64);

        emitInst(
            MIRInst::make(ARMOpC::ADRP_LDR)->setOperand<0>(mglo)->setOperand<1>(MIROperand::asReloc(mReloc->reloc())));

        return mglo;
    }

    return nullptr; // just to make clang happy
}

MIROperand_p LoweringContext::newVReg(const std::shared_ptr<IR::Type> &type) {
    switch (type->getTrait()) {
    case IR::IRCTYPE::ARRAY:
        return newVReg(*(type->as<IR::ArrayType>()));
    case IR::IRCTYPE::BASIC:
        return newVReg(*(type->as<IR::BType>()));
    case IR::IRCTYPE::PTR:
        return newVReg(*(type->as<IR::PtrType>()));
    default:
        Err::todo("LoweringContext::newVReg: vec and func");
        return nullptr;
    }
}

MIROperand_p LoweringContext::newVReg(const IR::BType &type) {
    return MIROperand::asVReg(mCodeGenCtx.nextId(), btypeConvert(type));
}

MIROperand_p LoweringContext::newVReg(const IR::PtrType &type) { // type not used
    return MIROperand::asVReg(mCodeGenCtx.nextId(), mPtrType);   // for armv8, int64 here
}

MIROperand_p LoweringContext::newVReg(const IR::ArrayType &type) {
    Err::todo("newReg: array type undo now");
    return nullptr;
}

MIROperand_p LoweringContext::newVReg(const IR::VectorType &type) {
    Err::todo("newReg: vector type undo now");
    return nullptr;
}

MIROperand_p LoweringContext::newVReg(const OpT &type) {
    return MIROperand::asVReg(mCodeGenCtx.nextId(), type); //
}

void LoweringContext::emitInst(const MIRInst_p &inst) {
    auto &insts = mCurrentBlk->Insts();
    insts.emplace_back(inst);
}

void LoweringContext::emitCopy(const MIROperand_p &dst, const MIROperand_p &src) {
    auto inst = MIRInst::make(chooseCopyOpC(dst, src));
    inst->setOperand<0>(dst);
    inst->setOperand<1>(src);

    emitInst(inst);
}

void LoweringContext::emitInstBeforeBr(const MIRInst_p_l &inst) { // insts ?
    ///@note 此处需要假设blk的所有跳转均位于blk的尾部

    auto &mblk = mCurrentBlk;
    auto &insts = mblk->Insts();

    auto insert_it = insts.end();
    for (auto it = insts.begin(); it != insts.end(); ++it) {
        if (it->get()->isGeneric() && it->get()->opcode<OpC>() == OpC::InstBranch) {
            insert_it = it;
            break;
        }
    }

    Err::gassert(insert_it != insts.end(), "emitInstBeforeBr: cant find a branch inst");

    insts.insert(insert_it, inst.begin(), inst.end());
}

void LoweringContext::emitInstBeforeBr(const MIRInst_p &inst) {

    auto &mblk = mCurrentBlk;
    auto &insts = mblk->Insts();

    auto insert_it = insts.end();
    for (auto it = insts.begin(); it != insts.end(); ++it) {
        if (it->get()->isGeneric() && it->get()->opcode<OpC>() == OpC::InstBranch) {
            insert_it = it;
            break;
        }
    }

    Err::gassert(insert_it != insts.end(), "emitInstBeforeBr: cant find a branch inst");

    insts.insert(insert_it, inst);
}

MIRBlk_p LoweringContext::addBlkAfter() {
    auto &blks = mCurrentBlk->getFunction()->blks();
    auto it = std::find_if(blks.begin(), blks.end(), [&](auto &block) { return block == mCurrentBlk; });

    Err::gassert(it != blks.end(), "addBlkAfter: cant find mCurrentBlk in blk list");

    auto mfunc = mCurrentBlk->getFunction();

    auto new_blk = make<MIRBlk>(mfunc->getmSym(), mfunc);
    blks.insert(std::next(it), new_blk);

    return new_blk;
}

void LoweringContext::addOperand(const IRVal_p &val, const MIROperand_p &mval) {
    Err::gassert(!mValMap.count(val), "addOperand: mValMap key already used");
    mValMap.emplace(val, mval);
}

///@note entry
MIRModule_p MIR_new::loweringModule(const IRModule &module, CodeGenContext &ctx) {
    std::map<string, MIRGlobal_p> globalMap;

    const auto &layout = ctx.target.dataLayOut;

    auto mModule = make<MIRModule>(ctx.target, ctx, module.getName());

    ///@brief 翻译全局的各种符号, 函数 + 全局变量
    ///@note
    auto &globalvals = module.getGlobalVars();
    auto &globals = mModule->globals();
    for (auto &func : module) {
        ///@note here we dont have to handle func declare

        string sym = func->getName().substr(1); // delete prefix '@'
        auto mfunc = make<MIRFunction>(sym, ctx);
        globals.push_back(make<MIRGlobal>(layout.codeAlignment, mfunc));
        mModule->addFunc(mfunc);

        globalMap.emplace(func->getName(), make<MIRGlobal>(layout.codeAlignment, mfunc)); // map with prefix
    }

    for (auto &globalval : globalvals) {
        auto mglo = MIR_new::loweringGlobal(*globalval);
        mModule->globals().emplace_back(mglo);
        globalMap.emplace(globalval->getName(), mglo); // map with prefix
    }

    ///@todo pre-lowering legalize(on module)

    ///@brief 1. lowering to Generic MIR
    for (auto &func : module) {
        auto mfunc = globalMap.at(func->getName())->reloc()->as<MIRFunction>();
        loweringFunction(mfunc, func, ctx, *mModule, globalMap);
    }

    return mModule;
}

MIRGlobal_p MIR_new::loweringGlobal(const IR::GlobalVariable &global) {
    MIRGlobal_p ret = nullptr;
    MIRRelocable_p inner = nullptr;
    auto initer = global.getIniter();
    auto sym = global.getName().substr(1); // not prefix
    auto align = global.getAlign();

    if (initer.isZero()) {
        auto size = initer.getIniterType()->getBytes();
        ///@todo vectorize

        inner = make<MIRBssStorage>(sym, size, align);

    } else {
        std::vector<MIRStorage> datas{};

        // LAMBDA_BEGIN

        std::function<void(const IR::GVIniter &)> recursive;
        recursive = [&datas, &recursive](const IR::GVIniter &_initer) {
            if (_initer.isZero()) {
                auto size = _initer.getIniterType()->getBytes();
                MIRStorage zeroStore{
                    static_cast<size_t>(size)}; // remaid that this is a size value by using explicit cast

                datas.emplace_back(zeroStore);

                return; // no more recurse
            }

            if (!_initer.isArray()) {
                if (auto ci32 = _initer.getConstVal()->as<IR::ConstantInt>()) {
                    MIRStorage intStore{ci32->getVal()};
                    datas.emplace_back(intStore);
                } else if (auto cf32 = _initer.getConstVal()->as<IR::ConstantFloat>()) {
                    MIRStorage floatStore{cf32->getVal()};
                    datas.emplace_back(floatStore);
                } else {
                    Err::unreachable("loweringGlobal: unrecognized btype");
                }
            } else {

                for (const auto &_initer_nxt : _initer.getInnerIniter()) {
                    recursive(_initer_nxt);
                }
            }

            return;
        };

        auto isStoreZero = [](const std::vector<MIRStorage>::iterator &it) -> bool {
            const bool isZeroInt = it->isInt32() && (it->store<int>() == 0);
            const bool isZeroFloat = it->isFloat() && (it->store<float>() == 0.0f);
            const bool isSizeType = it->isSize();

            return isZeroInt || isZeroFloat || isSizeType;
        };

        auto merge = [](MIRStorage &pre, MIRStorage &nxt) {
            size_t new_size = pre.isSize() ? pre.store<size_t>() : 4LL;
            new_size += nxt.isSize() ? nxt.store<size_t>() : 4LL;
        };

        // LAMBDA_END

        recursive(initer);

        ///@note merge the neighbor sizeStores
        for (auto it = datas.begin(); it != datas.end() && std::next(it) != datas.end(); ++it) {
            if (isStoreZero(it) && isStoreZero(std::next(it))) {
                merge(*it, *std::next(it));
                datas.erase(std::next(it));
            }
        }

        ///@todo vectorize

        inner = make<MIRDataStorage>(sym, datas, align);
    }

    ret = make<MIRGlobal>(align, inner);
    return ret;
}

void MIR_new::loweringFunction(MIRFunction_p mfunc, IRFunc_p func, CodeGenContext &codeGenCtx, MIRModule &mModule,
                               std::map<string, MIRGlobal_p> globalMap) {

    std::map<IRBlk_p, MIRBlk_p> blkMap;
    std::map<IRVal_p, MIROperand_p> valMap;
    std::map<IRVal_p, MIROperand_p> storeMap;
    LoweringContext ctx(mModule, codeGenCtx, blkMap, globalMap, valMap);

    // target
    // layout

    // lower blks, deal with entry and exit
    for (auto &blk : func->getDFVisitor<Util::DFVOrder::ReversePostOrder>()) {
        auto mblk = make<MIRBlk>(mfunc->getmSym() + '_' + blk->getName().substr(1), mfunc);
        mfunc->blks().emplace_back(mblk);

        blkMap.emplace(blk, mblk);

        ///@note bkdv2.0 的经验是: lowering phi 时只 lowering def, use先存为ir形式
        ///@note 等 phiEli pass 时, 通过变量池 varpool 映射 ir op 到正确的 mir op
        ///@note 在lowering inst之前提前获取phiInst的def
        for (auto &inst : blk->getPhiInsts()) {
            ///@todo 记录blk_src, blk_dst, op_src, op_dst

            auto vreg = ctx.newVReg(inst->getType());
            ctx.addOperand(inst, vreg);
        }
    }

    // lowering blk succs, preds
    for (auto &blk : func->getDFVisitor<Util::DFVOrder::ReversePostOrder>()) {
        auto &mblk = blkMap.at(blk);

        for (auto &pred : blk->getPreBB()) {
            mblk->addPred(blkMap.at(pred));
        }
        for (auto &succ : blk->getNextBB()) {
            mblk->addSucc(blkMap.at(succ));
        }
    }

    auto entry = func->getBlocks().front();
    auto mblk = blkMap.at(entry);
    mfunc->setEntryBlk(mblk); // entry blk

    for (auto &blk : func->getExitBBs()) {
        auto mblk = blkMap.at(blk);
        mfunc->addExitBlk(mblk);
    }

    // solve pass-down args
    auto &margs = mfunc->Args();
    for (auto &arg : func->getParams()) {
        auto vreg = ctx.newVReg(arg->getType());
        ctx.addOperand(arg, vreg);
        margs.emplace_back(vreg);
    }

    // emit prologue
    ctx.setCurrentBlk(mfunc->blks().front()); // entry blk
    codeGenCtx.frameInfo.emitPrologue(mfunc, ctx);

    // deal with alloca
    /// @todo ctx.set...?
    for (auto &inst : func->getBlocks().front()->getInsts()) {
        if (auto alloca = inst->as<IR::ALLOCAInst>()) {
            // stk obj
            auto ptype = alloca->getType();
            auto stkobjStore =
                mfunc->addStkObj(codeGenCtx, ptype->getBytes(), alloca->getAlign(), 0, StkObjUsage::Local); // get vreg

            storeMap.emplace(inst, stkobjStore);

            ctx.addOperand(alloca, stkobjStore); // stkobjStore
        } else {
            break;
        }
    }

    // lower regular insts

    for (auto &blk : func->getDFVisitor<Util::DFVOrder::ReversePostOrder>()) {
        auto mblk = blkMap.at(blk);
        ctx.setCurrentBlk(mblk);
        for (auto &inst : blk->getAllInsts()) {
            MIR_new::lowerInst(inst, ctx);
        }
    }

    // phi eliminations

    for (auto &blk : func->getDFVisitor<Util::DFVOrder::ReversePostOrder>()) {
        auto mblk_dst = blkMap.at(blk);
        ctx.setCurrentBlk(mblk_dst);

        std::map<IR::pBlock, PhiOperPair> tmpBlkMap;
        for (auto &inst : blk->getPhiInsts()) {

            auto &def = valMap.at(inst);

            for (auto &use_phi : inst->getPhiOpers()) {
                auto &mblk_src = blkMap.at(use_phi.block);
                auto &use = valMap.at(use_phi.value);

                if (tmpBlkMap.count(use_phi.block)) {
                    tmpBlkMap.at(use_phi.block).pairs.emplace_back(def, use);
                } else {
                    tmpBlkMap.emplace(use_phi.block, PhiOperPair{mblk_dst, mblk_src, {}});
                    tmpBlkMap.at(use_phi.block).pairs.emplace_back(def, use);
                }
            }
        }

        for (auto &[blk, pair] : tmpBlkMap) {
            ctx.addPhiOpers(pair);
        }
    }

    ///@todo bug check
    ctx.emitPhi();
}

void MIR_new::lowerInst(IRInst_p inst, LoweringContext &ctx) {

    ///@todo maybe irgen can add select inst

    using OP = IR::OP;
    switch (inst->getOpcode()) {
    case OP::ALLOCA:
        break;
    case OP::PHI:
        break;
    case OP::ADD:
    case OP::SUB:
    case OP::MUL:
    case OP::AND:
    case OP::OR:
        // no xor no shift...
    case OP::FADD:
    case OP::FSUB:
    case OP::FMUL:
        MIR_new::lowerInst(inst->as<IR::BinaryInst>(), ctx);
        break;
    case OP::DIV:
    case OP::REM:
    case OP::FDIV:
    case OP::FREM:
        ///@todo predict range of numbers
        MIR_new::lowerInst(inst->as<IR::BinaryInst>(), ctx);
        break;
    case OP::FNEG:
        MIR_new::lowerInst(inst->as<IR::FNEGInst>(), ctx);
        break;
    case OP::ICMP:
        MIR_new::lowerInst(inst->as<IR::ICMPInst>(), ctx);
        break;
    case OP::FCMP:
        MIR_new::lowerInst(inst->as<IR::FCMPInst>(), ctx);
        break;
    case OP::RET:
        MIR_new::lowerInst(inst->as<IR::RETInst>(), ctx);
        break;
    case OP::BR:
        MIR_new::lowerInst(inst->as<IR::BRInst>(), ctx);
        break;
    case OP::LOAD:
        MIR_new::lowerInst(inst->as<IR::LOADInst>(), ctx, inst->as<IR::LOADInst>()->getAlign());
        break;
    case OP::STORE:
        MIR_new::lowerInst(inst->as<IR::STOREInst>(), ctx, inst->as<IR::STOREInst>()->getAlign());
        break;
    case OP::ZEXT:
    case OP::BITCAST:
    case OP::SITOFP:
    case OP::FPTOSI:
        MIR_new::lowerInst(inst->as<IR::CastInst>(), ctx);
        break;
    case OP::GEP:
        MIR_new::lowerInst(inst->as<IR::GEPInst>(), ctx);
        break;
    case OP::CALL:
        MIR_new::lowerInst(inst->as<IR::CALLInst>(), ctx);
        break;
    default:
        Err::unreachable("lowerInst: unrecognized IR::OP");
    }
}