#include <memory>
#include <algorithm>
#include <cassert>
#include <cmath>
#include "../../Arm.hpp"
#include "../../../include/ir/function.hpp"
#include "../../include/tools/ArmTools.hpp"
#include "../../include/ArmComplexMIRStruct/ArmOperand.hpp"
#include "../../include/ArmComplexMIRStruct/ArmBB.hpp"
#include "../../include/ArmComplexMIRStruct/ArmInstruction.hpp"
#include "../../include/ArmComplexMIRStruct/ArmFunction.hpp"

using namespace ArmStruct;
using namespace ArmTools;
using FrameObjRefHash = std::unordered_set<std::reference_wrapper<ArmStruct::FrameObj>&, ArmTools::HashFrameObj, ArmTools::HashFrameObjEqual>;
using FrameObjRefHashPtr = std::unique_ptr<std::unordered_set<std::reference_wrapper<ArmStruct::FrameObj>&, ArmTools::HashFrameObj, ArmTools::HashFrameObjEqual>>;
///@todo 差构造函数

FrameObj::FrameObj(SubFrame *Father, OperandType type, unsigned int size, unsigned long long idx):
    father(Father), type(type), ObjSize(size), VirPtr(idx) {
        father->insertObj(VirPtr, this);
        // idx不只是FrameObj的编号, 也是MMptr的编号
        MMptr *ptr = new MMptr(this, type, idx);
        father->insertMMptr(idx, ptr);
}

ArrayObj::ArrayObj(SubFrame* father, OperandType elementType, unsigned long long VirPtr, std::vector<unsigned long long> dims):
    FrameObj(father, elementType, 0, VirPtr){
        unsigned int singleElemSize = 4; // to be continued...

        unsigned int totalObjSize = 0;
        for(unsigned int size : dims){
            arrayDims.push_back(size);
            totalObjSize += size * singleElemSize;
        }
        setSize(totalObjSize);
        
        MMptr *ArrayPtr = new MMptr(this, elementType, VirPtr);
        father->insertMMptr(VirPtr, ArrayPtr);
}

Function::Function(IR::Function& midEnd_function){
    
    this->Identifier = midEnd_function.getName();
    this->VRegNum = midEnd_function.getVRegNum();

    ///@brief fill VirMap and link instructions
    std::vector<std::shared_ptr<IR::BasicBlock>>& bbs = midEnd_function.getBlocks();

    for(auto bb_it = bbs.begin(); bb_it != bbs.end(); ++bb_it){
        auto &midEnd_BB = **bb_it;
        
        BB *backEnd_BB = new BB(midEnd_BB, *this);

        this->BBList.push_back(backEnd_BB);
        
        backEnd_BB->MkLiveOut(midEnd_BB); // 查表 IR::Value 到 Arm::Operand的转换

    }


    /// @note 现在是保存了SSA形式的MIR, 在这里插入一些OPT


    for(auto backEnd_BB : this->BBList){
        backEnd_BB->PhiEliminate();
    }
    
    /// @note 现在没有SSA了, 只能做窥孔优化

    // this->MkFrameInit(); //  改在 IR->MIR
}


unsigned int SubFrame::getSize(){
    unsigned int totalSize = 0;
    for(auto it = VirPtrFrameObjMap.begin(); it != VirPtrFrameObjMap.end(); ++it){
        totalSize += (*it).second->getSize();
    }
    return totalSize;
}


void Function::TerminatorPredict(){
    ///@todo 假设由中端传来的BB组织为一张复杂图
    ///@todo 一个结点的入度和出度最大为2
    ///@todo 需要将这个图转换为普通链表

    ///@note 由于前端使用访问者模式划分BB, 并且这个学期还没有针对IR做优化
    ///@note 所以传入的BB, 本身就是链式的, 这个接口可以暂时省略
}

std::string& Function::toString(){
    for(auto it = BBList.begin(); it != BBList.end(); ++it){
        auto BasicBlock = **it;
        str += BasicBlock.toString() + ':' + '\n'; // BB的label
        for(auto it_inst = BasicBlock.InstList.begin(); it_inst != BasicBlock.InstList.end(); ++it_inst){
            Instruction& inst = **it_inst;
            str += "    "; // 缩进
            str += inst.toString() + '\n';
        }
    }
    return str;
}