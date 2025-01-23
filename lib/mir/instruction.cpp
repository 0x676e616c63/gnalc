#include "../../include/mir/instruction.hpp"

using namespace MIR;

bool Instruction::OperandTypeCheck() {
    switch (tptrait) {
    case SourceOperandType::cp:
    case SourceOperandType::i12:
    case SourceOperandType::i:
    case SourceOperandType::i32: {
        /// @note 立即数合法化等到codegen再做, 这里一视同仁
        auto oper = SourceOperandList[0].get();
        if (!dynamic_cast<ConstantIDX *>(oper))
            return false;
    }
        break;

    default: {
        auto oper = SourceOperandList[0].get();
        // case SourceOperandType::r:
        if (!dynamic_cast<BindOnVirOP *>(oper) ||
            dynamic_cast<PreColedOP *>(oper))
            return false;

        switch (tptrait) {
        case SourceOperandType::ri:
            oper = SourceOperandList[1].get();
            if (!dynamic_cast<ConstantIDX *>(oper))
                return false;
            break;
        case SourceOperandType::rr:
            oper = SourceOperandList[1].get();
            if (!dynamic_cast<BindOnVirOP *>(oper) ||
                dynamic_cast<PreColedOP *>(oper))
                return false;
            break;
        case SourceOperandType::rsi:
            oper = SourceOperandList[1].get();
            if (!dynamic_cast<BindOnVirOP *>(oper) ||
                dynamic_cast<PreColedOP *>(oper))
                return false;
            oper = SourceOperandList[2].get();
            if (!dynamic_cast<ShiftOP *>(oper))
                return false;
            break;
        }}
    }
    return true;
}