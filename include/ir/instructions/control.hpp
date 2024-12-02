/**
 * @brief Terminator instructions and call
 * @brief ret. br, call
 */

#include "../instruction.hpp"

namespace IR {

// ret <type> <value>       ; Return a value from a non-void function
// ret void                 ; Return from void function
class RETInst : public Instruction {
private:
    Value* ret_val;

public:
    RETInst(Type t, Value* _ret_val);
    RETInst();

    bool isVoid();
    Value* getRetVal();
};


// br i1 <cond>, label <iftrue>, label <iffalse>
// br label <dest>          ; Unconditional branch
class BRInst : public Instruction {
private:
    BasicBlock* true_dest;
    BasicBlock* false_dest;
    bool conditional;
    std::vector<Value*> bbparams; // 基本块参数

public:
    BRInst(BasicBlock* _true_dest, BasicBlock* _false_dest);
    BRInst(BasicBlock* _dest);

    bool isConditional();
    BasicBlock* getDest();
    BasicBlock* getTrueDest();
    BasicBlock* getFalseDest();

    void setBBParams(std::initializer_list<Value*> _bbparams);
    void setBBparams(std::vector<Value*>& _bbparams);
    std::vector<Value*>& getBBParams();
};

//<result> = [tail | musttail | notail ] call [fast-math flags] [cconv] [ret attrs] [addrspace(<num>)]
//            <ty>|<fnty> <fnptrval>(<function args>) [fn attrs] [ operand bundles ]
// 
// %retval = call i32 @test(i32 %argc)
class CALLInst : public Instruction {
private:
    std::string func_name;
    std::vector<Value*> args;

public:
    CALLInst(Type t, std::string _func_name, std::vector<Value*>& _args);

    std::string getFuncName();
    std::vector<Value*>& getArgs();
};

}