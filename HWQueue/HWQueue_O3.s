; ModuleID = 'HWQueue.cpp'
target datalayout = "e-p:32:32:32-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:32:64-f32:32:32-f64:32:64-v64:64:64-v128:128:128-a0:0:64-f80:32:32-n8:16:32-S128"
target triple = "i386-pc-linux-gnu"

%struct.queue = type { i32, [20 x i32] }

define i32 @main(i32 %argc, i8** nocapture %argv) nounwind readnone {
entry:
  ret i32 0
}

define i32 @_Z3incP5queue(%struct.queue* nocapture %q) nounwind {
entry:
  %back = getelementptr inbounds %struct.queue* %q, i32 0, i32 0
  %0 = load i32* %back, align 4, !tbaa !0
  %inc = add nsw i32 %0, 1
  store i32 %inc, i32* %back, align 4, !tbaa !0
  ret i32 %0
}

define void @_Z5storeP5queueii(%struct.queue* nocapture %q, i32 %newvalue, i32 %index) nounwind {
entry:
  %arrayidx = getelementptr inbounds %struct.queue* %q, i32 0, i32 1, i32 %index
  store i32 %newvalue, i32* %arrayidx, align 4, !tbaa !0
  ret void
}

define i32 @_Z4readP5queue(%struct.queue* nocapture %q) nounwind readonly {
entry:
  %back = getelementptr inbounds %struct.queue* %q, i32 0, i32 0
  %0 = load i32* %back, align 4, !tbaa !0
  ret i32 %0
}

define i32 @_Z4swapP5queueii(%struct.queue* nocapture %q, i32 %value, i32 %index) nounwind {
entry:
  %arrayidx = getelementptr inbounds %struct.queue* %q, i32 0, i32 1, i32 %index
  %0 = load i32* %arrayidx, align 4, !tbaa !0
  store i32 %value, i32* %arrayidx, align 4, !tbaa !0
  ret i32 %0
}

define void @_Z7enqueueP5queuei(%struct.queue* nocapture %q, i32 %newvalue) nounwind {
entry:
  %back.i = getelementptr inbounds %struct.queue* %q, i32 0, i32 0
  %0 = load i32* %back.i, align 4, !tbaa !0
  %inc.i = add nsw i32 %0, 1
  store i32 %inc.i, i32* %back.i, align 4, !tbaa !0
  %arrayidx.i = getelementptr inbounds %struct.queue* %q, i32 0, i32 1, i32 %0
  store i32 %newvalue, i32* %arrayidx.i, align 4, !tbaa !0
  ret void
}

define void @_Z7dequeueP5queue(%struct.queue* nocapture %q) nounwind {
entry:
  %back.i = getelementptr inbounds %struct.queue* %q, i32 0, i32 0
  br label %while.body

while.body:                                       ; preds = %while.cond1, %entry
  %0 = load i32* %back.i, align 4, !tbaa !0
  %dec = add nsw i32 %0, -1
  br label %while.cond1

while.cond1:                                      ; preds = %while.body2, %while.body
  %i.0 = phi i32 [ 1, %while.body ], [ %inc, %while.body2 ]
  %cmp = icmp sgt i32 %i.0, %dec
  br i1 %cmp, label %while.body, label %while.body2

while.body2:                                      ; preds = %while.cond1
  %arrayidx.i = getelementptr inbounds %struct.queue* %q, i32 0, i32 1, i32 %i.0
  %1 = load i32* %arrayidx.i, align 4, !tbaa !0
  store i32 0, i32* %arrayidx.i, align 4, !tbaa !0
  %cmp4 = icmp eq i32 %1, 0
  %inc = add nsw i32 %i.0, 1
  br i1 %cmp4, label %while.cond1, label %if.then

if.then:                                          ; preds = %while.body2
  ret void
}

!0 = metadata !{metadata !"int", metadata !1}
!1 = metadata !{metadata !"omnipotent char", metadata !2}
!2 = metadata !{metadata !"Simple C/C++ TBAA"}
