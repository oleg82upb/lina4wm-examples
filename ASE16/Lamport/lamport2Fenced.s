; ModuleID = 'lamport2.c'
target datalayout = "e-p:32:32:32-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:32:64-f32:32:32-f64:32:64-v64:64:64-v128:128:128-a0:0:64-f80:32:32-n8:16:32-S128"
target triple = "i386-pc-linux-gnu"

@choosing = global [2 x i8*] zeroinitializer, align 4
@number = global [2 x i32*] zeroinitializer, align 4

define void @proci(i32 %i) nounwind {
entry:
  %arrayidx = getelementptr inbounds [2 x i8*]* @choosing, i32 0, i32 %i
  %0 = load i8** %arrayidx, align 4, !tbaa !0
  store i8 1, i8* %0, align 1, !tbaa !3
  fence seq_cst
  %1 = load i32** getelementptr inbounds ([2 x i32*]* @number, i32 0, i32 0), align 4, !tbaa !0
  %2 = load i32* %1, align 4, !tbaa !4
  %3 = load i32** getelementptr inbounds ([2 x i32*]* @number, i32 0, i32 1), align 4, !tbaa !0
  %4 = load i32* %3, align 4, !tbaa !4
  %cmp = icmp slt i32 %2, %4
  br i1 %cmp, label %if.then, label %if.else

if.then:                                          ; preds = %entry
  %add = add nsw i32 %4, 1
  %arrayidx1 = getelementptr inbounds [2 x i32*]* @number, i32 0, i32 %i
  %5 = load i32** %arrayidx1, align 4, !tbaa !0
  store i32 %add, i32* %5, align 4, !tbaa !4
  br label %if.end

if.else:                                          ; preds = %entry
  %add2 = add nsw i32 %2, 1
  %arrayidx3 = getelementptr inbounds [2 x i32*]* @number, i32 0, i32 %i
  %6 = load i32** %arrayidx3, align 4, !tbaa !0
  store i32 %add2, i32* %6, align 4, !tbaa !4
  br label %if.end

if.end:                                           ; preds = %if.else, %if.then
  %7 = load i8** %arrayidx, align 4, !tbaa !0
  store i8 0, i8* %7, align 1, !tbaa !3
  %arrayidx11 = getelementptr inbounds [2 x i32*]* @number, i32 0, i32 %i
  fence seq_cst
  br label %while.cond.preheader

while.cond.preheader:                             ; preds = %for.inc.split, %if.end
  %j.023 = phi i32 [ 0, %if.end ], [ %inc, %for.inc.split ]
  %arrayidx6 = getelementptr inbounds [2 x i8*]* @choosing, i32 0, i32 %j.023
  %8 = load i8** %arrayidx6, align 4, !tbaa !0
  %9 = load i8* %8, align 1, !tbaa !3, !range !5
  %10 = and i8 %9, 1
  %tobool = icmp eq i8 %10, 0
  br i1 %tobool, label %while.cond7.loopexit.split, label %while.cond

while.cond:                                       ; preds = %while.cond, %while.cond.preheader
  br label %while.cond

while.cond7.loopexit.split:                       ; preds = %while.cond.preheader
  %arrayidx8 = getelementptr inbounds [2 x i32*]* @number, i32 0, i32 %j.023
  %11 = load i32** %arrayidx8, align 4, !tbaa !0
  %12 = load i32* %11, align 4, !tbaa !4
  %cmp9 = icmp eq i32 %12, 0
  %cmp17 = icmp slt i32 %j.023, %i
  br i1 %cmp9, label %for.inc.split, label %land.rhs

land.rhs:                                         ; preds = %land.rhs, %while.cond7.loopexit.split
  %13 = load i32** %arrayidx11, align 4, !tbaa !0
  %14 = load i32* %13, align 4, !tbaa !4
  %cmp12 = icmp slt i32 %12, %14
  %cmp15 = icmp eq i32 %12, %14
  %or.cond = and i1 %cmp15, %cmp17
  %or.cond24 = or i1 %cmp12, %or.cond
  br i1 %or.cond24, label %land.rhs, label %for.inc.split

for.inc.split:                                    ; preds = %land.rhs, %while.cond7.loopexit.split
  %inc = add nsw i32 %j.023, 1
  %exitcond = icmp eq i32 %inc, 2
  br i1 %exitcond, label %for.end, label %while.cond.preheader

for.end:                                          ; preds = %for.inc.split
  %arrayidx21 = getelementptr inbounds [2 x i32*]* @number, i32 0, i32 %i
  %15 = load i32** %arrayidx21, align 4, !tbaa !0
  store i32 0, i32* %15, align 4, !tbaa !4
  ret void
}

define i32 @main() nounwind readnone {
entry:
  ret i32 0
}

!0 = metadata !{metadata !"any pointer", metadata !1}
!1 = metadata !{metadata !"omnipotent char", metadata !2}
!2 = metadata !{metadata !"Simple C/C++ TBAA", null}
!3 = metadata !{metadata !"_Bool", metadata !1}
!4 = metadata !{metadata !"int", metadata !1}
!5 = metadata !{i8 0, i8 2}                       
