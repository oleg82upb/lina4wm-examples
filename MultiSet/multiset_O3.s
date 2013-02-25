; ModuleID = 'multiset.cpp'
target datalayout = "e-p:32:32:32-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:32:64-f32:32:32-f64:32:64-v64:64:64-v128:128:128-a0:0:64-f80:32:32-n8:16:32-S128"
target triple = "i386-pc-linux-gnu"

%struct.Slot = type { i32, i32, i8 }

@M = global [20 x %struct.Slot] zeroinitializer, align 4

define i32 @main(i32 %argc, i8** nocapture %argv) nounwind readnone {
entry:
  ret i32 0
}

define zeroext i1 @_Z6lookupi(i32 %x) nounwind {
entry:
  br label %for.body

for.body:                                         ; preds = %entry, %if.end
  %i.015 = phi i32 [ 0, %entry ], [ %inc, %if.end ]
  %bLock.i = getelementptr inbounds [20 x %struct.Slot]* @M, i32 0, i32 %i.015, i32 2
  %0 = load i8* %bLock.i, align 4, !tbaa !0, !range !3
  %tobool.i = icmp eq i8 %0, 0
  br i1 %tobool.i, label %if.end.i, label %_ZN4Slot4lockEv.exit

if.end.i:                                         ; preds = %for.body
  store i8 1, i8* %bLock.i, align 4, !tbaa !0
  br label %_ZN4Slot4lockEv.exit

_ZN4Slot4lockEv.exit:                             ; preds = %for.body, %if.end.i
  %elt = getelementptr inbounds [20 x %struct.Slot]* @M, i32 0, i32 %i.015, i32 0
  %1 = load i32* %elt, align 4, !tbaa !4
  %cmp2 = icmp eq i32 %1, %x
  br i1 %cmp2, label %land.lhs.true, label %if.end

land.lhs.true:                                    ; preds = %_ZN4Slot4lockEv.exit
  %stt = getelementptr inbounds [20 x %struct.Slot]* @M, i32 0, i32 %i.015, i32 1
  %2 = load i32* %stt, align 4, !tbaa !5
  %cmp4 = icmp eq i32 %2, 2
  br i1 %cmp4, label %if.then, label %if.end

if.then:                                          ; preds = %land.lhs.true
  store i8 0, i8* %bLock.i, align 4, !tbaa !0
  br label %return

if.end:                                           ; preds = %land.lhs.true, %_ZN4Slot4lockEv.exit
  store i8 0, i8* %bLock.i, align 4, !tbaa !0
  %inc = add nsw i32 %i.015, 1
  %cmp = icmp slt i32 %inc, 20
  br i1 %cmp, label %for.body, label %return

return:                                           ; preds = %if.end, %if.then
  %retval.0 = phi i1 [ true, %if.then ], [ false, %if.end ]
  ret i1 %retval.0
}

define i32 @_Z8findsloti(i32 %x) nounwind {
entry:
  br label %for.cond

for.cond:                                         ; preds = %for.body, %entry
  %i.0 = phi i32 [ 0, %entry ], [ %inc, %for.body ]
  %cmp = icmp slt i32 %i.0, 20
  br i1 %cmp, label %for.body, label %return

for.body:                                         ; preds = %for.cond
  %stt = getelementptr inbounds [20 x %struct.Slot]* @M, i32 0, i32 %i.0, i32 1
  %0 = load i32* %stt, align 4, !tbaa !5
  %cmp1 = icmp eq i32 %0, 0
  %inc = add nsw i32 %i.0, 1
  br i1 %cmp1, label %if.then, label %for.cond

if.then:                                          ; preds = %for.body
  store i32 1, i32* %stt, align 4, !tbaa !5
  br label %return

return:                                           ; preds = %for.cond, %if.then
  %retval.0 = phi i32 [ %i.0, %if.then ], [ 20, %for.cond ]
  ret i32 %retval.0
}

define zeroext i1 @_Z10insertpairii(i32 %x, i32 %y) nounwind {
entry:
  br label %for.cond.i

for.cond.i:                                       ; preds = %for.body.i, %entry
  %i.0.i = phi i32 [ 0, %entry ], [ %inc.i, %for.body.i ]
  %cmp.i = icmp slt i32 %i.0.i, 20
  br i1 %cmp.i, label %for.body.i, label %return

for.body.i:                                       ; preds = %for.cond.i
  %stt.i = getelementptr inbounds [20 x %struct.Slot]* @M, i32 0, i32 %i.0.i, i32 1
  %0 = load i32* %stt.i, align 4, !tbaa !5
  %cmp1.i = icmp eq i32 %0, 0
  %inc.i = add nsw i32 %i.0.i, 1
  br i1 %cmp1.i, label %_Z8findsloti.exit, label %for.cond.i

_Z8findsloti.exit:                                ; preds = %for.body.i
  store i32 1, i32* %stt.i, align 4, !tbaa !5
  %cmp = icmp eq i32 %i.0.i, 20
  br i1 %cmp, label %return, label %for.cond.i39

for.cond.i39:                                     ; preds = %_Z8findsloti.exit, %for.body.i43
  %i.0.i37 = phi i32 [ %inc.i42, %for.body.i43 ], [ 0, %_Z8findsloti.exit ]
  %cmp.i38 = icmp slt i32 %i.0.i37, 20
  br i1 %cmp.i38, label %for.body.i43, label %if.then3

for.body.i43:                                     ; preds = %for.cond.i39
  %stt.i40 = getelementptr inbounds [20 x %struct.Slot]* @M, i32 0, i32 %i.0.i37, i32 1
  %1 = load i32* %stt.i40, align 4, !tbaa !5
  %cmp1.i41 = icmp eq i32 %1, 0
  %inc.i42 = add nsw i32 %i.0.i37, 1
  br i1 %cmp1.i41, label %_Z8findsloti.exit46, label %for.cond.i39

_Z8findsloti.exit46:                              ; preds = %for.body.i43
  store i32 1, i32* %stt.i40, align 4, !tbaa !5
  %cmp2 = icmp eq i32 %i.0.i37, 20
  br i1 %cmp2, label %if.then3, label %if.end4

if.then3:                                         ; preds = %for.cond.i39, %_Z8findsloti.exit46
  store i32 0, i32* %stt.i, align 4, !tbaa !5
  br label %return

if.end4:                                          ; preds = %_Z8findsloti.exit46
  %elt = getelementptr inbounds [20 x %struct.Slot]* @M, i32 0, i32 %i.0.i, i32 0
  store i32 %x, i32* %elt, align 4, !tbaa !4
  %elt7 = getelementptr inbounds [20 x %struct.Slot]* @M, i32 0, i32 %i.0.i37, i32 0
  store i32 %y, i32* %elt7, align 4, !tbaa !4
  %bLock.i32 = getelementptr inbounds [20 x %struct.Slot]* @M, i32 0, i32 %i.0.i, i32 2
  %2 = load i8* %bLock.i32, align 4, !tbaa !0, !range !3
  %tobool.i33 = icmp eq i8 %2, 0
  br i1 %tobool.i33, label %if.end.i34, label %_ZN4Slot4lockEv.exit36

if.end.i34:                                       ; preds = %if.end4
  store i8 1, i8* %bLock.i32, align 4, !tbaa !0
  br label %_ZN4Slot4lockEv.exit36

_ZN4Slot4lockEv.exit36:                           ; preds = %if.end4, %if.end.i34
  %bLock.i30 = getelementptr inbounds [20 x %struct.Slot]* @M, i32 0, i32 %i.0.i37, i32 2
  %3 = load i8* %bLock.i30, align 4, !tbaa !0, !range !3
  %tobool.i = icmp eq i8 %3, 0
  br i1 %tobool.i, label %if.end.i, label %_ZN4Slot4lockEv.exit

if.end.i:                                         ; preds = %_ZN4Slot4lockEv.exit36
  store i8 1, i8* %bLock.i30, align 4, !tbaa !0
  br label %_ZN4Slot4lockEv.exit

_ZN4Slot4lockEv.exit:                             ; preds = %_ZN4Slot4lockEv.exit36, %if.end.i
  store i32 2, i32* %stt.i, align 4, !tbaa !5
  store i32 2, i32* %stt.i40, align 4, !tbaa !5
  store i8 0, i8* %bLock.i32, align 4, !tbaa !0
  store i8 0, i8* %bLock.i30, align 4, !tbaa !0
  br label %return

return:                                           ; preds = %for.cond.i, %_Z8findsloti.exit, %_ZN4Slot4lockEv.exit, %if.then3
  %retval.0 = phi i1 [ false, %if.then3 ], [ true, %_ZN4Slot4lockEv.exit ], [ false, %_Z8findsloti.exit ], [ false, %for.cond.i ]
  ret i1 %retval.0
}

!0 = metadata !{metadata !"bool", metadata !1}
!1 = metadata !{metadata !"omnipotent char", metadata !2}
!2 = metadata !{metadata !"Simple C/C++ TBAA"}
!3 = metadata !{i8 0, i8 2}
!4 = metadata !{metadata !"int", metadata !1}
!5 = metadata !{metadata !"_ZTS6Status", metadata !1}
