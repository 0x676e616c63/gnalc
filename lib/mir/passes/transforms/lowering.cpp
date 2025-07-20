// Copyright (c) 2025 0x676e616c63
// SPDX-License-Identifier: MIT

#include "mir/passes/transforms/lowering.hpp"
#include "ir/function.hpp"
#include "ir/instructions/binary.hpp"
#include "ir/instructions/control.hpp"
#include "ir/instructions/converse.hpp"
#include "ir/instructions/memory.hpp"
#include "ir/instructions/phi.hpp"
#include "ir/instructions/vector.hpp"
#include "ir/type.hpp"
#include "mir/MIR.hpp"
#include "mir/info.hpp"
#include "mir/passes/transforms/isel.hpp"
#include "utils/exception.hpp"
#include <algorithm>
#include <utility>

using namespace MIR;

LoweringContext::LoweringContext(MIRModule &module, CodeGenContext &codeGenCtx, std::map<IRBlk_p, MIRBlk_p> &blkMap,
                                 std::map<string, MIRGlobal_p> &globalMap,
                                 std::map<IRVal_p, MIROperand_p> &valMap) noexcept
    : mModule(module), mCodeGenCtx(codeGenCtx), mBlkMap(blkMap), mGlobalMap(globalMap), mValMap(valMap) {
    mPtrType = OpT::Int64;
}

OpT MIR::btypeConvert(const IR::BType &type) {
    switch (type.getInner()) {
    case IR::IRBTYPE::I1:
    case IR::IRBTYPE::I8:
    case IR::IRBTYPE::I32:
        return OpT::Int32;
    case IR::IRBTYPE::I64:
        return OpT::Int64;
    case IR::IRBTYPE::FLOAT:
        return OpT::Float32;
    case IR::IRBTYPE::I128:
        Err::todo("int128 todo...");
    default:
        Err::unreachable("btypeConvert: try convert invalid btype");
    }
    return OpT::Int; // just to make clang happy
}

unsigned MIR::typeBitwide(const IR::pType &type) {
    if (auto btype = type->as<IR::BType>()) {

        if (btype->getInner() == IR::IRBTYPE::I1)
            return 1;
        else if (btype->getInner() == IR::IRBTYPE::I8)
            return 1;
        else if (btype->getInner() == IR::IRBTYPE::I32)
            return 4;
        else if (btype->getInner() == IR::IRBTYPE::I64)
            return 8;
        else if (btype->getInner() == IR::IRBTYPE::I128)
            Err::todo("typeBitwide: i128 todo...");
        else if (btype->getInner() == IR::IRBTYPE::FLOAT)
            return 4;
        else
            Err::unreachable("typeBitwide: unknown btype");

    } else if (auto ptrtype = type->as<IR::PtrType>()) {
        return 8;
    } else if (auto vectype = type->as<IR::VectorType>()) {
        switch (vectype->getVectorSize()) {
        case 2:
            return 8;
        case 3:
            return 12;
        case 4:
            return 16;
        }
    } else if (auto arraytype = type->as<IR::ArrayType>()) {
        Err::unreachable("typeBitwide: array type not supported");
    }
    return 8; // just make clang happy
}

MIRBlk_p LoweringContext::mapBlk(const IRBlk_p &blk) const { return mBlkMap.at(blk); }

MIRGlobal_p LoweringContext::mapGlobal(const string &global) const { return mGlobalMap.at(global); }

MIROperand_p LoweringContext::mapOperand(const IRVal_p &value) {
    if (value->getVTrait() == IR::ValueTrait::ORDINARY_VARIABLE ||
        value->getVTrait() == IR::ValueTrait::FORMAL_PARAMETER) {

        // get from mValMap
        return mValMap.at(value);

    } else if (value->getVTrait() == IR::ValueTrait::CONSTANT_LITERAL) {

        // get from mConstantMap
        if (auto ci32 = value->as<IR::ConstantInt>()) {

            auto imme = ci32->getVal();
            return mapOperand(imme);
        } else if (auto ci64 = value->as<IR::ConstantI64>()) {
            auto imme = ci64->getVal();
            return mapOperand(imme);
        } else if (auto ci128 = value->as<IR::ConstantI128>()) {
            Err::todo("ci128 lower todo...");
        }
        ///@note extent i1, i8 const to i32
        else if (auto ci1 = value->as<IR::ConstantI1>()) {

            auto imme = static_cast<int>(ci1->getVal());
            return mapOperand(imme);
        } else if (auto ci8 = value->as<IR::ConstantI8>()) {

            auto imme = static_cast<int>(ci8->getVal());
            return mapOperand(imme);
        } else if (auto cf32 = value->as<IR::ConstantFloat>()) {

            auto imme = cf32->getVal();

            return mapOperand(imme);
        }

    } else if (auto value_glo = value->as<IR::GlobalVariable>()) {
        if (mCodeGenCtx.isARMv8()) {

            auto mReloc = mGlobalMap.at(value_glo->getName());

            auto mglo = MIROperand::asVReg(mCodeGenCtx.nextId(), OpT::Int64);

            newInst(MIRInst::make(ARMOpC::ADRP_LDR)
                        ->setOperand<0>(mglo, mCodeGenCtx)
                        ->setOperand<1>(MIROperand::asReloc(mReloc->reloc()), mCodeGenCtx));

            return mglo;
        } else if (mCodeGenCtx.isRISCV64()) {
            auto mReloc = mGlobalMap.at(value_glo->getName());
            auto mglo = MIROperand::asVReg(mCodeGenCtx.nextId(), OpT::Int64);
            newInst(MIRInst::make(RVOpC::LA)
                        ->setOperand<0>(mglo, mCodeGenCtx)
                        ->setOperand<1>(MIROperand::asReloc(mReloc->reloc()), mCodeGenCtx));

            return mglo;
        } else
            Err::unreachable("Unsupported arch");
    } else if (auto func_ptr = value->as<IR::Function>()) {
        MIRGlobal_p mReloc;
        if (!mGlobalMap.count(func_ptr->getName())) {
            mReloc = make<MIRGlobal>(4, make<MIRReloc>(func_ptr->getName()));
            mGlobalMap.emplace(func_ptr->getName(), mReloc);
        } else {
            mReloc = mGlobalMap.at(func_ptr->getName());
        }

        auto mglo = MIROperand::asVReg(mCodeGenCtx.nextId(), OpT::Int64);
        newInst(MIRInst::make(OpC::InstLoadAddress)
                    ->setOperand<0>(mglo, mCodeGenCtx)
                    ->setOperand<1>(MIROperand::asReloc(mReloc->reloc()), mCodeGenCtx));

        return mglo;
    }

    Err::unreachable();
}

MIROperand_p LoweringContext::newVReg(const std::shared_ptr<IR::Type> &type) {
    switch (type->getTrait()) {
    case IR::IRCTYPE::ARRAY:
        return newVReg(*(type->as<IR::ArrayType>()));
    case IR::IRCTYPE::BASIC:
        return newVReg(*(type->as<IR::BType>()));
    case IR::IRCTYPE::PTR:
        return newVReg(*(type->as<IR::PtrType>()));
    case IR::IRCTYPE::VECTOR:
        return newVReg(*(type->as<IR::VectorType>()));
    default:
        Err::todo("LoweringContext::newVReg: vec and func");
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

    switch (type.getElmType()->getTrait()) {
    case IR::IRCTYPE::BASIC:
        switch (type.getElmType()->as<IR::BType>()->getInner()) {
        case IR::IRBTYPE::I1:
        case IR::IRBTYPE::I8:
        case IR::IRBTYPE::I32:
            switch (type.getVectorSize()) {
            case 4:
                return MIROperand::asVReg(mCodeGenCtx.nextId(), OpT::Intvec4);
            case 3:
                return MIROperand::asVReg(mCodeGenCtx.nextId(), OpT::Intvec3);
            case 2:
                return MIROperand::asVReg(mCodeGenCtx.nextId(), OpT::Intvec2);
            }
            break;
        case IR::IRBTYPE::I64:
            return MIROperand::asVReg(mCodeGenCtx.nextId(), OpT::Int64vec2);
            break;
        case IR::IRBTYPE::FLOAT:
            switch (type.getVectorSize()) {
            case 4:
                return MIROperand::asVReg(mCodeGenCtx.nextId(), OpT::Floatvec4);
            case 3:
                return MIROperand::asVReg(mCodeGenCtx.nextId(), OpT::Floatvec3);
            case 2:
                return MIROperand::asVReg(mCodeGenCtx.nextId(), OpT::Floatvec2);
            }
            break;
        // case IR::IRBTYPE::I128:
        default:
            Err::unreachable("newVReg: unknown vector inner btype");
        }
    case IR::IRCTYPE::PTR:
        return MIROperand::asVReg(mCodeGenCtx.nextId(), OpT::Int64vec2);
    default:
        Err::unreachable("newVReg: unknown vector inner type");
    }
}

MIROperand_p LoweringContext::newVReg(const OpT &type) {
    return MIROperand::asVReg(mCodeGenCtx.nextId(), type); //
}

MIROperand_p LoweringContext::newLiteral(string liter, size_t size, size_t align) {
    mCurrentBlk->add_tail_literal(size, align);
    return MIROperand::asLiteral(std::move(liter));
}

void LoweringContext::newInst(const MIRInst_p &inst) {
    auto &insts = mCurrentBlk->Insts();
    insts.emplace_back(inst);
}

void LoweringContext::addCopy(const MIROperand_p &dst, const MIROperand_p &src) {
    auto inst = MIRInst::make(chooseCopyOpC(dst, src));
    inst->setOperand<0>(dst, mCodeGenCtx);
    inst->setOperand<1>(src, mCodeGenCtx);

    newInst(inst);
}

void LoweringContext::addInstBeforeBr(const MIRInst_p_l &inst) { // insts ?
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

    Err::gassert(insert_it != insts.end(), "addInstBeforeBr: cant find a branch inst");

    insts.insert(insert_it, inst.begin(), inst.end());
}

void LoweringContext::addInstBeforeBr(const MIRInst_p &inst) {

    auto &mblk = mCurrentBlk;
    auto &insts = mblk->Insts();

    auto insert_it = insts.end();
    for (auto it = insts.begin(); it != insts.end(); ++it) {
        if (it->get()->isGeneric() && it->get()->opcode<OpC>() == OpC::InstBranch) {
            insert_it = it;
            break;
        }
    }

    Err::gassert(insert_it != insts.end(), "addInstBeforeBr: cant find a branch inst");

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
MIRModule_p MIR::loweringModule(const IRModule &module, CodeGenContext &ctx) {
    std::map<string, MIRGlobal_p> globalMap;

    const auto &layout = ctx.infos.dataLayout;

    auto mModule = make<MIRModule>(ctx.infos, ctx, module.getName(), module.getRuntimeTypes());

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
        auto mglo = MIR::loweringGlobal(*globalval);
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

MIRGlobal_p MIR::loweringGlobal(const IR::GlobalVariable &global) {
    MIRGlobal_p ret = nullptr;
    MIRReloc_p inner = nullptr;
    const auto &initer = global.getIniter();
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
                    static_cast<size_t>(size)}; // note that this is a size value by using explicit cast

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

            pre.mstore = new_size; // .zero ...
        };

        // LAMBDA_END

        recursive(initer);

        ///@note merge the neighbor sizeStores
        for (auto it = datas.begin(); it != datas.end() && std::next(it) != datas.end();) {
            if (isStoreZero(it) && isStoreZero(std::next(it))) {
                merge(*it, *std::next(it));
                datas.erase(std::next(it));
            } else {
                ++it;
            }
        }

        ///@todo vectorize

        inner = make<MIRDataStorage>(sym, datas, align);
    }

    ret = make<MIRGlobal>(align, inner);
    return ret;
}

void MIR::loweringFunction(MIRFunction_p mfunc, IRFunc_p func, CodeGenContext &codeGenCtx, MIRModule &mModule,
                           std::map<string, MIRGlobal_p> globalMap) {

    std::map<IRBlk_p, MIRBlk_p> blkMap;
    std::map<IRVal_p, MIROperand_p> valMap;
    std::map<IRVal_p, MIROperand_p> storeMap;
    LoweringContext ctx(mModule, codeGenCtx, blkMap, globalMap, valMap);

    // lower blks, deal with entry and exit
    for (auto &blk : func->getDFVisitor<Util::DFVOrder::ReversePostOrder>()) {
        auto mblk = make<MIRBlk>(mfunc->getmSym() + '_' + blk->getName().substr(1), mfunc);
        mfunc->blks().emplace_back(mblk);

        blkMap.emplace(blk, mblk);

        for (auto &inst : blk->getPhiInsts()) {

            auto vreg = ctx.newVReg(inst->getType());
            ctx.addOperand(inst, vreg);
        }
    }

    // lowering blk succs, preds(...)
    auto blks = func->getDFVisitor<Util::DFVOrder::ReversePostOrder>();
    for (auto it = blks.begin(); it != blks.end(); ++it) {
        auto &blk = *it;
        auto &mblk = blkMap.at(blk);

        for (auto &pred : blk->getPreBB()) {
            mblk->addPred(blkMap.at(pred));
        }
        for (auto &succ : blk->getNextBB()) {
            mblk->addSucc(blkMap.at(succ));
        }

        if (blks.size() > 1) {
            auto mprv = it != blks.begin() ? blkMap.at(*std::prev(it)) : nullptr;
            auto mnxt = it != std::prev(blks.end()) ? blkMap.at(*std::next(it)) : nullptr;

            mblk->resetPrv(mprv);
            mblk->resetNxt(mnxt);
        }
    }

    auto entry = func->getBlocks().front();
    auto entry_blk = blkMap.at(entry);
    mfunc->setEntryBlk(entry_blk); // entry blk

    for (auto &blk : func->getExitBBs()) {
        const auto &mblk = blkMap.at(blk);
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
    codeGenCtx.frameInfo->makePrologue(mfunc, ctx);

    // deal with alloca
    for (auto &inst : func->getBlocks().front()->getInsts()) {
        if (auto alloca = inst->as<IR::ALLOCAInst>()) {
            // stk obj
            auto ptype = alloca->getBaseType(); // basetype not getType
            auto stkobjStore = mfunc->addStkObj(codeGenCtx, ptype->getBytes(), alloca->getAlign(), 0,
                                                StkObjUsage::Local); // get vreg

            storeMap.emplace(alloca, stkobjStore);

            ctx.addOperand(alloca, stkobjStore); // stkobjStore
        } else {
            break;
        }
    }

    // lower regular insts
    for (auto &blk : func->getDFVisitor<Util::DFVOrder::ReversePostOrder>()) {
        const auto &mblk = blkMap.at(blk);
        ctx.setCurrentBlk(mblk);
        for (auto &inst : blk->getAllInsts()) {
            MIR::lowerInst(inst, ctx);
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

                MIR::MIROperand_p use;
                if (valMap.count(use_phi.value)) {
                    use = valMap.at(use_phi.value);
                } else {
                    auto &phiop = use_phi.value;
                    Err::gassert(phiop->getVTrait() == IR::ValueTrait::CONSTANT_LITERAL,
                                 "lowerFunc: cant map a phi op");
                    ///@todo vectorize
                    if (auto ci1 = phiop->as<IR::ConstantI1>()) {
                        use = MIROperand::asImme(ci1->getVal(), OpT::Int32);
                    } else if (auto ci8 = phiop->as<IR::ConstantI8>()) {
                        use = MIROperand::asImme(ci8->getVal(), OpT::Int32);
                    } else if (auto ci32 = phiop->as<IR::ConstantInt>()) {
                        use = MIROperand::asImme(ci32->getVal(), OpT::Int32);
                    } else if (auto f32 = phiop->as<IR::ConstantFloat>()) {
                        use = MIROperand::asImme(f32->getVal(), OpT::Float32);
                    } else {
                        Err::unreachable("unexpected phiop type");
                    }
                }
                Err::gassert(use != nullptr, "dont actually get a use");

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
    ctx.elimPhi();
}

void MIR::lowerInst(const IRInst_p &inst, LoweringContext &ctx) {

    if (auto store = inst->as<IR::STOREInst>(); (store && store->getValue()->getType()->is<IR::VectorType>())) {
        lowerInst_v(inst, ctx);
        return;
    } else if (inst->getType()->is<IR::VectorType>()) {
        lowerInst_v(inst, ctx);
        return;
    } else if (auto extract = inst->as<IR::EXTRACTInst>()) {
        lowerInst_v(inst, ctx);
        return;
    }

    using OP = IR::OP;
    switch (inst->getOpcode()) {
    case OP::ALLOCA:
        // dont touch this
        break;
    case OP::PHI:
        // dont touch this
        break;
    case OP::ADD:
    case OP::SUB:
    case OP::MUL:
    case OP::AND:
    case OP::OR:
    case OP::XOR:
    case OP::ASHR:
    case OP::LSHR:
    case OP::SHL:
    case OP::FADD:
    case OP::FSUB:
    case OP::FMUL:
        MIR::lowerInst(inst->as<IR::BinaryInst>(), ctx);
        break;
    case OP::DIV:
    case OP::SREM:
    case OP::UREM:
    case OP::FDIV:
    case OP::FREM:
        ///@todo predict range of numbers
        MIR::lowerInst(inst->as<IR::BinaryInst>(), ctx);
        break;
    case OP::FNEG:
        MIR::lowerInst(inst->as<IR::FNEGInst>(), ctx);
        break;
    case OP::ICMP:
        MIR::lowerInst(inst->as<IR::ICMPInst>(), ctx);
        break;
    case OP::FCMP:
        MIR::lowerInst(inst->as<IR::FCMPInst>(), ctx);
        break;
    case OP::RET:
        MIR::lowerInst(inst->as<IR::RETInst>(), ctx);
        break;
    case OP::BR:
        MIR::lowerInst(inst->as<IR::BRInst>(), ctx);
        break;
    case OP::LOAD:
        MIR::lowerInst(inst->as<IR::LOADInst>(), ctx, inst->as<IR::LOADInst>()->getAlign());
        break;
    case OP::STORE:
        MIR::lowerInst(inst->as<IR::STOREInst>(), ctx, inst->as<IR::STOREInst>()->getAlign());
        break;
    case OP::ZEXT:
    case OP::BITCAST:
    case OP::SITOFP:
    case OP::FPTOSI:
    case OP::PTRTOINT:
    case OP::INTTOPTR:
        MIR::lowerInst(inst->as<IR::CastInst>(), ctx);
        break;
    case OP::GEP:
        MIR::lowerInst(inst->as<IR::GEPInst>(), ctx);
        break;
    case OP::CALL:
        MIR::lowerInst(inst->as<IR::CALLInst>(), ctx);
        break;
    case OP::SELECT:
        MIR::lowerInst(inst->as<IR::SELECTInst>(), ctx);
        break;
    default:
        Err::unreachable("lowerInst: unrecognized IR::OP");
    }
}

void MIR::lowerInst_v(const IRInst_p &inst, LoweringContext &ctx) {
    using OP = IR::OP;
    switch (inst->getOpcode()) {
    case OP::ALLOCA:
    case OP::PHI:
        // dont touch this
        break;
    case OP::INSERT:
        MIR::lowerInst_v(inst->as<IR::INSERTInst>(), ctx);
        break;
    case OP::EXTRACT:
        MIR::lowerInst_v(inst->as<IR::EXTRACTInst>(), ctx);
        break;
    case OP::ADD:
    case OP::SUB:
    case OP::MUL:
    case OP::AND:
    case OP::OR:
    case OP::XOR:
    case OP::ASHR:
    case OP::LSHR:
    case OP::SHL:
    case OP::FADD:
    case OP::FSUB:
    case OP::FMUL:
        MIR::lowerInst_v(inst->as<IR::BinaryInst>(), ctx);
        break;
    case OP::DIV:
    case OP::SREM:
    case OP::UREM:
    case OP::FDIV:
    case OP::FREM:
        ///@todo predict range of numbers
        MIR::lowerInst_v(inst->as<IR::BinaryInst>(), ctx);
        break;
    case OP::FNEG:
        MIR::lowerInst_v(inst->as<IR::FNEGInst>(), ctx);
        break;
    case OP::ICMP:
        MIR::lowerInst_v(inst->as<IR::ICMPInst>(), ctx);
        break;
    case OP::FCMP:
        MIR::lowerInst_v(inst->as<IR::FCMPInst>(), ctx);
        break;
    case OP::LOAD:
        MIR::lowerInst_v(inst->as<IR::LOADInst>(), ctx);
        break;
    case OP::STORE:
        MIR::lowerInst_v(inst->as<IR::STOREInst>(), ctx);
        break;
    case OP::ZEXT:
    case OP::BITCAST:
    case OP::SITOFP:
    case OP::FPTOSI:
        MIR::lowerInst_v(inst->as<IR::CastInst>(), ctx);
        break;
    case OP::GEP:
        MIR::lowerInst_v(inst->as<IR::GEPInst>(), ctx);
        break;
    case OP::SELECT:
        MIR::lowerInst(inst->as<IR::SELECTInst>(), ctx);
        break;
    default:
        Err::unreachable("lowerInst: unrecognized IR::OP");
    }
}