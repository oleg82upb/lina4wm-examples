; ModuleID = 'multiset.cpp'
target datalayout = "e-p:32:32:32-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:32:64-f32:32:32-f64:32:64-v64:64:64-v128:128:128-a0:0:64-f80:32:32-n8:16:32-S128"
target triple = "i386-pc-linux-gnu"

%struct.Slot = type { i32, i32, i8 }

@M = global [20 x %struct.Slot] zeroinitializer, align 4

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

define zeroext i1 @_Z6lookupi(i32 %x) {
entry:
  %retval = alloca i1, align 1
  %x.addr = alloca i32, align 4
  %i = alloca i32, align 4
  store i32 %x, i32* %x.addr, align 4
  store i32 0, i32* %i, align 4
  br label %for.cond

for.cond:                                         ; preds = %for.inc, %entry
  %0 = load i32* %i, align 4
  %cmp = icmp slt i32 %0, 20
  br i1 %cmp, label %for.body, label %for.end

for.body:                                         ; preds = %for.cond
  %1 = load i32* %i, align 4
  %arrayidx = getelementptr inbounds [20 x %struct.Slot]* @M, i32 0, i32 %1
  %call = call zeroext i1 @_ZN4Slot4lockEv(%struct.Slot* %arrayidx)
  %2 = load i32* %i, align 4
  %arrayidx1 = getelementptr inbounds [20 x %struct.Slot]* @M, i32 0, i32 %2
  %elt = getelementptr inbounds %struct.Slot* %arrayidx1, i32 0, i32 0
  %3 = load i32* %elt, align 4
  %4 = load i32* %x.addr, align 4
  %cmp2 = icmp eq i32 %3, %4
  br i1 %cmp2, label %land.lhs.true, label %if.end

land.lhs.true:                                    ; preds = %for.body
  %5 = load i32* %i, align 4
  %arrayidx3 = getelementptr inbounds [20 x %struct.Slot]* @M, i32 0, i32 %5
  %stt = getelementptr inbounds %struct.Slot* %arrayidx3, i32 0, i32 1
  %6 = load i32* %stt, align 4
  %cmp4 = icmp eq i32 %6, 2
  br i1 %cmp4, label %if.then, label %if.end

if.then:                                          ; preds = %land.lhs.true
  %7 = load i32* %i, align 4
  %arrayidx5 = getelementptr inbounds [20 x %struct.Slot]* @M, i32 0, i32 %7
  call void @_ZN4Slot6unlockEv(%struct.Slot* %arrayidx5)
  store i1 true, i1* %retval
  br label %return

if.end:                                           ; preds = %land.lhs.true, %for.body
  %8 = load i32* %i, align 4
  %arrayidx6 = getelementptr inbounds [20 x %struct.Slot]* @M, i32 0, i32 %8
  call void @_ZN4Slot6unlockEv(%struct.Slot* %arrayidx6)
  br label %for.inc

for.inc:                                          ; preds = %if.end
  %9 = load i32* %i, align 4
  %inc = add nsw i32 %9, 1
  store i32 %inc, i32* %i, align 4
  br label %for.cond

for.end:                                          ; preds = %for.cond
  store i1 false, i1* %retval
  br label %return

return:                                           ; preds = %for.end, %if.then
  %10 = load i1* %retval
  ret i1 %10
}

define linkonce_odr zeroext i1 @_ZN4Slot4lockEv(%struct.Slot* %this) nounwind align 2 {
entry:
  %retval = alloca i1, align 1
  %this.addr = alloca %struct.Slot*, align 4
  store %struct.Slot* %this, %struct.Slot** %this.addr, align 4
  %this1 = load %struct.Slot** %this.addr
  %bLock = getelementptr inbounds %struct.Slot* %this1, i32 0, i32 2
  %0 = load i8* %bLock, align 1
  %tobool = trunc i8 %0 to i1
  %conv = zext i1 %tobool to i32
  %cmp = icmp eq i32 %conv, 1
  br i1 %cmp, label %if.then, label %if.end

if.then:                                          ; preds = %entry
  store i1 false, i1* %retval
  br label %return

if.end:                                           ; preds = %entry
  %bLock2 = getelementptr inbounds %struct.Slot* %this1, i32 0, i32 2
  store i8 1, i8* %bLock2, align 1
  store i1 true, i1* %retval
  br label %return

return:                                           ; preds = %if.end, %if.then
  %1 = load i1* %retval
  ret i1 %1
}

define linkonce_odr void @_ZN4Slot6unlockEv(%struct.Slot* %this) nounwind align 2 {
entry:
  %this.addr = alloca %struct.Slot*, align 4
  store %struct.Slot* %this, %struct.Slot** %this.addr, align 4
  %this1 = load %struct.Slot** %this.addr
  %bLock = getelementptr inbounds %struct.Slot* %this1, i32 0, i32 2
  store i8 0, i8* %bLock, align 1
  ret void
}

define i32 @_Z8findsloti(i32 %x) nounwind {
entry:
  %retval = alloca i32, align 4
  %x.addr = alloca i32, align 4
  %i = alloca i32, align 4
  store i32 %x, i32* %x.addr, align 4
  store i32 0, i32* %i, align 4
  br label %for.cond

for.cond:                                         ; preds = %for.inc, %entry
  %0 = load i32* %i, align 4
  %cmp = icmp slt i32 %0, 20
  br i1 %cmp, label %for.body, label %for.end

for.body:                                         ; preds = %for.cond
  %1 = load i32* %i, align 4
  %arrayidx = getelementptr inbounds [20 x %struct.Slot]* @M, i32 0, i32 %1
  %stt = getelementptr inbounds %struct.Slot* %arrayidx, i32 0, i32 1
  %2 = load i32* %stt, align 4
  %cmp1 = icmp eq i32 %2, 0
  br i1 %cmp1, label %if.then, label %if.end

if.then:                                          ; preds = %for.body
  %3 = load i32* %i, align 4
  %arrayidx2 = getelementptr inbounds [20 x %struct.Slot]* @M, i32 0, i32 %3
  %stt3 = getelementptr inbounds %struct.Slot* %arrayidx2, i32 0, i32 1
  store i32 1, i32* %stt3, align 4
  %4 = load i32* %i, align 4
  store i32 %4, i32* %retval
  br label %return

if.end:                                           ; preds = %for.body
  br label %for.inc

for.inc:                                          ; preds = %if.end
  %5 = load i32* %i, align 4
  %inc = add nsw i32 %5, 1
  store i32 %inc, i32* %i, align 4
  br label %for.cond

for.end:                                          ; preds = %for.cond
  store i32 20, i32* %retval
  br label %return

return:                                           ; preds = %for.end, %if.then
  %6 = load i32* %retval
  ret i32 %6
}

define zeroext i1 @_Z10insertpairii(i32 %x, i32 %y) {
entry:
  %retval = alloca i1, align 1
  %x.addr = alloca i32, align 4
  %y.addr = alloca i32, align 4
  %i = alloca i32, align 4
  %j = alloca i32, align 4
  store i32 %x, i32* %x.addr, align 4
  store i32 %y, i32* %y.addr, align 4
  %0 = load i32* %x.addr, align 4
  %call = call i32 @_Z8findsloti(i32 %0)
  store i32 %call, i32* %i, align 4
  %1 = load i32* %i, align 4
  %cmp = icmp eq i32 %1, 20
  br i1 %cmp, label %if.then, label %if.end

if.then:                                          ; preds = %entry
  store i1 false, i1* %retval
  br label %return

if.end:                                           ; preds = %entry
  %2 = load i32* %y.addr, align 4
  %call1 = call i32 @_Z8findsloti(i32 %2)
  store i32 %call1, i32* %j, align 4
  %3 = load i32* %j, align 4
  %cmp2 = icmp eq i32 %3, 20
  br i1 %cmp2, label %if.then3, label %if.end4

if.then3:                                         ; preds = %if.end
  %4 = load i32* %i, align 4
  %arrayidx = getelementptr inbounds [20 x %struct.Slot]* @M, i32 0, i32 %4
  %stt = getelementptr inbounds %struct.Slot* %arrayidx, i32 0, i32 1
  store i32 0, i32* %stt, align 4
  store i1 false, i1* %retval
  br label %return

if.end4:                                          ; preds = %if.end
  %5 = load i32* %x.addr, align 4
  %6 = load i32* %i, align 4
  %arrayidx5 = getelementptr inbounds [20 x %struct.Slot]* @M, i32 0, i32 %6
  %elt = getelementptr inbounds %struct.Slot* %arrayidx5, i32 0, i32 0
  store i32 %5, i32* %elt, align 4
  %7 = load i32* %y.addr, align 4
  %8 = load i32* %j, align 4
  %arrayidx6 = getelementptr inbounds [20 x %struct.Slot]* @M, i32 0, i32 %8
  %elt7 = getelementptr inbounds %struct.Slot* %arrayidx6, i32 0, i32 0
  store i32 %7, i32* %elt7, align 4
  %9 = load i32* %i, align 4
  %arrayidx8 = getelementptr inbounds [20 x %struct.Slot]* @M, i32 0, i32 %9
  %call9 = call zeroext i1 @_ZN4Slot4lockEv(%struct.Slot* %arrayidx8)
  %10 = load i32* %j, align 4
  %arrayidx10 = getelementptr inbounds [20 x %struct.Slot]* @M, i32 0, i32 %10
  %call11 = call zeroext i1 @_ZN4Slot4lockEv(%struct.Slot* %arrayidx10)
  %11 = load i32* %i, align 4
  %arrayidx12 = getelementptr inbounds [20 x %struct.Slot]* @M, i32 0, i32 %11
  %stt13 = getelementptr inbounds %struct.Slot* %arrayidx12, i32 0, i32 1
  store i32 2, i32* %stt13, align 4
  %12 = load i32* %j, align 4
  %arrayidx14 = getelementptr inbounds [20 x %struct.Slot]* @M, i32 0, i32 %12
  %stt15 = getelementptr inbounds %struct.Slot* %arrayidx14, i32 0, i32 1
  store i32 2, i32* %stt15, align 4
  %13 = load i32* %i, align 4
  %arrayidx16 = getelementptr inbounds [20 x %struct.Slot]* @M, i32 0, i32 %13
  call void @_ZN4Slot6unlockEv(%struct.Slot* %arrayidx16)
  %14 = load i32* %j, align 4
  %arrayidx17 = getelementptr inbounds [20 x %struct.Slot]* @M, i32 0, i32 %14
  call void @_ZN4Slot6unlockEv(%struct.Slot* %arrayidx17)
  store i1 true, i1* %retval
  br label %return

return:                                           ; preds = %if.end4, %if.then3, %if.then
  %15 = load i1* %retval
  ret i1 %15
}
