; ModuleID = 'ArraySet.cpp'
target datalayout = "e-p:32:32:32-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:32:64-f32:32:32-f64:32:64-v64:64:64-v128:128:128-a0:0:64-f80:32:32-n8:16:32-S128"
target triple = "i386-pc-linux-gnu"

@key = global [10 x i32] zeroinitializer, align 4
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
  %cmp30 = icmp slt i32 %0, 1
  br i1 %cmp30, label %while.body12, label %while.body.lr.ph

while.body.lr.ph:                                 ; preds = %entry
  %1 = add i32 %0, 1
  br label %while.body

while.cond4.preheader:                            ; preds = %if.end
  %cmp528 = icmp sgt i32 %nholes.1, 0
  br i1 %cmp528, label %while.body6, label %while.body12

while.body:                                       ; preds = %while.body.lr.ph, %if.end
  %i.032 = phi i32 [ 1, %while.body.lr.ph ], [ %add3, %if.end ]
  %nholes.031 = phi i32 [ 0, %while.body.lr.ph ], [ %nholes.1, %if.end ]
  %arrayidx = getelementptr inbounds [10 x i32]* @key, i32 0, i32 %i.032
  %2 = load i32* %arrayidx, align 4, !tbaa !0
  %cmp1 = icmp eq i32 %2, 0
  br i1 %cmp1, label %if.then, label %if.end

if.then:                                          ; preds = %while.body
  %add = add nsw i32 %nholes.031, 1
  %arrayidx2 = getelementptr inbounds i32* %vla, i32 %add
  store i32 %i.032, i32* %arrayidx2, align 4, !tbaa !0
  br label %if.end

if.end:                                           ; preds = %if.then, %while.body
  %nholes.1 = phi i32 [ %add, %if.then ], [ %nholes.031, %while.body ]
  %add3 = add nsw i32 %i.032, 1
  %exitcond = icmp eq i32 %add3, %1
  br i1 %exitcond, label %while.cond4.preheader, label %while.body

while.cond10.preheader:                           ; preds = %while.body6
  br i1 %tobool, label %while.body12, label %while.end16

while.body6:                                      ; preds = %while.cond4.preheader, %while.body6
  %nholes.229 = phi i32 [ %sub, %while.body6 ], [ %nholes.1, %while.cond4.preheader ]
  %arrayidx7 = getelementptr inbounds i32* %vla, i32 %nholes.229
  %3 = load i32* %arrayidx7, align 4, !tbaa !0
  %arrayidx8 = getelementptr inbounds [10 x i32]* @key, i32 0, i32 %3
  %4 = cmpxchg i32* %arrayidx8, i32 0, i32 %x seq_cst
  %sub = add nsw i32 %nholes.229, -1
  %tobool = icmp ne i32 %4, 0
  %cmp5 = icmp sgt i32 %sub, 0
  %or.cond = and i1 %cmp5, %tobool
  br i1 %or.cond, label %while.body6, label %while.cond10.preheader

while.body12:                                     ; preds = %entry, %while.cond4.preheader, %while.body12, %while.cond10.preheader
  %5 = load i32* @length, align 4, !tbaa !0
  %add13 = add nsw i32 %5, 1
  store i32 %add13, i32* @length, align 4, !tbaa !0
  %arrayidx14 = getelementptr inbounds [10 x i32]* @key, i32 0, i32 %add13
  %6 = cmpxchg i32* %arrayidx14, i32 0, i32 %x seq_cst
  %7 = icmp eq i32 %6, 0
  br i1 %7, label %while.end16, label %while.body12

while.end16:                                      ; preds = %while.body12, %while.cond10.preheader
  ret void
}

define void @_Z6Deletei(i32 %x) nounwind {
entry:
  %0 = load i32* @length, align 4, !tbaa !0
  %cmp3 = icmp slt i32 %0, 1
  br i1 %cmp3, label %while.end, label %while.body.lr.ph

while.body.lr.ph:                                 ; preds = %entry
  %1 = add i32 %0, 1
  br label %while.body

while.body:                                       ; preds = %while.body.lr.ph, %while.body
  %i.04 = phi i32 [ 1, %while.body.lr.ph ], [ %add, %while.body ]
  %arrayidx = getelementptr inbounds [10 x i32]* @key, i32 0, i32 %i.04
  %2 = cmpxchg i32* %arrayidx, i32 %x, i32 0 seq_cst
  %add = add nsw i32 %i.04, 1
  %exitcond = icmp eq i32 %add, %1
  br i1 %exitcond, label %while.end, label %while.body

while.end:                                        ; preds = %while.body, %entry
  ret void
}

!0 = metadata !{metadata !"int", metadata !1}
!1 = metadata !{metadata !"omnipotent char", metadata !2}
!2 = metadata !{metadata !"Simple C/C++ TBAA"}
