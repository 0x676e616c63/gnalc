// Copyright (c) 2025 0x676e616c63
// SPDX-License-Identifier: MIT

#include "ir/passes/transforms/lower_intrinsics.hpp"

#include "ir/block_utils.hpp"
#include "ir/irbuilder.hpp"
#include "ir/passes/analysis/target_analysis.hpp"
#include "ir/passes/transforms/namenormalizer.hpp"

#include <vector>

namespace IR {
void cleanup(const pFunc& impl) {
    breakAllCriticalEdges(*impl);
    NameNormalizePass nn(true);
    impl->accept(nn);
}
// define dso_local void @__gnalc_builtin_memset(ptr %0, i8 %1, i64 %2) {
// 3:
//   br label %7
//
// 7:
//   %8 = phi i64 [ %2, %3 ], [ %10, %7 ]
//   %9 = phi ptr [ %0, %3 ], [ %11, %7 ]
//   %10 = add i64 %8, -1
//   %11 = getelementptr i8, ptr %9, i64 1
//   store i8 %1, ptr %9, align 1
//   %12 = icmp eq i64 %10, 0
//   br i1 %12, label %13, label %7
//
// 13:
//   ret void
// }

void lowerMemset(Module &module, const pFuncDecl &memset_decl) {
    auto ptr = std::make_shared<FormalParam>("%ptr", makePtrType(makeBType(IRBTYPE::I8)), 0);
    auto val = std::make_shared<FormalParam>("%val", makeBType(IRBTYPE::I8), 1);
    auto len = std::make_shared<FormalParam>("%len", makeBType(IRBTYPE::I32), 2);
    auto memset_impl =
        std::make_shared<Function>("@__gnalc_intrinsic_memset", std::vector{ptr, val, len}, makeBType(IRBTYPE::VOID),
                                   &module.getConstantPool(),  FuncAttr::NotBuiltin | FuncAttr::LoweredIntrinsic);
    for (const auto& inst : memset_decl->inst_users()) {
        auto call = inst->as<CALLInst>();
        Err::gassert(call && call->getFunc() == memset_decl && call->getArgs()[3]->getType()->isI1()
            , "memset not used by array init?");
        // Remove is_volatile flag
        call->removeArg(3);
    }
    memset_decl->replaceSelf(memset_impl);
    module.addFunction(memset_impl);
    module.delFunctionDecl(memset_decl);

    auto entry = std::make_shared<BasicBlock>("%entry");
    auto body = std::make_shared<BasicBlock>("%body");
    auto exit = std::make_shared<BasicBlock>("%exit");
    memset_impl->addBlock(entry);
    memset_impl->addBlock(body);
    memset_impl->addBlock(exit);

    IRBuilder entry_builder(entry);
    entry_builder.makeBr(body);

    IRBuilder body_builder(body);
    auto phi1 = body_builder.makePhi(makeBType(IRBTYPE::I32));
    auto phi2 = body_builder.makePhi(makePtrType(makeBType(IRBTYPE::I8)));

    auto add = body_builder.makeAdd(phi1, module.getConst(-1));
    auto gep = body_builder.makeGep(phi2, module.getConst(1));
    (void)body_builder.makeStore(val, phi2, 1);
    auto icmp = body_builder.makeIcmp(ICMPOP::eq, add, module.getConst(0));
    (void)body_builder.makeBr(icmp, exit, body);

    phi1->addPhiOper(len, entry);
    phi1->addPhiOper(add, body);
    phi2->addPhiOper(ptr, entry);
    phi2->addPhiOper(gep, body);

    IRBuilder exit_builder(exit);
    (void)exit_builder.makeRet();
    memset_impl->updateCFG();
    cleanup(memset_impl);
}
// define dso_local void @__gnalc_builtin_memcpy(ptr %0, ptr %1, i64 %2)  {
// 3:
//   br label %5
//
// 5:
//   %6 = phi i64 [ %9, %5 ], [ %2, %3 ]
//   %7 = phi ptr [ %10, %5 ], [ %1, %3 ]
//   %8 = phi ptr [ %12, %5 ], [ %0, %3 ]
//   %9 = add i64 %6, -1
//   %10 = getelementptr i8, ptr %7, i64 1
//   %11 = load i8, ptr %7, align 1
//   %12 = getelementptr i8, ptr %8, i64 1
//   store i8 %11, ptr %8, align 1
//   %13 = icmp eq i64 %9, 0
//   br i1 %13, label %14, label %5
//
// 14:
//   ret void
// }
//
void lowerMemcpy(Module &module, const pFuncDecl &memcpy_decl) {
    auto dest = std::make_shared<FormalParam>("%dest", makePtrType(makeBType(IRBTYPE::I8)), 2);
    auto src = std::make_shared<FormalParam>("%src", makePtrType(makeBType(IRBTYPE::I8)), 1);
    auto len = std::make_shared<FormalParam>("%len", makeBType(IRBTYPE::I32), 2);
    auto memcpy_impl =
        std::make_shared<Function>("@__gnalc_intrinsic_memcpy", std::vector{dest, src, len}, makeBType(IRBTYPE::VOID),
                                   &module.getConstantPool(), FuncAttr::NotBuiltin | FuncAttr::LoweredIntrinsic);
    for (const auto& inst : memcpy_decl->inst_users()) {
        auto call = inst->as<CALLInst>();
        Err::gassert(call && call->getFunc() == memcpy_decl && call->getArgs()[3]->getType()->isI1()
            , "memcpy not used by array init?");
        // Remove is_volatile flag
        call->removeArg(3);
    }
    memcpy_decl->replaceSelf(memcpy_impl);
    module.addFunction(memcpy_impl);
    module.delFunctionDecl(memcpy_decl);

    auto entry = std::make_shared<BasicBlock>("%entry");
    auto body = std::make_shared<BasicBlock>("%body");
    auto exit = std::make_shared<BasicBlock>("%exit");
    memcpy_impl->addBlock(entry);
    memcpy_impl->addBlock(body);
    memcpy_impl->addBlock(exit);

    IRBuilder entry_builder(entry);
    entry_builder.makeBr(body);

    IRBuilder body_builder(body);
    auto phi1 = body_builder.makePhi(makeBType(IRBTYPE::I32));
    auto phi2 = body_builder.makePhi(makePtrType(makeBType(IRBTYPE::I8)));
    auto phi3 = body_builder.makePhi(makePtrType(makeBType(IRBTYPE::I8)));

    auto add = body_builder.makeAdd(phi1, module.getConst(-1));
    auto gep1 = body_builder.makeGep(phi2, module.getConst(1));
    auto ld = body_builder.makeLoad(phi2, 1);
    auto gep2 = body_builder.makeGep(phi3, module.getConst(1));
    (void)body_builder.makeStore(ld, phi3, 1);
    auto icmp = body_builder.makeIcmp(ICMPOP::eq, add, module.getConst(0));
    (void)body_builder.makeBr(icmp, exit, body);

    phi1->addPhiOper(len, entry);
    phi1->addPhiOper(add, body);
    phi2->addPhiOper(src, entry);
    phi2->addPhiOper(gep1, body);
    phi3->addPhiOper(dest, entry);
    phi3->addPhiOper(gep2, body);

    IRBuilder exit_builder(exit);
    (void)exit_builder.makeRet();
    memcpy_impl->updateCFG();
    cleanup(memcpy_impl);
}
PM::PreservedAnalyses LowerIntrinsicsPass::run(Module &module, MAM &manager) {
    auto &target = manager.getResult<TargetAnalysis>(module);

    // copy it since we'll delete the function decls once we've lowered them
    auto decls = module.getFunctionDecls();
    for (const auto &func_decl : decls) {
        // Skip non-intrinsic or useless functions
        if (!func_decl->isIntrinsic() || func_decl->getUseCount() == 0)
            continue;

        // Skip intrinsics that are supported by the target
        if (target->isIntrinsicSupported(func_decl->getIntrinsicID()))
            continue;

        if (func_decl->getIntrinsicID() == IntrinsicID::Memset)
            lowerMemset(module, func_decl);
        else if (func_decl->getIntrinsicID() == IntrinsicID::Memcpy)
            lowerMemcpy(module, func_decl);
        else
            Err::unreachable("Unhandled intrinsic");
    }

    return PreserveNone();
}
} // namespace IR