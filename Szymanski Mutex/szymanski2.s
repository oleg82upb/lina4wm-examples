; ModuleID = 'szymanski2.c'
target datalayout = "e-p:32:32:32-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:32:64-f32:32:32-f64:32:64-v64:64:64-v128:128:128-a0:0:64-f80:32:32-n8:16:32-S128"
target triple = "i386-pc-linux-gnu"

@flag = global [2 x i8] zeroinitializer, align 1
@flag0 = global i32* null, align 4
@flag1 = global i32* null, align 4

define void @proc0() nounwind {
entry:
  br label %L1

L1:                                               ; preds = %entry
  %0 = load i32** @flag0, align 4
  store i32 1, i32* %0, align 4
  br label %while.cond

while.cond:                                       ; preds = %while.body, %L1
  %1 = load i32** @flag1, align 4
  %2 = load i32* %1, align 4
  %cmp = icmp sgt i32 %2, 2
  br i1 %cmp, label %while.body, label %while.end

while.body:                                       ; preds = %while.cond
  br label %while.cond

while.end:                                        ; preds = %while.cond
  %3 = load i32** @flag0, align 4
  store i32 3, i32* %3, align 4
  %4 = load i32** @flag1, align 4
  %5 = load i32* %4, align 4
  %cmp1 = icmp eq i32 %5, 1
  br i1 %cmp1, label %if.then, label %if.end

if.then:                                          ; preds = %while.end
  %6 = load i32** @flag0, align 4
  store i32 2, i32* %6, align 4
  br label %while.cond2

while.cond2:                                      ; preds = %while.body4, %if.then
  %7 = load i32** @flag1, align 4
  %8 = load i32* %7, align 4
  %cmp3 = icmp eq i32 %8, 4
  br i1 %cmp3, label %while.body4, label %while.end5

while.body4:                                      ; preds = %while.cond2
  br label %while.cond2

while.end5:                                       ; preds = %while.cond2
  br label %if.end

if.end:                                           ; preds = %while.end5, %while.end
  %9 = load i32** @flag0, align 4
  store i32 4, i32* %9, align 4
  br label %while.cond6

while.cond6:                                      ; preds = %while.body9, %if.end
  %10 = load i32** @flag1, align 4
  %11 = load i32* %10, align 4
  %cmp7 = icmp eq i32 %11, 2
  br i1 %cmp7, label %lor.end, label %lor.rhs

lor.rhs:                                          ; preds = %while.cond6
  %12 = load i32** @flag1, align 4
  %13 = load i32* %12, align 4
  %cmp8 = icmp eq i32 %13, 3
  br label %lor.end

lor.end:                                          ; preds = %lor.rhs, %while.cond6
  %14 = phi i1 [ true, %while.cond6 ], [ %cmp8, %lor.rhs ]
  br i1 %14, label %while.body9, label %while.end10

while.body9:                                      ; preds = %lor.end
  br label %while.cond6

while.end10:                                      ; preds = %lor.end
  %15 = load i32** @flag0, align 4
  store i32 0, i32* %15, align 4
  ret void
}

define void @proc1() nounwind {
entry:
  br label %L1

L1:                                               ; preds = %entry
  %0 = load i32** @flag1, align 4
  store i32 1, i32* %0, align 4
  br label %while.cond

while.cond:                                       ; preds = %while.body, %L1
  %1 = load i32** @flag0, align 4
  %2 = load i32* %1, align 4
  %cmp = icmp sgt i32 %2, 2
  br i1 %cmp, label %while.body, label %while.end

while.body:                                       ; preds = %while.cond
  br label %while.cond

while.end:                                        ; preds = %while.cond
  %3 = load i32** @flag1, align 4
  store i32 3, i32* %3, align 4
  %4 = load i32** @flag0, align 4
  %5 = load i32* %4, align 4
  %cmp1 = icmp eq i32 %5, 1
  br i1 %cmp1, label %if.then, label %if.end

if.then:                                          ; preds = %while.end
  %6 = load i32** @flag1, align 4
  store i32 2, i32* %6, align 4
  br label %while.cond2

while.cond2:                                      ; preds = %while.body4, %if.then
  %7 = load i32** @flag0, align 4
  %8 = load i32* %7, align 4
  %cmp3 = icmp eq i32 %8, 4
  br i1 %cmp3, label %while.body4, label %while.end5

while.body4:                                      ; preds = %while.cond2
  br label %while.cond2

while.end5:                                       ; preds = %while.cond2
  br label %if.end

if.end:                                           ; preds = %while.end5, %while.end
  %9 = load i32** @flag1, align 4
  store i32 4, i32* %9, align 4
  br label %while.cond6

while.cond6:                                      ; preds = %while.body8, %if.end
  %10 = load i32** @flag0, align 4
  %11 = load i32* %10, align 4
  %cmp7 = icmp sgt i32 %11, 1
  br i1 %cmp7, label %while.body8, label %while.end9

while.body8:                                      ; preds = %while.cond6
  br label %while.cond6

while.end9:                                       ; preds = %while.cond6
  %12 = load i32** @flag1, align 4
  store i32 0, i32* %12, align 4
  ret void
}

define i32 @main() nounwind {
entry:
  ret i32 0
}
