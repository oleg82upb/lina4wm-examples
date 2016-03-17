; ModuleID = 'lamport2flat.c'
target datalayout = "e-p:32:32:32-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:32:64-f32:32:32-f64:32:64-v64:64:64-v128:128:128-a0:0:64-f80:32:32-n8:16:32-S128"
target triple = "i386-pc-linux-gnu"

@choosing = global [2 x i8] zeroinitializer, align 1
@number = global [2 x i32] zeroinitializer, align 4

define void @proci(i32 %i) nounwind {
entry:
  %arrayidx = getelementptr inbounds [2 x i8]* @choosing, i32 0, i32 %i
  store volatile i8 1, i8* %arrayidx, align 1, !tbaa !0
  fence seq_cst
  %0 = load volatile i32* getelementptr inbounds ([2 x i32]* @number, i32 0, i32 0), align 4, !tbaa !3
  %1 = load volatile i32* getelementptr inbounds ([2 x i32]* @number, i32 0, i32 1), align 4, !tbaa !3
  %cmp = icmp slt i32 %0, %1
  br i1 %cmp, label %if.then, label %if.else

if.then:                                          ; preds = %entry
  %2 = load volatile i32* getelementptr inbounds ([2 x i32]* @number, i32 0, i32 1), align 4, !tbaa !3
  %add = add nsw i32 %2, 1
  %arrayidx1 = getelementptr inbounds [2 x i32]* @number, i32 0, i32 %i
  store volatile i32 %add, i32* %arrayidx1, align 4, !tbaa !3
  br label %if.end

if.else:                                          ; preds = %entry
  %3 = load volatile i32* getelementptr inbounds ([2 x i32]* @number, i32 0, i32 0), align 4, !tbaa !3
  %add2 = add nsw i32 %3, 1
  %arrayidx3 = getelementptr inbounds [2 x i32]* @number, i32 0, i32 %i
  store volatile i32 %add2, i32* %arrayidx3, align 4, !tbaa !3
  br label %if.end

if.end:                                           ; preds = %if.else, %if.then
  store volatile i8 0, i8* %arrayidx, align 1, !tbaa !0
  %arrayidx11 = getelementptr inbounds [2 x i32]* @number, i32 0, i32 %i
  fence seq_cst
  br label %while.cond.preheader

while.cond.preheader:                             ; preds = %for.inc, %if.end
  %j.023 = phi i32 [ 0, %if.end ], [ %inc, %for.inc ]
  %arrayidx6 = getelementptr inbounds [2 x i8]* @choosing, i32 0, i32 %j.023
  br label %while.cond

while.cond:                                       ; preds = %while.cond.preheader, %while.cond
  %4 = load volatile i8* %arrayidx6, align 1, !tbaa !0, !range !4
  %5 = and i8 %4, 1
  %tobool = icmp eq i8 %5, 0
  br i1 %tobool, label %while.cond7.loopexit, label %while.cond

while.cond7.loopexit:                             ; preds = %while.cond
  %arrayidx8 = getelementptr inbounds [2 x i32]* @number, i32 0, i32 %j.023
  %cmp17 = icmp slt i32 %j.023, %i
  br label %while.cond7

while.cond7:                                      ; preds = %lor.rhs, %land.rhs, %while.cond7.loopexit
  %6 = load volatile i32* %arrayidx8, align 4, !tbaa !3
  %cmp9 = icmp eq i32 %6, 0
  br i1 %cmp9, label %for.inc, label %land.rhs

land.rhs:                                         ; preds = %while.cond7
  %7 = load volatile i32* %arrayidx8, align 4, !tbaa !3
  %8 = load volatile i32* %arrayidx11, align 4, !tbaa !3
  %cmp12 = icmp slt i32 %7, %8
  br i1 %cmp12, label %while.cond7, label %lor.rhs

lor.rhs:                                          ; preds = %land.rhs
  %9 = load volatile i32* %arrayidx8, align 4, !tbaa !3
  %10 = load volatile i32* %arrayidx11, align 4, !tbaa !3
  %cmp15 = icmp eq i32 %9, %10
  %or.cond = and i1 %cmp15, %cmp17
  br i1 %or.cond, label %while.cond7, label %for.inc

for.inc:                                          ; preds = %while.cond7, %lor.rhs
  %inc = add nsw i32 %j.023, 1
  %exitcond = icmp eq i32 %inc, 2
  br i1 %exitcond, label %for.end, label %while.cond.preheader

for.end:                                          ; preds = %for.inc
  %arrayidx21 = getelementptr inbounds [2 x i32]* @number, i32 0, i32 %i
  store volatile i32 0, i32* %arrayidx21, align 4, !tbaa !3
  ret void
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
