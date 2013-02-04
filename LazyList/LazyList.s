; ModuleID = 'LazyList.cpp'
target datalayout = "e-p:32:32:32-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:32:64-f32:32:32-f64:32:64-v64:64:64-v128:128:128-a0:0:64-f80:32:32-n8:16:32-S128"
target triple = "i386-pc-linux-gnu"

%struct.stNode = type { i32, i8, i8, %struct.stNode* }

@Head = global %struct.stNode* null, align 4
@Tail = global %struct.stNode* null, align 4

define void @_Z4initv() {
entry:
  %call = call noalias i8* @_Znwj(i32 12)
  %0 = bitcast i8* %call to %struct.stNode*
  store %struct.stNode* %0, %struct.stNode** @Head, align 4
  %1 = load %struct.stNode** @Head, align 4
  call void @_ZN6stNode5eInitEib(%struct.stNode* %1, i32 -2147483648, i1 zeroext false)
  %call1 = call noalias i8* @_Znwj(i32 12)
  %2 = bitcast i8* %call1 to %struct.stNode*
  store %struct.stNode* %2, %struct.stNode** @Tail, align 4
  %3 = load %struct.stNode** @Tail, align 4
  call void @_ZN6stNode5eInitEib(%struct.stNode* %3, i32 2147483647, i1 zeroext false)
  %4 = load %struct.stNode** @Tail, align 4
  %5 = load %struct.stNode** @Head, align 4
  %ptNext = getelementptr inbounds %struct.stNode* %5, i32 0, i32 3
  store %struct.stNode* %4, %struct.stNode** %ptNext, align 4
  %6 = load %struct.stNode** @Tail, align 4
  %ptNext2 = getelementptr inbounds %struct.stNode* %6, i32 0, i32 3
  store %struct.stNode* null, %struct.stNode** %ptNext2, align 4
  ret void
}

declare noalias i8* @_Znwj(i32)

define linkonce_odr void @_ZN6stNode5eInitEib(%struct.stNode* %this, i32 %iVal, i1 zeroext %bLoc) nounwind align 2 {
entry:
  %this.addr = alloca %struct.stNode*, align 4
  %iVal.addr = alloca i32, align 4
  %bLoc.addr = alloca i8, align 1
  store %struct.stNode* %this, %struct.stNode** %this.addr, align 4
  store i32 %iVal, i32* %iVal.addr, align 4
  %frombool = zext i1 %bLoc to i8
  store i8 %frombool, i8* %bLoc.addr, align 1
  %this1 = load %struct.stNode** %this.addr
  %0 = load i32* %iVal.addr, align 4
  %iValue = getelementptr inbounds %struct.stNode* %this1, i32 0, i32 0
  store i32 %0, i32* %iValue, align 4
  %1 = load i8* %bLoc.addr, align 1
  %tobool = trunc i8 %1 to i1
  %bLock = getelementptr inbounds %struct.stNode* %this1, i32 0, i32 1
  %frombool2 = zext i1 %tobool to i8
  store i8 %frombool2, i8* %bLock, align 1
  %bMark = getelementptr inbounds %struct.stNode* %this1, i32 0, i32 2
  store i8 0, i8* %bMark, align 1
  %ptNext = getelementptr inbounds %struct.stNode* %this1, i32 0, i32 3
  store %struct.stNode* null, %struct.stNode** %ptNext, align 4
  ret void
}

define %struct.stNode* @_Z6locatei(i32 %x) {
entry:
  %retval = alloca %struct.stNode*, align 4
  %x.addr = alloca i32, align 4
  %pred = alloca %struct.stNode*, align 4
  %curr = alloca %struct.stNode*, align 4
  store i32 %x, i32* %x.addr, align 4
  %0 = load %struct.stNode** @Head, align 4
  store %struct.stNode* %0, %struct.stNode** %pred, align 4
  %1 = load %struct.stNode** %pred, align 4
  %ptNext = getelementptr inbounds %struct.stNode* %1, i32 0, i32 3
  %2 = load %struct.stNode** %ptNext, align 4
  store %struct.stNode* %2, %struct.stNode** %curr, align 4
  br label %while.cond

while.cond:                                       ; preds = %while.body, %entry
  %3 = load %struct.stNode** %curr, align 4
  %iValue = getelementptr inbounds %struct.stNode* %3, i32 0, i32 0
  %4 = load i32* %iValue, align 4
  %5 = load i32* %x.addr, align 4
  %cmp = icmp slt i32 %4, %5
  br i1 %cmp, label %while.body, label %while.end

while.body:                                       ; preds = %while.cond
  %6 = load %struct.stNode** %curr, align 4
  store %struct.stNode* %6, %struct.stNode** %pred, align 4
  %7 = load %struct.stNode** %curr, align 4
  %ptNext1 = getelementptr inbounds %struct.stNode* %7, i32 0, i32 3
  %8 = load %struct.stNode** %ptNext1, align 4
  store %struct.stNode* %8, %struct.stNode** %curr, align 4
  br label %while.cond

while.end:                                        ; preds = %while.cond
  %9 = load %struct.stNode** %pred, align 4
  %call = call zeroext i1 @_ZN6stNode4lockEv(%struct.stNode* %9)
  %10 = load %struct.stNode** %curr, align 4
  %call2 = call zeroext i1 @_ZN6stNode4lockEv(%struct.stNode* %10)
  %11 = load %struct.stNode** %pred, align 4
  %12 = load %struct.stNode** %curr, align 4
  %call3 = call zeroext i1 @_Z8validateP6stNodeS0_(%struct.stNode* %11, %struct.stNode* %12)
  br i1 %call3, label %if.then, label %if.end

if.then:                                          ; preds = %while.end
  %13 = load %struct.stNode** %pred, align 4
  store %struct.stNode* %13, %struct.stNode** %retval
  br label %return

if.end:                                           ; preds = %while.end
  %14 = load %struct.stNode** %pred, align 4
  call void @_ZN6stNode6unlockEv(%struct.stNode* %14)
  %15 = load %struct.stNode** %curr, align 4
  call void @_ZN6stNode6unlockEv(%struct.stNode* %15)
  store %struct.stNode* null, %struct.stNode** %retval
  br label %return

return:                                           ; preds = %if.end, %if.then
  %16 = load %struct.stNode** %retval
  ret %struct.stNode* %16
}

define linkonce_odr zeroext i1 @_ZN6stNode4lockEv(%struct.stNode* %this) nounwind align 2 {
entry:
  %this.addr = alloca %struct.stNode*, align 4
  store %struct.stNode* %this, %struct.stNode** %this.addr, align 4
  %this1 = load %struct.stNode** %this.addr
  %bLock = getelementptr inbounds %struct.stNode* %this1, i32 0, i32 1
  %0 = cmpxchg i8* %bLock, i8 0, i8 1 seq_cst
  %1 = icmp eq i8 %0, 0
  ret i1 %1
}

define zeroext i1 @_Z8validateP6stNodeS0_(%struct.stNode* %pred, %struct.stNode* %curr) nounwind {
entry:
  %retval = alloca i1, align 1
  %pred.addr = alloca %struct.stNode*, align 4
  %curr.addr = alloca %struct.stNode*, align 4
  store %struct.stNode* %pred, %struct.stNode** %pred.addr, align 4
  store %struct.stNode* %curr, %struct.stNode** %curr.addr, align 4
  %0 = load %struct.stNode** %pred.addr, align 4
  %bMark = getelementptr inbounds %struct.stNode* %0, i32 0, i32 2
  %1 = load i8* %bMark, align 1
  %tobool = trunc i8 %1 to i1
  br i1 %tobool, label %if.end, label %land.lhs.true

land.lhs.true:                                    ; preds = %entry
  %2 = load %struct.stNode** %curr.addr, align 4
  %bMark1 = getelementptr inbounds %struct.stNode* %2, i32 0, i32 2
  %3 = load i8* %bMark1, align 1
  %tobool2 = trunc i8 %3 to i1
  br i1 %tobool2, label %if.end, label %land.lhs.true3

land.lhs.true3:                                   ; preds = %land.lhs.true
  %4 = load %struct.stNode** %pred.addr, align 4
  %ptNext = getelementptr inbounds %struct.stNode* %4, i32 0, i32 3
  %5 = load %struct.stNode** %ptNext, align 4
  %6 = load %struct.stNode** %curr.addr, align 4
  %cmp = icmp eq %struct.stNode* %5, %6
  br i1 %cmp, label %if.then, label %if.end

if.then:                                          ; preds = %land.lhs.true3
  store i1 true, i1* %retval
  br label %return

if.end:                                           ; preds = %land.lhs.true3, %land.lhs.true, %entry
  store i1 false, i1* %retval
  br label %return

return:                                           ; preds = %if.end, %if.then
  %7 = load i1* %retval
  ret i1 %7
}

define linkonce_odr void @_ZN6stNode6unlockEv(%struct.stNode* %this) nounwind align 2 {
entry:
  %this.addr = alloca %struct.stNode*, align 4
  store %struct.stNode* %this, %struct.stNode** %this.addr, align 4
  %this1 = load %struct.stNode** %this.addr
  %bLock = getelementptr inbounds %struct.stNode* %this1, i32 0, i32 1
  store i8 0, i8* %bLock, align 1
  ret void
}

define zeroext i1 @_Z6inserti(i32 %iIns) {
entry:
  %iIns.addr = alloca i32, align 4
  %result = alloca i8, align 1
  %left = alloca %struct.stNode*, align 4
  %right = alloca %struct.stNode*, align 4
  %mid = alloca %struct.stNode*, align 4
  store i32 %iIns, i32* %iIns.addr, align 4
  store i8 0, i8* %result, align 1
  %0 = load i32* %iIns.addr, align 4
  %call = call %struct.stNode* @_Z6locatei(i32 %0)
  store %struct.stNode* %call, %struct.stNode** %left, align 4
  %1 = load %struct.stNode** %left, align 4
  %ptNext = getelementptr inbounds %struct.stNode* %1, i32 0, i32 3
  %2 = load %struct.stNode** %ptNext, align 4
  store %struct.stNode* %2, %struct.stNode** %right, align 4
  %3 = load %struct.stNode** %right, align 4
  %iValue = getelementptr inbounds %struct.stNode* %3, i32 0, i32 0
  %4 = load i32* %iValue, align 4
  %5 = load i32* %iIns.addr, align 4
  %cmp = icmp ne i32 %4, %5
  br i1 %cmp, label %if.then, label %if.end

if.then:                                          ; preds = %entry
  %call1 = call noalias i8* @_Znwj(i32 12)
  %6 = bitcast i8* %call1 to %struct.stNode*
  store %struct.stNode* %6, %struct.stNode** %mid, align 4
  %7 = load %struct.stNode** %mid, align 4
  %8 = load i32* %iIns.addr, align 4
  call void @_ZN6stNode5eInitEib(%struct.stNode* %7, i32 %8, i1 zeroext false)
  %9 = load %struct.stNode** %right, align 4
  %10 = load %struct.stNode** %mid, align 4
  %ptNext2 = getelementptr inbounds %struct.stNode* %10, i32 0, i32 3
  store %struct.stNode* %9, %struct.stNode** %ptNext2, align 4
  %11 = load %struct.stNode** %mid, align 4
  %12 = load %struct.stNode** %left, align 4
  %ptNext3 = getelementptr inbounds %struct.stNode* %12, i32 0, i32 3
  store %struct.stNode* %11, %struct.stNode** %ptNext3, align 4
  store i8 1, i8* %result, align 1
  br label %if.end

if.end:                                           ; preds = %if.then, %entry
  %13 = load %struct.stNode** %left, align 4
  call void @_ZN6stNode6unlockEv(%struct.stNode* %13)
  %14 = load %struct.stNode** %right, align 4
  call void @_ZN6stNode6unlockEv(%struct.stNode* %14)
  ret i1 false
}

define zeroext i1 @_Z6removei(i32 %iDel) {
entry:
  %retval = alloca i1, align 1
  %iDel.addr = alloca i32, align 4
  %left = alloca %struct.stNode*, align 4
  %del = alloca %struct.stNode*, align 4
  %right = alloca %struct.stNode*, align 4
  store i32 %iDel, i32* %iDel.addr, align 4
  %0 = load i32* %iDel.addr, align 4
  %call = call %struct.stNode* @_Z6locatei(i32 %0)
  store %struct.stNode* %call, %struct.stNode** %left, align 4
  %1 = load %struct.stNode** %left, align 4
  %ptNext = getelementptr inbounds %struct.stNode* %1, i32 0, i32 3
  %2 = load %struct.stNode** %ptNext, align 4
  store %struct.stNode* %2, %struct.stNode** %del, align 4
  %3 = load %struct.stNode** %del, align 4
  %ptNext1 = getelementptr inbounds %struct.stNode* %3, i32 0, i32 3
  %4 = load %struct.stNode** %ptNext1, align 4
  store %struct.stNode* %4, %struct.stNode** %right, align 4
  %5 = load %struct.stNode** %del, align 4
  %iValue = getelementptr inbounds %struct.stNode* %5, i32 0, i32 0
  %6 = load i32* %iValue, align 4
  %7 = load i32* %iDel.addr, align 4
  %cmp = icmp eq i32 %6, %7
  br i1 %cmp, label %if.then, label %if.end

if.then:                                          ; preds = %entry
  %8 = load %struct.stNode** %del, align 4
  %bMark = getelementptr inbounds %struct.stNode* %8, i32 0, i32 2
  store i8 1, i8* %bMark, align 1
  %9 = load %struct.stNode** %right, align 4
  %10 = load %struct.stNode** %left, align 4
  %ptNext2 = getelementptr inbounds %struct.stNode* %10, i32 0, i32 3
  store %struct.stNode* %9, %struct.stNode** %ptNext2, align 4
  %11 = load %struct.stNode** %left, align 4
  call void @_ZN6stNode6unlockEv(%struct.stNode* %11)
  %12 = load %struct.stNode** %del, align 4
  call void @_ZN6stNode6unlockEv(%struct.stNode* %12)
  store i1 true, i1* %retval
  br label %return

if.end:                                           ; preds = %entry
  %13 = load %struct.stNode** %left, align 4
  call void @_ZN6stNode6unlockEv(%struct.stNode* %13)
  %14 = load %struct.stNode** %del, align 4
  call void @_ZN6stNode6unlockEv(%struct.stNode* %14)
  store i1 false, i1* %retval
  br label %return

return:                                           ; preds = %if.end, %if.then
  %15 = load i1* %retval
  ret i1 %15
}

define zeroext i1 @_Z8containsi(i32 %iCon) nounwind {
entry:
  %retval = alloca i1, align 1
  %iCon.addr = alloca i32, align 4
  %curr = alloca %struct.stNode*, align 4
  store i32 %iCon, i32* %iCon.addr, align 4
  %0 = load %struct.stNode** @Head, align 4
  store %struct.stNode* %0, %struct.stNode** %curr, align 4
  br label %while.cond

while.cond:                                       ; preds = %while.body, %entry
  %1 = load %struct.stNode** %curr, align 4
  %iValue = getelementptr inbounds %struct.stNode* %1, i32 0, i32 0
  %2 = load i32* %iValue, align 4
  %3 = load i32* %iCon.addr, align 4
  %cmp = icmp slt i32 %2, %3
  br i1 %cmp, label %while.body, label %while.end

while.body:                                       ; preds = %while.cond
  %4 = load %struct.stNode** %curr, align 4
  %ptNext = getelementptr inbounds %struct.stNode* %4, i32 0, i32 3
  %5 = load %struct.stNode** %ptNext, align 4
  store %struct.stNode* %5, %struct.stNode** %curr, align 4
  br label %while.cond

while.end:                                        ; preds = %while.cond
  %6 = load %struct.stNode** %curr, align 4
  %bMark = getelementptr inbounds %struct.stNode* %6, i32 0, i32 2
  %7 = load i8* %bMark, align 1
  %tobool = trunc i8 %7 to i1
  br i1 %tobool, label %if.then, label %if.end

if.then:                                          ; preds = %while.end
  store i1 false, i1* %retval
  br label %return

if.end:                                           ; preds = %while.end
  store i1 true, i1* %retval
  br label %return

return:                                           ; preds = %if.end, %if.then
  %8 = load i1* %retval
  ret i1 %8
}
