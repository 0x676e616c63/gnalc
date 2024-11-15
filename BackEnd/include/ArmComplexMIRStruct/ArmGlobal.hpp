#pragma once
#include <string>
#include "../../Arm.hpp"

class ArmStruct::Global{
    public:
        Global();
        ~Global()=default;
        void toString();
    private:
        std::string Label;
        std::string encoding;
};