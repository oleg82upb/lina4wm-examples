; ModuleID = 'szymanski2.c'
target datalayout = "e-p:32:32:32-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:32:64-f32:32:32-f64:32:64-v64:64:64-v128:128:128-a0:0:64-f80:32:32-n8:16:32-S128"
target triple = "i386-pc-linux-gnu"

@flag0 = global i32* null, align 4
@flag1 = global i32* null, align 4

define void @proc0() nounwind {
entry:
  %0 = load i32** @flag0, align 4, !tbaa !0
  store volatile i32 1, i32* %0, align 4, !tbaa !3
  fence seq_cst
  %1 = load i32** @flag1, align 4, !tbaa !0
  br label %while.cond

while.cond:                                       ; preds = %while.cond, %entry
  %2 = load volatile i32* %1, align 4, !tbaa !3
  %cmp = icmp sgt i32 %2, 2
  br i1 %cmp, label %while.cond, label %while.end

while.end:                                        ; preds = %while.cond
  %3 = load i32** @flag0, align 4, !tbaa !0
  store volatile i32 3, i32* %3, align 4, !tbaa !3
  fence seq_cst
  %4 = load i32** @flag1, align 4, !tbaa !0
  %5 = load volatile i32* %4, align 4, !tbaa !3
  %cmp1 = icmp eq i32 %5, 1
  br i1 %cmp1, label %if.then, label %if.end

if.then:                                          ; preds = %while.end
  %6 = load i32** @flag0, align 4, !tbaa !0
  store volatile i32 2, i32* %6, align 4, !tbaa !3
  %7 = load i32** @flag1, align 4, !tbaa !0
  br label %while.cond2

while.cond2:                                      ; preds = %while.cond2, %if.then
  %8 = load volatile i32* %7, align 4, !tbaa !3
  %cmp3 = icmp eq i32 %8, 4
  br i1 %cmp3, label %if.end, label %while.cond2

if.end:                                           ; preds = %while.cond2, %while.end
  %9 = load i32** @flag0, align 4, !tbaa !0
  store volatile i32 4, i32* %9, align 4, !tbaa !3
  %10 = load i32** @flag1, align 4, !tbaa !0
  br label %while.cond6

while.cond6:                                      ; preds = %while.cond6, %lor.rhs, %if.end
  %11 = load volatile i32* %10, align 4, !tbaa !3
  %cmp7 = icmp eq i32 %11, 2
  br i1 %cmp7, label %while.cond6, label %lor.rhs

lor.rhs:                                          ; preds = %while.cond6
  %12 = load volatile i32* %10, align 4, !tbaa !3
  %cmp8 = icmp eq i32 %12, 3
  br i1 %cmp8, label %while.cond6, label %while.end10

while.end10:                                      ; preds = %lor.rhs
  %13 = load i32** @flag0, align 4, !tbaa !0
  store volatile i32 0, i32* %13, align 4, !tbaa !3
  ret void
}

define void @proc1() nounwind {
entry:
  %0 = load i32** @flag1, align 4, !tbaa !0
  store volatile i32 1, i32* %0, align 4, !tbaa !3
  fence seq_cst
  %1 = load i32** @flag0, align 4, !tbaa !0
  br label %while.cond

while.cond:                                       ; preds = %while.cond, %entry
  %2 = load volatile i32* %1, align 4, !tbaa !3
  %cmp = icmp sgt i32 %2, 2
  br i1 %cmp, label %while.cond, label %while.end

while.end:                                        ; preds = %while.cond
  %3 = load i32** @flag1, align 4, !tbaa !0
  store volatile i32 3, i32* %3, align 4, !tbaa !3
  fence seq_cst
  %4 = load i32** @flag0, align 4, !tbaa !0
  %5 = load volatile i32* %4, align 4, !tbaa !3
  %cmp1 = icmp eq i32 %5, 1
  br i1 %cmp1, label %if.then, label %if.end

if.then:                                          ; preds = %while.end
  %6 = load i32** @flag1, align 4, !tbaa !0
  store volatile i32 2, i32* %6, align 4, !tbaa !3
  %7 = load i32** @flag0, align 4, !tbaa !0
  br label %while.cond2

while.cond2:                                      ; preds = %while.cond2, %if.then
  %8 = load volatile i32* %7, align 4, !tbaa !3
  %cmp3 = icmp eq i32 %8, 4
  br i1 %cmp3, label %if.end, label %while.cond2

if.end:                                           ; preds = %while.cond2, %while.end
  %9 = load i32** @flag1, align 4, !tbaa !0
  store volatile i32 4, i32* %9, align 4, !tbaa !3
  %10 = load i32** @flag0, align 4, !tbaa !0
  br label %while.cond6

while.cond6:                                      ; preds = %while.cond6, %if.end
  %11 = load volatile i32* %10, align 4, !tbaa !3
  %cmp7 = icmp sgt i32 %11, 1
  br i1 %cmp7, label %while.cond6, label %while.end9

while.end9:                                       ; preds = %while.cond6
  %12 = load i32** @flag1, align 4, !tbaa !0
  store volatile i32 0, i32* %12, align 4, !tbaa !3
  ret void
}

define i32 @main() nounwind readnone {
entry:
  ret i32 0
}

!0 = metadata !{metadata !"any pointer", metadata !1}
!1 = metadata !{metadata !"omnipotent char", metadata !2}
!2 = metadata !{metadata !"Simple C/C++ TBAA", null}
!3 = metadata !{metadata !"int", metadata !1}
