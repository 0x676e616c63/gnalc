#include "../../../../include/mir/passes/analysis/live_analysis.hpp"
#include <stack>

using namespace MIR;

std::list<OperP> extractUse(const InstP &inst) {
    std::list<OperP> uses;

    for (int i = 1; i < 5; ++i) {
        auto use = inst->getSourceOP(i);
        if (std::dynamic_pointer_cast<BindOnVirOP>(use))
            uses.emplace_back(use);
    }

    return uses;
}

OperP extractDef(const InstP &inst) { return inst->getTargetOP(); }

std::unordered_set<OperP> extractDef_v(const InstP &inst) {
    std::unordered_set<OperP> defs;

    Err::todo("extractDef_v todo...");

    return defs;
}

void LiveAnalysis::runOnFunc(Function *_func) {
    func = _func;

    ///@note 需要blks的dfs序
    std::vector<BlkP> dfsSeq;
    std::set<BlkP> visited;
    std::stack<BlkP> s;

    ///@warning 我们必须假设第一个blk是root
    const auto root_blk = *(func->getBlocks().begin());

    s.push(root_blk);

    while (!s.empty()) {
        auto curr = s.top();
        s.pop();
        visited.insert(curr);

        dfsSeq.push_back(curr);

        for (const auto &child : curr->getSuccs()) {
            if (visited.find(child) == visited.end())
                s.push(child);
        }
    }

    ///@brief 遍历
    for (const auto &blk : dfsSeq) {
        for (auto &succ : blk->getSuccs()) {
            for (auto &livevar : liveinfo.liveIn[succ]) {
                liveinfo.liveOut[blk].insert(livevar);
            }
        }

        runOnBlk(blk);
    }
}

void LiveAnalysis::runOnBlk(const BlkP &blk) {
    std::map<InstP, std::unordered_set<OperP>> instLiveIn;
    std::map<InstP, std::unordered_set<OperP>> instLiveOut;

    const auto &insts = blk->getInsts();

    instLiveOut[insts.back()] = liveinfo.liveOut[blk];

    for (auto it = insts.rbegin(); it != insts.rend(); ++it) {
        runOnInst(*it, instLiveIn[*it], instLiveOut[*it]);
        if (it != std::prev(insts.rend())) {
            instLiveOut[*std::next(it)] = instLiveIn[*it]; ///@bug
        }
    }
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
        case OpCode::ROR:
        case OpCode::RRX:
        case OpCode::MUL:
        case OpCode::DIV:
        case OpCode::SDIV:
        case OpCode::MLA:
        case OpCode::MLS:
        case OpCode::SMULL:
        case OpCode::SMMLA:
        case OpCode::SMMLS:
        case OpCode::TST:
        case OpCode::TEQ:
        case OpCode::COPY:
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
        case OpCode::PHI:
            Err::unreachable("no phi-inst expected in this pass");
            break;
        case OpCode::B:
        case OpCode::BX_RET:
        case OpCode::BX_SET_SWI:
        case OpCode::BL:
        case OpCode::BLX:
        case OpCode::CMP:
        case OpCode::CMN:
        case OpCode::RET:
            ///@brief pass liveout to livein
            livein = liveout;
            break;
        default:
            Err::unreachable("instruction liveness encounter an unknown op");
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
