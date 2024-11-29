#include <string>
#include "../Arm.hpp"
#include "../../include/ArmComplexMIRStruct/ArmBB.hpp"

using namespace ArmStruct;
using namespace ArmTools;
///@todo 记得补构造函数
std::string& BB::toString(){
   if(this->Terminator.isImplicity == false) return label;
}