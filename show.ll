; Module: 

@a = dso_local global i32 1, align 4
@b = dso_local global [2 x i32] [i32 1, i32 2], align 4
@c = dso_local global [2 x [2 x i32]] [[2 x i32] [i32 1, i32 2], [2 x i32] [i32 3, i32 4]], align 4
@d = dso_local global i32 0, align 4
@e = dso_local global [2 x i32] zeroinitializer, align 4
@f = dso_local global [2 x [3 x i32]] zeroinitializer, align 4

define dso_local i32 @main() {
entry:
  %1 = load i32, i32* @a, align 4
  store i32 %1, i32* @d, align 4
  %2 = getelementptr [2 x [2 x i32]], [2 x [2 x i32]]* @c, i32 0, i32 1
  %3 = getelementptr [2 x i32], [2 x i32]* %2, i32 0, i32 0
  %4 = load i32, i32* %3, align 4
  store i32 %4, i32* @a, align 4
  ret i32 0

}

