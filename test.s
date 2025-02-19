GlobalValues:
ConstValues:
- { id: 1, literal = '12', type = int32, isEncInText = false }
- { id: 0, literal = '8', type = int32, isEncInText = false }

---
name: @main
maxalignment: 4
hasTailCall: false
stackobjs: 
- { id: 0, size = 4B, local-offset = 0, type = Alloca}
- { id: 0, size = 4B, local-offset = 0, type = Alloca}
- { id: 0, size = 4B, local-offset = 0, type = Alloca}
- { id: 0, size = 4B, local-offset = 0, type = Alloca}
body:
    %0:
        %17:gpr = MOVri %const.0
        STRra %17:gpr, %2:gpr(%Stack.0)
        %18:gpr = MOVri %const.1
        STRra %18:gpr, %3:gpr(%Stack.0)
        %5:gpr = LDRra %2:gpr(%Stack.0)
        %6:gpr = LDRra %3:gpr(%Stack.0)
        %7:gpr = ADDrr %6:gpr, %5:gpr
        STRra %7:gpr, %1:gpr(%Stack.0)
        %8:gpr = LDRra %1:gpr(%Stack.0)
        $r0 = MOVi %8:gpr
        RET


