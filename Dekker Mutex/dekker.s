; ModuleID = 'dekker.c'
target datalayout = "e-p:32:32:32-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:32:64-f32:32:32-f64:32:64-v64:64:64-v128:128:128-a0:0:64-f80:32:32-n8:16:32-S128"
target triple = "i386-pc-linux-gnu"

@flag = global [2 x i8] zeroinitializer, align 1
@turn = global i32 0, align 4

define void @p0() nounwind {
entry:
  store i8 1, i8* getelementptr inbounds ([2 x i8]* @flag, i32 0, i32 0), align 1, !tbaa !0
  %0 = load i8* getelementptr inbounds ([2 x i8]* @flag, i32 0, i32 1), align 1, !tbaa !0, !range !3
  %1 = and i8 %0, 1
  %tobool5 = icmp eq i8 %1, 0
  br i1 %tobool5, label %while.end4, label %while.body.lr.ph

while.body.lr.ph:                                 ; preds = %entry
  %2 = load i32* @turn, align 4, !tbaa !4
  %cmp = icmp eq i32 %2, 0
  br i1 %cmp, label %while.cond.backedge.us.us, label %if.then.if.then.split_crit_edge

while.cond.backedge.us.us:                        ; preds = %while.cond.backedge.us.us, %while.body.lr.ph
  br label %while.cond.backedge.us.us

if.then.if.then.split_crit_edge:                  ; preds = %while.body.lr.ph
  store i8 0, i8* getelementptr inbounds ([2 x i8]* @flag, i32 0, i32 0), align 1, !tbaa !0
  br label %while.cond1

while.cond1:                                      ; preds = %while.cond1, %if.then.if.then.split_crit_edge
  br label %while.cond1

while.end4:                                       ; preds = %entry
  store i32 1, i32* @turn, align 4, !tbaa !4
  store i8 0, i8* getelementptr inbounds ([2 x i8]* @flag, i32 0, i32 0), align 1, !tbaa !0
  ret void
}

define void @p1() nounwind {
entry:
  store i8 1, i8* getelementptr inbounds ([2 x i8]* @flag, i32 0, i32 1), align 1, !tbaa !0
  %0 = load i8* getelementptr inbounds ([2 x i8]* @flag, i32 0, i32 0), align 1, !tbaa !0, !range !3
  %1 = and i8 %0, 1
  %tobool5 = icmp eq i8 %1, 0
  br i1 %tobool5, label %while.end4, label %while.body.lr.ph

while.body.lr.ph:                                 ; preds = %entry
  %2 = load i32* @turn, align 4, !tbaa !4
  %cmp = icmp eq i32 %2, 1
  br i1 %cmp, label %while.cond.backedge.us, label %if.then.if.then.split_crit_edge

while.cond.backedge.us:                           ; preds = %while.cond.backedge.us, %while.body.lr.ph
  br label %while.cond.backedge.us

if.then.if.then.split_crit_edge:                  ; preds = %while.body.lr.ph
  store i8 0, i8* getelementptr inbounds ([2 x i8]* @flag, i32 0, i32 1), align 1, !tbaa !0
  br label %while.cond1

while.cond1:                                      ; preds = %while.cond1, %if.then.if.then.split_crit_edge
  br label %while.cond1

while.end4:                                       ; preds = %entry
  store i32 0, i32* @turn, align 4, !tbaa !4
  store i8 0, i8* getelementptr inbounds ([2 x i8]* @flag, i32 0, i32 1), align 1, !tbaa !0
  ret void
}

define i32 @main() nounwind readnone {
entry:
  ret i32 0
}

!0 = metadata !{metadata !"_Bool", metadata !1}
!1 = metadata !{metadata !"omnipotent char", metadata !2}
!2 = metadata !{metadata !"Simple C/C++ TBAA", null}
!3 = metadata !{i8 0, i8 2}                       
!4 = metadata !{metadata !"int", metadata !1}
