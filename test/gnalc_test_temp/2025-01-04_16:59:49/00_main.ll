; Module: 

target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-f80:128-n8:16:32:64-S128"

define dso_local i32 @main() {
; livein:
; liveout:
entry:
  ; livein:
  ; liveout:
  ret i32 3
}

declare i32 @getint()
declare i32 @getch()
declare i32 @getarray(i32* noundef)
declare float @getfloat()
declare i32 @getfarray(float* noundef)
declare void @putint(i32 noundef)
declare void @putch(i32 noundef)
declare void @putarray(i32 noundef, i32* noundef)
declare void @putfloat(float noundef)
declare void @putfarray(i32 noundef, float* noundef)
declare void @putf(i8* noundef, ...)
declare void @_sysy_starttime(i32 noundef)
declare void @_sysy_stoptime(i32 noundef)
