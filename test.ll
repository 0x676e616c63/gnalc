; Module: ./test/custom/13-localarray.c


define dso_local i32 @main() {
0:
  %1 = alloca [8 x i32], align 4
  %2 = alloca [9 x i32], align 4
  %3 = alloca [32 x i32], align 4
  %4 = alloca [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x i32]]]]]]]]]]]]]]]]]]], align 4
  %5 = alloca [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x i32]]]]]]]]]]]]]]]]]]], align 4
  %6 = getelementptr [8 x i32], [8 x i32]* %1, i32 0, i32 0
  store i32 1, i32* %6, align 4
  %7 = getelementptr [8 x i32], [8 x i32]* %1, i32 0, i32 1
  store i32 0, i32* %7, align 4
  %8 = getelementptr [8 x i32], [8 x i32]* %1, i32 0, i32 2
  store i32 0, i32* %8, align 4
  %9 = getelementptr [8 x i32], [8 x i32]* %1, i32 0, i32 3
  store i32 0, i32* %9, align 4
  %10 = getelementptr [8 x i32], [8 x i32]* %1, i32 0, i32 4
  store i32 0, i32* %10, align 4
  %11 = getelementptr [8 x i32], [8 x i32]* %1, i32 0, i32 5
  store i32 0, i32* %11, align 4
  %12 = getelementptr [8 x i32], [8 x i32]* %1, i32 0, i32 6
  store i32 0, i32* %12, align 4
  %13 = getelementptr [8 x i32], [8 x i32]* %1, i32 0, i32 7
  store i32 0, i32* %13, align 4
  %14 = bitcast [9 x i32]* %2 to i8*
  call void @llvm.memset.p0i8.i32(i8* noundef %14, i8 noundef 0, i32 noundef 36, i1 noundef 0)
  %15 = getelementptr [9 x i32], [9 x i32]* %2, i32 0, i32 0
  store i32 2, i32* %15, align 4
  %16 = bitcast [32 x i32]* %3 to i8*
  call void @llvm.memset.p0i8.i32(i8* noundef %16, i8 noundef 0, i32 noundef 128, i1 noundef 0)
  %17 = bitcast [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x i32]]]]]]]]]]]]]]]]]]]* %4 to i8*
  call void @llvm.memset.p0i8.i32(i8* noundef %17, i8 noundef 0, i32 noundef 2097152, i1 noundef 0)
  %18 = bitcast [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x i32]]]]]]]]]]]]]]]]]]]* %5 to i8*
  call void @llvm.memset.p0i8.i32(i8* noundef %18, i8 noundef 0, i32 noundef 2097152, i1 noundef 0)
  %19 = getelementptr [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x i32]]]]]]]]]]]]]]]]]]], [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x i32]]]]]]]]]]]]]]]]]]]* %5, i32 0, i32 0
  %20 = getelementptr [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x i32]]]]]]]]]]]]]]]]]], [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x i32]]]]]]]]]]]]]]]]]]* %19, i32 0, i32 0
  %21 = getelementptr [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x i32]]]]]]]]]]]]]]]]], [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x i32]]]]]]]]]]]]]]]]]* %20, i32 0, i32 0
  %22 = getelementptr [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x i32]]]]]]]]]]]]]]]], [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x i32]]]]]]]]]]]]]]]]* %21, i32 0, i32 0
  %23 = getelementptr [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x i32]]]]]]]]]]]]]]], [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x i32]]]]]]]]]]]]]]]* %22, i32 0, i32 0
  %24 = getelementptr [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x i32]]]]]]]]]]]]]], [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x i32]]]]]]]]]]]]]]* %23, i32 0, i32 0
  %25 = getelementptr [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x i32]]]]]]]]]]]]], [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x i32]]]]]]]]]]]]]* %24, i32 0, i32 0
  %26 = getelementptr [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x i32]]]]]]]]]]]], [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x i32]]]]]]]]]]]]* %25, i32 0, i32 0
  %27 = getelementptr [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x i32]]]]]]]]]]], [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x i32]]]]]]]]]]]* %26, i32 0, i32 0
  %28 = getelementptr [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x i32]]]]]]]]]], [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x i32]]]]]]]]]]* %27, i32 0, i32 0
  %29 = getelementptr [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x i32]]]]]]]]], [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x i32]]]]]]]]]* %28, i32 0, i32 0
  %30 = getelementptr [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x i32]]]]]]]], [2 x [2 x [2 x [2 x [2 x [2 x [2 x [2 x i32]]]]]]]]* %29, i32 0, i32 0
  %31 = getelementptr [2 x [2 x [2 x [2 x [2 x [2 x [2 x i32]]]]]]], [2 x [2 x [2 x [2 x [2 x [2 x [2 x i32]]]]]]]* %30, i32 0, i32 0
  %32 = getelementptr [2 x [2 x [2 x [2 x [2 x [2 x i32]]]]]], [2 x [2 x [2 x [2 x [2 x [2 x i32]]]]]]* %31, i32 0, i32 0
  %33 = getelementptr [2 x [2 x [2 x [2 x [2 x i32]]]]], [2 x [2 x [2 x [2 x [2 x i32]]]]]* %32, i32 0, i32 0
  %34 = getelementptr [2 x [2 x [2 x [2 x i32]]]], [2 x [2 x [2 x [2 x i32]]]]* %33, i32 0, i32 0
  %35 = getelementptr [2 x [2 x [2 x i32]]], [2 x [2 x [2 x i32]]]* %34, i32 0, i32 0
  %36 = getelementptr [2 x [2 x i32]], [2 x [2 x i32]]* %35, i32 0, i32 0
  %37 = getelementptr [2 x i32], [2 x i32]* %36, i32 0, i32 0
  store i32 1, i32* %37, align 4
  ret i32 0

}

declare void @llvm.memset.p0i8.i32(i8* noundef, i8 noundef, i32 noundef, i1 noundef)
