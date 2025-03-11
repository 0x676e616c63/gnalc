//
// dom_idf_bug
// Created by panda on 25-3-11.
// source: contest/h_functional/04_break_continue.sy
//
int main() {
    int sum = 0;
    int i = 0;
    while(i < 20) {
        int j = 0;
        while (j < 10) {
            int k = 0;
            while (k < 5) {
                int m = 0;
                while (m < 3) {
                    if (m + 1 >= 3)
                        if (m)
                            if (m || !m)
                                if (m - -1 >= 3)
                                {{{{;;break;continue;}}}}
                    int n = 0;
                    while (n < 2) {
                        n = n + 1;
                        continue;
                        break;
                        sum = sum + 1;
                    }
                    m = m + 1;
                    sum = sum + 1;
                }
                while(1) {
                    while(1) break;
                    break;
                }
                k = k + 1;
            }
            j = j + 1;
            continue;
            j = j + 1;
        }
        i = i + 1;
    }
    return sum;
}

// 旧版本idf输出：
///home/panda/code/gnalc/cmake-build-debug/gnalc -S --log debug -emit-llvm --mem2reg
// -fuzz-repro "IR::GVNPREPass, IR::CFGSimplifyPass, IR::NameNormalizePass, IR::ADCEPass"
//(Post)DomTree:
//%46
//|   %1
//|   |   %0
//|   |   %44
//|   |   |   %6
//|   |   |   |   %5
//|   |   |   |   %42
//|   |   |   |   |   %11
//|   |   |   |   |   |   %10
//|   |   |   |   |   |   %40
//|   |   |   |   |   |   |   %16
//|   |   |   |   |   |   |   |   %15
//|   |   |   |   |   |   |   |   %38
//|   |   |   |   |   |   |   |   |   %33
//|   |   |   |   |   |   |   |   |   |   %32
//|   |   |   |   |   |   |   |   |   |   |   %20
//|   |   |   |   |   |   |   |   |   |   |   %23
//|   |   |   |   |   |   |   |   |   |   %36
//|   |   |   |   |   |   |   %29
//|   |   |   |   |   |   |   %25
//|   |   |   |   |   |   |   %27
//; Module:
//
//
//define dso_local i32 @main() {
//0:
//  br label %1
//
//1:
//  %2 = phi i32 [ 0, %0 ], [ %7, %44 ]
//  %3 = phi i32 [ 0, %0 ], [ %45, %44 ]
//  %4 = icmp slt i32 %3, 20
//  br i1 %4, label %5, label %46
//
//5:
//  br label %6
//
//6:
//  %7 = phi i32 [ %2, %5 ], [ %12, %42 ]
//  %8 = phi i32 [ 0, %5 ], [ %43, %42 ]
//  %9 = icmp slt i32 %8, 10
//  br i1 %9, label %10, label %44
//
//10:
//  br label %11
//
//11:
//  %12 = phi i32 [ %7, %10 ], [ %17, %40 ]
//  %13 = phi i32 [ 0, %10 ], [ %41, %40 ]
//  %14 = icmp slt i32 %13, 5
//  br i1 %14, label %15, label %42
//
//15:
//  br label %16
//
//16:
//  %17 = phi i32 [ %12, %15 ], [ %39, %38 ]
//  %18 = phi i32 [ 0, %15 ], [ %21, %38 ]
//  %19 = icmp slt i32 %18, 3
//  br i1 %19, label %20, label %40
//
//20:
//  %21 = add i32 %18, 1
//  br label %32
//
//32:
//  br label %33
//
//33:
//  %34 = phi i32 [ 0, %32 ], [ %37, %36 ]
//  %35 = icmp slt i32 %34, 2
//  br i1 %35, label %36, label %38
//
//36:
//  %37 = add i32 %34, 1
//  br label %33
//
//38:
//  %39 = add i32 %17, 1
//  br label %16
//
//40:
//  %41 = add i32 %13, 1
//  br label %11
//
//42:
//  %43 = add i32 %8, 1
//  br label %6
//
//44:
//  %45 = add i32 %3, 1
//  br label %1
//
//46:
//  ret i32 %2
//
//}
//
//[INFO] [FuzzTesting]: Reproducing pipeline: IR::GVNPREPass, IR::CFGSimplifyPass, IR::NameNormalizePass, IR::ADCEPass
//[INFO] [AM]: Running 'PM::InnerAnalysisManagerProxy<AnalysisManager<IR::Function>, IR::Module>' on ''
//[INFO] [AM]: Running 'IR::DomTreeAnalysis' on '@main'
//[INFO] [PM]: Finished 'IR::PromotePass' on '@main'.(inst: 84 -> 58)
//[INFO] [PM]: Finished 'IR::TailRecursionEliminationPass' on '@main'.(inst: 58 -> 58)
//[INFO] [PM]: Finished 'IR::InlinePass' on '@main'.(inst: 58 -> 58)
//[INFO] [PM]: Finished 'IR::NameNormalizePass' on '@main'.(inst: 58 -> 58)
//[INFO] [PM]: Finished 'IR::BreakCriticalEdgesPass' on '@main'.(inst: 58 -> 66)
//[INFO] [AM]: Running 'IR::DomTreeAnalysis' on '@main'
//[INFO] [AM]: Running 'IR::PostDomTreeAnalysis' on '@main'
//[DEBUG] [GVN-PRE] on '@main': '%43' replaced with '%21'.
//[INFO] [PM]: Finished 'IR::GVNPREPass' on '@main'.(inst: 66 -> 65)
//[INFO] [AM]: Get cached 'IR::DomTreeAnalysis' on '@main'
//[INFO] [PM]: Finished 'IR::VerifyPass' on '@main'.(inst: 65 -> 65)
//[DEBUG] [CFGSimplify] on '@main': Remove empty BasicBlock '%46_bce_%51'.
//[DEBUG] [CFGSimplify] on '@main': Remove empty BasicBlock '%50'.
//[DEBUG] [CFGSimplify] on '@main': Remove empty BasicBlock '%48_bce_%50'.
//[DEBUG] [CFGSimplify] on '@main': Remove empty BasicBlock '%49'.
//[DEBUG] [CFGSimplify] on '@main': drop BRInst of BasicBlock '%48' 's identical destination
//[DEBUG] [CFGSimplify] on '@main': Remove empty BasicBlock '%47'.
//[DEBUG] [CFGSimplify] on '@main': Remove empty BasicBlock '%45'.
//[DEBUG] [CFGSimplify] on '@main': Remove empty BasicBlock '%16_bce_%45'.
//[DEBUG] [CFGSimplify] on '@main': Remove empty BasicBlock '%20_bce_%36'.
//[DEBUG] [CFGSimplify] on '@main': Remove empty BasicBlock '%35'.
//[DEBUG] [CFGSimplify] on '@main': Remove empty BasicBlock '%23_bce_%35'.
//[DEBUG] [CFGSimplify] on '@main': Remove empty BasicBlock '%34'.
//[DEBUG] [CFGSimplify] on '@main': Remove empty BasicBlock '%33'.
//[DEBUG] [CFGSimplify] on '@main': Remove empty BasicBlock '%32'.
//[DEBUG] [CFGSimplify] on '@main': Remove empty BasicBlock '%25_bce_%29'.
//[DEBUG] [CFGSimplify] on '@main': Remove empty BasicBlock '%27_bce_%34'.
//[DEBUG] [CFGSimplify] on '@main': Remove empty BasicBlock '%27_bce_%29'.
//[DEBUG] [CFGSimplify] on '@main': Remove empty BasicBlock '%48'.
//[DEBUG] [CFGSimplify] on '@main': drop BRInst of BasicBlock '%46' 's identical destination
//[DEBUG] [CFGSimplify] on '@main': Remove empty BasicBlock '%46'.
//[INFO] [PM]: Finished 'IR::CFGSimplifyPass' on '@main'.(inst: 65 -> 47)
//[INFO] [AM]: Running 'IR::DomTreeAnalysis' on '@main'
//[INFO] [PM]: Finished 'IR::VerifyPass' on '@main'.(inst: 47 -> 47)
//[INFO] [PM]: Finished 'IR::NameNormalizePass' on '@main'.(inst: 47 -> 47)
//[INFO] [AM]: Running 'IR::PostDomTreeAnalysis' on '@main'
//%0: TRUE
//%1: %1, TRUE
//%5: %1, TRUE
//%6: %1, %6, TRUE
//%10: %6, TRUE
//%11: %6, %11, TRUE
//%15: %11, TRUE
//%16: %11, %16, %29, %27, TRUE
//%20: %16, TRUE
//%23: %20, TRUE
//%25: TRUE
//%27: %25, TRUE
//%29: %25, %27, TRUE
//%32: %16, %29, %27, TRUE
//%33: %16, %33, %29, %27, TRUE
//%36: %33, TRUE
//%38: %16, %29, %27, TRUE
//%40: %11, TRUE
//%42: %6, TRUE
//%44: %1, TRUE
//%46: TRUE
//%4, %1
//%9, %6
//%14, %11
//%19, %16
//%21, %20
//%26, %25
//%28, %27
//%30, %29
//%31, %29
//%13, %11
//%8, %6
//%35, %33
//%37, %36
//%3, %1
//%17, %16
//%12, %11
//%7, %6
//%2, %1
//%39, %38
//%41, %40
//%43, %42
//%45, %44
//__ret, %46
//__br, %0
//__br, %1
//__br, %5
//__br, %6
//__br, %10
//__br, %11
//__br, %15
//__br, %16
//__br, %25
//__br, %27
//__br, %29
//__br, %32
//__br, %33
//__br, %36
//__br, %38
//__br, %40
//__br, %42
//__br, %44
//%18, %16
//%34, %33
//
//[DEBUG] [ADCE]: Retargeting '%20' to '%32
//[DEBUG] [ADCE]: Retargeting '%23' to '%32
//[INFO] [PM]: Finished 'IR::ADCEPass' on '@main'.(inst: 47 -> 37)
//[INFO] [AM]: Running 'IR::DomTreeAnalysis' on '@main'
//[INFO] [PM]: Finished 'IR::VerifyPass' on '@main'.(inst: 37 -> 37)
//[INFO] [PM]: Finished 'IR::ModulePassWrapper' on ''.
//[INFO] [PM]: Finished 'IR::PrintModulePass' on ''.
//
//进程已结束，退出代码为 0

// 新版本idf输出：
///home/panda/code/gnalc/cmake-build-debug/gnalc -S --log debug -emit-llvm --mem2reg
// -fuzz-repro "IR::GVNPREPass, IR::CFGSimplifyPass, IR::NameNormalizePass, IR::ADCEPass"
//(Post)DomTree:
//%46
//|   %1
//|   |   %0
//|   |   %44
//|   |   |   %6
//|   |   |   |   %5
//|   |   |   |   %42
//|   |   |   |   |   %11
//|   |   |   |   |   |   %10
//|   |   |   |   |   |   %40
//|   |   |   |   |   |   |   %16
//|   |   |   |   |   |   |   |   %15
//|   |   |   |   |   |   |   |   %38
//|   |   |   |   |   |   |   |   |   %33
//|   |   |   |   |   |   |   |   |   |   %32
//|   |   |   |   |   |   |   |   |   |   |   %20
//|   |   |   |   |   |   |   |   |   |   |   %23
//|   |   |   |   |   |   |   |   |   |   %36
//|   |   |   |   |   |   |   %29
//|   |   |   |   |   |   |   %25
//|   |   |   |   |   |   |   %27
//; Module:
//
//
//define dso_local i32 @main() {
//0:
//  br label %1
//
//1:
//  %2 = phi i32 [ 0, %0 ], [ %7, %44 ]
//  %3 = phi i32 [ 0, %0 ], [ %45, %44 ]
//  %4 = icmp slt i32 %3, 20
//  br i1 %4, label %5, label %46
//
//5:
//  br label %6
//
//6:
//  %7 = phi i32 [ %2, %5 ], [ %12, %42 ]
//  %8 = phi i32 [ 0, %5 ], [ %43, %42 ]
//  %9 = icmp slt i32 %8, 10
//  br i1 %9, label %10, label %44
//
//10:
//  br label %11
//
//11:
//  %12 = phi i32 [ %7, %10 ], [ %17, %40 ]
//  %13 = phi i32 [ 0, %10 ], [ %41, %40 ]
//  %14 = icmp slt i32 %13, 5
//  br i1 %14, label %15, label %42
//
//15:
//  br label %16
//
//16:
//  %17 = phi i32 [ %12, %15 ], [ %39, %38 ]
//  %18 = phi i32 [ 0, %15 ], [ %21, %38 ]
//  %19 = icmp slt i32 %18, 3
//  br i1 %19, label %20, label %40
//
//20:
//  %21 = add i32 %18, 1
//  %22 = icmp sge i32 %21, 3
//  br i1 %22, label %23, label %32
//
//23:
//  %24 = icmp ne i32 %18, 0
//  br i1 %24, label %25, label %32
//
//25:
//  %26 = icmp ne i32 %18, 0
//  br i1 %26, label %29, label %27
//
//27:
//  %28 = icmp eq i32 %18, 0
//  br i1 %28, label %29, label %32
//
//29:
//  %30 = sub i32 %18, -1
//  %31 = icmp sge i32 %30, 3
//  br i1 %31, label %40, label %32
//
//32:
//  br label %33
//
//33:
//  %34 = phi i32 [ 0, %32 ], [ %37, %36 ]
//  %35 = icmp slt i32 %34, 2
//  br i1 %35, label %36, label %38
//
//36:
//  %37 = add i32 %34, 1
//  br label %33
//
//38:
//  %39 = add i32 %17, 1
//  br label %16
//
//40:
//  %41 = add i32 %13, 1
//  br label %11
//
//42:
//  %43 = add i32 %8, 1
//  br label %6
//
//44:
//  %45 = add i32 %3, 1
//  br label %1
//
//46:
//  ret i32 %2
//
//}
//
//[INFO] [FuzzTesting]: Reproducing pipeline: IR::GVNPREPass, IR::CFGSimplifyPass, IR::NameNormalizePass, IR::ADCEPass
//[INFO] [AM]: Running 'PM::InnerAnalysisManagerProxy<AnalysisManager<IR::Function>, IR::Module>' on ''
//[INFO] [AM]: Running 'IR::DomTreeAnalysis' on '@main'
//[INFO] [PM]: Finished 'IR::PromotePass' on '@main'.(inst: 84 -> 58)
//[INFO] [PM]: Finished 'IR::TailRecursionEliminationPass' on '@main'.(inst: 58 -> 58)
//[INFO] [PM]: Finished 'IR::InlinePass' on '@main'.(inst: 58 -> 58)
//[INFO] [PM]: Finished 'IR::NameNormalizePass' on '@main'.(inst: 58 -> 58)
//[INFO] [PM]: Finished 'IR::BreakCriticalEdgesPass' on '@main'.(inst: 58 -> 66)
//[INFO] [AM]: Running 'IR::DomTreeAnalysis' on '@main'
//[INFO] [AM]: Running 'IR::PostDomTreeAnalysis' on '@main'
//[DEBUG] [GVN-PRE] on '@main': '%43' replaced with '%21'.
//[INFO] [PM]: Finished 'IR::GVNPREPass' on '@main'.(inst: 66 -> 65)
//[INFO] [AM]: Get cached 'IR::DomTreeAnalysis' on '@main'
//[INFO] [PM]: Finished 'IR::VerifyPass' on '@main'.(inst: 65 -> 65)
//[DEBUG] [CFGSimplify] on '@main': Remove empty BasicBlock '%46_bce_%51'.
//[DEBUG] [CFGSimplify] on '@main': Remove empty BasicBlock '%50'.
//[DEBUG] [CFGSimplify] on '@main': Remove empty BasicBlock '%48_bce_%50'.
//[DEBUG] [CFGSimplify] on '@main': Remove empty BasicBlock '%49'.
//[DEBUG] [CFGSimplify] on '@main': drop BRInst of BasicBlock '%48' 's identical destination
//[DEBUG] [CFGSimplify] on '@main': Remove empty BasicBlock '%47'.
//[DEBUG] [CFGSimplify] on '@main': Remove empty BasicBlock '%45'.
//[DEBUG] [CFGSimplify] on '@main': Remove empty BasicBlock '%16_bce_%45'.
//[DEBUG] [CFGSimplify] on '@main': Remove empty BasicBlock '%20_bce_%36'.
//[DEBUG] [CFGSimplify] on '@main': Remove empty BasicBlock '%35'.
//[DEBUG] [CFGSimplify] on '@main': Remove empty BasicBlock '%23_bce_%35'.
//[DEBUG] [CFGSimplify] on '@main': Remove empty BasicBlock '%34'.
//[DEBUG] [CFGSimplify] on '@main': Remove empty BasicBlock '%33'.
//[DEBUG] [CFGSimplify] on '@main': Remove empty BasicBlock '%32'.
//[DEBUG] [CFGSimplify] on '@main': Remove empty BasicBlock '%25_bce_%29'.
//[DEBUG] [CFGSimplify] on '@main': Remove empty BasicBlock '%27_bce_%34'.
//[DEBUG] [CFGSimplify] on '@main': Remove empty BasicBlock '%27_bce_%29'.
//[DEBUG] [CFGSimplify] on '@main': Remove empty BasicBlock '%48'.
//[DEBUG] [CFGSimplify] on '@main': drop BRInst of BasicBlock '%46' 's identical destination
//[DEBUG] [CFGSimplify] on '@main': Remove empty BasicBlock '%46'.
//[INFO] [PM]: Finished 'IR::CFGSimplifyPass' on '@main'.(inst: 65 -> 47)
//[INFO] [AM]: Running 'IR::DomTreeAnalysis' on '@main'
//[INFO] [PM]: Finished 'IR::VerifyPass' on '@main'.(inst: 47 -> 47)
//[INFO] [PM]: Finished 'IR::NameNormalizePass' on '@main'.(inst: 47 -> 47)
//[INFO] [AM]: Running 'IR::PostDomTreeAnalysis' on '@main'
//%0: TRUE
//%1: %1, TRUE
//%5: %1, TRUE
//%6: %1, %6, TRUE
//%10: %6, TRUE
//%11: %6, %11, TRUE
//%15: %11, TRUE
//%16: %11, %16, %29, %27, TRUE
//%20: %16, TRUE
//%23: %20, TRUE
//%25: %23, TRUE // 主要差异！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！！
//%27: %25, TRUE
//%29: %25, %27, TRUE
//%32: %16, %29, %27, TRUE
//%33: %16, %33, %29, %27, TRUE
//%36: %33, TRUE
//%38: %16, %29, %27, TRUE
//%40: %11, TRUE
//%42: %6, TRUE
//%44: %1, TRUE
//%46: TRUE
//%4, %1
//%9, %6
//%14, %11
//%19, %16
//%21, %20
//%22, %20
//%24, %23
//%26, %25
//%28, %27
//%30, %29
//%31, %29
//%13, %11
//%8, %6
//%35, %33
//%37, %36
//%3, %1
//%17, %16
//%12, %11
//%7, %6
//%2, %1
//%39, %38
//%41, %40
//%43, %42
//%45, %44
//__ret, %46
//__br, %0
//__br, %1
//__br, %5
//__br, %6
//__br, %10
//__br, %11
//__br, %15
//__br, %16
//__br, %20
//__br, %23
//__br, %25
//__br, %27
//__br, %29
//__br, %32
//__br, %33
//__br, %36
//__br, %38
//__br, %40
//__br, %42
//__br, %44
//%18, %16
//%34, %33
//
//[INFO] [PM]: Finished 'IR::ADCEPass' on '@main'.(inst: 47 -> 47)
//[INFO] [AM]: Get cached 'IR::DomTreeAnalysis' on '@main'
//[INFO] [PM]: Finished 'IR::VerifyPass' on '@main'.(inst: 47 -> 47)
//[INFO] [PM]: Finished 'IR::ModulePassWrapper' on ''.
//[INFO] [PM]: Finished 'IR::PrintModulePass' on ''.
//
//进程已结束，退出代码为 0