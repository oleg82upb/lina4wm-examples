; ModuleID = 'ArraySet.cpp'
target datalayout = "e-p:32:32:32-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:32:64-f32:32:32-f64:32:64-v64:64:64-v128:128:128-a0:0:64-f80:32:32-n8:16:32-S128"
target triple = "i386-pc-linux-gnu"

@key = global [10 x i32] zeroinitializer, align 4
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

while.cond4:                                      ; preds = %while.body6, %while.end
  %12 = load i8* %added, align 1
  %tobool = trunc i8 %12 to i1
  br i1 %tobool, label %land.end, label %land.rhs

land.rhs:                                         ; preds = %while.cond4
  %13 = load i32* %nholes, align 4
  %cmp5 = icmp sgt i32 %13, 0
  br label %land.end

land.end:                                         ; preds = %land.rhs, %while.cond4
  %14 = phi i1 [ false, %while.cond4 ], [ %cmp5, %land.rhs ]
  br i1 %14, label %while.body6, label %while.end9

while.body6:                                      ; preds = %land.end
  %15 = load i32* %nholes, align 4
  %arrayidx7 = getelementptr inbounds i32* %vla, i32 %15
  %16 = load i32* %arrayidx7, align 4
  %arrayidx8 = getelementptr inbounds [10 x i32]* @key, i32 0, i32 %16
  %17 = load i32* %x.addr, align 4
  %18 = cmpxchg i32* %arrayidx8, i32 0, i32 %17 seq_cst
  %19 = icmp eq i32 %18, 0
  %frombool = zext i1 %19 to i8
  store i8 %frombool, i8* %added, align 1
  %20 = load i32* %nholes, align 4
  %sub = sub nsw i32 %20, 1
  store i32 %sub, i32* %nholes, align 4
  br label %while.cond4

while.end9:                                       ; preds = %land.end
  br label %while.cond10

while.cond10:                                     ; preds = %while.body12, %while.end9
  %21 = load i8* %added, align 1
  %tobool11 = trunc i8 %21 to i1
  %lnot = xor i1 %tobool11, true
  br i1 %lnot, label %while.body12, label %while.end16

while.body12:                                     ; preds = %while.cond10
  %22 = load i32* @length, align 4
  %add13 = add nsw i32 %22, 1
  store i32 %add13, i32* @length, align 4
  %23 = load i32* @length, align 4
  store i32 %23, i32* %i, align 4
  %24 = load i32* %i, align 4
  %arrayidx14 = getelementptr inbounds [10 x i32]* @key, i32 0, i32 %24
  %25 = load i32* %x.addr, align 4
  %26 = cmpxchg i32* %arrayidx14, i32 0, i32 %25 seq_cst
  %27 = icmp eq i32 %26, 0
  %frombool15 = zext i1 %27 to i8
  store i8 %frombool15, i8* %added, align 1
  br label %while.cond10

while.end16:                                      ; preds = %while.cond10
  %28 = load i8** %saved_stack
  call void @llvm.stackrestore(i8* %28)
  ret void
}

declare i8* @llvm.stacksave() nounwind

declare void @llvm.stackrestore(i8*) nounwind

define void @_Z6Deletei(i32 %x) nounwind {
entry:
  %x.addr = alloca i32, align 4
  %i = alloca i32, align 4
  %mylength = alloca i32, align 4
  %removed = alloca i8, align 1
  store i32 %x, i32* %x.addr, align 4
  %0 = load i32* @length, align 4
  store i32 %0, i32* %mylength, align 4
  store i32 1, i32* %i, align 4
  br label %while.cond

while.cond:                                       ; preds = %while.body, %entry
  %1 = load i8* %removed, align 1
  %tobool = trunc i8 %1 to i1
  br i1 %tobool, label %land.end, label %land.rhs

land.rhs:                                         ; preds = %while.cond
  %2 = load i32* %i, align 4
  %3 = load i32* %mylength, align 4
  %cmp = icmp sle i32 %2, %3
  br label %land.end

land.end:                                         ; preds = %land.rhs, %while.cond
  %4 = phi i1 [ false, %while.cond ], [ %cmp, %land.rhs ]
  br i1 %4, label %while.body, label %while.end

while.body:                                       ; preds = %land.end
  %5 = load i32* %i, align 4
  %arrayidx = getelementptr inbounds [10 x i32]* @key, i32 0, i32 %5
  %6 = load i32* %x.addr, align 4
  %7 = cmpxchg i32* %arrayidx, i32 %6, i32 0 seq_cst
  %8 = icmp eq i32 %7, %6
  %9 = load i32* %i, align 4
  %add = add nsw i32 %9, 1
  store i32 %add, i32* %i, align 4
  br label %while.cond

while.end:                                        ; preds = %land.end
  ret void
}
