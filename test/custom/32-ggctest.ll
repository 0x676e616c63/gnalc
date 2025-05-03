; Module: ../test/custom/32-ggctest.gg


define dso_local void @func(i32 noundef %0, i32 noundef %1, i32 noundef %2) {
3:
  %4 = alloca i32, align 4
  %5 = alloca i32, align 4
  %6 = alloca i32, align 4
  store i32 %0, i32* %4, align 4
  store i32 %1, i32* %5, align 4
  store i32 %2, i32* %6, align 4
  ret void

}

define dso_local i32 @main() {
0:
  %6.cloned = alloca i32, align 4
  %5.cloned = alloca i32, align 4
  %4.cloned = alloca i32, align 4
  br label %3.cloned.inline.entry0

3.cloned.inline.entry0:
  store i32 20, i32* %4.cloned, align 4
  store i32 10, i32* %5.cloned, align 4
  store i32 15, i32* %6.cloned, align 4
  br label %inline.aftercall1

inline.aftercall1:
  ret i32 0

}

