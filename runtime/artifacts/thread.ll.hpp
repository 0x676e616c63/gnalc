R"(; ModuleID = 'thread.cpp'
%struct.cpu_set_t = type { [16 x i64] }

@_ZL5state.0 = internal unnamed_addr global ptr null, align 64
@_ZL5state.1 = internal unnamed_addr global i32 0, align 8
@_ZL5state.2 = internal unnamed_addr global i32 0, align 4
@_ZL5state.3 = internal unnamed_addr global i8 0, align 64
@_ZL5state.4 = internal unnamed_addr global i8 0, align 64
@_ZL5state.5 = internal unnamed_addr global i8 0, align 64
@_ZL5state.6 = internal unnamed_addr global i8 0, align 1
@_ZL12worker_stack = internal unnamed_addr global ptr null, align 8
@llvm.global_ctors = appending global [1 x { i32, ptr, ptr }] [{ i32, ptr, ptr } { i32 65535, ptr @gnalc_thread_init, ptr null }]
@llvm.global_dtors = appending global [1 x { i32, ptr, ptr }] [{ i32, ptr, ptr } { i32 65535, ptr @gnalc_thread_deinit, ptr null }]

; Function Attrs: mustprogress nounwind sspstrong uwtable
define dso_local void @gnalc_thread_init() #0 {
  %1 = alloca %struct.cpu_set_t, align 8
  call void @llvm.lifetime.start.p0(i64 128, ptr nonnull %1) #7
  %2 = getelementptr inbounds nuw i8, ptr %1, i64 8
  call void @llvm.memset.p0.i64(ptr noundef nonnull align 8 dereferenceable(128) %2, i8 0, i64 120, i1 false)
  store i64 4, ptr %1, align 8, !tbaa !5
  %3 = call i32 @sched_setaffinity(i32 noundef 0, i64 noundef 128, ptr noundef nonnull %1) #7
  store atomic i8 0, ptr @_ZL5state.3 release, align 64
  store atomic i8 0, ptr @_ZL5state.4 release, align 64
  store atomic i8 0, ptr @_ZL5state.5 release, align 64
  %4 = call ptr @mmap(ptr noundef null, i64 noundef 65536, i32 noundef 3, i32 noundef 131106, i32 noundef -1, i64 noundef 0) #7
  store ptr %4, ptr @_ZL12worker_stack, align 8, !tbaa !9
  %5 = getelementptr inbounds nuw i8, ptr %4, i64 65536
  %6 = call i32 (ptr, ptr, i32, ptr, ...) @clone(ptr noundef nonnull @_ZL12worker_entryPv, ptr noundef nonnull %5, i32 noundef 331520, ptr noundef null) #7
  call void @llvm.lifetime.end.p0(i64 128, ptr nonnull %1) #7
  ret void
}

; Function Attrs: mustprogress nocallback nofree nosync nounwind willreturn memory(argmem: readwrite)
declare void @llvm.lifetime.start.p0(i64 immarg, ptr nocapture) #1

; Function Attrs: mustprogress nocallback nofree nounwind willreturn memory(argmem: write)
declare void @llvm.memset.p0.i64(ptr nocapture writeonly, i8, i64, i1 immarg) #2

; Function Attrs: mustprogress nocallback nofree nosync nounwind willreturn memory(argmem: readwrite)
declare void @llvm.lifetime.end.p0(i64 immarg, ptr nocapture) #1

; Function Attrs: nounwind
declare i32 @sched_setaffinity(i32 noundef, i64 noundef, ptr noundef) local_unnamed_addr #3

; Function Attrs: nounwind
declare ptr @mmap(ptr noundef, i64 noundef, i32 noundef, i32 noundef, i32 noundef, i64 noundef) local_unnamed_addr #3

; Function Attrs: nounwind
declare i32 @clone(ptr noundef, ptr noundef, i32 noundef, ptr noundef, ...) local_unnamed_addr #3

; Function Attrs: mustprogress sspstrong uwtable
define internal noundef i32 @_ZL12worker_entryPv(ptr nocapture readnone %0) #4 {
  %2 = alloca %struct.cpu_set_t, align 8
  call void @llvm.lifetime.start.p0(i64 128, ptr nonnull %2) #7
  %3 = getelementptr inbounds nuw i8, ptr %2, i64 8
  call void @llvm.memset.p0.i64(ptr noundef nonnull align 8 dereferenceable(128) %3, i8 0, i64 120, i1 false)
  store i64 8, ptr %2, align 8, !tbaa !5
  %4 = call i32 @sched_setaffinity(i32 noundef 0, i64 noundef 128, ptr noundef nonnull %2) #7
  br label %5

5:                                                ; preds = %11, %1
  %6 = load atomic i8, ptr @_ZL5state.3 acquire, align 64
  %7 = trunc i8 %6 to i1
  br i1 %7, label %13, label %8

8:                                                ; preds = %5
  %9 = load atomic i8, ptr @_ZL5state.5 acquire, align 64
  %10 = trunc i8 %9 to i1
  br i1 %10, label %12, label %11

11:                                               ; preds = %8, %13
  br label %5, !llvm.loop !11

12:                                               ; preds = %8
  store atomic i8 1, ptr @_ZL5state.6 release, align 1
  call void @llvm.lifetime.end.p0(i64 128, ptr nonnull %2) #7
  ret i32 0

13:                                               ; preds = %5
  %14 = load ptr, ptr @_ZL5state.0, align 64, !tbaa !13
  %15 = load i32, ptr @_ZL5state.1, align 8, !tbaa !20
  %16 = load i32, ptr @_ZL5state.2, align 4, !tbaa !21
  call void %14(i32 noundef %15, i32 noundef %16)
  store atomic i8 1, ptr @_ZL5state.4 release, align 64
  store atomic i8 0, ptr @_ZL5state.3 release, align 64
  br label %11
}

; Function Attrs: mustprogress nounwind sspstrong uwtable
define dso_local void @gnalc_thread_deinit() #0 {
  store atomic i8 1, ptr @_ZL5state.5 release, align 64
  br label %1

1:                                                ; preds = %1, %0
  %2 = load atomic i8, ptr @_ZL5state.6 acquire, align 1
  %3 = trunc i8 %2 to i1
  br i1 %3, label %4, label %1, !llvm.loop !22

4:                                                ; preds = %1
  %5 = load ptr, ptr @_ZL12worker_stack, align 8, !tbaa !9
  %6 = tail call i32 @munmap(ptr noundef %5, i64 noundef 65536) #7
  ret void
}

; Function Attrs: nounwind
declare i32 @munmap(ptr noundef, i64 noundef) local_unnamed_addr #3

; Function Attrs: mustprogress sspstrong uwtable
define dso_local void @gnalc_parallel_for(i32 noundef %0, i32 noundef %1, ptr noundef %2) local_unnamed_addr #4 {
  %4 = sub nsw i32 %1, %0
  %5 = icmp slt i32 %4, 65
  br i1 %5, label %6, label %7

6:                                                ; preds = %3
  tail call void %2(i32 noundef %0, i32 noundef %1)
  br label %13

7:                                                ; preds = %3
  %8 = lshr i32 %4, 1
  %9 = add nsw i32 %8, %0
  store i32 %9, ptr @_ZL5state.1, align 8, !tbaa !20
  store i32 %1, ptr @_ZL5state.2, align 4, !tbaa !21
  store ptr %2, ptr @_ZL5state.0, align 64, !tbaa !13
  store atomic i8 0, ptr @_ZL5state.4 monotonic, align 64
  fence release
  store atomic i8 1, ptr @_ZL5state.3 release, align 64
  tail call void %2(i32 noundef %0, i32 noundef %9)
  br label %10

10:                                               ; preds = %10, %7
  %11 = load atomic i8, ptr @_ZL5state.4 acquire, align 64
  %12 = trunc i8 %11 to i1
  br i1 %12, label %13, label %10, !llvm.loop !23

13:                                               ; preds = %10, %6
  ret void
}

; Function Attrs: mustprogress nofree norecurse nounwind sspstrong willreturn memory(argmem: readwrite) uwtable
define dso_local void @gnalc_atomic_add_i32(ptr nocapture noundef nonnull align 4 dereferenceable(4) %0, i32 noundef %1) local_unnamed_addr #5 {
  %3 = atomicrmw add ptr %0, i32 %1 seq_cst, align 4
  ret void
}

; Function Attrs: mustprogress nofree norecurse nounwind sspstrong memory(argmem: readwrite) uwtable
define dso_local void @gnalc_atomic_add_f32(ptr nocapture noundef nonnull align 4 dereferenceable(4) %0, float noundef %1) local_unnamed_addr #6 {
  %3 = load atomic i32, ptr %0 seq_cst, align 4
  %4 = bitcast i32 %3 to float
  %5 = fadd float %1, %4
  %6 = bitcast float %5 to i32
  %7 = cmpxchg weak ptr %0, i32 %3, i32 %6 seq_cst seq_cst, align 4
  %8 = extractvalue { i32, i1 } %7, 1
  br i1 %8, label %17, label %9

9:                                                ; preds = %2, %9
  %10 = phi { i32, i1 } [ %15, %9 ], [ %7, %2 ]
  %11 = extractvalue { i32, i1 } %10, 0
  %12 = bitcast i32 %11 to float
  %13 = fadd float %1, %12
  %14 = bitcast float %13 to i32
  %15 = cmpxchg weak ptr %0, i32 %11, i32 %14 seq_cst seq_cst, align 4
  %16 = extractvalue { i32, i1 } %15, 1
  br i1 %16, label %17, label %9, !llvm.loop !24

17:                                               ; preds = %9, %2
  ret void
}

attributes #0 = { mustprogress nounwind sspstrong uwtable "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #1 = { mustprogress nocallback nofree nosync nounwind willreturn memory(argmem: readwrite) }
attributes #2 = { mustprogress nocallback nofree nounwind willreturn memory(argmem: write) }
attributes #3 = { nounwind "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #4 = { mustprogress sspstrong uwtable "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #5 = { mustprogress nofree norecurse nounwind sspstrong willreturn memory(argmem: readwrite) uwtable "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #6 = { mustprogress nofree norecurse nounwind sspstrong memory(argmem: readwrite) uwtable "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #7 = { nounwind }

!llvm.module.flags = !{!0, !1, !2, !3}
!llvm.ident = !{!4}

!0 = !{i32 1, !"wchar_size", i32 4}
!1 = !{i32 8, !"PIC Level", i32 2}
!2 = !{i32 7, !"PIE Level", i32 2}
!3 = !{i32 7, !"uwtable", i32 2}
!4 = !{!"clang version 20.1.6"}
!5 = !{!6, !6, i64 0}
!6 = !{!"long", !7, i64 0}
!7 = !{!"omnipotent char", !8, i64 0}
!8 = !{!"Simple C++ TBAA"}
!9 = !{!10, !10, i64 0}
!10 = !{!"any pointer", !7, i64 0}
!11 = distinct !{!11, !12}
!12 = !{!"llvm.loop.mustprogress"}
!13 = !{!14, !10, i64 0}
!14 = !{!"_ZTS13ParallelState", !10, i64 0, !15, i64 8, !15, i64 12, !16, i64 64, !16, i64 128, !19, i64 192}
!15 = !{!"int", !7, i64 0}
!16 = !{!"_ZTSSt6atomicIbE", !17, i64 0}
!17 = !{!"_ZTSSt13__atomic_baseIbE", !18, i64 0}
!18 = !{!"bool", !7, i64 0}
!19 = !{!"_ZTSN13ParallelState13ShutdownFlagsE", !16, i64 0, !16, i64 1}
!20 = !{!14, !15, i64 8}
!21 = !{!14, !15, i64 12}
!22 = distinct !{!22, !12}
!23 = distinct !{!23, !12}
!24 = distinct !{!24, !12}
)"