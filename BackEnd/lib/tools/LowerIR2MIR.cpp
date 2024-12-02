#include <memory>
#include "../../../include/ir/module.hpp"
#include "../../include/tools/LowerIR2MIR.hpp"
#include "../../Arm.hpp"
#include "../../include/ArmComplexMIRStruct/ArmModule.hpp"


ArmTools::LowerIR2MIR::LowerIR2MIR(IR::Module& m){
    this->Module = std::make_unique<ArmStruct::Module>();
    this->run(m);
}

void ArmTools::LowerIR2MIR::run(IR::Module& midEnd_Module){
    
    auto midEnd_Funcs = midEnd_Module.getFunctions();
    for(auto it = midEnd_Funcs.begin(); it != midEnd_Funcs.end(); ++it){
        auto Func = **it;
        Module->AddFunction(std::make_unique<ArmStruct::Function>(Func));
    }
}