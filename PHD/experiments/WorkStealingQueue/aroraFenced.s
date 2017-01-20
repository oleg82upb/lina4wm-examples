;produced by cmd: clang -Os -S -emit-llvm arora-deque.c -o arora-deque-Os.s
; ModuleID = 'arora-deque.c'
target datalayout = "e-p:32:32:32-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:32:64-f32:32:32-f64:32:64-v64:64:64-v128:128:128-a0:0:64-f80:32:32-n8:16:32-S128"
target triple = "i386-pc-linux-gnu"

@bot = common global i32* null, align 4
@deq = common global i32* null, align 4
@age = common global i32* null, align 4
@top = common global i32* null, align 4

define void @push(i32 %elem) nounwind optsize {
entry:
  %0 = load i32** @bot, align 4, !tbaa !0
  %1 = load i32* %0, align 4, !tbaa !3
  %2 = load i32** @deq, align 4, !tbaa !0
  %arrayidx = getelementptr inbounds i32* %2, i32 %1
  store i32 %elem, i32* %arrayidx, align 4, !tbaa !3
  %inc = add i32 %1, 1
  fence seq_cst
  store i32 %inc, i32* %0, align 4, !tbaa !3
  ret void
}

define i32 @dequeue() nounwind optsize {
entry:
  %0 = load i32** @age, align 4, !tbaa !0
  %1 = load i32* %0, align 4, !tbaa !3
  %2 = load i32** @bot, align 4, !tbaa !0
  %3 = load i32* %2, align 4, !tbaa !3
  %shr = ashr i32 %1, 16
  %cmp = icmp ugt i32 %3, %shr
  br i1 %cmp, label %if.end, label %return

if.end:                                           ; preds = %entry
  %4 = load i32** @deq, align 4, !tbaa !0
  %arrayidx = getelementptr inbounds i32* %4, i32 %shr
  %5 = load i32* %arrayidx, align 4, !tbaa !3
  %add5 = add i32 %1, 65536
  %6 = cmpxchg i32* %0, i32 %1, i32 %add5 seq_cst
  %7 = icmp eq i32 %6, %1
  %. = select i1 %7, i32 %5, i32 -2
  br label %return

return:                                           ; preds = %if.end, %entry
  %retval.0 = phi i32 [ -1, %entry ], [ %., %if.end ]
  ret i32 %retval.0
}

define i32 @pop() nounwind optsize {
entry:
  %0 = load i32** @bot, align 4, !tbaa !0
  %1 = load i32* %0, align 4, !tbaa !3
  %cmp = icmp eq i32 %1, 0
  br i1 %cmp, label %return, label %if.end

if.end:                                           ; preds = %entry
  %dec = add i32 %1, -1
  store i32 %dec, i32* %0, align 4, !tbaa !3
  %2 = load i32** @deq, align 4, !tbaa !0
  %arrayidx = getelementptr inbounds i32* %2, i32 %dec
  %3 = load i32* %arrayidx, align 4, !tbaa !3
  %4 = load i32** @age, align 4, !tbaa !0
  fence seq_cst
  %5 = load i32* %4, align 4, !tbaa !3
  %shr = ashr i32 %5, 16
  %cmp1 = icmp ugt i32 %dec, %shr
  br i1 %cmp1, label %return, label %if.end3

if.end3:                                          ; preds = %if.end
  store i32 0, i32* %0, align 4, !tbaa !3
  %and = and i32 %5, 65535
  %add = add nsw i32 %and, 1
  %cmp5 = icmp eq i32 %dec, %shr
  br i1 %cmp5, label %if.then6, label %if.end9

if.then6:                                         ; preds = %if.end3
  %6 = cmpxchg i32* %4, i32 %5, i32 %add seq_cst
  %7 = icmp eq i32 %6, %5
  br i1 %7, label %return, label %if.then6.if.end9_crit_edge

if.then6.if.end9_crit_edge:                       ; preds = %if.then6
  %.pre = load i32** @age, align 4, !tbaa !0
  br label %if.end9

if.end9:                                          ; preds = %if.then6.if.end9_crit_edge, %if.end3
  ; need to maintain write order between if.end3 and this block
  ; resetting bot to 0 must happen before top is reset to 1
  ; otherwise, stealers may  steal already removed elements
  %8 = phi i32* [ %.pre, %if.then6.if.end9_crit_edge ], [ %4, %if.end3 ]
  store i32 %add, i32* %8, align 4, !tbaa !3
  br label %return

return:                                           ; preds = %if.then6, %if.end, %entry, %if.end9
  %retval.0 = phi i32 [ -1, %if.end9 ], [ -1, %entry ], [ %3, %if.end ], [ %3, %if.then6 ]
  ret i32 %retval.0
}

define i32 @main(i32 %argc, i8** nocapture %argv) nounwind readnone optsize {
entry:
  ret i32 0
}

!0 = metadata !{metadata !"any pointer", metadata !1}
!1 = metadata !{metadata !"omnipotent char", metadata !2}
!2 = metadata !{metadata !"Simple C/C++ TBAA", null}
!3 = metadata !{metadata !"int", metadata !1}
