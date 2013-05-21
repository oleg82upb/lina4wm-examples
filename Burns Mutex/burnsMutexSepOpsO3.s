; ModuleID = 'burnsMutexSepOps.cpp'
target datalayout = "e-p:32:32:32-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:32:64-f32:32:32-f64:32:64-v64:64:64-v128:128:128-a0:0:64-f80:32:32-n8:16:32-S128"
target triple = "i386-pc-linux-gnu"

@f0 = global i8 0, align 1
@f1 = global i8 0, align 1
@i = global i32 0, align 4

define void @_Z5p1_aqv() nounwind {
entry:
  store i8 1, i8* @f0, align 1, !tbaa !0
  %0 = load i8* @f1, align 1, !tbaa !0, !range !3
  %1 = and i8 %0, 1
  %tobool = icmp eq i8 %1, 0
  br i1 %tobool, label %while.end.split, label %while.cond

while.cond:                                       ; preds = %while.cond, %entry
  br label %while.cond

while.end.split:                                  ; preds = %entry
  ret void
}

define void @_Z6p1_relv() nounwind {
entry:
  store i8 0, i8* @f0, align 1, !tbaa !0
  ret void
}

define void @_Z5p2_aqv() nounwind {
entry:
  %0 = load i8* @f0, align 1, !tbaa !0, !range !3
  %1 = and i8 %0, 1
  %tobool = icmp eq i8 %1, 0
  br i1 %tobool, label %if.end, label %while.cond.backedge

while.cond.backedge:                              ; preds = %while.cond.backedge, %entry
  br label %while.cond.backedge

if.end:                                           ; preds = %entry
  store i8 1, i8* @f1, align 1
  ret void
}

define void @_Z6p2_relv() nounwind {
entry:
  store i8 0, i8* @f1, align 1, !tbaa !0
  ret void
}

define i32 @main() nounwind readnone {
entry:
  ret i32 0
}

!0 = metadata !{metadata !"bool", metadata !1}
!1 = metadata !{metadata !"omnipotent char", metadata !2}
!2 = metadata !{metadata !"Simple C/C++ TBAA", null}
!3 = metadata !{i8 0, i8 2}                       
