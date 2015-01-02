; ModuleID = 'lamport2.c'
target datalayout = "e-p:32:32:32-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:32:64-f32:32:32-f64:32:64-v64:64:64-v128:128:128-a0:0:64-f80:32:32-n8:16:32-S128"
target triple = "i386-pc-linux-gnu"

@choosing = global [2 x i8*] zeroinitializer, align 4
@number = global [2 x i32*] zeroinitializer, align 4

define void @proci(i32 %i) nounwind {
entry:
  %i.addr = alloca i32, align 4
  %j = alloca i32, align 4
  store i32 %i, i32* %i.addr, align 4
  br label %L1

L1:                                               ; preds = %for.end, %entry
  %0 = load i32* %i.addr, align 4
  %arrayidx = getelementptr inbounds [2 x i8*]* @choosing, i32 0, i32 %0
  %1 = load i8** %arrayidx, align 4
  store i8 1, i8* %1, align 1
  %2 = load i32** getelementptr inbounds ([2 x i32*]* @number, i32 0, i32 0), align 4
  %3 = load i32* %2, align 4
  %4 = load i32** getelementptr inbounds ([2 x i32*]* @number, i32 0, i32 1), align 4
  %5 = load i32* %4, align 4
  %cmp = icmp slt i32 %3, %5
  br i1 %cmp, label %if.then, label %if.else

if.then:                                          ; preds = %L1
  %6 = load i32** getelementptr inbounds ([2 x i32*]* @number, i32 0, i32 1), align 4
  %7 = load i32* %6, align 4
  %add = add nsw i32 1, %7
  %8 = load i32* %i.addr, align 4
  %arrayidx1 = getelementptr inbounds [2 x i32*]* @number, i32 0, i32 %8
  %9 = load i32** %arrayidx1, align 4
  store i32 %add, i32* %9, align 4
  br label %if.end

if.else:                                          ; preds = %L1
  %10 = load i32** getelementptr inbounds ([2 x i32*]* @number, i32 0, i32 0), align 4
  %11 = load i32* %10, align 4
  %add2 = add nsw i32 1, %11
  %12 = load i32* %i.addr, align 4
  %arrayidx3 = getelementptr inbounds [2 x i32*]* @number, i32 0, i32 %12
  %13 = load i32** %arrayidx3, align 4
  store i32 %add2, i32* %13, align 4
  br label %if.end

if.end:                                           ; preds = %if.else, %if.then
  %14 = load i32* %i.addr, align 4
  %arrayidx4 = getelementptr inbounds [2 x i8*]* @choosing, i32 0, i32 %14
  %15 = load i8** %arrayidx4, align 4
  store i8 0, i8* %15, align 1
  store i32 0, i32* %j, align 4
  br label %for.cond

for.cond:                                         ; preds = %for.inc, %if.end
  %16 = load i32* %j, align 4
  %cmp5 = icmp slt i32 %16, 2
  br i1 %cmp5, label %for.body, label %for.end

for.body:                                         ; preds = %for.cond
  br label %while.cond

while.cond:                                       ; preds = %while.body, %for.body
  %17 = load i32* %j, align 4
  %arrayidx6 = getelementptr inbounds [2 x i8*]* @choosing, i32 0, i32 %17
  %18 = load i8** %arrayidx6, align 4
  %19 = load i8* %18, align 1
  %tobool = trunc i8 %19 to i1
  br i1 %tobool, label %while.body, label %while.end

while.body:                                       ; preds = %while.cond
  br label %while.cond

while.end:                                        ; preds = %while.cond
  br label %while.cond7

while.cond7:                                      ; preds = %while.body19, %while.end
  %20 = load i32* %j, align 4
  %arrayidx8 = getelementptr inbounds [2 x i32*]* @number, i32 0, i32 %20
  %21 = load i32** %arrayidx8, align 4
  %22 = load i32* %21, align 4
  %cmp9 = icmp ne i32 %22, 0
  br i1 %cmp9, label %land.rhs, label %land.end18

land.rhs:                                         ; preds = %while.cond7
  %23 = load i32* %j, align 4
  %arrayidx10 = getelementptr inbounds [2 x i32*]* @number, i32 0, i32 %23
  %24 = load i32** %arrayidx10, align 4
  %25 = load i32* %24, align 4
  %26 = load i32* %i.addr, align 4
  %arrayidx11 = getelementptr inbounds [2 x i32*]* @number, i32 0, i32 %26
  %27 = load i32** %arrayidx11, align 4
  %28 = load i32* %27, align 4
  %cmp12 = icmp slt i32 %25, %28
  br i1 %cmp12, label %lor.end, label %lor.rhs

lor.rhs:                                          ; preds = %land.rhs
  %29 = load i32* %j, align 4
  %arrayidx13 = getelementptr inbounds [2 x i32*]* @number, i32 0, i32 %29
  %30 = load i32** %arrayidx13, align 4
  %31 = load i32* %30, align 4
  %32 = load i32* %i.addr, align 4
  %arrayidx14 = getelementptr inbounds [2 x i32*]* @number, i32 0, i32 %32
  %33 = load i32** %arrayidx14, align 4
  %34 = load i32* %33, align 4
  %cmp15 = icmp eq i32 %31, %34
  br i1 %cmp15, label %land.rhs16, label %land.end

land.rhs16:                                       ; preds = %lor.rhs
  %35 = load i32* %j, align 4
  %36 = load i32* %i.addr, align 4
  %cmp17 = icmp slt i32 %35, %36
  br label %land.end

land.end:                                         ; preds = %land.rhs16, %lor.rhs
  %37 = phi i1 [ false, %lor.rhs ], [ %cmp17, %land.rhs16 ]
  br label %lor.end

lor.end:                                          ; preds = %land.end, %land.rhs
  %38 = phi i1 [ true, %land.rhs ], [ %37, %land.end ]
  br label %land.end18

land.end18:                                       ; preds = %lor.end, %while.cond7
  %39 = phi i1 [ false, %while.cond7 ], [ %38, %lor.end ]
  br i1 %39, label %while.body19, label %while.end20

while.body19:                                     ; preds = %land.end18
  br label %while.cond7

while.end20:                                      ; preds = %land.end18
  br label %for.inc

for.inc:                                          ; preds = %while.end20
  %40 = load i32* %j, align 4
  %inc = add nsw i32 %40, 1
  store i32 %inc, i32* %j, align 4
  br label %for.cond

for.end:                                          ; preds = %for.cond
  %41 = load i32* %i.addr, align 4
  %arrayidx21 = getelementptr inbounds [2 x i32*]* @number, i32 0, i32 %41
  %42 = load i32** %arrayidx21, align 4
  store i32 0, i32* %42, align 4
  br label %L1

return:                                           ; No predecessors!
  ret void
}

define i32 @main() nounwind {
entry:
  ret i32 0
}
