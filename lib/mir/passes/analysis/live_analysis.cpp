#include "mir/passes/analysis/live_analysis.hpp"
#include "mir/instructions/branch.hpp"
#include <stack>

using namespace MIR;

PM::UniqueKey LiveAnalysis::Key;

std::list<OperP> LiveAnalysis::extractUse(const InstP &inst) {
    std::list<OperP> uses;

    ///@warning

    for (int i = 1; i < 5; ++i) {
        auto use = inst->getSourceOP(i);
        if (auto ptr = std::dynamic_pointer_cast<BaseADROP>(use)) {
            uses.emplace_back(ptr->getBase());
        }

        else if (std::dynamic_pointer_cast<BindOnVirOP>(use))
            uses.emplace_back(use);
    }

    return uses;
}

OperP LiveAnalysis::extractDef(const InstP &inst) {
    if (std::get<OpCode>(inst->getOpCode()) != OpCode::BL && std::get<OpCode>(inst->getOpCode()) != OpCode::BLX)
        // 30, 31
        return inst->getTargetOP();
    else { // function call
        auto &varpool = func->editInfo().getPool();
        auto call = std::dynamic_pointer_cast<branchInst>(inst);

        auto type = call->getRetValType();

        if (type == 0)
            return nullptr;
        else if (type == 1)
            return varpool.getValue(CoreRegister::r0);
        else if (type == 2)
            return varpool.getValue(FPURegister::s0);
        else {
            Err::unreachable("invalid ret type while live anaylsis");
            return nullptr; // just to make clang happy
        }
    }
}

std::unordered_set<OperP> LiveAnalysis::extractDef_v(const InstP &inst) {
    std::unordered_set<OperP> defs;

    Err::todo("extractDef_v todo...");

    return defs;
}

void LiveAnalysis::runOnFunc(Function *_func) {
    func = _func;

    ///@note 需要blks的逆dfs序
    ///@warning 我们必须假设第一个blk就是root
    const auto &blks = func->getBlocks();

    std::vector<BlkP> dfsSeqPost;
    std::set<BlkP> visited{*(blks.begin())};
    std::deque<std::pair<BlkP, bool>> s{{*(blks.begin()), false}};

    while (!s.empty()) {
        auto [curr, isProcessed] = s.back();
        s.pop_back();

        if (isProcessed)
            dfsSeqPost.emplace_back(curr);
        else {
            s.emplace_back(curr, true);
            const auto &children = curr->getSuccs();
            for (const auto &child : children) {
                if (visited.insert(child).second)
                    s.emplace_back(child, false);
            }
        }
    }

    ///@brief 遍历
    for (const auto &blk : dfsSeqPost) {
        for (auto &succ : blk->getSuccs()) {
            for (auto &livevar : liveinfo.liveIn[succ]) { // skip the end block
                ///@brief liveout of a blk
                liveinfo.liveOut[blk].insert(livevar);
            }
        }
        runOnBlk(blk);
    }
}

void LiveAnalysis::runOnBlk(const BlkP &blk) {
    std::map<InstP, std::unordered_set<OperP>> instLiveIn;  // tmp
    std::map<InstP, std::unordered_set<OperP>> instLiveOut; // tmp

    const auto &insts = blk->getInsts();

    instLiveOut[insts.back()] = liveinfo.liveOut[blk];

    for (auto it = insts.rbegin(); it != insts.rend(); ++it) {
        runOnInst(*it, instLiveIn[*it], instLiveOut[*it]);
        if (it != std::prev(insts.rend())) {
            instLiveOut[*std::next(it)] = instLiveIn[*it];
        }
    }

    ///@brief livein of a blk
    liveinfo.liveIn[blk] = instLiveIn[*(blk->getInsts().begin())];
}

void LiveAnalysis::runOnInst(const InstP &inst, std::unordered_set<OperP> &livein, std::unordered_set<OperP> &liveout) {

    if (std::dynamic_pointer_cast<NeonInstruction>(inst) == nullptr) {
        auto def = extractDef(inst);
        auto use = extractUse(inst);
        switch (std::get<OpCode>(inst->getOpCode())) {
        case OpCode::MOV:
        case OpCode::STR:
        case OpCode::LDR:
        case OpCode::NEG:
        case OpCode::ADD:
        case OpCode::SUB:
        case OpCode::RSB:
        case OpCode::ORR:
        case OpCode::AND:
        case OpCode::EOR:
        case OpCode::ORN:
        case OpCode::BIC:
        case OpCode::ASR:
        case OpCode::LSL:
        case OpCode::LSR:
        case OpCode::ROR:
        case OpCode::RRX:
        case OpCode::MUL:
        case OpCode::DIV:
        case OpCode::SDIV:
        case OpCode::MLA:
        case OpCode::MLS:
        case OpCode::SMULL:
        case OpCode::SMMUL:
        case OpCode::SMMLA:
        case OpCode::SMMLS:
        case OpCode::TST:
        case OpCode::TEQ:
        case OpCode::COPY:
        case OpCode::CMP:
        case OpCode::CMN:
        case OpCode::BL:  // $r0 or $s0
        case OpCode::BLX: // $r0 or $s0
            ///@todo 将use加到livein; 传递liveout; 记录interval range
            for (auto &use_op : use) {
                livein.insert(use_op); // add

                // interval range
                if (liveinfo.intervalLengths.find(use_op) == liveinfo.intervalLengths.end())
                    liveinfo.intervalLengths[use_op] = 1;
                else
                    ++liveinfo.intervalLengths[use_op];
            }

            for (auto &live_out : liveout) {
                if (live_out == def)
                    continue;
                livein.insert(live_out); // pass livein
            }
            break;
        case OpCode::PHI:
            Err::unreachable("no phi-inst expected in this pass");
            break;
        case OpCode::B:
        case OpCode::BX_RET:
        case OpCode::BX_SET_SWI:
        case OpCode::RET:
            ///@brief pass liveout to livein
            livein = liveout;
            break;
        default:
            Err::unreachable("instruction liveness encounter an unknown op: " +
                             enum_name(std::get<OpCode>(inst->getOpCode())));
        }

    } else {
        auto def = extractDef(inst);
        auto use = extractUse(inst);
        std::unordered_set<OperP> def_v;
        switch (std::get<NeonOpCode>(inst->getOpCode())) {
        case NeonOpCode::VMOV:
        case NeonOpCode::VSTR:
        case NeonOpCode::VLDR:
        case NeonOpCode::VSTX:
        case NeonOpCode::VLDX:
        case NeonOpCode::VADD:
        case NeonOpCode::VSUB:
        case NeonOpCode::VMUL:
        case NeonOpCode::VDIV:
        case NeonOpCode::VNEG:
        case NeonOpCode::VCVT:
            ///@todo 将use加到livein; 传递liveout; 记录interval range
            for (auto &use_op : use) {
                livein.insert(use_op); // add

                // interval range
                if (liveinfo.intervalLengths.find(use_op) == liveinfo.intervalLengths.end())
                    liveinfo.intervalLengths[use_op] = 1;
                else
                    ++liveinfo.intervalLengths[use_op];
            }

            for (auto &live_out : liveout) {
                if (live_out == def)
                    continue;
                livein.insert(live_out); // pass
            }
            break;
        case NeonOpCode::VADDV:
        case NeonOpCode::VMAXV:
        case NeonOpCode::VMINV:
            Err::todo("vertical instruction...");
            def_v = extractDef_v(inst);
            break;
        default:
            break;
        }
    }
}

Liveness LiveAnalysis::run(Function &f, FAM &fam) {
    liveinfo.clear();
    runOnFunc(&f);
    return liveinfo;
}
