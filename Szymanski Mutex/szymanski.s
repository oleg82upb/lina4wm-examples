; ModuleID = 'szymanski.c'
target datalayout = "e-p:32:32:32-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:32:64-f32:32:32-f64:32:64-v64:64:64-v128:128:128-a0:0:64-f80:32:32-n8:16:32-S128"
target triple = "i386-pc-linux-gnu"

@flag = global [2 x i8] zeroinitializer, align 1

define i32 @allHigherIn014(i32 %i) nounwind readonly {
entry:
  ret i32 1
}

define i32 @existFlag(i32 %i) nounwind readonly {
entry:
  br label %for.cond

for.cond:                                         ; preds = %for.body, %entry
  %j.0 = phi i32 [ 0, %entry ], [ %inc, %for.body ]
  %cmp = icmp slt i32 %j.0, 2
  br i1 %cmp, label %for.body, label %return

for.body:                                         ; preds = %for.cond
  %arrayidx = getelementptr inbounds [2 x i8]* @flag, i32 0, i32 %j.0
  %0 = load i8* %arrayidx, align 1, !tbaa !0, !range !3
  %1 = and i8 %0, 1
  %conv = zext i8 %1 to i32
  %cmp1 = icmp eq i32 %conv, %i
  %inc = add nsw i32 %j.0, 1
  br i1 %cmp1, label %return, label %for.cond

return:                                           ; preds = %for.cond, %for.body
  %retval.0 = phi i32 [ 1, %for.body ], [ 0, %for.cond ]
  ret i32 %retval.0
}

define i32 @allLowerIn01(i32 %i) nounwind readonly {
entry:
  ret i32 1
}

define i32 @allFlags123() nounwind readnone {
entry:
  ret i32 1
}

define void @proci(i32 %i) nounwind {
entry:
  %arrayidx = getelementptr inbounds [2 x i8]* @flag, i32 0, i32 %i
  store i8 1, i8* %arrayidx, align 1, !tbaa !0
  br label %for.cond.i25

for.cond.i25:                                     ; preds = %for.body.i29, %entry
  %j.0.i23 = phi i32 [ 0, %entry ], [ %inc.i28, %for.body.i29 ]
  %cmp.i24 = icmp slt i32 %j.0.i23, 2
  br i1 %cmp.i24, label %for.body.i29, label %if.end

for.body.i29:                                     ; preds = %for.cond.i25
  %arrayidx.i26 = getelementptr inbounds [2 x i8]* @flag, i32 0, i32 %j.0.i23
  %0 = load i8* %arrayidx.i26, align 1, !tbaa !0, !range !3
  %1 = and i8 %0, 1
  %cmp1.i = icmp eq i8 %1, 0
  %inc.i28 = add nsw i32 %j.0.i23, 1
  br i1 %cmp1.i, label %for.cond.i25, label %if.then

if.then:                                          ; preds = %for.body.i29
  store i8 1, i8* %arrayidx, align 1, !tbaa !0
  br label %for.cond.i

for.cond.i:                                       ; preds = %for.cond.i, %if.then
  br label %for.cond.i

if.end:                                           ; preds = %for.cond.i25
  store i8 1, i8* %arrayidx, align 1, !tbaa !0
  br label %while.cond12

while.cond12:                                     ; preds = %while.cond12, %if.end
  br label %while.cond12
}

define i32 @main() nounwind readnone {
entry:
  ret i32 0
}

!0 = metadata !{metadata !"_Bool", metadata !1}
!1 = metadata !{metadata !"omnipotent char", metadata !2}
!2 = metadata !{metadata !"Simple C/C++ TBAA", null}
!3 = metadata !{i8 0, i8 2}                       
