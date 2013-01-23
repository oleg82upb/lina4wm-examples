; ModuleID = 'burnsMutex.cpp'
target datalayout = "e-p:32:32:32-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:32:64-f32:32:32-f64:32:64-v64:64:64-v128:128:128-a0:0:64-f80:32:32-n8:16:32-S128"
target triple = "i386-pc-linux-gnu"

@f0 = global i8 0, align 1
@f1 = global i8 0, align 1
@i = global i32 0, align 4

define void @_Z2p1v() noreturn nounwind {
entry:
  %0 = load i8* @f1, align 1, !tbaa !0, !range !3
  %1 = and i8 %0, 1
  %tobool = icmp eq i8 %1, 0
  br i1 %tobool, label %while.end.split.us, label %while.cond1

while.end.split.us:                               ; preds = %entry, %while.end.split.us
  br label %while.end.split.us

while.cond1:                                      ; preds = %while.cond1, %entry
  br label %while.cond1
}

define void @_Z2p2v() noreturn nounwind {
entry:
  %0 = load i8* @f0, align 1, !tbaa !0, !range !3
  %1 = and i8 %0, 1
  %tobool = icmp eq i8 %1, 0
  br i1 %tobool, label %while.cond1.backedge.us.us, label %while.cond1.backedge

while.cond1.backedge.us.us:                       ; preds = %while.cond1.backedge.us.us, %entry
  br label %while.cond1.backedge.us.us

while.cond1.backedge:                             ; preds = %while.cond1.backedge, %entry
  br label %while.cond1.backedge
}

define i32 @main() nounwind readnone {
entry:
  ret i32 0
}

!0 = metadata !{metadata !"bool", metadata !1}
!1 = metadata !{metadata !"omnipotent char", metadata !2}
!2 = metadata !{metadata !"Simple C/C++ TBAA", null}
!3 = metadata !{i8 0, i8 2}                       
