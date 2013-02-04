; ModuleID = 'LazyList.cpp'
target datalayout = "e-p:32:32:32-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:32:64-f32:32:32-f64:32:64-v64:64:64-v128:128:128-a0:0:64-f80:32:32-n8:16:32-S128"
target triple = "i386-pc-linux-gnu"

%struct.stNode = type { i32, i8, i8, %struct.stNode* }

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
  %2 = getelementptr inbounds i8* %call, i32 5
  store i8 0, i8* %2, align 1, !tbaa !4
  %call1 = tail call noalias i8* @_Znwj(i32 12)
  %3 = bitcast i8* %call1 to %struct.stNode*
  store %struct.stNode* %3, %struct.stNode** @Tail, align 4, !tbaa !0
  %iValue.i3 = bitcast i8* %call1 to i32*
  store i32 2147483647, i32* %iValue.i3, align 4, !tbaa !3
  %4 = getelementptr inbounds i8* %call1, i32 4
  store i8 0, i8* %4, align 1, !tbaa !4
  %5 = getelementptr inbounds i8* %call1, i32 5
  store i8 0, i8* %5, align 1, !tbaa !4
  %ptNext = getelementptr inbounds i8* %call, i32 8
  %6 = bitcast i8* %ptNext to %struct.stNode**
  store %struct.stNode* %3, %struct.stNode** %6, align 4, !tbaa !0
  %ptNext2 = getelementptr inbounds i8* %call1, i32 8
  %7 = bitcast i8* %ptNext2 to %struct.stNode**
  store %struct.stNode* null, %struct.stNode** %7, align 4, !tbaa !0
  ret void
}

declare noalias i8* @_Znwj(i32)

define %struct.stNode* @_Z6locatei(i32 %x) nounwind {
entry:
  %0 = load %struct.stNode** @Head, align 4, !tbaa !0
  br label %while.cond

while.cond:                                       ; preds = %while.cond, %entry
  %pred.0 = phi %struct.stNode* [ %0, %entry ], [ %curr.0, %while.cond ]
  %curr.0.in = getelementptr inbounds %struct.stNode* %pred.0, i32 0, i32 3
  %curr.0 = load %struct.stNode** %curr.0.in, align 4
  %iValue = getelementptr inbounds %struct.stNode* %curr.0, i32 0, i32 0
  %1 = load i32* %iValue, align 4, !tbaa !3
  %cmp = icmp slt i32 %1, %x
  br i1 %cmp, label %while.cond, label %while.end

while.end:                                        ; preds = %while.cond
  %bLock.i = getelementptr inbounds %struct.stNode* %pred.0, i32 0, i32 1
  %2 = cmpxchg i8* %bLock.i, i8 0, i8 1 seq_cst
  %bLock.i14 = getelementptr inbounds %struct.stNode* %curr.0, i32 0, i32 1
  %3 = cmpxchg i8* %bLock.i14, i8 0, i8 1 seq_cst
  %bMark.i = getelementptr inbounds %struct.stNode* %pred.0, i32 0, i32 2
  %4 = load i8* %bMark.i, align 1, !tbaa !4, !range !5
  %tobool.i = icmp eq i8 %4, 0
  br i1 %tobool.i, label %land.lhs.true.i, label %if.end

land.lhs.true.i:                                  ; preds = %while.end
  %bMark1.i = getelementptr inbounds %struct.stNode* %curr.0, i32 0, i32 2
  %5 = load i8* %bMark1.i, align 1, !tbaa !4, !range !5
  %tobool2.i = icmp eq i8 %5, 0
  br i1 %tobool2.i, label %land.lhs.true3.i, label %if.end

land.lhs.true3.i:                                 ; preds = %land.lhs.true.i
  %6 = load %struct.stNode** %curr.0.in, align 4, !tbaa !0
  %cmp.i = icmp eq %struct.stNode* %6, %curr.0
  br i1 %cmp.i, label %return, label %if.end

if.end:                                           ; preds = %land.lhs.true3.i, %land.lhs.true.i, %while.end
  store i8 0, i8* %bLock.i, align 1, !tbaa !4
  store i8 0, i8* %bLock.i14, align 1, !tbaa !4
  br label %return

return:                                           ; preds = %land.lhs.true3.i, %if.end
  %retval.0 = phi %struct.stNode* [ null, %if.end ], [ %pred.0, %land.lhs.true3.i ]
  ret %struct.stNode* %retval.0
}

define zeroext i1 @_Z8validateP6stNodeS0_(%struct.stNode* nocapture %pred, %struct.stNode* %curr) nounwind readonly {
entry:
  %bMark = getelementptr inbounds %struct.stNode* %pred, i32 0, i32 2
  %0 = load i8* %bMark, align 1, !tbaa !4, !range !5
  %tobool = icmp eq i8 %0, 0
  br i1 %tobool, label %land.lhs.true, label %if.end

land.lhs.true:                                    ; preds = %entry
  %bMark1 = getelementptr inbounds %struct.stNode* %curr, i32 0, i32 2
  %1 = load i8* %bMark1, align 1, !tbaa !4, !range !5
  %tobool2 = icmp eq i8 %1, 0
  br i1 %tobool2, label %land.lhs.true3, label %if.end

land.lhs.true3:                                   ; preds = %land.lhs.true
  %ptNext = getelementptr inbounds %struct.stNode* %pred, i32 0, i32 3
  %2 = load %struct.stNode** %ptNext, align 4, !tbaa !0
  %cmp = icmp eq %struct.stNode* %2, %curr
  br i1 %cmp, label %return, label %if.end

if.end:                                           ; preds = %land.lhs.true, %entry, %land.lhs.true3
  br label %return

return:                                           ; preds = %land.lhs.true3, %if.end
  %retval.0 = phi i1 [ false, %if.end ], [ true, %land.lhs.true3 ]
  ret i1 %retval.0
}

define zeroext i1 @_Z6inserti(i32 %iIns) {
entry:
  %0 = load %struct.stNode** @Head, align 4, !tbaa !0
  br label %while.cond.i

while.cond.i:                                     ; preds = %while.cond.i, %entry
  %pred.0.i = phi %struct.stNode* [ %0, %entry ], [ %curr.0.i, %while.cond.i ]
  %curr.0.in.i = getelementptr inbounds %struct.stNode* %pred.0.i, i32 0, i32 3
  %curr.0.i = load %struct.stNode** %curr.0.in.i, align 4
  %iValue.i = getelementptr inbounds %struct.stNode* %curr.0.i, i32 0, i32 0
  %1 = load i32* %iValue.i, align 4, !tbaa !3
  %cmp.i = icmp slt i32 %1, %iIns
  br i1 %cmp.i, label %while.cond.i, label %while.end.i

while.end.i:                                      ; preds = %while.cond.i
  %bLock.i.i = getelementptr inbounds %struct.stNode* %pred.0.i, i32 0, i32 1
  %2 = cmpxchg i8* %bLock.i.i, i8 0, i8 1 seq_cst
  %bLock.i14.i = getelementptr inbounds %struct.stNode* %curr.0.i, i32 0, i32 1
  %3 = cmpxchg i8* %bLock.i14.i, i8 0, i8 1 seq_cst
  %bMark.i.i = getelementptr inbounds %struct.stNode* %pred.0.i, i32 0, i32 2
  %4 = load i8* %bMark.i.i, align 1, !tbaa !4, !range !5
  %tobool.i.i = icmp eq i8 %4, 0
  br i1 %tobool.i.i, label %land.lhs.true.i.i, label %if.end.i

land.lhs.true.i.i:                                ; preds = %while.end.i
  %bMark1.i.i = getelementptr inbounds %struct.stNode* %curr.0.i, i32 0, i32 2
  %5 = load i8* %bMark1.i.i, align 1, !tbaa !4, !range !5
  %tobool2.i.i = icmp eq i8 %5, 0
  br i1 %tobool2.i.i, label %land.lhs.true3.i.i, label %if.end.i

land.lhs.true3.i.i:                               ; preds = %land.lhs.true.i.i
  %6 = load %struct.stNode** %curr.0.in.i, align 4, !tbaa !0
  %cmp.i.i = icmp eq %struct.stNode* %6, %curr.0.i
  br i1 %cmp.i.i, label %_Z6locatei.exit, label %if.end.i

if.end.i:                                         ; preds = %land.lhs.true3.i.i, %land.lhs.true.i.i, %while.end.i
  store i8 0, i8* %bLock.i.i, align 1, !tbaa !4
  store i8 0, i8* %bLock.i14.i, align 1, !tbaa !4
  %.pre = load %struct.stNode** inttoptr (i32 8 to %struct.stNode**), align 8, !tbaa !0
  br label %_Z6locatei.exit

_Z6locatei.exit:                                  ; preds = %land.lhs.true3.i.i, %if.end.i
  %7 = phi %struct.stNode* [ %.pre, %if.end.i ], [ %curr.0.i, %land.lhs.true3.i.i ]
  %retval.0.i = phi %struct.stNode* [ null, %if.end.i ], [ %pred.0.i, %land.lhs.true3.i.i ]
  %iValue = getelementptr inbounds %struct.stNode* %7, i32 0, i32 0
  %8 = load i32* %iValue, align 4, !tbaa !3
  %cmp = icmp eq i32 %8, %iIns
  br i1 %cmp, label %if.end, label %if.then

if.then:                                          ; preds = %_Z6locatei.exit
  %ptNext = getelementptr inbounds %struct.stNode* %retval.0.i, i32 0, i32 3
  %call1 = tail call noalias i8* @_Znwj(i32 12)
  %9 = bitcast i8* %call1 to %struct.stNode*
  %iValue.i13 = bitcast i8* %call1 to i32*
  store i32 %iIns, i32* %iValue.i13, align 4, !tbaa !3
  %10 = getelementptr inbounds i8* %call1, i32 4
  store i8 0, i8* %10, align 1, !tbaa !4
  %11 = getelementptr inbounds i8* %call1, i32 5
  store i8 0, i8* %11, align 1, !tbaa !4
  %ptNext.i = getelementptr inbounds i8* %call1, i32 8
  %12 = bitcast i8* %ptNext.i to %struct.stNode**
  store %struct.stNode* %7, %struct.stNode** %12, align 4, !tbaa !0
  store %struct.stNode* %9, %struct.stNode** %ptNext, align 4, !tbaa !0
  br label %if.end

if.end:                                           ; preds = %_Z6locatei.exit, %if.then
  %bLock.i12 = getelementptr inbounds %struct.stNode* %retval.0.i, i32 0, i32 1
  store i8 0, i8* %bLock.i12, align 1, !tbaa !4
  %bLock.i = getelementptr inbounds %struct.stNode* %7, i32 0, i32 1
  store i8 0, i8* %bLock.i, align 1, !tbaa !4
  ret i1 false
}

define zeroext i1 @_Z6removei(i32 %iDel) nounwind {
entry:
  %0 = load %struct.stNode** @Head, align 4, !tbaa !0
  br label %while.cond.i

while.cond.i:                                     ; preds = %while.cond.i, %entry
  %pred.0.i = phi %struct.stNode* [ %0, %entry ], [ %curr.0.i, %while.cond.i ]
  %curr.0.in.i = getelementptr inbounds %struct.stNode* %pred.0.i, i32 0, i32 3
  %curr.0.i = load %struct.stNode** %curr.0.in.i, align 4
  %iValue.i = getelementptr inbounds %struct.stNode* %curr.0.i, i32 0, i32 0
  %1 = load i32* %iValue.i, align 4, !tbaa !3
  %cmp.i = icmp slt i32 %1, %iDel
  br i1 %cmp.i, label %while.cond.i, label %while.end.i

while.end.i:                                      ; preds = %while.cond.i
  %bLock.i.i = getelementptr inbounds %struct.stNode* %pred.0.i, i32 0, i32 1
  %2 = cmpxchg i8* %bLock.i.i, i8 0, i8 1 seq_cst
  %bLock.i14.i = getelementptr inbounds %struct.stNode* %curr.0.i, i32 0, i32 1
  %3 = cmpxchg i8* %bLock.i14.i, i8 0, i8 1 seq_cst
  %bMark.i.i = getelementptr inbounds %struct.stNode* %pred.0.i, i32 0, i32 2
  %4 = load i8* %bMark.i.i, align 1, !tbaa !4, !range !5
  %tobool.i.i = icmp eq i8 %4, 0
  br i1 %tobool.i.i, label %land.lhs.true.i.i, label %if.end.i

land.lhs.true.i.i:                                ; preds = %while.end.i
  %bMark1.i.i = getelementptr inbounds %struct.stNode* %curr.0.i, i32 0, i32 2
  %5 = load i8* %bMark1.i.i, align 1, !tbaa !4, !range !5
  %tobool2.i.i = icmp eq i8 %5, 0
  br i1 %tobool2.i.i, label %land.lhs.true3.i.i, label %if.end.i

land.lhs.true3.i.i:                               ; preds = %land.lhs.true.i.i
  %6 = load %struct.stNode** %curr.0.in.i, align 4, !tbaa !0
  %cmp.i.i = icmp eq %struct.stNode* %6, %curr.0.i
  br i1 %cmp.i.i, label %_Z6locatei.exit, label %if.end.i

if.end.i:                                         ; preds = %land.lhs.true3.i.i, %land.lhs.true.i.i, %while.end.i
  store i8 0, i8* %bLock.i.i, align 1, !tbaa !4
  store i8 0, i8* %bLock.i14.i, align 1, !tbaa !4
  %.pre = load %struct.stNode** inttoptr (i32 8 to %struct.stNode**), align 8, !tbaa !0
  br label %_Z6locatei.exit

_Z6locatei.exit:                                  ; preds = %land.lhs.true3.i.i, %if.end.i
  %7 = phi %struct.stNode* [ %.pre, %if.end.i ], [ %curr.0.i, %land.lhs.true3.i.i ]
  %retval.0.i = phi %struct.stNode* [ null, %if.end.i ], [ %pred.0.i, %land.lhs.true3.i.i ]
  %iValue = getelementptr inbounds %struct.stNode* %7, i32 0, i32 0
  %8 = load i32* %iValue, align 4, !tbaa !3
  %cmp = icmp eq i32 %8, %iDel
  br i1 %cmp, label %if.then, label %if.end

if.then:                                          ; preds = %_Z6locatei.exit
  %ptNext = getelementptr inbounds %struct.stNode* %retval.0.i, i32 0, i32 3
  %ptNext1 = getelementptr inbounds %struct.stNode* %7, i32 0, i32 3
  %9 = load %struct.stNode** %ptNext1, align 4, !tbaa !0
  %bMark = getelementptr inbounds %struct.stNode* %7, i32 0, i32 2
  store i8 1, i8* %bMark, align 1, !tbaa !4
  store %struct.stNode* %9, %struct.stNode** %ptNext, align 4, !tbaa !0
  %bLock.i13 = getelementptr inbounds %struct.stNode* %retval.0.i, i32 0, i32 1
  store i8 0, i8* %bLock.i13, align 1, !tbaa !4
  %bLock.i12 = getelementptr inbounds %struct.stNode* %7, i32 0, i32 1
  store i8 0, i8* %bLock.i12, align 1, !tbaa !4
  br label %return

if.end:                                           ; preds = %_Z6locatei.exit
  %bLock.i11 = getelementptr inbounds %struct.stNode* %retval.0.i, i32 0, i32 1
  store i8 0, i8* %bLock.i11, align 1, !tbaa !4
  %bLock.i = getelementptr inbounds %struct.stNode* %7, i32 0, i32 1
  store i8 0, i8* %bLock.i, align 1, !tbaa !4
  br label %return

return:                                           ; preds = %if.end, %if.then
  %retval.0 = phi i1 [ true, %if.then ], [ false, %if.end ]
  ret i1 %retval.0
}

define zeroext i1 @_Z8containsi(i32 %iCon) nounwind readonly {
entry:
  br label %while.cond

while.cond:                                       ; preds = %while.cond, %entry
  %curr.0.in = phi %struct.stNode** [ @Head, %entry ], [ %ptNext, %while.cond ]
  %curr.0 = load %struct.stNode** %curr.0.in, align 4
  %iValue = getelementptr inbounds %struct.stNode* %curr.0, i32 0, i32 0
  %0 = load i32* %iValue, align 4, !tbaa !3
  %cmp = icmp slt i32 %0, %iCon
  %ptNext = getelementptr inbounds %struct.stNode* %curr.0, i32 0, i32 3
  br i1 %cmp, label %while.cond, label %while.end

while.end:                                        ; preds = %while.cond
  %bMark = getelementptr inbounds %struct.stNode* %curr.0, i32 0, i32 2
  %1 = load i8* %bMark, align 1, !tbaa !4, !range !5
  %tobool = icmp eq i8 %1, 0
  ret i1 %tobool
}

!0 = metadata !{metadata !"any pointer", metadata !1}
!1 = metadata !{metadata !"omnipotent char", metadata !2}
!2 = metadata !{metadata !"Simple C/C++ TBAA"}
!3 = metadata !{metadata !"int", metadata !1}
!4 = metadata !{metadata !"bool", metadata !1}
!5 = metadata !{i8 0, i8 2}
