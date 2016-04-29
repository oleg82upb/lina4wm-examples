; ModuleID = 'lamport2.c'
target datalayout = "e-p:32:32:32-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:32:64-f32:32:32-f64:32:64-v64:64:64-v128:128:128-a0:0:64-f80:32:32-n8:16:32-S128"
target triple = "i386-pc-linux-gnu"

@choosing = global [2 x i8*] zeroinitializer, align 4
@number = global [2 x i32*] zeroinitializer, align 4

define void @proci(i32 %i) nounwind {
entry:
  %arrayidx = getelementptr inbounds [2 x i8*]* @choosing, i32 0, i32 %i
  %0 = load i8** %arrayidx, align 4, !tbaa !0
  store volatile i8 1, i8* %0, align 1, !tbaa !3
  fence seq_cst
  %1 = load i32** getelementptr inbounds ([2 x i32*]* @number, i32 0, i32 0), align 4, !tbaa !0
  %2 = load volatile i32* %1, align 4, !tbaa !4
  %3 = load i32** getelementptr inbounds ([2 x i32*]* @number, i32 0, i32 1), align 4, !tbaa !0
  %4 = load volatile i32* %3, align 4, !tbaa !4
  %cmp = icmp slt i32 %2, %4
  br i1 %cmp, label %if.then, label %if.else

if.then:                                          ; preds = %entry
  %5 = load volatile i32* %3, align 4, !tbaa !4
  %add = add nsw i32 %5, 1
  %arrayidx1 = getelementptr inbounds [2 x i32*]* @number, i32 0, i32 %i
  %6 = load i32** %arrayidx1, align 4, !tbaa !0
  store volatile i32 %add, i32* %6, align 4, !tbaa !4
  br label %if.end

if.else:                                          ; preds = %entry
  %7 = load volatile i32* %1, align 4, !tbaa !4
  %add2 = add nsw i32 %7, 1
  %arrayidx3 = getelementptr inbounds [2 x i32*]* @number, i32 0, i32 %i
  %8 = load i32** %arrayidx3, align 4, !tbaa !0
  store volatile i32 %add2, i32* %8, align 4, !tbaa !4
  br label %if.end

if.end:                                           ; preds = %if.else, %if.then
  fence seq_cst
  %9 = load i8** %arrayidx, align 4, !tbaa !0
  store volatile i8 0, i8* %9, align 1, !tbaa !3
  %arrayidx11 = getelementptr inbounds [2 x i32*]* @number, i32 0, i32 %i
  %10 = load i8** getelementptr inbounds ([2 x i8*]* @choosing, i32 0, i32 0), align 4, !tbaa !0
  br label %while.cond

while.cond:                                       ; preds = %if.end, %while.cond
  %11 = load volatile i8* %10, align 1, !tbaa !3, !range !5
  %12 = and i8 %11, 1
  %tobool = icmp eq i8 %12, 0
  br i1 %tobool, label %while.cond7.loopexit, label %while.cond

while.cond7.loopexit:                             ; preds = %while.cond
  %13 = load i32** getelementptr inbounds ([2 x i32*]* @number, i32 0, i32 0), align 4, !tbaa !0
  %cmp17 = icmp sgt i32 %i, 0
  br i1 %cmp17, label %while.cond7.us, label %while.cond7

while.cond7.us:                                   ; preds = %land.rhs.us, %lor.rhs.us, %while.cond7.loopexit
  %14 = load volatile i32* %13, align 4, !tbaa !4
  %cmp9.us = icmp eq i32 %14, 0
  br i1 %cmp9.us, label %for.inc, label %land.rhs.us

land.rhs.us:                                      ; preds = %while.cond7.us
  %15 = load volatile i32* %13, align 4, !tbaa !4
  %16 = load i32** %arrayidx11, align 4, !tbaa !0
  %17 = load volatile i32* %16, align 4, !tbaa !4
  %cmp12.us = icmp slt i32 %15, %17
  br i1 %cmp12.us, label %while.cond7.us, label %lor.rhs.us

lor.rhs.us:                                       ; preds = %land.rhs.us
  %18 = load volatile i32* %13, align 4, !tbaa !4
  %19 = load volatile i32* %16, align 4, !tbaa !4
  %cmp15.us = icmp eq i32 %18, %19
  br i1 %cmp15.us, label %while.cond7.us, label %for.inc

while.cond7:                                      ; preds = %land.rhs, %while.cond7.loopexit
  %20 = load volatile i32* %13, align 4, !tbaa !4
  %cmp9 = icmp eq i32 %20, 0
  br i1 %cmp9, label %for.inc, label %land.rhs

land.rhs:                                         ; preds = %while.cond7
  %21 = load volatile i32* %13, align 4, !tbaa !4
  %22 = load i32** %arrayidx11, align 4, !tbaa !0
  %23 = load volatile i32* %22, align 4, !tbaa !4
  %cmp12 = icmp slt i32 %21, %23
  br i1 %cmp12, label %while.cond7, label %lor.rhs

lor.rhs:                                          ; preds = %land.rhs
  %24 = load volatile i32* %13, align 4, !tbaa !4
  %25 = load volatile i32* %22, align 4, !tbaa !4
  br label %for.inc

for.inc:                                          ; preds = %while.cond7, %lor.rhs, %while.cond7.us, %lor.rhs.us
  %26 = load i8** getelementptr inbounds ([2 x i8*]* @choosing, i32 0, i32 1), align 4, !tbaa !0
  br label %while.cond.1

while.cond.1:                                     ; preds = %while.cond.1, %for.inc
  %27 = load volatile i8* %26, align 1, !tbaa !3, !range !5
  %28 = and i8 %27, 1
  %tobool.1 = icmp eq i8 %28, 0
  br i1 %tobool.1, label %while.cond7.loopexit.1, label %while.cond.1

while.cond7.loopexit.1:                           ; preds = %while.cond.1
  %29 = load i32** getelementptr inbounds ([2 x i32*]* @number, i32 0, i32 1), align 4, !tbaa !0
  %cmp17.1 = icmp sgt i32 %i, 1
  br i1 %cmp17.1, label %while.cond7.us.1, label %while.cond7.1

while.cond7.1:                                    ; preds = %land.rhs.1, %while.cond7.loopexit.1
  %30 = load volatile i32* %29, align 4, !tbaa !4
  %cmp9.1 = icmp eq i32 %30, 0
  br i1 %cmp9.1, label %for.inc.1, label %land.rhs.1

land.rhs.1:                                       ; preds = %while.cond7.1
  %31 = load volatile i32* %29, align 4, !tbaa !4
  %32 = load i32** %arrayidx11, align 4, !tbaa !0
  %33 = load volatile i32* %32, align 4, !tbaa !4
  %cmp12.1 = icmp slt i32 %31, %33
  br i1 %cmp12.1, label %while.cond7.1, label %lor.rhs.1

lor.rhs.1:                                        ; preds = %land.rhs.1
  %34 = load volatile i32* %29, align 4, !tbaa !4
  %35 = load volatile i32* %32, align 4, !tbaa !4
  br label %for.inc.1

while.cond7.us.1:                                 ; preds = %land.rhs.us.1, %lor.rhs.us.1, %while.cond7.loopexit.1
  %36 = load volatile i32* %29, align 4, !tbaa !4
  %cmp9.us.1 = icmp eq i32 %36, 0
  br i1 %cmp9.us.1, label %for.inc.1, label %land.rhs.us.1

land.rhs.us.1:                                    ; preds = %while.cond7.us.1
  %37 = load volatile i32* %29, align 4, !tbaa !4
  %38 = load i32** %arrayidx11, align 4, !tbaa !0
  %39 = load volatile i32* %38, align 4, !tbaa !4
  %cmp12.us.1 = icmp slt i32 %37, %39
  br i1 %cmp12.us.1, label %while.cond7.us.1, label %lor.rhs.us.1

lor.rhs.us.1:                                     ; preds = %land.rhs.us.1
  %40 = load volatile i32* %29, align 4, !tbaa !4
  %41 = load volatile i32* %38, align 4, !tbaa !4
  %cmp15.us.1 = icmp eq i32 %40, %41
  br i1 %cmp15.us.1, label %while.cond7.us.1, label %for.inc.1

for.inc.1:                                        ; preds = %while.cond7.us.1, %lor.rhs.us.1, %while.cond7.1, %lor.rhs.1
  %42 = load i32** %arrayidx11, align 4, !tbaa !0
  store volatile i32 0, i32* %42, align 4, !tbaa !4
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
