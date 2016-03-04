; ModuleID = 'peterson.c'
target datalayout = "e-p:32:32:32-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:32:64-f32:32:32-f64:32:64-v64:64:64-v128:128:128-a0:0:64-f80:32:32-n8:16:32-S128"
target triple = "i386-pc-linux-gnu"

@flag0 = global i8* null, align 4
@flag1 = global i8* null, align 4
@turn = global i8* null, align 4

define void @p0() nounwind {
entry:
  %0 = load i8** @flag0, align 4
  store i8 1, i8* %0, align 1
  %1 = load i8** @turn, align 4
  store i8 1, i8* %1, align 1
  fence seq_cst
  br label %while.cond

while.cond:                                       ; preds = %while.body, %entry
  %2 = load i8** @flag1, align 4
  %3 = load i8* %2, align 1
  %tobool = trunc i8 %3 to i1
  %conv = zext i1 %tobool to i32
  %cmp = icmp eq i32 %conv, 1
  br i1 %cmp, label %land.rhs, label %land.end

land.rhs:                                         ; preds = %while.cond
  %4 = load i8** @turn, align 4
  %5 = load i8* %4, align 1
  %tobool2 = trunc i8 %5 to i1
  %conv3 = zext i1 %tobool2 to i32
  %cmp4 = icmp eq i32 %conv3, 1
  br label %land.end

land.end:                                         ; preds = %land.rhs, %while.cond
  %6 = phi i1 [ false, %while.cond ], [ %cmp4, %land.rhs ]
  br i1 %6, label %while.body, label %while.end

while.body:                                       ; preds = %land.end
  br label %while.cond

while.end:                                        ; preds = %land.end
  %7 = load i8** @flag0, align 4
  store i8 0, i8* %7, align 1
  ret void
}

define void @p1() nounwind {
entry:
  %0 = load i8** @flag1, align 4
  store i8 1, i8* %0, align 1
  %1 = load i8** @turn, align 4
  store i8 0, i8* %1, align 1
  fence seq_cst
  br label %while.cond

while.cond:                                       ; preds = %while.body, %entry
  %2 = load i8** @flag0, align 4
  %3 = load i8* %2, align 1
  %tobool = trunc i8 %3 to i1
  %conv = zext i1 %tobool to i32
  %cmp = icmp eq i32 %conv, 1
  br i1 %cmp, label %land.rhs, label %land.end

land.rhs:                                         ; preds = %while.cond
  %4 = load i8** @turn, align 4
  %5 = load i8* %4, align 1
  %tobool2 = trunc i8 %5 to i1
  %conv3 = zext i1 %tobool2 to i32
  %cmp4 = icmp eq i32 %conv3, 0
  br label %land.end

land.end:                                         ; preds = %land.rhs, %while.cond
  %6 = phi i1 [ false, %while.cond ], [ %cmp4, %land.rhs ]
  br i1 %6, label %while.body, label %while.end

while.body:                                       ; preds = %land.end
  br label %while.cond

while.end:                                        ; preds = %land.end
  %7 = load i8** @flag1, align 4
  store i8 0, i8* %7, align 1
  ret void
}

define i32 @main() nounwind {
entry:
  ret i32 0
}
