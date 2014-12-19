; ModuleID = 'peterson.c'
target datalayout = "e-p:32:32:32-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:32:64-f32:32:32-f64:32:64-v64:64:64-v128:128:128-a0:0:64-f80:32:32-n8:16:32-S128"
target triple = "i386-pc-linux-gnu"

@flag = global [2 x i8] zeroinitializer, align 1
@turn = global i32 0, align 4

define void @p0() nounwind {
entry:
  store i8 1, i8* getelementptr inbounds ([2 x i8]* @flag, i32 0, i32 0), align 1, !tbaa !0
  store i32 1, i32* @turn, align 4, !tbaa !3
  %0 = load i8* getelementptr inbounds ([2 x i8]* @flag, i32 0, i32 1), align 1, !tbaa !0, !range !4
  %1 = and i8 %0, 1
  %tobool = icmp eq i8 %1, 0
  br i1 %tobool, label %while.end.split, label %while.cond

while.cond:                                       ; preds = %while.cond, %entry
  br label %while.cond

while.end.split:                                  ; preds = %entry
  store i8 0, i8* getelementptr inbounds ([2 x i8]* @flag, i32 0, i32 0), align 1, !tbaa !0
  ret void
}

define void @p1() nounwind {
entry:
  store i8 1, i8* getelementptr inbounds ([2 x i8]* @flag, i32 0, i32 1), align 1, !tbaa !0
  store i32 0, i32* @turn, align 4, !tbaa !3
  %0 = load i8* getelementptr inbounds ([2 x i8]* @flag, i32 0, i32 0), align 1, !tbaa !0, !range !4
  %1 = and i8 %0, 1
  %tobool = icmp eq i8 %1, 0
  br i1 %tobool, label %while.end.split, label %while.cond

while.cond:                                       ; preds = %while.cond, %entry
  br label %while.cond

while.end.split:                                  ; preds = %entry
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
!3 = metadata !{metadata !"int", metadata !1}
!4 = metadata !{i8 0, i8 2}                       
