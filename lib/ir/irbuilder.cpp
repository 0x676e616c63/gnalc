// Copyright (c) 2025 0x676e616c63
// SPDX-License-Identifier: MIT

#include "ir/irbuilder.hpp"
#include "ir/basic_block.hpp"
#include "ir/instructions/binary.hpp"
#include "ir/instructions/compare.hpp"
#include "ir/instructions/control.hpp"
#include "ir/instructions/converse.hpp"
#include "ir/instructions/memory.hpp"
#include "ir/instructions/phi.hpp"
#include "ir/instructions/vector.hpp"
namespace IR {
void IRBuilder::setNamePrefix(const std::string &name_prefix_) { name_prefix = name_prefix_; }
void IRBuilder::setInsertPoint(const pBlock &bb, BBInstIter insert_point_) {
    block = bb;
    insert_point = insert_point_;
}

#define MAKE_BINARY(Name, Op, IRName)                                                                                  \
    pBinary IRBuilder::make##Name(const pVal &lhs, const pVal &rhs, const std::string &name) const {                   \
        return makeInst<BinaryInst>(name, IRName, Op, lhs, rhs);                                                       \
    }

MAKE_BINARY(Add, OP::ADD, "add")
MAKE_BINARY(Sub, OP::SUB, "sub")
MAKE_BINARY(Mul, OP::MUL, "mul")
MAKE_BINARY(Div, OP::DIV, "div")
MAKE_BINARY(URem, OP::UREM, "urem")
MAKE_BINARY(SRem, OP::SREM, "srem")
MAKE_BINARY(FAdd, OP::FADD, "fadd")
MAKE_BINARY(FSub, OP::FSUB, "fsub")
MAKE_BINARY(FMul, OP::FMUL, "fmul")
MAKE_BINARY(FDiv, OP::FDIV, "fdiv")
MAKE_BINARY(FRem, OP::FREM, "frem")
MAKE_BINARY(Shl, OP::SHL, "shl")
MAKE_BINARY(LShr, OP::LSHR, "lshr")
MAKE_BINARY(AShr, OP::ASHR, "ashr")
MAKE_BINARY(And, OP::AND, "and")
MAKE_BINARY(Or, OP::OR, "or")
MAKE_BINARY(Xor, OP::XOR, "xor")

pBinary IRBuilder::makeBinary(OP op, const pVal &lhs, const pVal &rhs, const std::string &name) const {
    return makeInst<BinaryInst>(name, "binary", op, lhs, rhs);
}

pFneg IRBuilder::makeFNeg(const pVal &val, const std::string &name) const {
    return makeInst<FNEGInst>(name, "fneg", val);
}
pZext IRBuilder::makeZext(const pVal &val, IRBTYPE type, const std::string &name) const {
    return makeInst<ZEXTInst>(name, "zext", val, type);
}
pSext IRBuilder::makeSext(const pVal &val, IRBTYPE type, const std::string &name) const {
    return makeInst<SEXTInst>(name, "sext", val, type);
}
pBitcast IRBuilder::makeBitcast(const pVal &val, const pType &type, const std::string &name) const {
    return makeInst<BITCASTInst>(name, "bitcast", val, type);
}
pFptosi IRBuilder::makeFptosi(const pVal &val, const std::string &name) const {
    return makeInst<FPTOSIInst>(name, "fptosi", val);
}
pSitofp IRBuilder::makeSitofp(const pVal &val, const std::string &name) const {
    return makeInst<SITOFPInst>(name, "sitofp", val);
}
pIcmp IRBuilder::makeIcmp(ICMPOP op, const pVal &lhs, const pVal &rhs, const std::string &name) {
    return makeInst<ICMPInst>(name, "icmp", op, lhs, rhs);
}
pFcmp IRBuilder::makeFcmp(FCMPOP op, const pVal &lhs, const pVal &rhs, const std::string &name) {
    return makeInst<FCMPInst>(name, "fcmp", op, lhs, rhs);
}
pGep IRBuilder::makeGep(const pVal &ptr, const pVal &idx, const std::string &name) const {
    return makeInst<GEPInst>(name, "gep0", ptr, idx);
}
pGep IRBuilder::makeGep(const pVal &ptr, const pVal &idx1, const pVal &idx2, const std::string &name) const {
    return makeInst<GEPInst>(name, "gep1", ptr, idx1, idx2);
}
pGep IRBuilder::makeGep(const pVal &ptr, const std::vector<pVal> &indices, const std::string &name) const {
    return makeInst<GEPInst>(name, "gep2", ptr, indices);
}
pAlloca IRBuilder::makeAlloca(const pType &type, int align, const std::string &name) const {
    return makeInst<ALLOCAInst>(name, "alloca", type, align);
}
pLoad IRBuilder::makeLoad(const pVal &ptr, int align, const std::string &name) const {
    return makeInst<LOADInst>(name, "load", ptr, align);
}
pStore IRBuilder::makeStore(const pVal &val, const pVal &ptr, int align) const {
    return makeNamelessInst<STOREInst>(val, ptr, align);
}
pBr IRBuilder::makeBr(const pBlock &dest) { return makeNamelessInst<BRInst>(dest); }
pBr IRBuilder::makeBr(const pVal &cond, const pBlock &true_dest, const pBlock &false_dest) {
    return makeNamelessInst<BRInst>(cond, true_dest, false_dest);
}
pRet IRBuilder::makeRet() { return makeNamelessInst<RETInst>(); }
pRet IRBuilder::makeRet(const pVal &val) { return makeNamelessInst<RETInst>(val); }
pSelect IRBuilder::makeSelect(const pVal &cond, const pVal &true_val, const pVal &false_val, const std::string &name) {
    return makeInst<SELECTInst>(name, "select", cond, true_val, false_val);
}
pPhi IRBuilder::makePhi(const pType &type, const std::string &name) { return makeInst<PHIInst>(name, "phi", type); }
pCall IRBuilder::makeCall(const pFuncDecl &func, const std::vector<pVal> &args, const std::string &name) {
    return makeInst<CALLInst>(name, "call", func, args);
}
pExtract IRBuilder::makeExtract(const pVal &vector, const pVal &idx, const std::string &name) {
    return makeInst<EXTRACTInst>(name, "extract", vector, idx);
}
pInsert IRBuilder::makeInsert(const pVal &vector, const pVal &element, const pVal &idx, const std::string &name) {
    return makeInst<INSERTInst>(name, "insert", vector, element, idx);
}
pShuffle IRBuilder::makeShuffle(const pVal &v1, const pVal &v2, const pConstI32Vec &mask,
                                const std::string &name) const {
    return makeInst<SHUFFLEInst>(name, "shuffle", v1, v2, mask);
}
} // namespace IR
