; Module: 


define dso_local i32 @main() {
entry:
  call void @putch(i32 noundef 72)
  call void @putch(i32 noundef 101)
  call void @putch(i32 noundef 108)
  call void @putch(i32 noundef 108)
  call void @putch(i32 noundef 111)
  call void @putch(i32 noundef 44)
  call void @putch(i32 noundef 32)
  call void @putch(i32 noundef 87)
  call void @putch(i32 noundef 111)
  call void @putch(i32 noundef 114)
  call void @putch(i32 noundef 108)
  call void @putch(i32 noundef 100)
  call void @putch(i32 noundef 33)
  call void @putch(i32 noundef 10)
  ret i32 0

}

declare void @putch(i32 noundef)
