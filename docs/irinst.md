# Gnalc IR Reference

Gnalc IR is subset of [LLVM IR](https://llvm.org/docs/LangRef.html).

## Terminator Instructions

- ret

- br

- ~~switch~~

- ~~indirectbr~~

- ~~invoke~~

- ~~callbr~~

- ~~resume~~

- ~~catchswitch~~

- ~~catchret~~

- ~~cleanupret~~

- ~~unreachable~~

## Unary Operations

- fneg

## Binary Operations

- add

- fadd

- sub

- fsub

- mul

- fmul

- ~~udiv~~

- sdiv

- fdiv

- urem

- srem

- frem

## Bitwise Binary Operations

- shl

- lshr

- ashr

- and

- or

- xor

## Vector Operations

- extractelement

- insertelement

- shufflevector

## Aggregate Operations

- ~~extractvalue~~

- ~~insertvalue~~

## Memory Access and Addressing Operations

- alloca

- load

- store

- ~~fence~~

- ~~cmpxchg~~

- ~~atomicrmw~~

- getelementptr (positive indices only)

## Conversion Operations

- ~~trunc ... to~~

- zext ... to

- sext ... to

- ~~fptrunc ... to~~

- ~~fpext ... to~~

- ~~fptoui ... to~~

- fptosi ... to

- ~~uitofp ... to~~

- sitofp ... to

- ~~ptrtoint ... to~~

- ~~inttoptr ... to~~

- bitcast ... to

- ~~addrspacecast ... to~~

## Other Operations

- icmp

- fcmp

- phi

- select

- ~~freeze~~

- call

- ~~va_arg~~

- ~~landingpad~~

- ~~catchpad~~

- ~~cleanuppad~~