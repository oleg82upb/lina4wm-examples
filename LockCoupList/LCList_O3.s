; ModuleID = 'LCList.cpp'
target datalayout = "e-p:32:32:32-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:32:64-f32:32:32-f64:32:64-v64:64:64-v128:128:128-a0:0:64-f80:32:32-n8:16:32-S128"
target triple = "i386-pc-linux-gnu"

%struct.stNode = type { i32, i8, %struct.stNode* }

@Head = global %struct.stNode* null, align 4
@Tail = global %struct.stNode* null, align 4

define void @_Z4initv() {
entry:
  %call = tail call noalias i8* @_Znwj(i32 12)
  %0 = bitcast i8* %call to %struct.stNode*
  store %struct.stNode* %0, %struct.stNode** @Head, align 4, !tbaa !0
  %iValue.i = bitcast i8* %call to i32*
  store i32 -2147483648, i32* %iValue.i, align 4, !tbaa !3
  %1 = getelementptr inbounds i8* %call, i32 4
  store i8 0, i8* %1, align 1, !tbaa !4
  %call1 = tail call noalias i8* @_Znwj(i32 12)
  %2 = bitcast i8* %call1 to %struct.stNode*
  store %struct.stNode* %2, %struct.stNode** @Tail, align 4, !tbaa !0
  %iValue.i3 = bitcast i8* %call1 to i32*
  store i32 2147483647, i32* %iValue.i3, align 4, !tbaa !3
  %3 = getelementptr inbounds i8* %call1, i32 4
  store i8 0, i8* %3, align 1, !tbaa !4
  %ptNext = getelementptr inbounds i8* %call, i32 8
  %4 = bitcast i8* %ptNext to %struct.stNode**
  store %struct.stNode* %2, %struct.stNode** %4, align 4, !tbaa !0
  %ptNext2 = getelementptr inbounds i8* %call1, i32 8
  %5 = bitcast i8* %ptNext2 to %struct.stNode**
  store %struct.stNode* null, %struct.stNode** %5, align 4, !tbaa !0
  ret void
}

declare noalias i8* @_Znwj(i32)

define %struct.stNode* @_Z6locatei(i32 %x) nounwind {
entry:
  %0 = load %struct.stNode** @Head, align 4, !tbaa !0
  %bLock.i = getelementptr inbounds %struct.stNode* %0, i32 0, i32 1
  %1 = cmpxchg i8* %bLock.i, i8 0, i8 1 seq_cst
  %ptNext = getelementptr inbounds %struct.stNode* %0, i32 0, i32 2
  %2 = load %struct.stNode** %ptNext, align 4, !tbaa !0
  %bLock.i11 = getelementptr inbounds %struct.stNode* %2, i32 0, i32 1
  %3 = cmpxchg i8* %bLock.i11, i8 0, i8 1 seq_cst
  %iValue12 = getelementptr inbounds %struct.stNode* %2, i32 0, i32 0
  %4 = load i32* %iValue12, align 4, !tbaa !3
  %cmp13 = icmp slt i32 %4, %x
  br i1 %cmp13, label %while.body, label %while.end

while.body:                                       ; preds = %entry, %while.body
  %curr.015 = phi %struct.stNode* [ %5, %while.body ], [ %2, %entry ]
  %pred.014 = phi %struct.stNode* [ %curr.015, %while.body ], [ %0, %entry ]
  %bLock.i10 = getelementptr inbounds %struct.stNode* %pred.014, i32 0, i32 1
  store i8 0, i8* %bLock.i10, align 1, !tbaa !4
  %ptNext2 = getelementptr inbounds %struct.stNode* %curr.015, i32 0, i32 2
  %5 = load %struct.stNode** %ptNext2, align 4, !tbaa !0
  %bLock.i9 = getelementptr inbounds %struct.stNode* %5, i32 0, i32 1
  %6 = cmpxchg i8* %bLock.i9, i8 0, i8 1 seq_cst
  %iValue = getelementptr inbounds %struct.stNode* %5, i32 0, i32 0
  %7 = load i32* %iValue, align 4, !tbaa !3
  %cmp = icmp slt i32 %7, %x
  br i1 %cmp, label %while.body, label %while.end

while.end:                                        ; preds = %while.body, %entry
  %pred.0.lcssa = phi %struct.stNode* [ %0, %entry ], [ %curr.015, %while.body ]
  ret %struct.stNode* %pred.0.lcssa
}

define zeroext i1 @_Z6inserti(i32 %iIns) {
entry:
  %0 = load %struct.stNode** @Head, align 4, !tbaa !0
  %bLock.i.i = getelementptr inbounds %struct.stNode* %0, i32 0, i32 1
  %1 = cmpxchg i8* %bLock.i.i, i8 0, i8 1 seq_cst
  %ptNext.i = getelementptr inbounds %struct.stNode* %0, i32 0, i32 2
  %2 = load %struct.stNode** %ptNext.i, align 4, !tbaa !0
  %bLock.i11.i = getelementptr inbounds %struct.stNode* %2, i32 0, i32 1
  %3 = cmpxchg i8* %bLock.i11.i, i8 0, i8 1 seq_cst
  %iValue12.i = getelementptr inbounds %struct.stNode* %2, i32 0, i32 0
  %4 = load i32* %iValue12.i, align 4, !tbaa !3
  %cmp13.i = icmp slt i32 %4, %iIns
  br i1 %cmp13.i, label %while.body.i, label %_Z6locatei.exit

while.body.i:                                     ; preds = %entry, %while.body.i
  %curr.015.i = phi %struct.stNode* [ %5, %while.body.i ], [ %2, %entry ]
  %pred.014.i = phi %struct.stNode* [ %curr.015.i, %while.body.i ], [ %0, %entry ]
  %bLock.i10.i = getelementptr inbounds %struct.stNode* %pred.014.i, i32 0, i32 1
  store i8 0, i8* %bLock.i10.i, align 1, !tbaa !4
  %ptNext2.i = getelementptr inbounds %struct.stNode* %curr.015.i, i32 0, i32 2
  %5 = load %struct.stNode** %ptNext2.i, align 4, !tbaa !0
  %bLock.i9.i = getelementptr inbounds %struct.stNode* %5, i32 0, i32 1
  %6 = cmpxchg i8* %bLock.i9.i, i8 0, i8 1 seq_cst
  %iValue.i = getelementptr inbounds %struct.stNode* %5, i32 0, i32 0
  %7 = load i32* %iValue.i, align 4, !tbaa !3
  %cmp.i = icmp slt i32 %7, %iIns
  br i1 %cmp.i, label %while.body.i, label %_Z6locatei.exit

_Z6locatei.exit:                                  ; preds = %while.body.i, %entry
  %pred.0.lcssa.i = phi %struct.stNode* [ %0, %entry ], [ %curr.015.i, %while.body.i ]
  %ptNext = getelementptr inbounds %struct.stNode* %pred.0.lcssa.i, i32 0, i32 2
  %8 = load %struct.stNode** %ptNext, align 4, !tbaa !0
  %iValue = getelementptr inbounds %struct.stNode* %8, i32 0, i32 0
  %9 = load i32* %iValue, align 4, !tbaa !3
  %cmp = icmp eq i32 %9, %iIns
  br i1 %cmp, label %if.end, label %if.then

if.then:                                          ; preds = %_Z6locatei.exit
  %call1 = tail call noalias i8* @_Znwj(i32 12)
  %10 = bitcast i8* %call1 to %struct.stNode*
  %iValue.i13 = bitcast i8* %call1 to i32*
  store i32 %iIns, i32* %iValue.i13, align 4, !tbaa !3
  %11 = getelementptr inbounds i8* %call1, i32 4
  store i8 0, i8* %11, align 1, !tbaa !4
  %ptNext.i15 = getelementptr inbounds i8* %call1, i32 8
  %12 = bitcast i8* %ptNext.i15 to %struct.stNode**
  store %struct.stNode* %8, %struct.stNode** %12, align 4, !tbaa !0
  store %struct.stNode* %10, %struct.stNode** %ptNext, align 4, !tbaa !0
  br label %if.end

if.end:                                           ; preds = %_Z6locatei.exit, %if.then
  %result.0 = phi i1 [ true, %if.then ], [ false, %_Z6locatei.exit ]
  %bLock.i12 = getelementptr inbounds %struct.stNode* %pred.0.lcssa.i, i32 0, i32 1
  store i8 0, i8* %bLock.i12, align 1, !tbaa !4
  %bLock.i = getelementptr inbounds %struct.stNode* %8, i32 0, i32 1
  store i8 0, i8* %bLock.i, align 1, !tbaa !4
  ret i1 %result.0
}

define zeroext i1 @_Z6removei(i32 %iDel) nounwind {
entry:
  %0 = load %struct.stNode** @Head, align 4, !tbaa !0
  %bLock.i.i = getelementptr inbounds %struct.stNode* %0, i32 0, i32 1
  %1 = cmpxchg i8* %bLock.i.i, i8 0, i8 1 seq_cst
  %ptNext.i = getelementptr inbounds %struct.stNode* %0, i32 0, i32 2
  %2 = load %struct.stNode** %ptNext.i, align 4, !tbaa !0
  %bLock.i11.i = getelementptr inbounds %struct.stNode* %2, i32 0, i32 1
  %3 = cmpxchg i8* %bLock.i11.i, i8 0, i8 1 seq_cst
  %iValue12.i = getelementptr inbounds %struct.stNode* %2, i32 0, i32 0
  %4 = load i32* %iValue12.i, align 4, !tbaa !3
  %cmp13.i = icmp slt i32 %4, %iDel
  br i1 %cmp13.i, label %while.body.i, label %_Z6locatei.exit

while.body.i:                                     ; preds = %entry, %while.body.i
  %curr.015.i = phi %struct.stNode* [ %5, %while.body.i ], [ %2, %entry ]
  %pred.014.i = phi %struct.stNode* [ %curr.015.i, %while.body.i ], [ %0, %entry ]
  %bLock.i10.i = getelementptr inbounds %struct.stNode* %pred.014.i, i32 0, i32 1
  store i8 0, i8* %bLock.i10.i, align 1, !tbaa !4
  %ptNext2.i = getelementptr inbounds %struct.stNode* %curr.015.i, i32 0, i32 2
  %5 = load %struct.stNode** %ptNext2.i, align 4, !tbaa !0
  %bLock.i9.i = getelementptr inbounds %struct.stNode* %5, i32 0, i32 1
  %6 = cmpxchg i8* %bLock.i9.i, i8 0, i8 1 seq_cst
  %iValue.i = getelementptr inbounds %struct.stNode* %5, i32 0, i32 0
  %7 = load i32* %iValue.i, align 4, !tbaa !3
  %cmp.i = icmp slt i32 %7, %iDel
  br i1 %cmp.i, label %while.body.i, label %_Z6locatei.exit

_Z6locatei.exit:                                  ; preds = %while.body.i, %entry
  %pred.0.lcssa.i = phi %struct.stNode* [ %0, %entry ], [ %curr.015.i, %while.body.i ]
  %ptNext = getelementptr inbounds %struct.stNode* %pred.0.lcssa.i, i32 0, i32 2
  %8 = load %struct.stNode** %ptNext, align 4, !tbaa !0
  %iValue = getelementptr inbounds %struct.stNode* %8, i32 0, i32 0
  %9 = load i32* %iValue, align 4, !tbaa !3
  %cmp = icmp eq i32 %9, %iDel
  br i1 %cmp, label %if.then, label %if.end

if.then:                                          ; preds = %_Z6locatei.exit
  %ptNext1 = getelementptr inbounds %struct.stNode* %8, i32 0, i32 2
  %10 = load %struct.stNode** %ptNext1, align 4, !tbaa !0
  store %struct.stNode* %10, %struct.stNode** %ptNext, align 4, !tbaa !0
  %bLock.i12 = getelementptr inbounds %struct.stNode* %pred.0.lcssa.i, i32 0, i32 1
  store i8 0, i8* %bLock.i12, align 1, !tbaa !4
  %bLock.i11 = getelementptr inbounds %struct.stNode* %8, i32 0, i32 1
  store i8 0, i8* %bLock.i11, align 1, !tbaa !4
  br label %return

if.end:                                           ; preds = %_Z6locatei.exit
  %bLock.i10 = getelementptr inbounds %struct.stNode* %pred.0.lcssa.i, i32 0, i32 1
  store i8 0, i8* %bLock.i10, align 1, !tbaa !4
  %bLock.i = getelementptr inbounds %struct.stNode* %8, i32 0, i32 1
  store i8 0, i8* %bLock.i, align 1, !tbaa !4
  br label %return

return:                                           ; preds = %if.end, %if.then
  %retval.0 = phi i1 [ true, %if.then ], [ false, %if.end ]
  ret i1 %retval.0
}

!0 = metadata !{metadata !"any pointer", metadata !1}
!1 = metadata !{metadata !"omnipotent char", metadata !2}
!2 = metadata !{metadata !"Simple C/C++ TBAA"}
!3 = metadata !{metadata !"int", metadata !1}
!4 = metadata !{metadata !"bool", metadata !1}
