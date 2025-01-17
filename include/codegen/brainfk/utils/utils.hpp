#ifndef GNALC_CODEGEN_BRAINFK_UTILS_UTILS_HPP
#define GNALC_CODEGEN_BRAINFK_UTILS_UTILS_HPP

#include <string>
#include "../bfmodule.hpp"
namespace BrainFk {

inline std::string to_mybf_presentation(const std::string& raw)
{
    std::string ret = "{ ";

    for (auto& ch : raw)
    {
        switch (ch)
        {
        case '>':
            ret += "BFInstruction::PTRINC";
            break;
        case '<':
            ret += "BFInstruction::PTRDEC";
            break;
        case '+':
            ret += "BFInstruction::INC";
            break;
        case '-':
            ret += "BFInstruction::DEC";
            break;
        case '.':
            ret += "BFInstruction::OUTPUT";
            break;
        case ',':
            ret += "BFInstruction::INPUT";
            break;
        case '[':
            ret += "BFInstruction::BEQZ";
            break;
        case ']':
            ret += "BFInstruction::BNEZ";
            break;
        default:
            std::cerr << "Warning: Ignored character '" << ch << "'" << std::endl;
            continue;
        }

        ret += ", ";
    }

    while (!ret.empty() && (ret.back() == ',' || ret.back() == ' '))
        ret.pop_back();

    ret += " }";

    return ret;
}

}
#endif