#include "mir/riscv64/isel.hpp"
#include "mir/MIR.hpp"
#include "mir/passes/transforms/isel.hpp"
#include <algorithm>
#include <optional>

using namespace MIR;

bool RVIselInfo::isLegalGenericInst(MIRInst_p minst) const {

}

bool RVIselInfo::match(MIRInst_p minst, ISelContext &ctx, bool allow) const {

}

// for pass isel
bool RVIselInfo::legalizeInst(MIRInst_p minst, ISelContext &ctx) const {

}

void RVIselInfo::preLegalizeInst(InstLegalizeContext &_ctx) {

}
void RVIselInfo::legalizeWithStkOp(InstLegalizeContext &_ctx, MIROperand_p mop, const StkObj &obj) const {

}

void RVIselInfo::legalizeWithStkGep(InstLegalizeContext &_ctx, MIROperand_p mop, const StkObj &obj) const {

}

void RVIselInfo::legalizeWithStkPtrCast(InstLegalizeContext &_ctx, MIROperand_p mop, const StkObj &obj) const {

}

void RVIselInfo::legalizeCopy(InstLegalizeContext &_ctx) const {

}

void RVIselInfo::legalizeAdrp(InstLegalizeContext &_ctx) const {
}

RVIselInfo::~RVIselInfo() = default;
