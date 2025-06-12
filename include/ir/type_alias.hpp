#ifndef GNALC_IR_DEF_HPP
#define GNALC_IR_DEF_HPP

#include <memory>

namespace IR {
// base
class Value;
class User;
class Use;
using pVal = std::shared_ptr<Value>;
using pUser = std::shared_ptr<User>;
using wpVal = std::weak_ptr<Value>;
using wpUser = std::weak_ptr<User>;

// binary
class BinaryInst;
class FNEGInst;
using pBinary = std::shared_ptr<BinaryInst>;
using pFneg = std::shared_ptr<FNEGInst>;

// compare
class ICMPInst;
class FCMPInst;
using pIcmp = std::shared_ptr<ICMPInst>;
using pFcmp = std::shared_ptr<FCMPInst>;

// control
class RETInst;
class BRInst;
class CALLInst;
class SELECTInst;
using pRet = std::shared_ptr<RETInst>;
using pBr = std::shared_ptr<BRInst>;
using pCall = std::shared_ptr<CALLInst>;
using pSelect = std::shared_ptr<SELECTInst>;

// converse
class CastInst;
class FPTOSIInst;
class SITOFPInst;
class ZEXTInst;
class SEXTInst;
class BITCASTInst;
using pCast = std::shared_ptr<CastInst>;
using pFptosi = std::shared_ptr<FPTOSIInst>;
using pSitofp = std::shared_ptr<SITOFPInst>;
using pZext = std::shared_ptr<ZEXTInst>;
using pSext = std::shared_ptr<SEXTInst>;
using pBitcast = std::shared_ptr<BITCASTInst>;

// vector
class EXTRACTInst;
class INSERTInst;
class SHUFFLEInst;
using pExtract = std::shared_ptr<EXTRACTInst>;
using pInsert = std::shared_ptr<INSERTInst>;
using pShuffle = std::shared_ptr<SHUFFLEInst>;

// helper
class HELPERInst;
class CONDValue;
class ANDValue;
class ORValue;
class IFInst;
class WHILEInst;
class BREAKInst;
class CONTINUEInst;
class FORInst;
using pHelper = std::shared_ptr<HELPERInst>;
using pCondValue = std::shared_ptr<CONDValue>;
using pAndValue = std::shared_ptr<ANDValue>;
using pOrValue = std::shared_ptr<ORValue>;
using pIfInst = std::shared_ptr<IFInst>;
using pWhileInst = std::shared_ptr<WHILEInst>;
using pBreakInst = std::shared_ptr<BREAKInst>;
using pContinueInst = std::shared_ptr<CONTINUEInst>;
using pForInst = std::shared_ptr<FORInst>;

// memory
class ALLOCAInst;
class LOADInst;
class STOREInst;
class GEPInst;
using pAlloca = std::shared_ptr<ALLOCAInst>;
using pLoad = std::shared_ptr<LOADInst>;
using pStore = std::shared_ptr<STOREInst>;
using pGep = std::shared_ptr<GEPInst>;

// phi
class PHIInst;
using pPhi = std::shared_ptr<PHIInst>;

// basic block
class BasicBlock;
using pBlock = std::shared_ptr<BasicBlock>;
using wpBlock = std::weak_ptr<BasicBlock>;

// constant
// TODO

// function
class FunctionDecl;
class FormalParam;
class Function;
class LinearFunction;
using pFuncDecl = std::shared_ptr<FunctionDecl>;
using pFormalParam = std::shared_ptr<FormalParam>;
using pFunc = std::shared_ptr<Function>;
using wpFunc = std::weak_ptr<Function>;
using pLFunc = std::shared_ptr<LinearFunction>;
using wpLFunc = std::weak_ptr<LinearFunction>;

// global variable
class GlobalVariable;
using pGlobalVar = std::shared_ptr<GlobalVariable>;

// instruction
class Instruction;
using pInst = std::shared_ptr<Instruction>;

// module
class Module;
// using pModule = std::shared_ptr<Module>;

// type
class Type;
class BType;
class PtrType;
class ArrayType;
class VectorType;
class FunctionType;
using pType = std::shared_ptr<Type>;
using pBType = std::shared_ptr<BType>;
using pPtrType = std::shared_ptr<PtrType>;
using pArrayType = std::shared_ptr<ArrayType>;
using pVecType = std::shared_ptr<VectorType>;
using pFuncType = std::shared_ptr<FunctionType>;

// loop
class Loop;
using pLoop = std::shared_ptr<Loop>;
using wpLoop = std::weak_ptr<Loop>;
} // namespace IR
#endif //DEF_HPP
