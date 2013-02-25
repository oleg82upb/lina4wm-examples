; ModuleID = 'HWQueue.cpp'
target datalayout = "e-p:32:32:32-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:32:64-f32:32:32-f64:32:64-v64:64:64-v128:128:128-a0:0:64-f80:32:32-n8:16:32-S128"
target triple = "i386-pc-linux-gnu"

%struct.queue = type { i32, [20 x i32] }

define i32 @main(i32 %argc, i8** %argv) nounwind {
entry:
  %retval = alloca i32, align 4
  %argc.addr = alloca i32, align 4
  %argv.addr = alloca i8**, align 4
  store i32 0, i32* %retval
  store i32 %argc, i32* %argc.addr, align 4
  store i8** %argv, i8*** %argv.addr, align 4
  ret i32 0
}

define i32 @_Z3incP5queue(%struct.queue* %q) nounwind {
entry:
  %q.addr = alloca %struct.queue*, align 4
  %r = alloca i32, align 4
  store %struct.queue* %q, %struct.queue** %q.addr, align 4
  %0 = load %struct.queue** %q.addr, align 4
  %back = getelementptr inbounds %struct.queue* %0, i32 0, i32 0
  %1 = load i32* %back, align 4
  store i32 %1, i32* %r, align 4
  %2 = load %struct.queue** %q.addr, align 4
  %back1 = getelementptr inbounds %struct.queue* %2, i32 0, i32 0
  %3 = load i32* %back1, align 4
  %inc = add nsw i32 %3, 1
  store i32 %inc, i32* %back1, align 4
  %4 = load i32* %r, align 4
  ret i32 %4
}

define void @_Z5storeP5queueii(%struct.queue* %q, i32 %newvalue, i32 %index) nounwind {
entry:
  %q.addr = alloca %struct.queue*, align 4
  %newvalue.addr = alloca i32, align 4
  %index.addr = alloca i32, align 4
  store %struct.queue* %q, %struct.queue** %q.addr, align 4
  store i32 %newvalue, i32* %newvalue.addr, align 4
  store i32 %index, i32* %index.addr, align 4
  %0 = load i32* %newvalue.addr, align 4
  %1 = load i32* %index.addr, align 4
  %2 = load %struct.queue** %q.addr, align 4
  %items = getelementptr inbounds %struct.queue* %2, i32 0, i32 1
  %arrayidx = getelementptr inbounds [20 x i32]* %items, i32 0, i32 %1
  store i32 %0, i32* %arrayidx, align 4
  ret void
}

define i32 @_Z4readP5queue(%struct.queue* %q) nounwind {
entry:
  %q.addr = alloca %struct.queue*, align 4
  store %struct.queue* %q, %struct.queue** %q.addr, align 4
  %0 = load %struct.queue** %q.addr, align 4
  %back = getelementptr inbounds %struct.queue* %0, i32 0, i32 0
  %1 = load i32* %back, align 4
  ret i32 %1
}

define i32 @_Z4swapP5queueii(%struct.queue* %q, i32 %value, i32 %index) nounwind {
entry:
  %q.addr = alloca %struct.queue*, align 4
  %value.addr = alloca i32, align 4
  %index.addr = alloca i32, align 4
  %r = alloca i32, align 4
  store %struct.queue* %q, %struct.queue** %q.addr, align 4
  store i32 %value, i32* %value.addr, align 4
  store i32 %index, i32* %index.addr, align 4
  %0 = load i32* %index.addr, align 4
  %1 = load %struct.queue** %q.addr, align 4
  %items = getelementptr inbounds %struct.queue* %1, i32 0, i32 1
  %arrayidx = getelementptr inbounds [20 x i32]* %items, i32 0, i32 %0
  %2 = load i32* %arrayidx, align 4
  store i32 %2, i32* %r, align 4
  %3 = load i32* %value.addr, align 4
  %4 = load i32* %index.addr, align 4
  %5 = load %struct.queue** %q.addr, align 4
  %items1 = getelementptr inbounds %struct.queue* %5, i32 0, i32 1
  %arrayidx2 = getelementptr inbounds [20 x i32]* %items1, i32 0, i32 %4
  store i32 %3, i32* %arrayidx2, align 4
  %6 = load i32* %r, align 4
  ret i32 %6
}

define void @_Z7enqueueP5queuei(%struct.queue* %q, i32 %newvalue) nounwind {
entry:
  %q.addr = alloca %struct.queue*, align 4
  %newvalue.addr = alloca i32, align 4
  %i = alloca i32, align 4
  store %struct.queue* %q, %struct.queue** %q.addr, align 4
  store i32 %newvalue, i32* %newvalue.addr, align 4
  %0 = load %struct.queue** %q.addr, align 4
  %call = call i32 @_Z3incP5queue(%struct.queue* %0)
  store i32 %call, i32* %i, align 4
  %1 = load %struct.queue** %q.addr, align 4
  %2 = load i32* %newvalue.addr, align 4
  %3 = load i32* %i, align 4
  call void @_Z5storeP5queueii(%struct.queue* %1, i32 %2, i32 %3)
  ret void
}

define void @_Z7dequeueP5queue(%struct.queue* %q) nounwind {
entry:
  %q.addr = alloca %struct.queue*, align 4
  %range = alloca i32, align 4
  %i = alloca i32, align 4
  store %struct.queue* %q, %struct.queue** %q.addr, align 4
  br label %while.body

while.body:                                       ; preds = %entry, %while.end
  %0 = load %struct.queue** %q.addr, align 4
  %call = call i32 @_Z4readP5queue(%struct.queue* %0)
  store i32 %call, i32* %range, align 4
  %1 = load i32* %range, align 4
  %dec = add nsw i32 %1, -1
  store i32 %dec, i32* %range, align 4
  store i32 1, i32* %i, align 4
  br label %while.cond1

while.cond1:                                      ; preds = %if.end, %while.body
  %2 = load i32* %i, align 4
  %3 = load i32* %range, align 4
  %cmp = icmp sle i32 %2, %3
  br i1 %cmp, label %while.body2, label %while.end

while.body2:                                      ; preds = %while.cond1
  %4 = load %struct.queue** %q.addr, align 4
  %5 = load i32* %i, align 4
  %call3 = call i32 @_Z4swapP5queueii(%struct.queue* %4, i32 0, i32 %5)
  %cmp4 = icmp ne i32 %call3, 0
  br i1 %cmp4, label %if.then, label %if.end

if.then:                                          ; preds = %while.body2
  ret void

if.end:                                           ; preds = %while.body2
  %6 = load i32* %i, align 4
  %inc = add nsw i32 %6, 1
  store i32 %inc, i32* %i, align 4
  br label %while.cond1

while.end:                                        ; preds = %while.cond1
  br label %while.body
}
