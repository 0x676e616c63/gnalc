#include "../../../../include/mir/passes/transforms/const2reg.hpp"
#include "../../../../include/mir/instructions/memory.hpp"

using namespace MIR;

PM::PreservedAnalyses Const2Reg::run(Function &func, FAM &fam) {
    function = &func;
    varpool = &(func.editInfo().varpool);

    dominfo = fam.getResult<DomTreeAnalysis>(func);

    Main();

    return PM::PreservedAnalyses::all();
}

void Const2Reg::Main() {
    const auto &const2vir = varpool->getConst2Vir();
    const auto &const2blks = varpool->getConst2blks();

    for (const auto &[constobj, constvir] : const2vir) {
        runOneach(const2blks.at(constobj), constobj, constvir);
    }
}

void Const2Reg::mkConst2Reg(const ConstObj &constobj, const BindOnP &constvir, BasicBlock *blk) {

    std::shared_ptr<movInst> mov;
    auto constobj_ptr = std::make_shared<ConstObj>(constobj);

    if (constobj.isGlo())
        mov = std::make_shared<movInst>(SourceOperandType::a, constvir, std::make_shared<ConstantIDX>(constobj_ptr));
    else
        mov = std::make_shared<movInst>(SourceOperandType::i32, constvir, std::make_shared<ConstantIDX>(constobj_ptr));

    auto &insts = blk->getInsts();

    auto extract = [](const auto &_inst) -> std::set<OperP> {
        std::set<OperP> set;
        for (int i = 1; i < 5; ++i) {
            if (auto op = _inst->getSourceOP(i))
                set.insert(op);
        }
        return set;
    };

    for (auto it = insts.begin(); it != insts.end(); ++it) {
        auto uses = extract(*it);
        if (uses.find(constvir) != uses.end()) {
            insts.insert(it, mov);
            break;
        }
    }
}

void Const2Reg::runOneach(std::unordered_set<BlkP> blks, const ConstObj &constobj, const BindOnP &constvir) {
    Err::gassert(!blks.empty(), "record blks empty!");

    std::vector<BlkP> stack(blks.begin(), blks.end());

    auto LCA = dominfo[stack.back().get()].get(); // 直接裸指针了, 便于覆盖
    stack.pop_back();

    while (!stack.empty()) {
        auto node = dominfo[stack.back().get()].get();
        stack.pop_back();

        while (LCA != node) {
            if (LCA->level() > node->level()) {
                LCA = LCA->parent();
                continue;
            }
            if (LCA->level() < node->level()) {
                node = node->parent();
                continue;
            }
            if (LCA->level() == node->level() && LCA != node) {
                LCA = LCA->parent();
            }
        }
    }

    auto LCA_blk = LCA->block();

    mkConst2Reg(constobj, constvir, LCA_blk);
}