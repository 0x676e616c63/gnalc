#include "mir-old/passes/transforms/postRAstackformat.hpp"
#include "mir-old/instructions/binary.hpp"
#include "mir-old/instructions/copy.hpp"
#include "mir-old/instructions/memory.hpp"
#include "mir-old/passes/analysis/live_analysis.hpp"

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

    calleeSavedSize = 0;

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

    ///@brief 处理栈对齐
    if (*maxAlignment == 8 && *stackSize % 8 != 0) {
        auto pad_obj = make<FrameObj>(FrameTrait::Padding, 4);
        objs->emplace_back(pad_obj);
        *stackSize += 4;
    } else if (*maxAlignment == 16 && *stackSize % 16 != 0) {
        auto pad_obj = make<FrameObj>(FrameTrait::Padding, 16 - (*stackSize % 16));
        objs->emplace_back(pad_obj);
        *stackSize += 16 - (*stackSize % 16);
    }

    ///@brief 保存时依然注意对齐
    frameSaveANDPadding();

    frameObjSort();

    frameObjImpl();
}

void postRAstackformat::frameObjSort() {
    if (objs->empty())
        return;

    ///@todo 排列栈空间, 保证对齐, 尝试提高缓存率

    ///@brief 重排Alloca和spill变量(local), 满足SIMD额外的对齐要求
    unsigned args_end = 0;                        // 后一位, 是args
    unsigned calleesave_begin = objs->size() - 1; // 第一个前一个, 不是calleesave

    unsigned current = 0;
    std::set<std::shared_ptr<FrameObj>> fixStkMoved; // 防止循环移动
    for (; current != objs->size() - 1;) {
        auto &obj = (*objs)[current];
        auto tmp = current;

        switch (obj->getTrait()) {
        case FrameTrait::Alloca:
        case FrameTrait::Spill:
            ++current;
            break;
        case FrameTrait::Arg:
            ///@note mov to the head
            // std::iter_swap(args_end, current);
            std::swap((*objs)[args_end], obj);
            ++args_end;
            ++current;
            break;
        case FrameTrait::CalleeSaved:
        case FrameTrait::Padding:
            ///@note remain at the tail of objs
            if (current >= calleesave_begin) {
                ++current;
            } else {
                std::swap(obj, (*objs)[calleesave_begin]);
                --calleesave_begin;
            }
            break;
        case FrameTrait::FixStack:
            ///@note after calleesaved and padding, be aware of seq

            if (fixStkMoved.find(obj) != fixStkMoved.end()) {
                ++current;
            } else {
                objs->emplace_back(obj);
                objs->erase(objs->begin() + current);
                --calleesave_begin; // FixStack需要在calleesave之后
                fixStkMoved.insert(obj);
                // ++current;
            }
            break;
        default:
            break;
        }
    }

    ///@brief fix-alignment, maybe needed a padding
    // if (func->getInfo().arg_in_use % 2 != 0) {
    //     unsigned padding_size = *maxAlignment - (func->getInfo().arg_in_use % *maxAlignment);
    //     auto paddingObj = std::make_shared<FrameObj>(FrameTrait::Padding, padding_size);
    //     paddingObj->setId(objs->size());
    //     objs->insert(objs->begin() + calleesave_begin - 1, paddingObj);
    // }

    ///@brief local_begin, local_end内重排

    auto QWORD_begin = args_end;
    auto DWORD_begin = args_end;
    auto WORD_end = calleesave_begin - 1;
    ///@note DWORD_begin 和 WORD_begin 可能相同, 此时只有一个local量

    for (; DWORD_begin < WORD_end;) {
        auto obj = (*objs)[DWORD_begin];

        switch (obj->getAliagnment()) {
        case 4:
            std::swap(DWORD_begin, WORD_end);
            --WORD_end;
            break;
        case 8:
            ++DWORD_begin;
            break;
        case 16:
            std::swap(WORD_end, QWORD_begin);
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
    for (unsigned i = 0; i < 4; ++i)
        regdit->erase(i);

    for (unsigned i = 0; i < 16; ++i)
        regdit_s->erase(i);

    if (func->getName() == "@main") {
        regdit->clear();
        regdit_s->clear();
    }

    if (func->getInfo().hasCall)
        regdit->insert(static_cast<int>(CoreRegister::lr));

    ///@brief 修整push之后的栈到8字节对齐
    if (regdit->size() % 2)
        regdit->insert(1); // 压入无用r1保持对齐

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
        *stackSize += 4;
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
            obj->setOffset(*stackSize + calleeSavedSize + (obj->getSeq() - 4) * 4); // 先push, 后取arg
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

    ///@brief insert front: create new stack
    Err::gassert(*stackSize < 2147483648, "stacksize larger than 2^31 - 1");

    ///@note 所获取的栈大小会比实际上的大, 并且注意保持对齐
    int real_stack_size = ceilEncoded((int)(*stackSize), *maxAlignment);
    int fix_stack_size = (*maxAlignment - ((real_stack_size + calleeSavedSize) % *maxAlignment)) % *maxAlignment;

    auto stack_size = std::make_shared<ConstantIDX>(constpool->getConstant(real_stack_size));

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

        auto sub_fix = std::make_shared<binaryImmInst>( // maybe eli by dce
            OpCode::SUB, SourceOperandType::ri, varpool->getValue(CoreRegister::sp),
            varpool->getValue(CoreRegister::sp), make<ConstantIDX>(constpool->getConstant(fix_stack_size)), nullptr);

        initialize_blk->addInsts_front({mov, bic, sub, sub_fix});
    } else if (*maxAlignment == 8) {
        auto sub =
            std::make_shared<binaryImmInst>(OpCode::SUB, SourceOperandType::ri, varpool->getValue(CoreRegister::sp),
                                            varpool->getValue(CoreRegister::sp), stack_size, nullptr);
        auto sub_fix = std::make_shared<binaryImmInst>( // maybe eli by dce
            OpCode::SUB, SourceOperandType::ri, varpool->getValue(CoreRegister::sp),
            varpool->getValue(CoreRegister::sp), make<ConstantIDX>(constpool->getConstant(fix_stack_size)), nullptr);
        initialize_blk->addInsts_front({sub, sub_fix});
    } else {
        Err::unreachable("bad stack alignment");
    }

    std::set<unsigned> calleeSave = *regdit;
    std::set<unsigned> calleeSave_s = *regdit_s;

    auto push = make<PUSH>(calleeSave);
    auto push_v = make<VPUSH>(calleeSave_s);

    initialize_blk->addInsts_front({push, push_v}); ///@warning

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

        auto add_fix = std::make_shared<binaryImmInst>(
            OpCode::ADD, SourceOperandType::ri, varpool->getValue(CoreRegister::sp),
            varpool->getValue(CoreRegister::sp), make<ConstantIDX>(constpool->getConstant(fix_stack_size)), nullptr);

        insts.emplace_back(add);
        insts.emplace_back(add_fix); // maybe not in use
    } else {
        Err::unreachable("bad stack alignment");
    }

    auto vpop = std::make_shared<VPOP>(calleeSave_s);
    auto pop = std::make_shared<POP>(calleeSave);

    if (func->getName() != "@main" || func->getInfo().hasCall) {
        insts.emplace_back(vpop);
        insts.emplace_back(pop);
    }

    for (const auto &blk : func->getBlocks()) {
        if (!blk->isRetBlk)
            continue;

        blk->addInsts_beforebranch(insts);
    }
}