; ModuleID = 'pgsql.c'
target datalayout = "e-p:32:32:32-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:32:64-f32:32:32-f64:32:64-v64:64:64-v128:128:128-a0:0:64-f80:32:32-n8:16:32-S128"
target triple = "i386-pc-linux-gnu"

@latch1 = global i8 1, align 1
@flag1 = global i8 1, align 1
@latch2 = global i8 0, align 1
@flag2 = global i8 0, align 1

define noalias i8* @worker_1() nounwind {
entry:
  store volatile i8 0, i8* @latch1, align 1, !tbaa !0
  %0 = load volatile i8* @flag1, align 1, !tbaa !0, !range !3
  %1 = and i8 %0, 1
  %tobool = icmp eq i8 %1, 0
  br i1 %tobool, label %if.end, label %if.then

if.then:                                          ; preds = %entry
  store volatile i8 0, i8* @flag1, align 1, !tbaa !0
  store volatile i8 1, i8* @flag2, align 1, !tbaa !0
  fence seq_cst
  store volatile i8 1, i8* @latch2, align 1, !tbaa !0
  br label %if.end

if.end:                                           ; preds = %entry, %if.then
  store volatile i8 0, i8* @latch1, align 1, !tbaa !0
  %2 = load volatile i8* @flag1, align 1, !tbaa !0, !range !3
  %3 = and i8 %2, 1
  %tobool1 = icmp eq i8 %3, 0
  br i1 %tobool1, label %if.end3, label %if.then2

if.then2:                                         ; preds = %if.end
  store volatile i8 0, i8* @flag1, align 1, !tbaa !0
  store volatile i8 1, i8* @flag2, align 1, !tbaa !0
  fence seq_cst
  store volatile i8 1, i8* @latch2, align 1, !tbaa !0
  br label %if.end3

if.end3:                                          ; preds = %if.end, %if.then2
  store volatile i8 0, i8* @latch1, align 1, !tbaa !0
  %4 = load volatile i8* @flag1, align 1, !tbaa !0, !range !3
  %5 = and i8 %4, 1
  %tobool4 = icmp eq i8 %5, 0
  br i1 %tobool4, label %if.end6, label %if.then5

if.then5:                                         ; preds = %if.end3
  store volatile i8 0, i8* @flag1, align 1, !tbaa !0
  store volatile i8 1, i8* @flag2, align 1, !tbaa !0
  fence seq_cst
  store volatile i8 1, i8* @latch2, align 1, !tbaa !0
  br label %if.end6

if.end6:                                          ; preds = %if.end3, %if.then5
  store volatile i8 0, i8* @latch1, align 1, !tbaa !0
  %6 = load volatile i8* @flag1, align 1, !tbaa !0, !range !3
  %7 = and i8 %6, 1
  %tobool7 = icmp eq i8 %7, 0
  br i1 %tobool7, label %if.end9, label %if.then8

if.then8:                                         ; preds = %if.end6
  store volatile i8 0, i8* @flag1, align 1, !tbaa !0
  store volatile i8 1, i8* @flag2, align 1, !tbaa !0
  fence seq_cst
  store volatile i8 1, i8* @latch2, align 1, !tbaa !0
  br label %if.end9

if.end9:                                          ; preds = %if.end6, %if.then8
  store volatile i8 0, i8* @latch1, align 1, !tbaa !0
  %8 = load volatile i8* @flag1, align 1, !tbaa !0, !range !3
  %9 = and i8 %8, 1
  %tobool10 = icmp eq i8 %9, 0
  br i1 %tobool10, label %if.end12, label %if.then11

if.then11:                                        ; preds = %if.end9
  store volatile i8 0, i8* @flag1, align 1, !tbaa !0
  store volatile i8 1, i8* @flag2, align 1, !tbaa !0
  fence seq_cst
  store volatile i8 1, i8* @latch2, align 1, !tbaa !0
  br label %if.end12

if.end12:                                         ; preds = %if.end9, %if.then11
  store volatile i8 0, i8* @latch1, align 1, !tbaa !0
  %10 = load volatile i8* @flag1, align 1, !tbaa !0, !range !3
  %11 = and i8 %10, 1
  %tobool13 = icmp eq i8 %11, 0
  br i1 %tobool13, label %if.end15, label %if.then14

if.then14:                                        ; preds = %if.end12
  store volatile i8 0, i8* @flag1, align 1, !tbaa !0
  store volatile i8 1, i8* @flag2, align 1, !tbaa !0
  fence seq_cst
  store volatile i8 1, i8* @latch2, align 1, !tbaa !0
  br label %if.end15

if.end15:                                         ; preds = %if.end12, %if.then14
  store volatile i8 0, i8* @latch1, align 1, !tbaa !0
  %12 = load volatile i8* @flag1, align 1, !tbaa !0, !range !3
  %13 = and i8 %12, 1
  %tobool16 = icmp eq i8 %13, 0
  br i1 %tobool16, label %if.end18, label %if.then17

if.then17:                                        ; preds = %if.end15
  store volatile i8 0, i8* @flag1, align 1, !tbaa !0
  store volatile i8 1, i8* @flag2, align 1, !tbaa !0
  fence seq_cst
  store volatile i8 1, i8* @latch2, align 1, !tbaa !0
  br label %if.end18

if.end18:                                         ; preds = %if.end15, %if.then17
  store volatile i8 0, i8* @latch1, align 1, !tbaa !0
  %14 = load volatile i8* @flag1, align 1, !tbaa !0, !range !3
  %15 = and i8 %14, 1
  %tobool19 = icmp eq i8 %15, 0
  br i1 %tobool19, label %if.end21, label %if.then20

if.then20:                                        ; preds = %if.end18
  store volatile i8 0, i8* @flag1, align 1, !tbaa !0
  store volatile i8 1, i8* @flag2, align 1, !tbaa !0
  fence seq_cst
  store volatile i8 1, i8* @latch2, align 1, !tbaa !0
  br label %if.end21

if.end21:                                         ; preds = %if.end18, %if.then20
  ret i8* null
}

define noalias i8* @worker_2() nounwind {
entry:
  store volatile i8 0, i8* @latch2, align 1, !tbaa !0
  %0 = load volatile i8* @flag2, align 1, !tbaa !0, !range !3
  %1 = and i8 %0, 1
  %tobool = icmp eq i8 %1, 0
  br i1 %tobool, label %if.end, label %if.then

if.then:                                          ; preds = %entry
  store volatile i8 0, i8* @flag2, align 1, !tbaa !0
  store volatile i8 1, i8* @flag1, align 1, !tbaa !0
  fence seq_cst
  store volatile i8 1, i8* @latch1, align 1, !tbaa !0
  br label %if.end

if.end:                                           ; preds = %entry, %if.then
  store volatile i8 0, i8* @latch2, align 1, !tbaa !0
  %2 = load volatile i8* @flag2, align 1, !tbaa !0, !range !3
  %3 = and i8 %2, 1
  %tobool1 = icmp eq i8 %3, 0
  br i1 %tobool1, label %if.end3, label %if.then2

if.then2:                                         ; preds = %if.end
  store volatile i8 0, i8* @flag2, align 1, !tbaa !0
  store volatile i8 1, i8* @flag1, align 1, !tbaa !0
  fence seq_cst
  store volatile i8 1, i8* @latch1, align 1, !tbaa !0
  br label %if.end3

if.end3:                                          ; preds = %if.end, %if.then2
  store volatile i8 0, i8* @latch2, align 1, !tbaa !0
  %4 = load volatile i8* @flag2, align 1, !tbaa !0, !range !3
  %5 = and i8 %4, 1
  %tobool4 = icmp eq i8 %5, 0
  br i1 %tobool4, label %if.end6, label %if.then5

if.then5:                                         ; preds = %if.end3
  store volatile i8 0, i8* @flag2, align 1, !tbaa !0
  store volatile i8 1, i8* @flag1, align 1, !tbaa !0
  fence seq_cst
  store volatile i8 1, i8* @latch1, align 1, !tbaa !0
  br label %if.end6

if.end6:                                          ; preds = %if.end3, %if.then5
  store volatile i8 0, i8* @latch2, align 1, !tbaa !0
  %6 = load volatile i8* @flag2, align 1, !tbaa !0, !range !3
  %7 = and i8 %6, 1
  %tobool7 = icmp eq i8 %7, 0
  br i1 %tobool7, label %if.end9, label %if.then8

if.then8:                                         ; preds = %if.end6
  store volatile i8 0, i8* @flag2, align 1, !tbaa !0
  store volatile i8 1, i8* @flag1, align 1, !tbaa !0
  fence seq_cst
  store volatile i8 1, i8* @latch1, align 1, !tbaa !0
  br label %if.end9

if.end9:                                          ; preds = %if.end6, %if.then8
  store volatile i8 0, i8* @latch2, align 1, !tbaa !0
  %8 = load volatile i8* @flag2, align 1, !tbaa !0, !range !3
  %9 = and i8 %8, 1
  %tobool10 = icmp eq i8 %9, 0
  br i1 %tobool10, label %if.end12, label %if.then11

if.then11:                                        ; preds = %if.end9
  store volatile i8 0, i8* @flag2, align 1, !tbaa !0
  store volatile i8 1, i8* @flag1, align 1, !tbaa !0
  fence seq_cst
  store volatile i8 1, i8* @latch1, align 1, !tbaa !0
  br label %if.end12

if.end12:                                         ; preds = %if.end9, %if.then11
  store volatile i8 0, i8* @latch2, align 1, !tbaa !0
  %10 = load volatile i8* @flag2, align 1, !tbaa !0, !range !3
  %11 = and i8 %10, 1
  %tobool13 = icmp eq i8 %11, 0
  br i1 %tobool13, label %if.end15, label %if.then14

if.then14:                                        ; preds = %if.end12
  store volatile i8 0, i8* @flag2, align 1, !tbaa !0
  store volatile i8 1, i8* @flag1, align 1, !tbaa !0
  fence seq_cst
  store volatile i8 1, i8* @latch1, align 1, !tbaa !0
  br label %if.end15

if.end15:                                         ; preds = %if.end12, %if.then14
  store volatile i8 0, i8* @latch2, align 1, !tbaa !0
  %12 = load volatile i8* @flag2, align 1, !tbaa !0, !range !3
  %13 = and i8 %12, 1
  %tobool16 = icmp eq i8 %13, 0
  br i1 %tobool16, label %if.end18, label %if.then17

if.then17:                                        ; preds = %if.end15
  store volatile i8 0, i8* @flag2, align 1, !tbaa !0
  store volatile i8 1, i8* @flag1, align 1, !tbaa !0
  fence seq_cst
  store volatile i8 1, i8* @latch1, align 1, !tbaa !0
  br label %if.end18

if.end18:                                         ; preds = %if.end15, %if.then17
  store volatile i8 0, i8* @latch2, align 1, !tbaa !0
  %14 = load volatile i8* @flag2, align 1, !tbaa !0, !range !3
  %15 = and i8 %14, 1
  %tobool19 = icmp eq i8 %15, 0
  br i1 %tobool19, label %if.end21, label %if.then20

if.then20:                                        ; preds = %if.end18
  store volatile i8 0, i8* @flag2, align 1, !tbaa !0
  store volatile i8 1, i8* @flag1, align 1, !tbaa !0
  fence seq_cst
  store volatile i8 1, i8* @latch1, align 1, !tbaa !0
  br label %if.end21

if.end21:                                         ; preds = %if.end18, %if.then20
  ret i8* null
}

define i32 @main() nounwind readnone {
entry:
  ret i32 0
}

!0 = metadata !{metadata !"_Bool", metadata !1}
!1 = metadata !{metadata !"omnipotent char", metadata !2}
!2 = metadata !{metadata !"Simple C/C++ TBAA", null}
!3 = metadata !{i8 0, i8 2}                       
