; ModuleID = 'stack.cpp'
target datalayout = "e-p:32:32:32-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:32:64-f32:32:32-f64:32:64-v64:64:64-v128:128:128-a0:0:64-f80:32:32-n8:16:32-S128"
target triple = "i386-pc-linux-gnu"

%class.Stack = type { %class.Node* }
%class.Node = type { i32, %class.Node* }

@_ZN5StackC1Ev = alias void %class.Stack** @_ZN5StackC2Ev

define void @_ZN5StackC2Ev(%class.Stack* nocapture %this) unnamed_addr nounwind align 2 {
entry:
  %head = getelementptr inbounds %class.Stack* %this, i32 0, i32 0
  store volatile %class.Node* null, %class.Node** %head, align 4, !tbaa !0
  ret void
}

define void @_ZN5Stack4pushEi(%class.Stack* %this, i32 %v) align 2 {
invoke.cont:
  %call = tail call noalias i8* @_Znwj(i32 8)
  %val = bitcast i8* %call to i32*
  store i32 %v, i32* %val, align 4, !tbaa !3
  %head = getelementptr inbounds %class.Stack* %this, i32 0, i32 0
  %next = getelementptr inbounds i8* %call, i32 4
  %0 = bitcast i8* %next to %class.Node**
  %1 = bitcast %class.Stack* %this to i32*
  %2 = ptrtoint i8* %call to i32
  br label %do.body

do.body:                                          ; preds = %do.body, %invoke.cont
  %3 = load volatile %class.Node** %head, align 4, !tbaa !0
  store %class.Node* %3, %class.Node** %0, align 4, !tbaa !0
  %4 = ptrtoint %class.Node* %3 to i32
  %5 = cmpxchg i32* %1, i32 %4, i32 %2 seq_cst
  %6 = icmp eq i32 %5, %4
  br i1 %6, label %do.end, label %do.body

do.end:                                           ; preds = %do.body
  ret void
}

declare noalias i8* @_Znwj(i32)

define %class.Node* @_ZN5Stack3popEv(%class.Stack* %this) nounwind align 2 {
entry:
  %head = getelementptr inbounds %class.Stack* %this, i32 0, i32 0
  %0 = bitcast %class.Stack* %this to i32*
  br label %do.body

do.body:                                          ; preds = %if.end, %entry
  %1 = load volatile %class.Node** %head, align 4, !tbaa !0
  %cmp = icmp eq %class.Node* %1, null
  br i1 %cmp, label %return, label %if.end

if.end:                                           ; preds = %do.body
  %next = getelementptr inbounds %class.Node* %1, i32 0, i32 1
  %2 = load %class.Node** %next, align 4, !tbaa !0
  %3 = ptrtoint %class.Node* %1 to i32
  %4 = ptrtoint %class.Node* %2 to i32
  %5 = cmpxchg i32* %0, i32 %3, i32 %4 seq_cst
  %6 = icmp eq i32 %5, %3
  br i1 %6, label %return, label %do.body

return:                                           ; preds = %if.end, %do.body
  %retval.0 = phi %class.Node* [ null, %do.body ], [ %1, %if.end ]
  ret %class.Node* %retval.0
}

!0 = metadata !{metadata !"any pointer", metadata !1}
!1 = metadata !{metadata !"omnipotent char", metadata !2}
!2 = metadata !{metadata !"Simple C/C++ TBAA", null}
!3 = metadata !{metadata !"int", metadata !1}
