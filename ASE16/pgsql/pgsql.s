; ModuleID = 'pgsql.c'
target datalayout = "e-p:32:32:32-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:32:64-f32:32:32-f64:32:64-v64:64:64-v128:128:128-a0:0:64-f80:32:32-n8:16:32-S128"
target triple = "i386-pc-linux-gnu"

@latch1 = global i8 1, align 1
@flag1 = global i8 1, align 1
@latch2 = global i8 0, align 1
@flag2 = global i8 0, align 1

define noalias i8* @worker_1() noreturn nounwind {
entry:
  br label %for.cond

for.cond:                                         ; preds = %for.cond, %if.then, %entry
  %0 = load volatile i8* @flag1, align 1, !tbaa !0, !range !3
  %1 = and i8 %0, 1
  %tobool = icmp eq i8 %1, 0
  br i1 %tobool, label %for.cond, label %if.then

if.then:                                          ; preds = %for.cond
  store volatile i8 0, i8* @latch1, align 1, !tbaa !0
  store volatile i8 0, i8* @flag1, align 1, !tbaa !0
  store volatile i8 1, i8* @flag2, align 1, !tbaa !0
  fence seq_cst
  store volatile i8 1, i8* @latch2, align 1, !tbaa !0
  br label %for.cond
}

define noalias i8* @worker_2() noreturn nounwind {
entry:
  br label %for.cond

for.cond:                                         ; preds = %for.cond, %if.then, %entry
  %0 = load volatile i8* @flag2, align 1, !tbaa !0, !range !3
  %1 = and i8 %0, 1
  %tobool = icmp eq i8 %1, 0
  br i1 %tobool, label %for.cond, label %if.then

if.then:                                          ; preds = %for.cond
  store volatile i8 0, i8* @latch2, align 1, !tbaa !0
  store volatile i8 0, i8* @flag2, align 1, !tbaa !0
  store volatile i8 1, i8* @flag1, align 1, !tbaa !0
  fence seq_cst
  store volatile i8 1, i8* @latch1, align 1, !tbaa !0
  br label %for.cond
}

define i32 @main() nounwind readnone {
entry:
  ret i32 0
}

!0 = metadata !{metadata !"_Bool", metadata !1}
!1 = metadata !{metadata !"omnipotent char", metadata !2}
!2 = metadata !{metadata !"Simple C/C++ TBAA", null}
!3 = metadata !{i8 0, i8 2}                       
