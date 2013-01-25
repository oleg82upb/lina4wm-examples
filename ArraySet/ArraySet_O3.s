; ModuleID = 'ArraySet.cpp'
target datalayout = "e-p:32:32:32-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:32:64-f32:32:32-f64:32:64-v64:64:64-v128:128:128-a0:0:64-f80:32:32-n8:16:32-S128"
target triple = "i386-pc-linux-gnu"

@key = global [10 x i32] zeroinitializer, align 4
@gen = global [10 x i32] zeroinitializer, align 4
@length = global i32 0, align 4

define zeroext i1 @_Z6Memberi(i32 %x) nounwind readonly {
entry:
  %mylength.012 = load i32* @length, align 4
  %cmp13 = icmp sgt i32 %mylength.012, 0
  br i1 %cmp13, label %while.cond1, label %return

while.cond1:                                      ; preds = %entry, %while.body3
  %i.1 = phi i32 [ %add, %while.body3 ], [ 0, %entry ]
  %cmp2 = icmp eq i32 %i.1, %mylength.012
  br i1 %cmp2, label %return, label %while.body3

while.body3:                                      ; preds = %while.cond1
  %add = add nsw i32 %i.1, 1
  %arrayidx = getelementptr inbounds [10 x i32]* @key, i32 0, i32 %add
  %0 = load i32* %arrayidx, align 4, !tbaa !0
  %cmp4 = icmp eq i32 %0, %x
  br i1 %cmp4, label %return, label %while.cond1

return:                                           ; preds = %entry, %while.cond1, %while.body3
  %retval.0 = phi i1 [ true, %while.body3 ], [ false, %while.cond1 ], [ false, %entry ]
  ret i1 %retval.0
}

define void @_Z6Inserti(i32 %x) nounwind {
entry:
  %0 = load i32* @length, align 4, !tbaa !0
  %vla = alloca i32, i32 %0, align 4
  %cmp46 = icmp slt i32 %0, 1
  br i1 %cmp46, label %while.body18, label %while.body.lr.ph

while.body.lr.ph:                                 ; preds = %entry
  %1 = add i32 %0, 1
  br label %while.body

while.cond4.preheader:                            ; preds = %if.end
  %cmp544 = icmp sgt i32 %nholes.1, 0
  br i1 %cmp544, label %while.body6, label %while.body18

while.body:                                       ; preds = %while.body.lr.ph, %if.end
  %i.048 = phi i32 [ 1, %while.body.lr.ph ], [ %add3, %if.end ]
  %nholes.047 = phi i32 [ 0, %while.body.lr.ph ], [ %nholes.1, %if.end ]
  %arrayidx = getelementptr inbounds [10 x i32]* @key, i32 0, i32 %i.048
  %2 = load i32* %arrayidx, align 4, !tbaa !0
  %cmp1 = icmp eq i32 %2, 0
  br i1 %cmp1, label %if.then, label %if.end

if.then:                                          ; preds = %while.body
  %add = add nsw i32 %nholes.047, 1
  %arrayidx2 = getelementptr inbounds i32* %vla, i32 %add
  store i32 %i.048, i32* %arrayidx2, align 4, !tbaa !0
  br label %if.end

if.end:                                           ; preds = %if.then, %while.body
  %nholes.1 = phi i32 [ %add, %if.then ], [ %nholes.047, %while.body ]
  %add3 = add nsw i32 %i.048, 1
  %exitcond = icmp eq i32 %add3, %1
  br i1 %exitcond, label %while.cond4.preheader, label %while.body

while.cond16.preheader:                           ; preds = %if.end14
  br i1 %cmp9, label %while.end27, label %while.body18

while.body6:                                      ; preds = %while.cond4.preheader, %if.end14
  %nholes.245 = phi i32 [ %sub, %if.end14 ], [ %nholes.1, %while.cond4.preheader ]
  %arrayidx7 = getelementptr inbounds i32* %vla, i32 %nholes.245
  %3 = load i32* %arrayidx7, align 4, !tbaa !0
  %arrayidx8 = getelementptr inbounds [10 x i32]* @key, i32 0, i32 %3
  %4 = load i32* %arrayidx8, align 4, !tbaa !0
  %cmp9 = icmp eq i32 %4, 0
  br i1 %cmp9, label %if.end14.thread.thread, label %if.end14

if.end14.thread.thread:                           ; preds = %while.body6
  store i32 %x, i32* %arrayidx8, align 4, !tbaa !0
  br label %while.end27

if.end14:                                         ; preds = %while.body6
  %sub = add nsw i32 %nholes.245, -1
  %tobool = xor i1 %cmp9, true
  %cmp5 = icmp sgt i32 %sub, 0
  %or.cond = and i1 %cmp5, %tobool
  br i1 %or.cond, label %while.body6, label %while.cond16.preheader

while.body18:                                     ; preds = %while.cond16.preheader, %entry, %while.cond4.preheader, %while.body18
  %add1943 = phi i32 [ %0, %while.cond16.preheader ], [ %add19, %while.body18 ], [ %0, %while.cond4.preheader ], [ %0, %entry ]
  %add19 = add nsw i32 %add1943, 1
  %arrayidx20 = getelementptr inbounds [10 x i32]* @key, i32 0, i32 %add19
  %5 = load i32* %arrayidx20, align 4, !tbaa !0
  %cmp21 = icmp eq i32 %5, 0
  br i1 %cmp21, label %while.cond16.while.end27_crit_edge, label %while.body18

while.cond16.while.end27_crit_edge:               ; preds = %while.body18
  store i32 %x, i32* %arrayidx20, align 4, !tbaa !0
  store i32 %add19, i32* @length, align 4
  br label %while.end27

while.end27:                                      ; preds = %while.cond16.preheader, %if.end14.thread.thread, %while.cond16.while.end27_crit_edge
  ret void
}

define void @_Z6Deletei(i32 %x) nounwind {
entry:
  %0 = load i32* @length, align 4, !tbaa !0
  %vla = alloca i32, i32 %0, align 4
  %vla1 = alloca i32, i32 %0, align 4
  %cmp41 = icmp slt i32 %0, 1
  br i1 %cmp41, label %while.body9.lr.ph, label %while.body.lr.ph

while.body.lr.ph:                                 ; preds = %entry
  %1 = add i32 %0, 1
  br label %while.body

while.cond7.preheader:                            ; preds = %if.end
  %cmp839 = icmp slt i32 %ntodo.1, 0
  br i1 %cmp839, label %while.end24, label %while.body9.lr.ph

while.body9.lr.ph:                                ; preds = %entry, %while.cond7.preheader
  %ntodo.0.lcssa46 = phi i32 [ %ntodo.1, %while.cond7.preheader ], [ 0, %entry ]
  %2 = add i32 %ntodo.0.lcssa46, 1
  br label %while.body9

while.body:                                       ; preds = %while.body.lr.ph, %if.end
  %i.043 = phi i32 [ 1, %while.body.lr.ph ], [ %add6, %if.end ]
  %ntodo.042 = phi i32 [ 0, %while.body.lr.ph ], [ %ntodo.1, %if.end ]
  %arrayidx2 = getelementptr inbounds [10 x i32]* @key, i32 0, i32 %i.043
  %3 = load i32* %arrayidx2, align 4, !tbaa !0
  %cmp3 = icmp eq i32 %3, 0
  br i1 %cmp3, label %if.then, label %if.end

if.then:                                          ; preds = %while.body
  %arrayidx = getelementptr inbounds i32* %vla1, i32 %i.043
  %4 = load i32* %arrayidx, align 4, !tbaa !0
  %add = add nsw i32 %ntodo.042, 1
  %arrayidx4 = getelementptr inbounds i32* %vla, i32 %add
  store i32 %i.043, i32* %arrayidx4, align 4, !tbaa !0
  %arrayidx5 = getelementptr inbounds i32* %vla1, i32 %add
  store i32 %4, i32* %arrayidx5, align 4, !tbaa !0
  br label %if.end

if.end:                                           ; preds = %if.then, %while.body
  %ntodo.1 = phi i32 [ %add, %if.then ], [ %ntodo.042, %while.body ]
  %add6 = add nsw i32 %i.043, 1
  %exitcond44 = icmp eq i32 %add6, %1
  br i1 %exitcond44, label %while.cond7.preheader, label %while.body

while.body9:                                      ; preds = %if.end22, %while.body9.lr.ph
  %i.140 = phi i32 [ 0, %while.body9.lr.ph ], [ %add23, %if.end22 ]
  %arrayidx10 = getelementptr inbounds i32* %vla, i32 %i.140
  %5 = load i32* %arrayidx10, align 4, !tbaa !0
  %arrayidx11 = getelementptr inbounds i32* %vla1, i32 %5
  %6 = load i32* %arrayidx11, align 4, !tbaa !0
  %arrayidx12 = getelementptr inbounds i32* %vla1, i32 %i.140
  %7 = load i32* %arrayidx12, align 4, !tbaa !0
  %cmp13 = icmp eq i32 %6, %7
  br i1 %cmp13, label %if.then14, label %if.end22

if.then14:                                        ; preds = %while.body9
  %arrayidx16 = getelementptr inbounds [10 x i32]* @key, i32 0, i32 %5
  store i32 0, i32* %arrayidx16, align 4, !tbaa !0
  %add19 = add nsw i32 %6, 1
  store i32 %add19, i32* %arrayidx11, align 4, !tbaa !0
  br label %if.end22

if.end22:                                         ; preds = %if.then14, %while.body9
  %add23 = add nsw i32 %i.140, 1
  %exitcond = icmp eq i32 %add23, %2
  br i1 %exitcond, label %while.end24, label %while.body9

while.end24:                                      ; preds = %if.end22, %while.cond7.preheader
  ret void
}

!0 = metadata !{metadata !"int", metadata !1}
!1 = metadata !{metadata !"omnipotent char", metadata !2}
!2 = metadata !{metadata !"Simple C/C++ TBAA"}
