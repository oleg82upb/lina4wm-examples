; ModuleID = 'dekker.c'
target datalayout = "e-p:32:32:32-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:32:64-f32:32:32-f64:32:64-v64:64:64-v128:128:128-a0:0:64-f80:32:32-n8:16:32-S128"
target triple = "i386-pc-linux-gnu"

@flag0 = global i8* null, align 4
@flag1 = global i8* null, align 4
@turn = global i8* null, align 4

define void @p0() nounwind {
entry:
  %0 = load i8** @flag0, align 4
  store i8 1, i8* %0, align 1
  br label %while.cond

while.cond:                                       ; preds = %if.end, %entry
  fence seq_cst
  %1 = load i8** @flag1, align 4
  %2 = load i8* %1, align 1
  %tobool = trunc i8 %2 to i1
  br i1 %tobool, label %while.body, label %while.end9

while.body:                                       ; preds = %while.cond
  %3 = load i8** @turn, align 4
  %4 = load i8* %3, align 1
  %tobool1 = trunc i8 %4 to i1
  %conv = zext i1 %tobool1 to i32
  %cmp = icmp ne i32 %conv, 0
  br i1 %cmp, label %if.then, label %if.end

if.then:                                          ; preds = %while.body
  %5 = load i8** @flag0, align 4
  store i8 0, i8* %5, align 1
  br label %while.cond3

while.cond3:                                      ; preds = %while.body8, %if.then
  %6 = load i8** @turn, align 4
  %7 = load i8* %6, align 1
  %tobool4 = trunc i8 %7 to i1
  %conv5 = zext i1 %tobool4 to i32
  %cmp6 = icmp ne i32 %conv5, 0
  br i1 %cmp6, label %while.body8, label %while.end

while.body8:                                      ; preds = %while.cond3
  br label %while.cond3

while.end:                                        ; preds = %while.cond3
  %8 = load i8** @flag0, align 4
  store i8 1, i8* %8, align 1
  br label %if.end

if.end:                                           ; preds = %while.end, %while.body
  br label %while.cond

while.end9:                                       ; preds = %while.cond
  %9 = load i8** @turn, align 4
  store i8 1, i8* %9, align 1
  %10 = load i8** @flag0, align 4
  store i8 0, i8* %10, align 1
  ret void
}

define void @p1() nounwind {
entry:
  %0 = load i8** @flag1, align 4
  store i8 1, i8* %0, align 1
  br label %while.cond

while.cond:                                       ; preds = %if.end, %entry
  fence seq_cst
  %1 = load i8** @flag0, align 4
  %2 = load i8* %1, align 1
  %tobool = trunc i8 %2 to i1
  br i1 %tobool, label %while.body, label %while.end9

while.body:                                       ; preds = %while.cond
  %3 = load i8** @turn, align 4
  %4 = load i8* %3, align 1
  %tobool1 = trunc i8 %4 to i1
  %conv = zext i1 %tobool1 to i32
  %cmp = icmp ne i32 %conv, 1
  br i1 %cmp, label %if.then, label %if.end

if.then:                                          ; preds = %while.body
  %5 = load i8** @flag1, align 4
  store i8 0, i8* %5, align 1
  br label %while.cond3

while.cond3:                                      ; preds = %while.body8, %if.then
  %6 = load i8** @turn, align 4
  %7 = load i8* %6, align 1
  %tobool4 = trunc i8 %7 to i1
  %conv5 = zext i1 %tobool4 to i32
  %cmp6 = icmp ne i32 %conv5, 1
  br i1 %cmp6, label %while.body8, label %while.end

while.body8:                                      ; preds = %while.cond3
  br label %while.cond3

while.end:                                        ; preds = %while.cond3
  %8 = load i8** @flag1, align 4
  store i8 1, i8* %8, align 1
  br label %if.end

if.end:                                           ; preds = %while.end, %while.body
  br label %while.cond

while.end9:                                       ; preds = %while.cond
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
