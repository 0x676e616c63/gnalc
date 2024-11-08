/**
 * @file value.h
 * @brief IR base class: Value User Use...
 */

#pragma once
#include <vector>
#include <string>

namespace BaseIR
{
    enum Type
    {
        INT, FLOAT, VOID
    };

    class Value;
    class User;
    class Use;
}
