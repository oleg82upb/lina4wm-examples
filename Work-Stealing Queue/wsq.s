; ModuleID = 'work-stealing-queue.c'
target datalayout = "e-p:32:32:32-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:32:64-f32:32:32-f64:32:64-v64:64:64-v128:128:128-a0:0:64-f80:32:32-n8:16:32-S128"
target triple = "i386-pc-linux-gnu"

%struct.item_t = type { i32, i32* }

@wsq = global %struct.item_t* null, align 4
@top = common global i32 0, align 4
@bottom = common global i32 0, align 4

define %struct.item_t* @expand() nounwind {
entry:
  %newsize = alloca i32, align 4
  %newitems = alloca i32*, align 4
  %newq = alloca %struct.item_t*, align 4
  %i = alloca i32, align 4
  %0 = load %struct.item_t** @wsq, align 4
  %size = getelementptr inbounds %struct.item_t* %0, i32 0, i32 0
  %1 = load i32* %size, align 4
  %mul = mul nsw i32 %1, 2
  store i32 %mul, i32* %newsize, align 4
  %2 = load i32* %newsize, align 4
  %mul1 = mul i32 %2, 4
  %call = call noalias i8* @malloc(i32 %mul1) nounwind
  %3 = bitcast i8* %call to i32*
  store i32* %3, i32** %newitems, align 4
  %call2 = call noalias i8* @malloc(i32 8) nounwind
  %4 = bitcast i8* %call2 to %struct.item_t*
  store %struct.item_t* %4, %struct.item_t** %newq, align 4
  %5 = load i32* @top, align 4
  store i32 %5, i32* %i, align 4
  br label %for.cond

for.cond:                                         ; preds = %for.inc, %entry
  %6 = load i32* %i, align 4
  %7 = load i32* @bottom, align 4
  %cmp = icmp slt i32 %6, %7
  br i1 %cmp, label %for.body, label %for.end

for.body:                                         ; preds = %for.cond
  %8 = load i32* %i, align 4
  %9 = load %struct.item_t** @wsq, align 4
  %size3 = getelementptr inbounds %struct.item_t* %9, i32 0, i32 0
  %10 = load i32* %size3, align 4
  %rem = srem i32 %8, %10
  %11 = load %struct.item_t** @wsq, align 4
  %ap = getelementptr inbounds %struct.item_t* %11, i32 0, i32 1
  %12 = load i32** %ap, align 4
  %arrayidx = getelementptr inbounds i32* %12, i32 %rem
  %13 = load i32* %arrayidx, align 4
  %14 = load i32* %i, align 4
  %15 = load i32* %newsize, align 4
  %rem4 = srem i32 %14, %15
  %16 = load i32** %newitems, align 4
  %arrayidx5 = getelementptr inbounds i32* %16, i32 %rem4
  store i32 %13, i32* %arrayidx5, align 4
  br label %for.inc

for.inc:                                          ; preds = %for.body
  %17 = load i32* %i, align 4
  %inc = add nsw i32 %17, 1
  store i32 %inc, i32* %i, align 4
  br label %for.cond

for.end:                                          ; preds = %for.cond
  %18 = load i32* %newsize, align 4
  %19 = load %struct.item_t** %newq, align 4
  %size6 = getelementptr inbounds %struct.item_t* %19, i32 0, i32 0
  store i32 %18, i32* %size6, align 4
  %20 = load i32** %newitems, align 4
  %21 = load %struct.item_t** %newq, align 4
  %ap7 = getelementptr inbounds %struct.item_t* %21, i32 0, i32 1
  store i32* %20, i32** %ap7, align 4
  %22 = load %struct.item_t** %newq, align 4
  store %struct.item_t* %22, %struct.item_t** @wsq, align 4
  %23 = load %struct.item_t** %newq, align 4
  ret %struct.item_t* %23
}

declare noalias i8* @malloc(i32) nounwind

define void @push(i32 %task) nounwind {
entry:
  %task.addr = alloca i32, align 4
  %b = alloca i32, align 4
  %t = alloca i32, align 4
  %q = alloca %struct.item_t*, align 4
  store i32 %task, i32* %task.addr, align 4
  %0 = load i32* @bottom, align 4
  store i32 %0, i32* %b, align 4
  %1 = load i32* @top, align 4
  store i32 %1, i32* %t, align 4
  %2 = load %struct.item_t** @wsq, align 4
  store %struct.item_t* %2, %struct.item_t** %q, align 4
  %3 = load i32* %b, align 4
  %4 = load i32* %t, align 4
  %sub = sub nsw i32 %3, %4
  %5 = load %struct.item_t** %q, align 4
  %size = getelementptr inbounds %struct.item_t* %5, i32 0, i32 0
  %6 = load i32* %size, align 4
  %sub1 = sub nsw i32 %6, 1
  %cmp = icmp sge i32 %sub, %sub1
  br i1 %cmp, label %if.then, label %if.end

if.then:                                          ; preds = %entry
  %call = call %struct.item_t* @expand()
  store %struct.item_t* %call, %struct.item_t** %q, align 4
  br label %if.end

if.end:                                           ; preds = %if.then, %entry
  %7 = load i32* %task.addr, align 4
  %8 = load i32* %b, align 4
  %9 = load %struct.item_t** %q, align 4
  %size2 = getelementptr inbounds %struct.item_t* %9, i32 0, i32 0
  %10 = load i32* %size2, align 4
  %rem = srem i32 %8, %10
  %11 = load %struct.item_t** %q, align 4
  %ap = getelementptr inbounds %struct.item_t* %11, i32 0, i32 1
  %12 = load i32** %ap, align 4
  %arrayidx = getelementptr inbounds i32* %12, i32 %rem
  store i32 %7, i32* %arrayidx, align 4
  %13 = load i32* %b, align 4
  %add = add nsw i32 %13, 1
  store i32 %add, i32* @bottom, align 4
  ret void
}

define i32 @take() nounwind {
entry:
  %retval = alloca i32, align 4
  %b = alloca i32, align 4
  %q = alloca %struct.item_t*, align 4
  %t = alloca i32, align 4
  %task = alloca i32, align 4
  %0 = load i32* @bottom, align 4
  %sub = sub nsw i32 %0, 1
  store i32 %sub, i32* %b, align 4
  %1 = load %struct.item_t** @wsq, align 4
  store %struct.item_t* %1, %struct.item_t** %q, align 4
  %2 = load i32* %b, align 4
  store i32 %2, i32* @bottom, align 4
  %3 = load i32* @top, align 4
  store i32 %3, i32* %t, align 4
  %4 = load i32* %b, align 4
  %5 = load i32* %t, align 4
  %cmp = icmp slt i32 %4, %5
  br i1 %cmp, label %if.then, label %if.end

if.then:                                          ; preds = %entry
  %6 = load i32* %t, align 4
  store i32 %6, i32* @bottom, align 4
  store i32 42, i32* %retval
  br label %return

if.end:                                           ; preds = %entry
  %7 = load i32* %b, align 4
  %8 = load %struct.item_t** %q, align 4
  %size = getelementptr inbounds %struct.item_t* %8, i32 0, i32 0
  %9 = load i32* %size, align 4
  %rem = srem i32 %7, %9
  %10 = load %struct.item_t** %q, align 4
  %ap = getelementptr inbounds %struct.item_t* %10, i32 0, i32 1
  %11 = load i32** %ap, align 4
  %arrayidx = getelementptr inbounds i32* %11, i32 %rem
  %12 = load i32* %arrayidx, align 4
  store i32 %12, i32* %task, align 4
  %13 = load i32* %b, align 4
  %14 = load i32* %t, align 4
  %cmp1 = icmp sgt i32 %13, %14
  br i1 %cmp1, label %if.then2, label %if.end3

if.then2:                                         ; preds = %if.end
  %15 = load i32* %task, align 4
  store i32 %15, i32* %retval
  br label %return

if.end3:                                          ; preds = %if.end
  %16 = load i32* %t, align 4
  %17 = load i32* %t, align 4
  %add = add nsw i32 %17, 1
  %18 = cmpxchg i32* @top, i32 %16, i32 %add seq_cst
  %19 = icmp eq i32 %18, %16
  br i1 %19, label %if.end5, label %if.then4

if.then4:                                         ; preds = %if.end3
  store i32 42, i32* %retval
  br label %return

if.end5:                                          ; preds = %if.end3
  %20 = load i32* %t, align 4
  %add6 = add nsw i32 %20, 1
  store i32 %add6, i32* @bottom, align 4
  %21 = load i32* %task, align 4
  store i32 %21, i32* %retval
  br label %return

return:                                           ; preds = %if.end5, %if.then4, %if.then2, %if.then
  %22 = load i32* %retval
  ret i32 %22
}

define i32 @steal() nounwind {
entry:
  %retval = alloca i32, align 4
  %t = alloca i32, align 4
  %b = alloca i32, align 4
  %q = alloca %struct.item_t*, align 4
  %task = alloca i32, align 4
  %0 = load i32* @top, align 4
  store i32 %0, i32* %t, align 4
  %1 = load i32* @bottom, align 4
  store i32 %1, i32* %b, align 4
  %2 = load %struct.item_t** @wsq, align 4
  store %struct.item_t* %2, %struct.item_t** %q, align 4
  %3 = load i32* %t, align 4
  %4 = load i32* %b, align 4
  %cmp = icmp sge i32 %3, %4
  br i1 %cmp, label %if.then, label %if.end

if.then:                                          ; preds = %entry
  store i32 42, i32* %retval
  br label %return

if.end:                                           ; preds = %entry
  %5 = load i32* %t, align 4
  %6 = load %struct.item_t** %q, align 4
  %size = getelementptr inbounds %struct.item_t* %6, i32 0, i32 0
  %7 = load i32* %size, align 4
  %rem = srem i32 %5, %7
  %8 = load %struct.item_t** %q, align 4
  %ap = getelementptr inbounds %struct.item_t* %8, i32 0, i32 1
  %9 = load i32** %ap, align 4
  %arrayidx = getelementptr inbounds i32* %9, i32 %rem
  %10 = load i32* %arrayidx, align 4
  store i32 %10, i32* %task, align 4
  %11 = load i32* %t, align 4
  %12 = load i32* %t, align 4
  %add = add nsw i32 %12, 1
  %13 = cmpxchg i32* @top, i32 %11, i32 %add seq_cst
  %14 = icmp eq i32 %13, %11
  br i1 %14, label %if.end2, label %if.then1

if.then1:                                         ; preds = %if.end
  store i32 1334, i32* %retval
  br label %return

if.end2:                                          ; preds = %if.end
  %15 = load i32* %task, align 4
  store i32 %15, i32* %retval
  br label %return

return:                                           ; preds = %if.end2, %if.then1, %if.then
  %16 = load i32* %retval
  ret i32 %16
}

define i32 @main(i32 %argc, i8** %argv) nounwind {
entry:
  %retval = alloca i32, align 4
  %argc.addr = alloca i32, align 4
  %argv.addr = alloca i8**, align 4
  store i32 0, i32* %retval
  store i32 %argc, i32* %argc.addr, align 4
  store i8** %argv, i8*** %argv.addr, align 4
  %call = call noalias i8* @malloc(i32 8) nounwind
  %0 = bitcast i8* %call to %struct.item_t*
  store %struct.item_t* %0, %struct.item_t** @wsq, align 4
  %1 = load %struct.item_t** @wsq, align 4
  %size = getelementptr inbounds %struct.item_t* %1, i32 0, i32 0
  store i32 1, i32* %size, align 4
  %2 = load %struct.item_t** @wsq, align 4
  %ap = getelementptr inbounds %struct.item_t* %2, i32 0, i32 1
  store i32* null, i32** %ap, align 4
  %3 = load %struct.item_t** @wsq, align 4
  %4 = bitcast %struct.item_t* %3 to i8*
  call void @free(i8* %4) nounwind
  ret i32 0
}

declare void @free(i8*) nounwind
