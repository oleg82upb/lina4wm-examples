; ModuleID = 'tml.c'
target datalayout = "e-p:32:32:32-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:32:64-f32:32:32-f64:32:64-v64:64:64-v128:128:128-a0:0:64-f80:32:32-n8:16:32-S128"
target triple = "i386-pc-linux-gnu"

@glb = global i32* null, align 4
@x = global i32* null, align 4
@y = global i32* null, align 4
@lx1 = global i32 0, align 4
@ly1 = global i32 0, align 4
@lx2 = global i32 0, align 4
@ly2 = global i32 0, align 4

define i32 @proc11() nounwind {
entry:
  %0 = load i32** @glb, align 4, !tbaa !0
  br label %do.body

do.body:                                          ; preds = %do.body, %entry
  %1 = load volatile i32* %0, align 4, !tbaa !3
  %and = and i32 %1, 1
  %tobool = icmp eq i32 %and, 0
  br i1 %tobool, label %if.then, label %do.body

if.then:                                          ; preds = %do.body
  %add = add nsw i32 %1, 1
  %2 = cmpxchg i32* %0, i32 %1, i32 %add seq_cst
  %3 = icmp eq i32 %2, %1
  br i1 %3, label %if.end4, label %return

if.end4:                                          ; preds = %if.then
  %4 = load i32** @x, align 4, !tbaa !0
  store volatile i32 1, i32* %4, align 4, !tbaa !3
  %5 = load i32** @y, align 4, !tbaa !0
  %6 = load volatile i32* %5, align 4, !tbaa !3
  %7 = load i32** @glb, align 4, !tbaa !0
  %8 = load volatile i32* %7, align 4, !tbaa !3
  %cmp = icmp eq i32 %8, %add
  br i1 %cmp, label %if.end6, label %return

if.end6:                                          ; preds = %if.end4
  store i32 %6, i32* @ly1, align 4, !tbaa !3
  %and7 = and i32 %add, 1
  %tobool8 = icmp eq i32 %and7, 0
  br i1 %tobool8, label %return, label %if.then9

if.then9:                                         ; preds = %if.end6
  %9 = load i32** @glb, align 4, !tbaa !0
  %incdec.ptr = getelementptr inbounds i32* %9, i32 1
  store i32* %incdec.ptr, i32** @glb, align 4, !tbaa !0
  br label %return

return:                                           ; preds = %if.then9, %if.end6, %if.end4, %if.then
  %retval.0 = phi i32 [ -1, %if.then ], [ -1, %if.end4 ], [ 1, %if.end6 ], [ 1, %if.then9 ]
  ret i32 %retval.0
}

define i32 @proc21() nounwind {
entry:
  %0 = load i32** @glb, align 4, !tbaa !0
  br label %do.body

do.body:                                          ; preds = %do.body, %entry
  %1 = load volatile i32* %0, align 4, !tbaa !3
  %and = and i32 %1, 1
  %tobool = icmp eq i32 %and, 0
  br i1 %tobool, label %if.then, label %do.body

if.then:                                          ; preds = %do.body
  %add = add nsw i32 %1, 1
  %2 = cmpxchg i32* %0, i32 %1, i32 %add seq_cst
  %3 = icmp eq i32 %2, %1
  br i1 %3, label %if.end4, label %return

if.end4:                                          ; preds = %if.then
  %4 = load i32** @x, align 4, !tbaa !0
  store volatile i32 1, i32* %4, align 4, !tbaa !3
  %5 = load i32** @x, align 4, !tbaa !0
  %6 = load volatile i32* %5, align 4, !tbaa !3
  %7 = load i32** @glb, align 4, !tbaa !0
  %8 = load volatile i32* %7, align 4, !tbaa !3
  %cmp = icmp eq i32 %8, %add
  br i1 %cmp, label %if.end6, label %return

if.end6:                                          ; preds = %if.end4
  store i32 %6, i32* @lx2, align 4, !tbaa !3
  %and7 = and i32 %add, 1
  %tobool8 = icmp eq i32 %and7, 0
  br i1 %tobool8, label %return, label %if.then9

if.then9:                                         ; preds = %if.end6
  %9 = load i32** @glb, align 4, !tbaa !0
  %incdec.ptr = getelementptr inbounds i32* %9, i32 1
  store i32* %incdec.ptr, i32** @glb, align 4, !tbaa !0
  %10 = load volatile i32* %9, align 4, !tbaa !3
  br label %return

return:                                           ; preds = %if.then9, %if.end6, %if.end4, %if.then
  %retval.0 = phi i32 [ -1, %if.then ], [ -1, %if.end4 ], [ 1, %if.end6 ], [ 1, %if.then9 ]
  ret i32 %retval.0
}

define i32 @proc12() nounwind {
entry:
  %0 = load i32** @glb, align 4, !tbaa !0
  br label %do.body

do.body:                                          ; preds = %do.body, %entry
  %1 = load volatile i32* %0, align 4, !tbaa !3
  %and = and i32 %1, 1
  %tobool = icmp eq i32 %and, 0
  br i1 %tobool, label %if.then, label %do.body

if.then:                                          ; preds = %do.body
  %add = add nsw i32 %1, 1
  %2 = cmpxchg i32* %0, i32 %1, i32 %add seq_cst
  %3 = icmp eq i32 %2, %1
  br i1 %3, label %if.end4, label %return

if.end4:                                          ; preds = %if.then
  %4 = load i32** @x, align 4, !tbaa !0
  store volatile i32 1, i32* %4, align 4, !tbaa !3
  %5 = load i32** @x, align 4, !tbaa !0
  %6 = load volatile i32* %5, align 4, !tbaa !3
  %7 = load i32** @glb, align 4, !tbaa !0
  %8 = load volatile i32* %7, align 4, !tbaa !3
  %cmp = icmp eq i32 %8, %add
  br i1 %cmp, label %if.end6, label %return

if.end6:                                          ; preds = %if.end4
  store i32 %6, i32* @lx1, align 4, !tbaa !3
  %9 = load i32** @y, align 4, !tbaa !0
  %10 = load volatile i32* %9, align 4, !tbaa !3
  %11 = load i32** @glb, align 4, !tbaa !0
  %12 = load volatile i32* %11, align 4, !tbaa !3
  %cmp7 = icmp eq i32 %12, %add
  br i1 %cmp7, label %if.end9, label %return

if.end9:                                          ; preds = %if.end6
  store i32 %10, i32* @ly1, align 4, !tbaa !3
  %and10 = and i32 %add, 1
  %tobool11 = icmp eq i32 %and10, 0
  br i1 %tobool11, label %return, label %if.then12

if.then12:                                        ; preds = %if.end9
  %13 = load i32** @glb, align 4, !tbaa !0
  %incdec.ptr = getelementptr inbounds i32* %13, i32 1
  store i32* %incdec.ptr, i32** @glb, align 4, !tbaa !0
  %14 = load volatile i32* %13, align 4, !tbaa !3
  br label %return

return:                                           ; preds = %if.then12, %if.end9, %if.end6, %if.end4, %if.then
  %retval.0 = phi i32 [ -1, %if.then ], [ -1, %if.end4 ], [ -1, %if.end6 ], [ 1, %if.end9 ], [ 1, %if.then12 ]
  ret i32 %retval.0
}

define i32 @proc22() nounwind {
entry:
  %0 = load i32** @glb, align 4, !tbaa !0
  br label %do.body

do.body:                                          ; preds = %do.body, %entry
  %1 = load volatile i32* %0, align 4, !tbaa !3
  %and = and i32 %1, 1
  %tobool = icmp eq i32 %and, 0
  br i1 %tobool, label %if.then, label %do.body

if.then:                                          ; preds = %do.body
  %add = add nsw i32 %1, 1
  %2 = cmpxchg i32* %0, i32 %1, i32 %add seq_cst
  %3 = icmp eq i32 %2, %1
  br i1 %3, label %if.end4, label %return

if.end4:                                          ; preds = %if.then
  %4 = load i32** @x, align 4, !tbaa !0
  store volatile i32 1, i32* %4, align 4, !tbaa !3
  %5 = load i32** @y, align 4, !tbaa !0
  %6 = load volatile i32* %5, align 4, !tbaa !3
  %7 = load i32** @glb, align 4, !tbaa !0
  %8 = load volatile i32* %7, align 4, !tbaa !3
  %cmp = icmp eq i32 %8, %add
  br i1 %cmp, label %if.end6, label %return

if.end6:                                          ; preds = %if.end4
  store i32 %6, i32* @ly2, align 4, !tbaa !3
  %9 = load i32** @x, align 4, !tbaa !0
  %10 = load volatile i32* %9, align 4, !tbaa !3
  %11 = load i32** @glb, align 4, !tbaa !0
  %12 = load volatile i32* %11, align 4, !tbaa !3
  %cmp7 = icmp eq i32 %12, %add
  br i1 %cmp7, label %if.end9, label %return

if.end9:                                          ; preds = %if.end6
  store i32 %10, i32* @lx2, align 4, !tbaa !3
  %and10 = and i32 %add, 1
  %tobool11 = icmp eq i32 %and10, 0
  br i1 %tobool11, label %return, label %if.then12

if.then12:                                        ; preds = %if.end9
  %13 = load i32** @glb, align 4, !tbaa !0
  %incdec.ptr = getelementptr inbounds i32* %13, i32 1
  store i32* %incdec.ptr, i32** @glb, align 4, !tbaa !0
  %14 = load volatile i32* %13, align 4, !tbaa !3
  br label %return

return:                                           ; preds = %if.then12, %if.end9, %if.end6, %if.end4, %if.then
  %retval.0 = phi i32 [ -1, %if.then ], [ -1, %if.end4 ], [ -1, %if.end6 ], [ 1, %if.end9 ], [ 1, %if.then12 ]
  ret i32 %retval.0
}

define i32 @proc13() nounwind {
entry:
  %0 = load i32** @glb, align 4, !tbaa !0
  br label %do.body

do.body:                                          ; preds = %do.body, %entry
  %1 = load volatile i32* %0, align 4, !tbaa !3
  %and = and i32 %1, 1
  %tobool = icmp eq i32 %and, 0
  br i1 %tobool, label %if.then, label %do.body

if.then:                                          ; preds = %do.body
  %add = add nsw i32 %1, 1
  %2 = cmpxchg i32* %0, i32 %1, i32 %add seq_cst
  %3 = icmp eq i32 %2, %1
  br i1 %3, label %if.end4, label %return

if.end4:                                          ; preds = %if.then
  %4 = load i32** @x, align 4, !tbaa !0
  store volatile i32 1, i32* %4, align 4, !tbaa !3
  %and5 = and i32 %add, 1
  %tobool6 = icmp eq i32 %and5, 0
  br i1 %tobool6, label %return, label %if.then7

if.then7:                                         ; preds = %if.end4
  %5 = load i32** @glb, align 4, !tbaa !0
  %incdec.ptr = getelementptr inbounds i32* %5, i32 1
  store i32* %incdec.ptr, i32** @glb, align 4, !tbaa !0
  br label %return

return:                                           ; preds = %if.then7, %if.end4, %if.then
  %retval.0 = phi i32 [ -1, %if.then ], [ 1, %if.end4 ], [ 1, %if.then7 ]
  ret i32 %retval.0
}

define i32 @proc23() nounwind {
entry:
  %0 = load i32** @glb, align 4, !tbaa !0
  br label %do.body

do.body:                                          ; preds = %do.body, %entry
  %1 = load volatile i32* %0, align 4, !tbaa !3
  %and = and i32 %1, 1
  %tobool = icmp eq i32 %and, 0
  br i1 %tobool, label %if.then, label %do.body

if.then:                                          ; preds = %do.body
  %add = add nsw i32 %1, 1
  %2 = cmpxchg i32* %0, i32 %1, i32 %add seq_cst
  %3 = icmp eq i32 %2, %1
  br i1 %3, label %if.end4, label %return

if.end4:                                          ; preds = %if.then
  %4 = load i32** @y, align 4, !tbaa !0
  store volatile i32 1, i32* %4, align 4, !tbaa !3
  %and5 = and i32 %add, 1
  %tobool6 = icmp eq i32 %and5, 0
  br i1 %tobool6, label %return, label %if.then7

if.then7:                                         ; preds = %if.end4
  %5 = load i32** @glb, align 4, !tbaa !0
  %incdec.ptr = getelementptr inbounds i32* %5, i32 1
  store i32* %incdec.ptr, i32** @glb, align 4, !tbaa !0
  br label %return

return:                                           ; preds = %if.then7, %if.end4, %if.then
  %retval.0 = phi i32 [ -1, %if.then ], [ 1, %if.end4 ], [ 1, %if.then7 ]
  ret i32 %retval.0
}

define i32 @proc33() nounwind {
entry:
  %0 = load i32** @glb, align 4, !tbaa !0
  br label %do.body

do.body:                                          ; preds = %do.body, %entry
  %1 = load volatile i32* %0, align 4, !tbaa !3
  %and = and i32 %1, 1
  %tobool = icmp eq i32 %and, 0
  br i1 %tobool, label %do.end, label %do.body

do.end:                                           ; preds = %do.body
  %2 = load i32** @x, align 4, !tbaa !0
  %3 = load volatile i32* %2, align 4, !tbaa !3
  %4 = load volatile i32* %0, align 4, !tbaa !3
  %cmp = icmp eq i32 %4, %1
  br i1 %cmp, label %if.end, label %return

if.end:                                           ; preds = %do.end
  store i32 %3, i32* @lx1, align 4, !tbaa !3
  %5 = load i32** @y, align 4, !tbaa !0
  %6 = load volatile i32* %5, align 4, !tbaa !3
  %7 = load i32** @glb, align 4, !tbaa !0
  %8 = load volatile i32* %7, align 4, !tbaa !3
  %cmp1 = icmp eq i32 %8, %1
  br i1 %cmp1, label %if.end3, label %return

if.end3:                                          ; preds = %if.end
  store i32 %6, i32* @ly1, align 4, !tbaa !3
  br label %return

return:                                           ; preds = %if.end3, %if.end, %do.end
  %retval.0 = phi i32 [ -1, %do.end ], [ -1, %if.end ], [ 1, %if.end3 ]
  ret i32 %retval.0
}

define i32 @proc43() nounwind {
entry:
  %0 = load i32** @glb, align 4, !tbaa !0
  br label %do.body

do.body:                                          ; preds = %do.body, %entry
  %1 = load volatile i32* %0, align 4, !tbaa !3
  %and = and i32 %1, 1
  %tobool = icmp eq i32 %and, 0
  br i1 %tobool, label %do.end, label %do.body

do.end:                                           ; preds = %do.body
  %2 = load i32** @y, align 4, !tbaa !0
  %3 = load volatile i32* %2, align 4, !tbaa !3
  %4 = load volatile i32* %0, align 4, !tbaa !3
  %cmp = icmp eq i32 %4, %1
  br i1 %cmp, label %if.end, label %return

if.end:                                           ; preds = %do.end
  store i32 %3, i32* @ly2, align 4, !tbaa !3
  %5 = load i32** @x, align 4, !tbaa !0
  %6 = load volatile i32* %5, align 4, !tbaa !3
  %7 = load i32** @glb, align 4, !tbaa !0
  %8 = load volatile i32* %7, align 4, !tbaa !3
  %cmp1 = icmp eq i32 %8, %1
  br i1 %cmp1, label %if.end3, label %return

if.end3:                                          ; preds = %if.end
  store i32 %6, i32* @lx2, align 4, !tbaa !3
  br label %return

return:                                           ; preds = %if.end3, %if.end, %do.end
  %retval.0 = phi i32 [ -1, %do.end ], [ -1, %if.end ], [ 1, %if.end3 ]
  ret i32 %retval.0
}

define i32 @main(i32 %argc, i8** nocapture %argv) nounwind readnone {
entry:
  ret i32 0
}

!0 = metadata !{metadata !"any pointer", metadata !1}
!1 = metadata !{metadata !"omnipotent char", metadata !2}
!2 = metadata !{metadata !"Simple C/C++ TBAA", null}
!3 = metadata !{metadata !"int", metadata !1}
