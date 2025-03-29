#include "../../../../include/mir/passes/transforms/postRAstackformat.hpp"
#include "../../../../include/mir/instructions/binary.hpp"
#include "../../../../include/mir/instructions/copy.hpp"
#include "../../../../include/mir/instructions/memory.hpp"
#include "../../../../include/mir/passes/analysis/live_analysis.hpp"

using namespace MIR;

///@note 可能做向量化, 所以需要预备栈的16字节对齐

PM::PreservedAnalyses postRAstackformat::run(Function &function, FAM &fam) {
    func = &function;
    varpool = &(func->editInfo().varpool);
    constpool = &(func->editInfo().constpool);
    objs = &(func->editInfo().StackObjs);
    regdit = &(func->editInfo().regdit);
    regdit_s = &(func->editInfo().regdit_s);
    stackSize = &(func->editInfo().stackSize);
    maxAlignment = &(func->editInfo().maxAlignment);

    FrameGenerate();

    Leagalize();

    func->editInfo().liveinfo = fam.getResult<LiveAnalysis>(function); // update liveinfo

    return PM::PreservedAnalyses::all();
}

void postRAstackformat::FrameGenerate() {
    ///@brief stacksize
    *stackSize = 0;

    for (auto &obj : *objs) {
        if (obj->getTrait() == FrameTrait::FixStack)
            continue;

        *stackSize += obj->getSize();
        *maxAlignment = std::max(*maxAlignment, obj->getAliagnment());
    }

    frameSaveANDPadding();

    frameObjSort();

    frameObjImpl();
}

void postRAstackformat::frameObjSort() {
    ///@todo 排列栈空间, 保证对齐, 尝试提高缓存率

    ///@brief 重排Alloca和spill变量(local), 满足SIMD额外的对齐要求
    auto args_end = objs->begin();                  // 后一位, 不是args
    auto calleesave_begin = std::prev(objs->end()); // 第一个, 是calleesave

    auto current = objs->begin();
    for (; current != objs->end();) {
        auto &obj = *current;
        auto tmp = current;

        switch (obj->getTrait()) {
        case FrameTrait::Alloca:
        case FrameTrait::Spill:
            ++current;
            break;
        case FrameTrait::Arg:
            ///@note mov to the head
            std::iter_swap(args_end, current);
            ++args_end;
            ++current;
            break;
        case FrameTrait::CalleeSaved:
        case FrameTrait::Padding:
            ///@note remain at the tail of objs
            if (current >= calleesave_begin) {
                ++current;
            } else {
                std::iter_swap(current, calleesave_begin);
                --calleesave_begin;
            }
            break;
        case FrameTrait::FixStack:
            ///@note after calleesaved and padding, be aware of seq
            ++current;
            objs->insert(std::prev(objs->end()), *tmp);
            objs->erase(tmp);
        default:
            break;
        }
    }

    ///@brief fix-alignment, maybe needed a padding
    if (func->getInfo().arg_in_use % 2 != 0) {
        unsigned padding_size = *maxAlignment - (func->getInfo().arg_in_use % *maxAlignment);
        auto paddingObj = std::make_shared<FrameObj>(FrameTrait::Padding, padding_size);
        paddingObj->setId(objs->size());
        objs->insert(std::prev(calleesave_begin), paddingObj);
    }

    ///@brief local_begin, local_end内重排

    auto QWORD_begin = args_end;
    auto DWORD_begin = args_end;
    auto WORD_end = std::prev(calleesave_begin);
    ///@note DWORD_begin 和 WORD_begin 可能相同, 此时只有一个local量

    for (; DWORD_begin < WORD_end;) {
        auto &obj = *DWORD_begin;
        auto tmp = DWORD_begin;

        switch (obj->getAliagnment()) {
        case 4:
            std::iter_swap(DWORD_begin, WORD_end);
            --WORD_end;
            break;
        case 8:
            ++DWORD_begin;
            break;
        case 16:
            std::iter_swap(WORD_end, QWORD_begin);
            ++WORD_end;
            ++QWORD_begin;
            break;
        default:
            Err::unreachable("invalid alignment");
            break;
        }
    }

    ///@warning be aware that the CalleeSaved and Padding may be not on the right sequence
    ///@warning but it's not really matter:
    ///@warning CalleeSaved created by push / vpush
    ///@warning Padding created by sub / bic
    ///@warning so the seq will remain unchangable
}

void postRAstackformat::frameSaveANDPadding() {
    // save lr/RA
    if (func->getInfo().hasCall) {
        calleeSavedSize += 4;
    }

    ///@warning 大小不计入stk obj
    calleeSavedSize += regdit->size() * 4;
    calleeSavedSize += regdit_s->size() * 4;

    if (calleeSavedSize) {
        auto calleeSaveObj = std::make_shared<FrameObj>(FrameTrait::CalleeSaved, calleeSavedSize);
        calleeSaveObj->setId(objs->size());

        objs->insert(objs->end(), calleeSaveObj);
    }

    if (calleeSavedSize % 8 != 0 && *maxAlignment == 8) {
        // if maxAlignment == 16, we try anthor way
        auto paddingObj = std::make_shared<FrameObj>(FrameTrait::Padding, 4);
        paddingObj->setId(objs->size());
        objs->insert(std::prev(objs->end()), paddingObj);
    }
}

void postRAstackformat::frameObjImpl() {
    ///@brief 根据Sort结果, 对obj赋offset
    size_t current_size = 0;
    unsigned cnt = 0;
    for (auto &obj : *objs) {
        if (obj->getTrait() != FrameTrait::FixStack) {
            obj->setOffset(current_size);
            current_size += obj->getSize();
        } else {
            Err::gassert(obj->getSeq() != -1, "fix-stack obj corrupted.");
            obj->setOffset((calleeSavedSize + obj->getSeq() - 4) * -1);
        }
        ///@note 方便debug
        obj->setId(cnt++);
    }
}

void postRAstackformat::Leagalize() {
    ///@brief insert insts;
    auto initialize_blk = func->getBlock("%initialize");
    Err::gassert(initialize_blk != nullptr, "get initialize failed");

    ///@note only arg-load instruction in %initialize
    ///@brief insert-front: callee-saved insts( push {...} )
    ///@brief insert-after: add sp, sp, #rest_stk_size
    std::set<unsigned> calleeSave = *regdit;
    std::set<unsigned> calleeSave_s = *regdit_s;

    for (unsigned i = 0; i < 4; ++i)
        calleeSave.erase(i);
    for (unsigned i = 0; i < 16; ++i)
        calleeSave_s.erase(i);

    auto push = std::make_shared<PUSH>(calleeSave);
    auto push_v = std::make_shared<VPUSH>(calleeSave_s);

    if (func->getName() != "@main")
        initialize_blk->addInsts_front({push, push_v});

    ///@note mov ... ldr ... (extract args)

    ///@brief insert front: create new stack
    Err::gassert(*stackSize < 2147483648, "stacksize larger than 2^31 - 1");
    auto stack_size = std::make_shared<ConstantIDX>(constpool->getConstant((int)*stackSize)); // maybe invalid

    if (*maxAlignment == 16) {
        ///@brief stage sp
        auto mov = std::make_shared<movInst>(SourceOperandType::r, varpool->getValue(CoreRegister::r7),
                                             varpool->getValue(CoreRegister::sp));

        auto alignment = std::make_shared<ConstantIDX>(constpool->getConstant(16));

        auto bic =
            std::make_shared<binaryImmInst>(OpCode::BIC, SourceOperandType::ri, varpool->getValue(CoreRegister::sp),
                                            varpool->getValue(CoreRegister::sp), alignment,
                                            nullptr); // 16 bytes align

        auto sub =
            std::make_shared<binaryImmInst>(OpCode::SUB, SourceOperandType::ri, varpool->getValue(CoreRegister::sp),
                                            varpool->getValue(CoreRegister::sp), stack_size, nullptr);
        initialize_blk->addInsts_beforebranch({mov, bic, sub});

    } else if (*maxAlignment == 8) {
        auto sub =
            std::make_shared<binaryImmInst>(OpCode::SUB, SourceOperandType::ri, varpool->getValue(CoreRegister::sp),
                                            varpool->getValue(CoreRegister::sp), stack_size, nullptr);
        initialize_blk->addInsts_beforebranch({sub});
    } else {
        Err::unreachable("bad stack alignment");
    }

    ///@brief stack recoveray
    std::list<InstP> insts;
    if (*maxAlignment == 16) {
        auto mov = std::make_shared<movInst>(SourceOperandType::r, varpool->getValue(CoreRegister::sp),
                                             varpool->getValue(CoreRegister::r7));

        insts.emplace_back(mov);
    } else if (*maxAlignment == 8) {
        auto add =
            std::make_shared<binaryImmInst>(OpCode::ADD, SourceOperandType::ri, varpool->getValue(CoreRegister::sp),
                                            varpool->getValue(CoreRegister::sp), stack_size, nullptr);

        insts.emplace_back(add);
    } else {
        Err::unreachable("bad stack alignment");
    }

    auto vpop = std::make_shared<VPOP>(calleeSave_s);
    auto pop = std::make_shared<POP>(calleeSave);

    if (func->getName() != "@main") {
        insts.emplace_back(vpop);
        insts.emplace_back(pop);
    }

    for (const auto &blk : func->getBlocks()) {
        if (!blk->isRetBlk)
            continue;

        blk->addInsts_beforebranch(insts);
    }
}