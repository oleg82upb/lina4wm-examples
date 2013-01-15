; ModuleID = 'msqueue.cpp'
target datalayout = "e-p:32:32:32-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:32:64-f32:32:32-f64:32:64-v64:64:64-v128:128:128-a0:0:64-f80:32:32-n8:16:32-S128"
target triple = "i386-pc-linux-gnu"

%class.MSQueue = type { %class.Node*, %class.Node* }
%class.Node = type { i32, %class.Node* }

@_ZN7MSQueueC1Ev = alias void (%class.MSQueue*)* @_ZN7MSQueueC2Ev

define void @_ZN7MSQueueC2Ev(%class.MSQueue* nocapture %this) unnamed_addr align 2 {
invoke.cont:
  %call = tail call noalias i8* @_Znwj(i32 8)
  %0 = bitcast i8* %call to %class.Node*
  %val.i.i = bitcast i8* %call to i32*
  store i32 0, i32* %val.i.i, align 4, !tbaa !0
  %next = getelementptr inbounds i8* %call, i32 4
  %1 = bitcast i8* %next to %class.Node**
  store %class.Node* null, %class.Node** %1, align 4, !tbaa !3
  %head = getelementptr inbounds %class.MSQueue* %this, i32 0, i32 0
  store volatile %class.Node* %0, %class.Node** %head, align 4, !tbaa !3
  %tail = getelementptr inbounds %class.MSQueue* %this, i32 0, i32 1
  store volatile %class.Node* %0, %class.Node** %tail, align 4, !tbaa !3
  ret void
}

declare noalias i8* @_Znwj(i32)

define void @_ZN7MSQueue7enqueueEi(%class.MSQueue* %this, i32 %value) align 2 {
invoke.cont:
  %call = tail call noalias i8* @_Znwj(i32 8)
  %val = bitcast i8* %call to i32*
  store i32 %value, i32* %val, align 4, !tbaa !0
  %next2 = getelementptr inbounds i8* %call, i32 4
  %0 = bitcast i8* %next2 to %class.Node**
  store %class.Node* null, %class.Node** %0, align 4, !tbaa !3
  %tail = getelementptr inbounds %class.MSQueue* %this, i32 0, i32 1
  %1 = ptrtoint i8* %call to i32
  %2 = bitcast %class.Node** %tail to i32*
  br label %do.body

do.body:                                          ; preds = %if.else, %if.then6, %do.body, %invoke.cont
  %3 = load volatile %class.Node** %tail, align 4, !tbaa !3
  %next3 = getelementptr inbounds %class.Node* %3, i32 0, i32 1
  %4 = load %class.Node** %next3, align 4, !tbaa !3
  %5 = load volatile %class.Node** %tail, align 4, !tbaa !3
  %cmp = icmp eq %class.Node* %3, %5
  br i1 %cmp, label %if.then, label %do.body

if.then:                                          ; preds = %do.body
  %cmp5 = icmp eq %class.Node* %4, null
  br i1 %cmp5, label %if.then6, label %if.else

if.then6:                                         ; preds = %if.then
  %6 = bitcast %class.Node** %next3 to i32*
  %7 = cmpxchg i32* %6, i32 0, i32 %1 seq_cst
  %8 = icmp eq i32 %7, 0
  br i1 %8, label %do.end, label %do.body

if.else:                                          ; preds = %if.then
  %9 = ptrtoint %class.Node* %3 to i32
  %10 = ptrtoint %class.Node* %4 to i32
  %11 = cmpxchg i32* %2, i32 %9, i32 %10 seq_cst
  br label %do.body

do.end:                                           ; preds = %if.then6
  %12 = ptrtoint %class.Node* %3 to i32
  %13 = cmpxchg i32* %2, i32 %12, i32 %1 seq_cst
  ret void
}

define zeroext i1 @_ZN7MSQueue7dequeueEPi(%class.MSQueue* %this, i32* nocapture %value) nounwind align 2 {
entry:
  %head = getelementptr inbounds %class.MSQueue* %this, i32 0, i32 0
  %tail = getelementptr inbounds %class.MSQueue* %this, i32 0, i32 1
  %0 = bitcast %class.Node** %tail to i32*
  %1 = bitcast %class.MSQueue* %this to i32*
  br label %do.body

do.body:                                          ; preds = %if.end, %if.else, %do.body, %entry
  %2 = load volatile %class.Node** %head, align 4, !tbaa !3
  %3 = load volatile %class.Node** %tail, align 4, !tbaa !3
  %4 = load volatile %class.Node** %head, align 4, !tbaa !3
  %next3 = getelementptr inbounds %class.Node* %4, i32 0, i32 1
  %5 = load %class.Node** %next3, align 4, !tbaa !3
  %6 = load volatile %class.Node** %head, align 4, !tbaa !3
  %cmp = icmp eq %class.Node* %2, %6
  br i1 %cmp, label %if.then, label %do.body

if.then:                                          ; preds = %do.body
  %cmp5 = icmp eq %class.Node* %2, %3
  br i1 %cmp5, label %if.then6, label %if.else

if.then6:                                         ; preds = %if.then
  %cmp7 = icmp eq %class.Node* %5, null
  br i1 %cmp7, label %return, label %if.end

if.end:                                           ; preds = %if.then6
  %7 = ptrtoint %class.Node* %2 to i32
  %8 = ptrtoint %class.Node* %5 to i32
  %9 = cmpxchg i32* %0, i32 %7, i32 %8 seq_cst
  br label %do.body

if.else:                                          ; preds = %if.then
  %val = getelementptr inbounds %class.Node* %5, i32 0, i32 0
  %10 = load i32* %val, align 4, !tbaa !0
  store i32 %10, i32* %value, align 4, !tbaa !0
  %11 = ptrtoint %class.Node* %2 to i32
  %12 = ptrtoint %class.Node* %5 to i32
  %13 = cmpxchg i32* %1, i32 %11, i32 %12 seq_cst
  %14 = icmp eq i32 %13, %11
  br i1 %14, label %return, label %do.body

return:                                           ; preds = %if.else, %if.then6
  %retval.0 = phi i1 [ false, %if.then6 ], [ true, %if.else ]
  ret i1 %retval.0
}

define i32 @main() nounwind readnone {
entry:
  ret i32 0
}

!0 = metadata !{metadata !"int", metadata !1}
!1 = metadata !{metadata !"omnipotent char", metadata !2}
!2 = metadata !{metadata !"Simple C/C++ TBAA", null}
!3 = metadata !{metadata !"any pointer", metadata !1}
