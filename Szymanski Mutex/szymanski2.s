; ModuleID = 'szymanski2.c'
target datalayout = "e-p:32:32:32-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:32:64-f32:32:32-f64:32:64-v64:64:64-v128:128:128-a0:0:64-f80:32:32-n8:16:32-S128"
target triple = "i386-pc-linux-gnu"

@flag = global [2 x i8] zeroinitializer, align 1

define void @proci(i32 %i) noreturn nounwind {
entry:
  %arrayidx = getelementptr inbounds [2 x i8]* @flag, i32 0, i32 %i
  br label %L1

L1:                                               ; preds = %if.end, %entry
  store i8 1, i8* %arrayidx, align 1, !tbaa !0
  %0 = load i8* getelementptr inbounds ([2 x i8]* @flag, i32 0, i32 0), align 1, !tbaa !0, !range !3
  %1 = and i8 %0, 1
  %tobool7 = icmp eq i8 %1, 0
  br i1 %tobool7, label %lor.lhs.false, label %if.then

lor.lhs.false:                                    ; preds = %L1
  %2 = load i8* getelementptr inbounds ([2 x i8]* @flag, i32 0, i32 1), align 1, !tbaa !0, !range !3
  %3 = and i8 %2, 1
  %tobool11 = icmp eq i8 %3, 0
  br i1 %tobool11, label %if.end, label %if.then

if.then:                                          ; preds = %lor.lhs.false, %L1
  store i8 1, i8* %arrayidx, align 1, !tbaa !0
  br label %if.end

if.end:                                           ; preds = %if.then, %lor.lhs.false
  store i8 0, i8* %arrayidx, align 1, !tbaa !0
  br label %L1
}

define i32 @main() nounwind readnone {
entry:
  ret i32 0
}

!0 = metadata !{metadata !"_Bool", metadata !1}
!1 = metadata !{metadata !"omnipotent char", metadata !2}
!2 = metadata !{metadata !"Simple C/C++ TBAA", null}
!3 = metadata !{i8 0, i8 2}                       
