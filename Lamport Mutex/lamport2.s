; ModuleID = 'lamport.c'
target datalayout = "e-p:32:32:32-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:32:64-f32:32:32-f64:32:64-v64:64:64-v128:128:128-a0:0:64-f80:32:32-n8:16:32-S128"
target triple = "i386-pc-linux-gnu"

@choosing = global [2 x i8] zeroinitializer, align 1
@number = global [2 x i32] zeroinitializer, align 4

define void @proci(i32 %i) noreturn nounwind {
entry:
  %arrayidx = getelementptr inbounds [2 x i8]* @choosing, i32 0, i32 %i
  %arrayidx1 = getelementptr inbounds [2 x i32]* @number, i32 0, i32 %i
  br label %L1

L1:                                               ; preds = %for.inc.split.1, %entry
  store i8 1, i8* %arrayidx, align 1, !tbaa !0
  %0 = load i32* getelementptr inbounds ([2 x i32]* @number, i32 0, i32 0), align 4, !tbaa !3
  %1 = load i32* getelementptr inbounds ([2 x i32]* @number, i32 0, i32 1), align 4, !tbaa !3
  %cmp = icmp slt i32 %0, %1
  %storemerge.v = select i1 %cmp, i32 %1, i32 %0
  %storemerge = add i32 %storemerge.v, 1
  store i32 %storemerge, i32* %arrayidx1, align 4
  store i8 0, i8* %arrayidx, align 1, !tbaa !0
  %2 = load i8* getelementptr inbounds ([2 x i8]* @choosing, i32 0, i32 0), align 1, !tbaa !0, !range !4
  %3 = and i8 %2, 1
  %tobool = icmp eq i8 %3, 0
  br i1 %tobool, label %while.cond7.loopexit.split, label %while.cond

while.cond:                                       ; preds = %while.cond, %L1
  br label %while.cond

while.cond7.loopexit.split:                       ; preds = %L1
  %4 = load i32* getelementptr inbounds ([2 x i32]* @number, i32 0, i32 0), align 4, !tbaa !3
  %cmp9 = icmp eq i32 %4, 0
  br i1 %cmp9, label %for.inc.split, label %while.cond7.loopexit.split.while.cond7.loopexit.split.split_crit_edge

while.cond7.loopexit.split.while.cond7.loopexit.split.split_crit_edge: ; preds = %while.cond7.loopexit.split
  %cmp17 = icmp sgt i32 %i, 0
  br i1 %cmp17, label %land.rhs.us, label %land.rhs

land.rhs.us:                                      ; preds = %land.rhs.us, %while.cond7.loopexit.split.while.cond7.loopexit.split.split_crit_edge
  %5 = icmp sgt i32 %4, %storemerge
  br i1 %5, label %for.inc.split, label %land.rhs.us

land.rhs:                                         ; preds = %land.rhs, %while.cond7.loopexit.split.while.cond7.loopexit.split.split_crit_edge
  %cmp12 = icmp slt i32 %4, %storemerge
  br i1 %cmp12, label %land.rhs, label %for.inc.split

for.inc.split:                                    ; preds = %land.rhs.us, %land.rhs, %while.cond7.loopexit.split
  %6 = load i8* getelementptr inbounds ([2 x i8]* @choosing, i32 0, i32 1), align 1, !tbaa !0, !range !4
  %7 = and i8 %6, 1
  %tobool.1 = icmp eq i8 %7, 0
  br i1 %tobool.1, label %while.cond7.loopexit.split.1, label %while.cond.1

while.cond.1:                                     ; preds = %while.cond.1, %for.inc.split
  br label %while.cond.1

while.cond7.loopexit.split.1:                     ; preds = %for.inc.split
  %8 = load i32* getelementptr inbounds ([2 x i32]* @number, i32 0, i32 1), align 4, !tbaa !3
  %cmp9.1 = icmp eq i32 %8, 0
  br i1 %cmp9.1, label %for.inc.split.1, label %while.cond7.loopexit.split.while.cond7.loopexit.split.split_crit_edge.1

while.cond7.loopexit.split.while.cond7.loopexit.split.split_crit_edge.1: ; preds = %while.cond7.loopexit.split.1
  %cmp17.1 = icmp sgt i32 %i, 1
  br i1 %cmp17.1, label %land.rhs.us.1, label %land.rhs.1

land.rhs.1:                                       ; preds = %land.rhs.1, %while.cond7.loopexit.split.while.cond7.loopexit.split.split_crit_edge.1
  %cmp12.1 = icmp slt i32 %8, %storemerge
  br i1 %cmp12.1, label %land.rhs.1, label %for.inc.split.1

land.rhs.us.1:                                    ; preds = %land.rhs.us.1, %while.cond7.loopexit.split.while.cond7.loopexit.split.split_crit_edge.1
  %9 = icmp sgt i32 %8, %storemerge
  br i1 %9, label %for.inc.split.1, label %land.rhs.us.1

for.inc.split.1:                                  ; preds = %while.cond7.loopexit.split.1, %land.rhs.1, %land.rhs.us.1
  store i32 0, i32* %arrayidx1, align 4, !tbaa !3
  br label %L1
}

define i32 @main() nounwind readnone {
entry:
  ret i32 0
}

!0 = metadata !{metadata !"_Bool", metadata !1}
!1 = metadata !{metadata !"omnipotent char", metadata !2}
!2 = metadata !{metadata !"Simple C/C++ TBAA", null}
!3 = metadata !{metadata !"int", metadata !1}
!4 = metadata !{i8 0, i8 2}                       
