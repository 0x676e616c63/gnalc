# 接收中端IR
## struct in: ???
## struct out: Module, Func, BB, instruction(MIR), operand(Register)
## procedure: LowerIR2MIR
## function during the procedure
### phiInstEliminate, instRewrite, divideUseDef, countVirtualReg, terminateBBPredict
# 寄存器分配
## struct in: Func, BB, instruction, operand
## struct out: nothing change
## procedure: a lot
## function during the procedure: a lot
# 栈帧生成
## struct in: Func, BB, instruction, operand
## struct out: Frame, FrameObj(in Func)
## procedure: Func->MkFrame
## function during the procedure: unclear
# 合法化
## struct in: Func, (BB), instrction, operand
## struct out: ...
## procedure: LowerMIR2ASM
# codegen