; ModuleID = 'ArraySet.cpp'
target datalayout = "e-p:32:32:32-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:32:64-f32:32:32-f64:32:64-v64:64:64-v128:128:128-a0:0:64-f80:32:32-n8:16:32-S128"
target triple = "i386-pc-linux-gnu"

@key = global [10 x i32] zeroinitializer, align 4
@gen = global [10 x i32] zeroinitializer, align 4
@length = global i32 0, align 4

define zeroext i1 @_Z6Memberi(i32 %x) nounwind {
entry:
  %retval = alloca i1, align 1
  %x.addr = alloca i32, align 4
  %i = alloca i32, align 4
  %mylength = alloca i32, align 4
  %v = alloca i32, align 4
  store i32 %x, i32* %x.addr, align 4
  store i32 0, i32* %i, align 4
  %0 = load i32* @length, align 4
  store i32 %0, i32* %mylength, align 4
  br label %while.cond

while.cond:                                       ; preds = %while.end, %entry
  %1 = load i32* %i, align 4
  %2 = load i32* %mylength, align 4
  %cmp = icmp slt i32 %1, %2
  br i1 %cmp, label %while.body, label %while.end5

while.body:                                       ; preds = %while.cond
  br label %while.cond1

while.cond1:                                      ; preds = %if.end, %while.body
  %3 = load i32* %i, align 4
  %4 = load i32* %mylength, align 4
  %cmp2 = icmp ne i32 %3, %4
  br i1 %cmp2, label %while.body3, label %while.end

while.body3:                                      ; preds = %while.cond1
  %5 = load i32* %i, align 4
  %add = add nsw i32 %5, 1
  store i32 %add, i32* %i, align 4
  %6 = load i32* %i, align 4
  %arrayidx = getelementptr inbounds [10 x i32]* @key, i32 0, i32 %6
  %7 = load i32* %arrayidx, align 4
  store i32 %7, i32* %v, align 4
  %8 = load i32* %v, align 4
  %9 = load i32* %x.addr, align 4
  %cmp4 = icmp eq i32 %8, %9
  br i1 %cmp4, label %if.then, label %if.end

if.then:                                          ; preds = %while.body3
  store i1 true, i1* %retval
  br label %return

if.end:                                           ; preds = %while.body3
  br label %while.cond1

while.end:                                        ; preds = %while.cond1
  %10 = load i32* @length, align 4
  store i32 %10, i32* %mylength, align 4
  br label %while.cond

while.end5:                                       ; preds = %while.cond
  store i1 false, i1* %retval
  br label %return

return:                                           ; preds = %while.end5, %if.then
  %11 = load i1* %retval
  ret i1 %11
}

define void @_Z6Inserti(i32 %x) nounwind {
entry:
  %x.addr = alloca i32, align 4
  %i = alloca i32, align 4
  %mylength = alloca i32, align 4
  %added = alloca i8, align 1
  %saved_stack = alloca i8*
  %nholes = alloca i32, align 4
  %v = alloca i32, align 4
  store i32 %x, i32* %x.addr, align 4
  %0 = load i32* @length, align 4
  %1 = call i8* @llvm.stacksave()
  store i8* %1, i8** %saved_stack
  %vla = alloca i32, i32 %0, align 4
  store i8 0, i8* %added, align 1
  store i32 0, i32* %nholes, align 4
  %2 = load i32* @length, align 4
  store i32 %2, i32* %mylength, align 4
  store i32 1, i32* %i, align 4
  br label %while.cond

while.cond:                                       ; preds = %if.end, %entry
  %3 = load i32* %i, align 4
  %4 = load i32* %mylength, align 4
  %cmp = icmp sle i32 %3, %4
  br i1 %cmp, label %while.body, label %while.end

while.body:                                       ; preds = %while.cond
  %5 = load i32* %i, align 4
  %arrayidx = getelementptr inbounds [10 x i32]* @key, i32 0, i32 %5
  %6 = load i32* %arrayidx, align 4
  store i32 %6, i32* %v, align 4
  %7 = load i32* %v, align 4
  %cmp1 = icmp eq i32 %7, 0
  br i1 %cmp1, label %if.then, label %if.end

if.then:                                          ; preds = %while.body
  %8 = load i32* %nholes, align 4
  %add = add nsw i32 %8, 1
  store i32 %add, i32* %nholes, align 4
  %9 = load i32* %i, align 4
  %10 = load i32* %nholes, align 4
  %arrayidx2 = getelementptr inbounds i32* %vla, i32 %10
  store i32 %9, i32* %arrayidx2, align 4
  br label %if.end

if.end:                                           ; preds = %if.then, %while.body
  %11 = load i32* %i, align 4
  %add3 = add nsw i32 %11, 1
  store i32 %add3, i32* %i, align 4
  br label %while.cond

while.end:                                        ; preds = %while.cond
  br label %while.cond4

while.cond4:                                      ; preds = %if.end14, %while.end
  %12 = load i8* %added, align 1
  %tobool = trunc i8 %12 to i1
  br i1 %tobool, label %land.end, label %land.rhs

land.rhs:                                         ; preds = %while.cond4
  %13 = load i32* %nholes, align 4
  %cmp5 = icmp sgt i32 %13, 0
  br label %land.end

land.end:                                         ; preds = %land.rhs, %while.cond4
  %14 = phi i1 [ false, %while.cond4 ], [ %cmp5, %land.rhs ]
  br i1 %14, label %while.body6, label %while.end15

while.body6:                                      ; preds = %land.end
  %15 = load i32* %nholes, align 4
  %arrayidx7 = getelementptr inbounds i32* %vla, i32 %15
  %16 = load i32* %arrayidx7, align 4
  %arrayidx8 = getelementptr inbounds [10 x i32]* @key, i32 0, i32 %16
  %17 = load i32* %arrayidx8, align 4
  %cmp9 = icmp eq i32 %17, 0
  %frombool = zext i1 %cmp9 to i8
  store i8 %frombool, i8* %added, align 1
  %18 = load i8* %added, align 1
  %tobool10 = trunc i8 %18 to i1
  br i1 %tobool10, label %if.then11, label %if.end14

if.then11:                                        ; preds = %while.body6
  %19 = load i32* %x.addr, align 4
  %20 = load i32* %nholes, align 4
  %arrayidx12 = getelementptr inbounds i32* %vla, i32 %20
  %21 = load i32* %arrayidx12, align 4
  %arrayidx13 = getelementptr inbounds [10 x i32]* @key, i32 0, i32 %21
  store i32 %19, i32* %arrayidx13, align 4
  br label %if.end14

if.end14:                                         ; preds = %if.then11, %while.body6
  %22 = load i32* %nholes, align 4
  %sub = sub nsw i32 %22, 1
  store i32 %sub, i32* %nholes, align 4
  br label %while.cond4

while.end15:                                      ; preds = %land.end
  br label %while.cond16

while.cond16:                                     ; preds = %if.end26, %while.end15
  %23 = load i8* %added, align 1
  %tobool17 = trunc i8 %23 to i1
  %lnot = xor i1 %tobool17, true
  br i1 %lnot, label %while.body18, label %while.end27

while.body18:                                     ; preds = %while.cond16
  %24 = load i32* @length, align 4
  %add19 = add nsw i32 %24, 1
  store i32 %add19, i32* @length, align 4
  %25 = load i32* @length, align 4
  store i32 %25, i32* %i, align 4
  %26 = load i32* %i, align 4
  %arrayidx20 = getelementptr inbounds [10 x i32]* @key, i32 0, i32 %26
  %27 = load i32* %arrayidx20, align 4
  %cmp21 = icmp eq i32 %27, 0
  %frombool22 = zext i1 %cmp21 to i8
  store i8 %frombool22, i8* %added, align 1
  %28 = load i8* %added, align 1
  %tobool23 = trunc i8 %28 to i1
  br i1 %tobool23, label %if.then24, label %if.end26

if.then24:                                        ; preds = %while.body18
  %29 = load i32* %x.addr, align 4
  %30 = load i32* %i, align 4
  %arrayidx25 = getelementptr inbounds [10 x i32]* @key, i32 0, i32 %30
  store i32 %29, i32* %arrayidx25, align 4
  br label %if.end26

if.end26:                                         ; preds = %if.then24, %while.body18
  br label %while.cond16

while.end27:                                      ; preds = %while.cond16
  %31 = load i8** %saved_stack
  call void @llvm.stackrestore(i8* %31)
  ret void
}

declare i8* @llvm.stacksave() nounwind

declare void @llvm.stackrestore(i8*) nounwind

define void @_Z6Deletei(i32 %x) nounwind {
entry:
  %x.addr = alloca i32, align 4
  %i = alloca i32, align 4
  %mylength = alloca i32, align 4
  %saved_stack = alloca i8*
  %ntodo = alloca i32, align 4
  %removed = alloca i8, align 1
  %v = alloca i32, align 4
  %g = alloca i32, align 4
  store i32 %x, i32* %x.addr, align 4
  %0 = load i32* @length, align 4
  %1 = call i8* @llvm.stacksave()
  store i8* %1, i8** %saved_stack
  %vla = alloca i32, i32 %0, align 4
  %2 = load i32* @length, align 4
  %vla1 = alloca i32, i32 %2, align 4
  store i32 0, i32* %ntodo, align 4
  %3 = load i32* @length, align 4
  store i32 %3, i32* %mylength, align 4
  store i32 1, i32* %i, align 4
  br label %while.cond

while.cond:                                       ; preds = %if.end, %entry
  %4 = load i32* %i, align 4
  %5 = load i32* %mylength, align 4
  %cmp = icmp sle i32 %4, %5
  br i1 %cmp, label %while.body, label %while.end

while.body:                                       ; preds = %while.cond
  %6 = load i32* %i, align 4
  %arrayidx = getelementptr inbounds i32* %vla1, i32 %6
  %7 = load i32* %arrayidx, align 4
  store i32 %7, i32* %g, align 4
  %8 = load i32* %i, align 4
  %arrayidx2 = getelementptr inbounds [10 x i32]* @key, i32 0, i32 %8
  %9 = load i32* %arrayidx2, align 4
  store i32 %9, i32* %v, align 4
  %10 = load i32* %v, align 4
  %cmp3 = icmp eq i32 %10, 0
  br i1 %cmp3, label %if.then, label %if.end

if.then:                                          ; preds = %while.body
  %11 = load i32* %ntodo, align 4
  %add = add nsw i32 %11, 1
  store i32 %add, i32* %ntodo, align 4
  %12 = load i32* %i, align 4
  %13 = load i32* %ntodo, align 4
  %arrayidx4 = getelementptr inbounds i32* %vla, i32 %13
  store i32 %12, i32* %arrayidx4, align 4
  %14 = load i32* %g, align 4
  %15 = load i32* %ntodo, align 4
  %arrayidx5 = getelementptr inbounds i32* %vla1, i32 %15
  store i32 %14, i32* %arrayidx5, align 4
  br label %if.end

if.end:                                           ; preds = %if.then, %while.body
  %16 = load i32* %i, align 4
  %add6 = add nsw i32 %16, 1
  store i32 %add6, i32* %i, align 4
  br label %while.cond

while.end:                                        ; preds = %while.cond
  store i32 0, i32* %i, align 4
  br label %while.cond7

while.cond7:                                      ; preds = %if.end22, %while.end
  %17 = load i32* %i, align 4
  %18 = load i32* %ntodo, align 4
  %cmp8 = icmp sle i32 %17, %18
  br i1 %cmp8, label %while.body9, label %while.end24

while.body9:                                      ; preds = %while.cond7
  %19 = load i32* %i, align 4
  %arrayidx10 = getelementptr inbounds i32* %vla, i32 %19
  %20 = load i32* %arrayidx10, align 4
  %arrayidx11 = getelementptr inbounds i32* %vla1, i32 %20
  %21 = load i32* %arrayidx11, align 4
  %22 = load i32* %i, align 4
  %arrayidx12 = getelementptr inbounds i32* %vla1, i32 %22
  %23 = load i32* %arrayidx12, align 4
  %cmp13 = icmp eq i32 %21, %23
  %frombool = zext i1 %cmp13 to i8
  store i8 %frombool, i8* %removed, align 1
  %24 = load i8* %removed, align 1
  %tobool = trunc i8 %24 to i1
  br i1 %tobool, label %if.then14, label %if.end22

if.then14:                                        ; preds = %while.body9
  %25 = load i32* %i, align 4
  %arrayidx15 = getelementptr inbounds i32* %vla, i32 %25
  %26 = load i32* %arrayidx15, align 4
  %arrayidx16 = getelementptr inbounds [10 x i32]* @key, i32 0, i32 %26
  store i32 0, i32* %arrayidx16, align 4
  %27 = load i32* %i, align 4
  %arrayidx17 = getelementptr inbounds i32* %vla, i32 %27
  %28 = load i32* %arrayidx17, align 4
  %arrayidx18 = getelementptr inbounds i32* %vla1, i32 %28
  %29 = load i32* %arrayidx18, align 4
  %add19 = add nsw i32 %29, 1
  %30 = load i32* %i, align 4
  %arrayidx20 = getelementptr inbounds i32* %vla, i32 %30
  %31 = load i32* %arrayidx20, align 4
  %arrayidx21 = getelementptr inbounds i32* %vla1, i32 %31
  store i32 %add19, i32* %arrayidx21, align 4
  br label %if.end22

if.end22:                                         ; preds = %if.then14, %while.body9
  %32 = load i32* %i, align 4
  %add23 = add nsw i32 %32, 1
  store i32 %add23, i32* %i, align 4
  br label %while.cond7

while.end24:                                      ; preds = %while.cond7
  %33 = load i8** %saved_stack
  call void @llvm.stackrestore(i8* %33)
  ret void
}
