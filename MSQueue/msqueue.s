; ModuleID = 'msqueue.cpp'
target datalayout = "e-p:32:32:32-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:32:64-f32:32:32-f64:32:64-v64:64:64-v128:128:128-a0:0:64-f80:32:32-n8:16:32-S128"
target triple = "i386-pc-linux-gnu"

%class.MSQueue = type { %class.Node*, %class.Node* }
%class.Node = type { i32, %class.Node* }

@_ZN7MSQueueC1Ev = alias void (%class.MSQueue*)* @_ZN7MSQueueC2Ev

define void @_ZN7MSQueueC2Ev(%class.MSQueue* %this) unnamed_addr align 2 {
entry:
  %this.addr = alloca %class.MSQueue*, align 4
  %node = alloca %class.Node*, align 4
  %exn.slot = alloca i8*
  %ehselector.slot = alloca i32
  store %class.MSQueue* %this, %class.MSQueue** %this.addr, align 4
  %this1 = load %class.MSQueue** %this.addr
  %call = call noalias i8* @_Znwj(i32 8)
  %0 = bitcast i8* %call to %class.Node*
  invoke void @_ZN4NodeC1Ev(%class.Node* %0)
          to label %invoke.cont unwind label %lpad

invoke.cont:                                      ; preds = %entry
  store %class.Node* %0, %class.Node** %node, align 4
  %1 = load %class.Node** %node, align 4
  %next = getelementptr inbounds %class.Node* %1, i32 0, i32 1
  store %class.Node* null, %class.Node** %next, align 4
  %2 = load %class.Node** %node, align 4
  %head = getelementptr inbounds %class.MSQueue* %this1, i32 0, i32 0
  store volatile %class.Node* %2, %class.Node** %head, align 4
  %3 = load %class.Node** %node, align 4
  %tail = getelementptr inbounds %class.MSQueue* %this1, i32 0, i32 1
  store volatile %class.Node* %3, %class.Node** %tail, align 4
  ret void

lpad:                                             ; preds = %entry
  %4 = landingpad { i8*, i32 } personality i8* bitcast (i32 (...)* @__gxx_personality_v0 to i8*)
          cleanup
  %5 = extractvalue { i8*, i32 } %4, 0
  store i8* %5, i8** %exn.slot
  %6 = extractvalue { i8*, i32 } %4, 1
  store i32 %6, i32* %ehselector.slot
  call void @_ZdlPv(i8* %call) nounwind
  br label %eh.resume

eh.resume:                                        ; preds = %lpad
  %exn = load i8** %exn.slot
  %sel = load i32* %ehselector.slot
  %lpad.val = insertvalue { i8*, i32 } undef, i8* %exn, 0
  %lpad.val2 = insertvalue { i8*, i32 } %lpad.val, i32 %sel, 1
  resume { i8*, i32 } %lpad.val2
}

declare noalias i8* @_Znwj(i32)

define linkonce_odr void @_ZN4NodeC1Ev(%class.Node* %this) unnamed_addr align 2 {
entry:
  %this.addr = alloca %class.Node*, align 4
  store %class.Node* %this, %class.Node** %this.addr, align 4
  %this1 = load %class.Node** %this.addr
  call void @_ZN4NodeC2Ev(%class.Node* %this1)
  ret void
}

declare i32 @__gxx_personality_v0(...)

declare void @_ZdlPv(i8*) nounwind

define void @_ZN7MSQueue7enqueueEi(%class.MSQueue* %this, i32 %value) align 2 {
entry:
  %this.addr = alloca %class.MSQueue*, align 4
  %value.addr = alloca i32, align 4
  %node = alloca %class.Node*, align 4
  %localTail = alloca %class.Node*, align 4
  %next = alloca %class.Node*, align 4
  %exn.slot = alloca i8*
  %ehselector.slot = alloca i32
  store %class.MSQueue* %this, %class.MSQueue** %this.addr, align 4
  store i32 %value, i32* %value.addr, align 4
  %this1 = load %class.MSQueue** %this.addr
  %call = call noalias i8* @_Znwj(i32 8)
  %0 = bitcast i8* %call to %class.Node*
  invoke void @_ZN4NodeC1Ev(%class.Node* %0)
          to label %invoke.cont unwind label %lpad

invoke.cont:                                      ; preds = %entry
  store %class.Node* %0, %class.Node** %node, align 4
  %1 = load i32* %value.addr, align 4
  %2 = load %class.Node** %node, align 4
  %val = getelementptr inbounds %class.Node* %2, i32 0, i32 0
  store i32 %1, i32* %val, align 4
  %3 = load %class.Node** %node, align 4
  %next2 = getelementptr inbounds %class.Node* %3, i32 0, i32 1
  store %class.Node* null, %class.Node** %next2, align 4
  br label %do.body

do.body:                                          ; preds = %do.cond, %invoke.cont
  %tail = getelementptr inbounds %class.MSQueue* %this1, i32 0, i32 1
  %4 = load volatile %class.Node** %tail, align 4
  store %class.Node* %4, %class.Node** %localTail, align 4
  %5 = load %class.Node** %localTail, align 4
  %next3 = getelementptr inbounds %class.Node* %5, i32 0, i32 1
  %6 = load %class.Node** %next3, align 4
  store %class.Node* %6, %class.Node** %next, align 4
  %7 = load %class.Node** %localTail, align 4
  %tail4 = getelementptr inbounds %class.MSQueue* %this1, i32 0, i32 1
  %8 = load volatile %class.Node** %tail4, align 4
  %cmp = icmp eq %class.Node* %7, %8
  br i1 %cmp, label %if.then, label %if.end11

if.then:                                          ; preds = %do.body
  %9 = load %class.Node** %next, align 4
  %cmp5 = icmp eq %class.Node* %9, null
  br i1 %cmp5, label %if.then6, label %if.else

if.then6:                                         ; preds = %if.then
  %10 = load %class.Node** %localTail, align 4
  %next7 = getelementptr inbounds %class.Node* %10, i32 0, i32 1
  %11 = bitcast %class.Node** %next7 to i32*
  %12 = load %class.Node** %next, align 4
  %13 = ptrtoint %class.Node* %12 to i32
  %14 = load %class.Node** %node, align 4
  %15 = ptrtoint %class.Node* %14 to i32
  %16 = cmpxchg i32* %11, i32 %13, i32 %15 seq_cst
  %17 = icmp eq i32 %16, %13
  br i1 %17, label %if.then8, label %if.end

if.then8:                                         ; preds = %if.then6
  br label %do.end

lpad:                                             ; preds = %entry
  %18 = landingpad { i8*, i32 } personality i8* bitcast (i32 (...)* @__gxx_personality_v0 to i8*)
          cleanup
  %19 = extractvalue { i8*, i32 } %18, 0
  store i8* %19, i8** %exn.slot
  %20 = extractvalue { i8*, i32 } %18, 1
  store i32 %20, i32* %ehselector.slot
  call void @_ZdlPv(i8* %call) nounwind
  br label %eh.resume

if.end:                                           ; preds = %if.then6
  br label %if.end10

if.else:                                          ; preds = %if.then
  %tail9 = getelementptr inbounds %class.MSQueue* %this1, i32 0, i32 1
  %21 = bitcast %class.Node** %tail9 to i32*
  %22 = load %class.Node** %localTail, align 4
  %23 = ptrtoint %class.Node* %22 to i32
  %24 = load %class.Node** %next, align 4
  %25 = ptrtoint %class.Node* %24 to i32
  %26 = cmpxchg i32* %21, i32 %23, i32 %25 seq_cst
  %27 = icmp eq i32 %26, %23
  br label %if.end10

if.end10:                                         ; preds = %if.else, %if.end
  br label %if.end11

if.end11:                                         ; preds = %if.end10, %do.body
  br label %do.cond

do.cond:                                          ; preds = %if.end11
  br i1 true, label %do.body, label %do.end

do.end:                                           ; preds = %do.cond, %if.then8
  %tail12 = getelementptr inbounds %class.MSQueue* %this1, i32 0, i32 1
  %28 = bitcast %class.Node** %tail12 to i32*
  %29 = load %class.Node** %localTail, align 4
  %30 = ptrtoint %class.Node* %29 to i32
  %31 = load %class.Node** %node, align 4
  %32 = ptrtoint %class.Node* %31 to i32
  %33 = cmpxchg i32* %28, i32 %30, i32 %32 seq_cst
  %34 = icmp eq i32 %33, %30
  ret void

eh.resume:                                        ; preds = %lpad
  %exn = load i8** %exn.slot
  %sel = load i32* %ehselector.slot
  %lpad.val = insertvalue { i8*, i32 } undef, i8* %exn, 0
  %lpad.val13 = insertvalue { i8*, i32 } %lpad.val, i32 %sel, 1
  resume { i8*, i32 } %lpad.val13
}

define zeroext i1 @_ZN7MSQueue7dequeueEPi(%class.MSQueue* %this, i32* %value) nounwind align 2 {
entry:
  %retval = alloca i1, align 1
  %this.addr = alloca %class.MSQueue*, align 4
  %value.addr = alloca i32*, align 4
  %localHead = alloca %class.Node*, align 4
  %localTail = alloca %class.Node*, align 4
  %next = alloca %class.Node*, align 4
  store %class.MSQueue* %this, %class.MSQueue** %this.addr, align 4
  store i32* %value, i32** %value.addr, align 4
  %this1 = load %class.MSQueue** %this.addr
  br label %do.body

do.body:                                          ; preds = %do.cond, %entry
  %head = getelementptr inbounds %class.MSQueue* %this1, i32 0, i32 0
  %0 = load volatile %class.Node** %head, align 4
  store %class.Node* %0, %class.Node** %localHead, align 4
  %tail = getelementptr inbounds %class.MSQueue* %this1, i32 0, i32 1
  %1 = load volatile %class.Node** %tail, align 4
  store %class.Node* %1, %class.Node** %localTail, align 4
  %head2 = getelementptr inbounds %class.MSQueue* %this1, i32 0, i32 0
  %2 = load volatile %class.Node** %head2, align 4
  %next3 = getelementptr inbounds %class.Node* %2, i32 0, i32 1
  %3 = load %class.Node** %next3, align 4
  store %class.Node* %3, %class.Node** %next, align 4
  %4 = load %class.Node** %localHead, align 4
  %head4 = getelementptr inbounds %class.MSQueue* %this1, i32 0, i32 0
  %5 = load volatile %class.Node** %head4, align 4
  %cmp = icmp eq %class.Node* %4, %5
  br i1 %cmp, label %if.then, label %if.end14

if.then:                                          ; preds = %do.body
  %6 = load %class.Node** %localHead, align 4
  %7 = load %class.Node** %localTail, align 4
  %cmp5 = icmp eq %class.Node* %6, %7
  br i1 %cmp5, label %if.then6, label %if.else

if.then6:                                         ; preds = %if.then
  %8 = load %class.Node** %next, align 4
  %cmp7 = icmp eq %class.Node* %8, null
  br i1 %cmp7, label %if.then8, label %if.end

if.then8:                                         ; preds = %if.then6
  store i1 false, i1* %retval
  br label %return

if.end:                                           ; preds = %if.then6
  %tail9 = getelementptr inbounds %class.MSQueue* %this1, i32 0, i32 1
  %9 = bitcast %class.Node** %tail9 to i32*
  %10 = load %class.Node** %localTail, align 4
  %11 = ptrtoint %class.Node* %10 to i32
  %12 = load %class.Node** %next, align 4
  %13 = ptrtoint %class.Node* %12 to i32
  %14 = cmpxchg i32* %9, i32 %11, i32 %13 seq_cst
  %15 = icmp eq i32 %14, %11
  br label %if.end13

if.else:                                          ; preds = %if.then
  %16 = load %class.Node** %next, align 4
  %val = getelementptr inbounds %class.Node* %16, i32 0, i32 0
  %17 = load i32* %val, align 4
  %18 = load i32** %value.addr, align 4
  store i32 %17, i32* %18, align 4
  %head10 = getelementptr inbounds %class.MSQueue* %this1, i32 0, i32 0
  %19 = bitcast %class.Node** %head10 to i32*
  %20 = load %class.Node** %localHead, align 4
  %21 = ptrtoint %class.Node* %20 to i32
  %22 = load %class.Node** %next, align 4
  %23 = ptrtoint %class.Node* %22 to i32
  %24 = cmpxchg i32* %19, i32 %21, i32 %23 seq_cst
  %25 = icmp eq i32 %24, %21
  br i1 %25, label %if.then11, label %if.end12

if.then11:                                        ; preds = %if.else
  br label %do.end

if.end12:                                         ; preds = %if.else
  br label %if.end13

if.end13:                                         ; preds = %if.end12, %if.end
  br label %if.end14

if.end14:                                         ; preds = %if.end13, %do.body
  br label %do.cond

do.cond:                                          ; preds = %if.end14
  br i1 true, label %do.body, label %do.end

do.end:                                           ; preds = %do.cond, %if.then11
  store i1 true, i1* %retval
  br label %return

return:                                           ; preds = %do.end, %if.then8
  %26 = load i1* %retval
  ret i1 %26
}

define i32 @main() nounwind {
entry:
  %retval = alloca i32, align 4
  store i32 0, i32* %retval
  ret i32 0
}

define linkonce_odr void @_ZN4NodeC2Ev(%class.Node* %this) unnamed_addr nounwind align 2 {
entry:
  %this.addr = alloca %class.Node*, align 4
  store %class.Node* %this, %class.Node** %this.addr, align 4
  %this1 = load %class.Node** %this.addr
  %val = getelementptr inbounds %class.Node* %this1, i32 0, i32 0
  store i32 0, i32* %val, align 4
  ret void
}
