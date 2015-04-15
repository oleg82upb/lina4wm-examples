; ModuleID = 'dekker.c'
target datalayout = "e-p:32:32:32-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:32:64-f32:32:32-f64:32:64-v64:64:64-v128:128:128-a0:0:64-f80:32:32-n8:16:32-S128"
target triple = "i386-pc-linux-gnu"

@flag0 = global i8* null, align 4
@flag1 = global i8* null, align 4
@turn = global i8* null, align 4

define void @p0() nounwind {
entry:
  store i8 1, i8* @flag0, align 1
  br label %while.cond

while.cond:                                       ; preds = %if.end, %entry
  fence seq_cst
  %2 = load i8* @flag1, align 1
  br i1 %2, label %while.body, label %while.end12

while.body:                                       ; preds = %while.cond
  %4 = load i8* @turn, align 1
  br i1 %4, label %while.cond, label %if.then

if.then:                                          ; preds = %while.body
  store i8 0, i8* @flag0, align 1
  br label %while.cond6

while.cond6:                                      ; preds = %while.body11, %if.then
  %7 = load i8* @turn, align 1
  br i1 %7, label %while.end, label %while.cond6

while.end:                                        ; preds = %while.cond6
  %8 = load i8** @flag0, align 4
  store i8 1, i8* %8, align 1
  br label %while.cond

while.end12:                                      ; preds = %while.cond
  store i8 1, i8* @turn, align 1
  store i8 0, i8* @flag, align 1
  ret void
}

define void @p1() nounwind {
entry:
  %0 = load i8** @flag1, align 4
  store i8 1, i8* @flag1, align 1
  fence seq_cst
  br label %while.cond

while.cond:                                       ; preds = %if.end, %entry
  %1 = load i8** @flag0, align 4
  %2 = load i8* %1, align 1
  %tobool = trunc i8 %2 to i1
  %conv = zext i1 %tobool to i32
  %cmp = icmp eq i32 %conv, 1
  br i1 %cmp, label %while.body, label %while.end12

while.body:                                       ; preds = %while.cond
  %3 = load i8** @turn, align 4
  %4 = load i8* %3, align 1
  %tobool2 = trunc i8 %4 to i1
  %conv3 = zext i1 %tobool2 to i32
  %cmp4 = icmp ne i32 %conv3, 1
  br i1 %cmp4, label %if.then, label %if.end

if.then:                                          ; preds = %while.body
  %5 = load i8** @flag1, align 4
  store i8 0, i8* %5, align 1
  br label %while.cond6

while.cond6:                                      ; preds = %while.body11, %if.then
  %6 = load i8** @turn, align 4
  %7 = load i8* %6, align 1
  %tobool7 = trunc i8 %7 to i1
  %conv8 = zext i1 %tobool7 to i32
  %cmp9 = icmp ne i32 %conv8, 1
  br i1 %cmp9, label %while.body11, label %while.end

while.body11:                                     ; preds = %while.cond6
  br label %while.cond6

while.end:                                        ; preds = %while.cond6
  %8 = load i8** @flag1, align 4
  store i8 1, i8* %8, align 1
  br label %if.end

if.end:                                           ; preds = %while.end, %while.body
  br label %while.cond

while.end12:                                      ; preds = %while.cond
  %9 = load i8** @turn, align 4
  store i8 0, i8* %9, align 1
  %10 = load i8** @flag1, align 4
  store i8 0, i8* %10, align 1
  ret void
}

define i32 @main() nounwind {
entry:
  ret i32 0
}
