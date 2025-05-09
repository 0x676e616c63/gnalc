#include "ir/instructions/binary.hpp"
#include "ir/instructions/converse.hpp"
#include "ir/instructions/memory.hpp"
#include "mir/passes/transforms/isel.hpp"
#include "mir/passes/transforms/lowering.hpp"
#include <forward_list>
#include <queue>

using namespace MIR_new;

OpC MIR_new::IROpCodeConvert(IR::OP op) {
    using OP = IR::OP;
    switch (op) {
    case OP::RET:
        Err::unreachable("IROpCodeConvert: RET should not be convert");
    case OP::ALLOCA:
        Err::unreachable("IROpCodeConvert: ALLOCA should not be convert");
    case OP::BR:
        return OpC::InstBranch;
    case OP::FNEG:
        return OpC::InstFNeg;
    case OP::ADD:
        return OpC::InstAdd;
    case OP::FADD:
        return OpC::InstFAdd;
    case OP::SUB:
        return OpC::InstSub;
    case OP::FSUB:
        return OpC::InstFSub;
    case OP::MUL:
        return OpC::InstMul;
    case OP::FMUL:
        return OpC::InstFMul;
    case OP::DIV:
        return OpC::InstSDiv;
    case OP::FDIV:
        return OpC::InstFDiv;
    case OP::REM:
        return OpC::InstSRem;
    case OP::FREM:
        return OpC::InstFRem;
    case OP::AND:
        return OpC::InstAnd;
    case OP::OR:
        return OpC::InstOr;
    case OP::LOAD:
        Err::unreachable("IROpCodeConvert: LOAD should not be convert");
    case OP::STORE:
        Err::unreachable("IROpCodeConvert: STORE should not be convert");
    case OP::GEP:
        Err::unreachable("IROpCodeConvert: GEP should not be convert");
    case OP::FPTOSI:
        return OpC::InstF2S;
    case OP::SITOFP:
        return OpC::InstS2F;
    case OP::ZEXT:
    case OP::BITCAST:
        return OpC::InstCopy;
    case OP::PHI:
        Err::unreachable("IROpCodeConvert: PHI should not be convert");
    case OP::HELPER:
        Err::unreachable("IROpCodeConvert: HELPER should not be convert");
    default:
        Err::unreachable("IROpCodeConvert: op should be handled manully");
    }

    return OpC::InstAdd; // just make clang happy
}

Cond MIR_new::IRCondConvert(IR::ICMPOP cond) {
    using ICMPOP = IR::ICMPOP;
    switch (cond) {
    case ICMPOP::eq:
        return EQ;
    case ICMPOP::ne:
        return NE;
    case ICMPOP::sge:
        return GE;
    case ICMPOP::sgt:
        return GT;
    case ICMPOP::sle:
        return LE;
    case ICMPOP::slt:
        return LT;
    }
}
Cond MIR_new::IRCondConvert(IR::FCMPOP cond) {
    using FCMPOP = IR::FCMPOP;
    switch (cond) {
    case FCMPOP::oeq:
        return EQ;
    case FCMPOP::oge:
        return GE;
    case FCMPOP::ogt:
        return GT;
    case FCMPOP::ole:
        return LE;
    case FCMPOP::olt:
        return LT;
    case FCMPOP::one:
        return NE;
    case FCMPOP::ord:
        Err::unreachable("IRCondConvert: ord unexpected");
    }
    return AL; // just make clang happy
}

void MIR_new::lowerInst(const IR::pBinary &binary, LoweringContext &ctx) {
    auto mop = MIR_new::IROpCodeConvert(binary->getOpcode());
    auto def = ctx.newVReg(binary->getType());

    ctx.newInst(MIRInst::make(mop)
                    ->setOperand<0>(def)
                    ->setOperand<1>(ctx.mapOperand(binary->getLHS()))
                    ->setOperand<2>(ctx.mapOperand(binary->getRHS())));

    ctx.addOperand(binary, def);
}

// void MIR_new::lowerInst(IR::pBinary binary, LoweringContext &ctx, IR::DomTreeAnalysis::Result &domTree,
//                         IR::LiveAnalysis::Result &liveRange) {
//     auto lhs = binary->getLHS();
//     auto rhs = binary->getRHS();

//     auto mop = MIR_new::IROpCodeConvert(binary->getOpcode());

//     auto def = ctx.newVReg(binary->getType());

//     ///@todo 通过Dom和liveRange, 分析被除数和除数的可能取值上限, 并加入到op3, op4

//     ctx.newInst(
//         MIRInst::make(mop)->setOperand<0>(def)->setOperand<1>(ctx.mapOperand(lhs))->setOperand<2>(ctx.mapOperand(rhs)));

//     ctx.addOperand(binary, def);
// }

void MIR_new::lowerInst(const IR::pFneg &fneg, LoweringContext &ctx) {
    auto def = ctx.newVReg(fneg->getType());

    ctx.newInst(MIRInst::make(OpC::InstFNeg)->setOperand<0>(def)->setOperand<1>(ctx.mapOperand(fneg->getVal())));

    ctx.addOperand(fneg, def);
}

void MIR_new::lowerInst(const IR::pIcmp &icmp, LoweringContext &ctx) {
    auto def = ctx.newVReg(icmp->getType());

    ctx.newInst(MIRInst::make(OpC::InstICmp)
                    ->setOperand<0>(nullptr)
                    ->setOperand<1>(ctx.mapOperand(icmp->getLHS()))
                    ->setOperand<2>(ctx.mapOperand(icmp->getRHS())));

    ctx.newInst(
        MIRInst::make(ARMOpC::CSET)->setOperand<0>(def)->setOperand<1>(ctx.mapOperand(IRCondConvert(icmp->getCond()))));

    ///@note condflag 加入到常量池

    ctx.addOperand(icmp, def);
}

void MIR_new::lowerInst(const IR::pFcmp &fcmp, LoweringContext &ctx) {
    auto def = ctx.newVReg(fcmp->getType());

    ctx.newInst(MIRInst::make(OpC::InstFCmp)
                    ->setOperand<0>(nullptr)
                    ->setOperand<1>(ctx.mapOperand(fcmp->getLHS()))
                    ->setOperand<2>(ctx.mapOperand(fcmp->getRHS())));

    ctx.newInst(
        MIRInst::make(ARMOpC::CSET)->setOperand<0>(def)->setOperand<1>(ctx.mapOperand(IRCondConvert(fcmp->getCond()))));

    ctx.addOperand(fcmp, def);
}

void MIR_new::lowerInst(const IR::pRet &ret, LoweringContext &ctx) {
    ctx.CodeGenCtx().frameInfo.makeReturn(ret, ctx); //
}

void MIR_new::lowerInst(const IR::pBr &br, LoweringContext &ctx) {

    // auto blk_src = ctx.CurrentBlk();

    // LAMBDA BEGIN

    const auto emitBranch = [&]() {
        auto blk_true = ctx.mapBlk(br->getDest());
        // auto use = ctx.mapOperand(br->getCond());

        ctx.newInst(MIRInst::make(OpC::InstBranch)
                        ->setOperand<0>(nullptr)
                        ->setOperand<1>(MIROperand::asReloc(blk_true))
                        ->setOperand<2>(ctx.mapOperand(AL))
                        ->setOperand<3>(MIROperand::asProb(1.0)));
    };

    const auto emitBranchCond = [&]() {
        // cmp/fcmp (previously lowered)
        // CSET <reg>, <cond> ; int or float
        // ... (in most casese, flag dont change, but be aware)
        // CBNZ w<>, label

        auto blk_true = ctx.mapBlk(br->getTrueDest());
        auto blk_false = ctx.mapBlk(br->getFalseDest());
        auto use = ctx.mapOperand(br->getCond()); // val or const

        if (auto const_cond = br->getCond()->as<IR::ConstantI1>()) {

            ctx.newInst(MIRInst::make(OpC::InstBranch)
                            ->setOperand<0>(nullptr)
                            ->setOperand<1>(MIROperand::asReloc(const_cond->getVal() ? blk_true : blk_false))
                            ->setOperand<2>(ctx.mapOperand(AL))
                            ->setOperand<3>(MIROperand::asProb(1.0)));
        }

        else if (use && !use->isImme()) {
            ctx.newInst(MIRInst::make(ARMOpC::CBNZ)
                            ->setOperand<0>(nullptr)
                            ->setOperand<1>(use)
                            ->setOperand<2>(MIROperand::asReloc(blk_true))
                            ->setOperand<3>(MIROperand::asProb(0.5)));

            ctx.newInst(MIRInst::make(OpC::InstBranch)
                            ->setOperand<0>(nullptr)
                            ->setOperand<1>(MIROperand::asReloc(blk_false))
                            ->setOperand<2>(ctx.mapOperand(AL))
                            ->setOperand<3>(MIROperand::asProb(0.5)));
        } ///@note blk op 不放入变量池
    };

    ///@todo 分支概率预测 T/F, 现阶段所有分支概率均为0.5

    // LAMBDA END

    if (br->isConditional()) {
        emitBranchCond();
    } else {
        emitBranch();
    }
}

void MIR_new::lowerInst(const IR::pLoad &load, LoweringContext &ctx, size_t size) {
    auto def = ctx.newVReg(load->getType());

    ctx.newInst(MIRInst::make(OpC::InstLoad)
                    ->setOperand<0>(def)
                    ->setOperand<1>(ctx.mapOperand(load->getPtr())) // ptr or stkptr
                    // ->setOpernand<2> idx or imme
                    // ->setOperand<3> shift code
                    ->setOperand<4>(MIROperand::asImme(size, OpT::special)));

    ctx.addOperand(load, def);
}

void MIR_new::lowerInst(const IR::pStore &store, LoweringContext &ctx, size_t size) {
    ctx.newInst(MIRInst::make(OpC::InstStore)
                    ->setOperand<0>(nullptr)
                    ->setOperand<1>(ctx.mapOperand(store->getValue()))
                    ->setOperand<2>(ctx.mapOperand(store->getPtr()))
                    // ->setOpernand<3> idx or imme
                    // ->setOperand<4> shift code
                    ->setOperand<5>(MIROperand::asImme(size, OpT::special)));
}

void MIR_new::lowerInst(const IR::pCast &cast, LoweringContext &ctx) {
    auto def = ctx.newVReg(cast->getType());

    ///@note ctx.mapOperand(cast->getOVal()) may get a stk op
    ctx.addCopy(def, ctx.mapOperand(cast->getOVal()));

    ctx.addOperand(cast, def);
}

void MIR_new::lowerInst(const IR::pGep &gep, LoweringContext &ctx) {
    auto def_ptr = ctx.newVReg(gep->getType());

    auto idx = gep->getIdxs().back();
    int persize;
    if (auto arrayType = gep->getBaseType()->as<IR::ArrayType>()) {
        persize = arrayType->getElmType()->getBytes();
    } else if (auto ptrType = gep->getBaseType()->as<IR::PtrType>()) {
        persize = ptrType->getElmType()->getBytes();
    } else if (auto bType = gep->getBaseType()->as<IR::BType>()) {
        persize = bType->getBytes();
    } else {
        Err::unreachable("lowerInst(IR::pGep, LoweringContext &): unknown base type");
    }

    auto base = gep->getPtr();

    if (auto idx_const = idx->as<IR::ConstantInt>()) {
        auto offset = persize * idx_const->getVal();
        auto use_ptr = ctx.mapOperand(base);

        if (use_ptr->isStack()) {
            ctx.newInst(MIRInst::make(OpC::InstAddSP)
                            ->setOperand<0>(def_ptr)
                            ->setOperand<1>(use_ptr)
                            ->setOperand<2>(ctx.mapOperand<int>(offset)));
        } else if (offset) {
            ctx.newInst(MIRInst::make(OpC::InstAdd)
                            ->setOperand<0>(def_ptr)
                            ->setOperand<1>(use_ptr)
                            ->setOperand<2>(ctx.mapOperand<int>(offset)));
        } else {
            ctx.addCopy(def_ptr, use_ptr);
        }

    } else {
        auto moffset = ctx.newVReg(OpT::Int64); // dont allow add x<>, x<>, w<>
        ctx.newInst(MIRInst::make(OpC::InstMul)
                        ->setOperand<0>(moffset)
                        ->setOperand<1>(ctx.mapOperand(idx))
                        ->setOperand<2>(ctx.mapOperand<int>(persize)));

        auto use_ptr = ctx.mapOperand(base);

        if (use_ptr->isStack()) {
            ctx.newInst(
                MIRInst::make(OpC::InstAddSP)->setOperand<0>(def_ptr)->setOperand<1>(use_ptr)->setOperand<2>(moffset));
        } else {
            ctx.newInst(
                MIRInst::make(OpC::InstAdd)->setOperand<0>(def_ptr)->setOperand<1>(use_ptr)->setOperand<2>(moffset));
        }
    }

    ctx.addOperand(gep, def_ptr);
}

void MIR_new::lowerInst(const IR::pCall &call, LoweringContext &ctx) {
    ctx.CodeGenCtx().frameInfo.handleCallEntry(call, ctx); //
}

void LoweringContext::elimPhi() {
    auto &ctx = *this; // 虽然有点怪

    // LAMBDA_BEGIN

    auto emitPhiCopy = [&ctx](MIROperand_p dst, MIROperand_p src, MIRBlk_p pred) {
        auto succ = ctx.CurrentBlk();
        ctx.setCurrentBlk(pred);

        // src maybe a constant
        ctx.addInstBeforeBr(MIRInst::make(chooseCopyOpC(dst, src))->setOperand<0>(dst)->setOperand<1>(src));

        ctx.setCurrentBlk(succ);

        return;
    };

    auto addCopy = [&ctx, &emitPhiCopy](MIROperand_p dst, MIRBlk_p pred) -> MIROperand_p {
        auto stageVal = ctx.newVReg(dst->type());

        emitPhiCopy(stageVal, dst, pred); // very carefully

        return stageVal;
    };

    // LAMBDA_END

    struct Node {
        // 从目的寄存器指向源寄存器
        std::forward_list<unsigned> nxt;
        unsigned indegree = 0;
    };

    for (auto &phiOper : phiOpers) {
        auto &mblk_succ = phiOper.blk_dst;
        auto &mblk_pred = phiOper.blk_src;
        auto &pairs = phiOper.pairs;

        auto len = pairs.size();
        std::map<MIROperand_p, unsigned> mapping; // ptr to idx
        std::vector<Node> graph(pairs.size());

        for (int i = 0; i < len; ++i) {
            mapping[pairs[i].second] = i; // .first or .second
        }

        for (int i = 0; i < len; ++i) {
            if (mapping.find(pairs[i].first) != mapping.end()) {
                unsigned src = i;
                auto dst = mapping[pairs[i].first];

                graph[dst].nxt.emplace_front(src);
                ++graph[src].indegree;
            }
        }

        std::queue<unsigned> queue;
        for (int i = 0; i < len; ++i) {
            if (graph[i].indegree == 0) {
                queue.push(i);
            }
        }

        std::map<MIROperand_p, MIROperand_p> stagedMap;

        ///@note break critical edge here, ir already done

        auto emitBlk = mblk_pred;

        for (int i = 0, j = 0; i < len;) {
            // LAMBDA BEGIN

            auto visit = [&](unsigned idx) {
                ///@note 遍历src
                ++i;

                auto &pair = pairs[idx];
                auto dst = pair.first;
                auto src = pair.second;

                if (stagedMap.count(src)) {
                    src = stagedMap.at(src);
                }

                if (graph.at(idx).indegree) {
                    ///@note 可能会出现一种比较极端的情况, %0 = phi [... ...], ..., [%0, ...]
                    ///@note 理论上由于单赋值, 所以不需要做什么, 但是算法会还是会插入一个stage, 以及一个冗余的copy
                    Err::gassert(graph.at(idx).indegree == 1, "elimPhi::visit: indegree must be 1 here");
                    Logger::logDebug("elimPhi::visit: need a stage by %" + std::to_string(dst->reg()));

                    graph[idx].indegree = 0;
                    auto stagedVal = addCopy(dst, mblk_pred);
                    stagedMap[dst] = stagedVal;
                }

                emitPhiCopy(dst, src, mblk_pred);

                auto &node = graph[idx];
                for (auto nxt : node.nxt) {
                    auto &nxt_node = graph[nxt];
                    Err::gassert(nxt_node.indegree == 1, "elimPhi: src op is not 1 indegree");
                    --nxt_node.indegree;
                    if (nxt_node.indegree == 0) {
                        queue.push(nxt);
                    }
                }
            };

            // LAMBDA END

            ///@brief topo sorted
            while (!queue.empty()) {
                unsigned cur = queue.front();
                queue.pop();
                visit(cur);
            }

            if (i >= len) {
                Err::gassert(i == len, "you visit too much");
                break;
            }

            for (; j < len; ++j) {
                if (graph[j].indegree) {
                    visit(j);
                    if (!queue.empty()) {
                        break;
                    }
                }
            }
        }
    }
}