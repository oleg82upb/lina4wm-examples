; ModuleID = 'rdcss.cpp'
target datalayout = "e-p:32:32:32-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:32:64-f32:32:32-f64:32:64-v64:64:64-v128:128:128-a0:0:64-f80:32:32-n8:16:32-S128"
target triple = "i386-pc-linux-gnu"

%struct.stDescriptor = type { i32*, i32*, i32, i32, i32 }

@_ZTIj = external constant i8*
@_ZTS12stDescriptor = linkonce_odr constant [15 x i8] c"12stDescriptor\00"

define i32 @_Z5RDCSSP12stDescriptor(%struct.stDescriptor* %d) nounwind {
entry:
  %a2 = getelementptr inbounds %struct.stDescriptor* %d, i32 0, i32 1
  %o2 = getelementptr inbounds %struct.stDescriptor* %d, i32 0, i32 3
  %0 = ptrtoint %struct.stDescriptor* %d to i32
  %1 = load i8** getelementptr inbounds (i8** @_ZTIj, i32 1), align 4, !tbaa !0
  %cmp.i13 = icmp eq i8* %1, getelementptr inbounds ([15 x i8]* @_ZTS12stDescriptor, i32 0, i32 0)
  br i1 %cmp.i13, label %if.then.us, label %lor.rhs.i15

if.then.us:                                       ; preds = %if.then.i25.us, %if.else.i27.us, %entry
  %2 = load i32** %a2, align 4, !tbaa !0
  %3 = load i32* %o2, align 4, !tbaa !3
  %4 = cmpxchg i32* %2, i32 %3, i32 %0 seq_cst
  %5 = inttoptr i32 %4 to %struct.stDescriptor*
  %a1.i20.us = getelementptr inbounds %struct.stDescriptor* %5, i32 0, i32 0
  %6 = load i32** %a1.i20.us, align 4, !tbaa !0
  %7 = load i32* %6, align 4, !tbaa !3
  %o1.i21.us = getelementptr inbounds %struct.stDescriptor* %5, i32 0, i32 2
  %8 = load i32* %o1.i21.us, align 4, !tbaa !3
  %cmp.i22.us = icmp eq i32 %7, %8
  %a2.i23.us = getelementptr inbounds %struct.stDescriptor* %5, i32 0, i32 1
  %9 = load i32** %a2.i23.us, align 4, !tbaa !0
  br i1 %cmp.i22.us, label %if.then.i25.us, label %if.else.i27.us

if.else.i27.us:                                   ; preds = %if.then.us
  %o2.i26.us = getelementptr inbounds %struct.stDescriptor* %5, i32 0, i32 3
  %10 = load i32* %o2.i26.us, align 4, !tbaa !3
  %11 = cmpxchg i32* %9, i32 %4, i32 %10 seq_cst
  br label %if.then.us

if.then.i25.us:                                   ; preds = %if.then.us
  %n2.i24.us = getelementptr inbounds %struct.stDescriptor* %5, i32 0, i32 4
  %12 = load i32* %n2.i24.us, align 4, !tbaa !3
  %13 = cmpxchg i32* %9, i32 %4, i32 %12 seq_cst
  br label %if.then.us

lor.rhs.i15:                                      ; preds = %_ZNKSt9type_infoeqERKS_.exit, %entry
  %14 = load i32** %a2, align 4, !tbaa !0
  %15 = load i32* %o2, align 4, !tbaa !3
  %16 = cmpxchg i32* %14, i32 %15, i32 %0 seq_cst
  %17 = load i8* %1, align 1, !tbaa !1
  %cmp4.i14 = icmp eq i8 %17, 42
  br i1 %cmp4.i14, label %do.end, label %_ZNKSt9type_infoeqERKS_.exit19

_ZNKSt9type_infoeqERKS_.exit19:                   ; preds = %lor.rhs.i15
  %call.i16 = tail call i32 @strcmp(i8* %1, i8* getelementptr inbounds ([15 x i8]* @_ZTS12stDescriptor, i32 0, i32 0)) nounwind
  %cmp7.i17 = icmp eq i32 %call.i16, 0
  br i1 %cmp7.i17, label %if.then, label %lor.rhs.i

if.then:                                          ; preds = %_ZNKSt9type_infoeqERKS_.exit19
  %18 = inttoptr i32 %16 to %struct.stDescriptor*
  %a1.i20 = getelementptr inbounds %struct.stDescriptor* %18, i32 0, i32 0
  %19 = load i32** %a1.i20, align 4, !tbaa !0
  %20 = load i32* %19, align 4, !tbaa !3
  %o1.i21 = getelementptr inbounds %struct.stDescriptor* %18, i32 0, i32 2
  %21 = load i32* %o1.i21, align 4, !tbaa !3
  %cmp.i22 = icmp eq i32 %20, %21
  %a2.i23 = getelementptr inbounds %struct.stDescriptor* %18, i32 0, i32 1
  %22 = load i32** %a2.i23, align 4, !tbaa !0
  br i1 %cmp.i22, label %if.then.i25, label %if.else.i27

if.then.i25:                                      ; preds = %if.then
  %n2.i24 = getelementptr inbounds %struct.stDescriptor* %18, i32 0, i32 4
  %23 = load i32* %n2.i24, align 4, !tbaa !3
  %24 = cmpxchg i32* %22, i32 %16, i32 %23 seq_cst
  br label %lor.rhs.i

if.else.i27:                                      ; preds = %if.then
  %o2.i26 = getelementptr inbounds %struct.stDescriptor* %18, i32 0, i32 3
  %25 = load i32* %o2.i26, align 4, !tbaa !3
  %26 = cmpxchg i32* %22, i32 %16, i32 %25 seq_cst
  br label %lor.rhs.i

lor.rhs.i:                                        ; preds = %_ZNKSt9type_infoeqERKS_.exit19, %if.then.i25, %if.else.i27
  %.pr = load i8* %1, align 1, !tbaa !1
  %cmp4.i = icmp eq i8 %.pr, 42
  br i1 %cmp4.i, label %do.end, label %_ZNKSt9type_infoeqERKS_.exit

_ZNKSt9type_infoeqERKS_.exit:                     ; preds = %lor.rhs.i
  %call.i = tail call i32 @strcmp(i8* %1, i8* getelementptr inbounds ([15 x i8]* @_ZTS12stDescriptor, i32 0, i32 0)) nounwind
  %cmp7.i = icmp eq i32 %call.i, 0
  br i1 %cmp7.i, label %lor.rhs.i15, label %do.end

do.end:                                           ; preds = %lor.rhs.i15, %lor.rhs.i, %_ZNKSt9type_infoeqERKS_.exit
  %27 = load i32* %o2, align 4, !tbaa !3
  %cmp = icmp eq i32 %16, %27
  br i1 %cmp, label %if.then4, label %if.end5

if.then4:                                         ; preds = %do.end
  %a1.i = getelementptr inbounds %struct.stDescriptor* %d, i32 0, i32 0
  %28 = load i32** %a1.i, align 4, !tbaa !0
  %29 = load i32* %28, align 4, !tbaa !3
  %o1.i = getelementptr inbounds %struct.stDescriptor* %d, i32 0, i32 2
  %30 = load i32* %o1.i, align 4, !tbaa !3
  %cmp.i = icmp eq i32 %29, %30
  %31 = load i32** %a2, align 4, !tbaa !0
  br i1 %cmp.i, label %if.then.i, label %if.else.i

if.then.i:                                        ; preds = %if.then4
  %n2.i = getelementptr inbounds %struct.stDescriptor* %d, i32 0, i32 4
  %32 = load i32* %n2.i, align 4, !tbaa !3
  %33 = cmpxchg i32* %31, i32 %0, i32 %32 seq_cst
  br label %if.end5

if.else.i:                                        ; preds = %if.then4
  %34 = cmpxchg i32* %31, i32 %0, i32 %16 seq_cst
  br label %if.end5

if.end5:                                          ; preds = %if.else.i, %if.then.i, %do.end
  ret i32 %16
}

define i32 @_Z4CAS1Pjjj(i32* %a, i32 %o, i32 %n) nounwind {
entry:
  %0 = cmpxchg i32* %a, i32 %o, i32 %n seq_cst
  ret i32 %0
}

define void @_Z8CompleteP12stDescriptor(%struct.stDescriptor* %d) nounwind {
entry:
  %a1 = getelementptr inbounds %struct.stDescriptor* %d, i32 0, i32 0
  %0 = load i32** %a1, align 4, !tbaa !0
  %1 = load i32* %0, align 4, !tbaa !3
  %o1 = getelementptr inbounds %struct.stDescriptor* %d, i32 0, i32 2
  %2 = load i32* %o1, align 4, !tbaa !3
  %cmp = icmp eq i32 %1, %2
  %a2 = getelementptr inbounds %struct.stDescriptor* %d, i32 0, i32 1
  %3 = load i32** %a2, align 4, !tbaa !0
  %4 = ptrtoint %struct.stDescriptor* %d to i32
  br i1 %cmp, label %if.then, label %if.else

if.then:                                          ; preds = %entry
  %n2 = getelementptr inbounds %struct.stDescriptor* %d, i32 0, i32 4
  %5 = load i32* %n2, align 4, !tbaa !3
  %6 = cmpxchg i32* %3, i32 %4, i32 %5 seq_cst
  br label %if.end

if.else:                                          ; preds = %entry
  %o2 = getelementptr inbounds %struct.stDescriptor* %d, i32 0, i32 3
  %7 = load i32* %o2, align 4, !tbaa !3
  %8 = cmpxchg i32* %3, i32 %4, i32 %7 seq_cst
  br label %if.end

if.end:                                           ; preds = %if.else, %if.then
  ret void
}

define i32 @_Z4ReadPj(i32* nocapture %addr) nounwind {
entry:
  %0 = load i8** getelementptr inbounds (i8** @_ZTIj, i32 1), align 4, !tbaa !0
  %cmp.i = icmp eq i8* %0, getelementptr inbounds ([15 x i8]* @_ZTS12stDescriptor, i32 0, i32 0)
  br label %do.body

do.body:                                          ; preds = %do.cond, %_ZNKSt9type_infoeqERKS_.exit10, %entry
  %1 = load i32* %addr, align 4, !tbaa !3
  br i1 %cmp.i, label %if.then, label %lor.rhs.i

lor.rhs.i:                                        ; preds = %do.body
  %2 = load i8* %0, align 1, !tbaa !1
  %cmp4.i = icmp eq i8 %2, 42
  br i1 %cmp4.i, label %do.end, label %_ZNKSt9type_infoeqERKS_.exit

_ZNKSt9type_infoeqERKS_.exit:                     ; preds = %lor.rhs.i
  %call.i = tail call i32 @strcmp(i8* %0, i8* getelementptr inbounds ([15 x i8]* @_ZTS12stDescriptor, i32 0, i32 0)) nounwind
  %cmp7.i = icmp eq i32 %call.i, 0
  br i1 %cmp7.i, label %if.then, label %lor.rhs.i6

if.then:                                          ; preds = %do.body, %_ZNKSt9type_infoeqERKS_.exit
  %3 = inttoptr i32 %1 to %struct.stDescriptor*
  %a1.i = getelementptr inbounds %struct.stDescriptor* %3, i32 0, i32 0
  %4 = load i32** %a1.i, align 4, !tbaa !0
  %5 = load i32* %4, align 4, !tbaa !3
  %o1.i = getelementptr inbounds %struct.stDescriptor* %3, i32 0, i32 2
  %6 = load i32* %o1.i, align 4, !tbaa !3
  %cmp.i3 = icmp eq i32 %5, %6
  %a2.i = getelementptr inbounds %struct.stDescriptor* %3, i32 0, i32 1
  %7 = load i32** %a2.i, align 4, !tbaa !0
  br i1 %cmp.i3, label %if.then.i, label %if.else.i

if.then.i:                                        ; preds = %if.then
  %n2.i = getelementptr inbounds %struct.stDescriptor* %3, i32 0, i32 4
  %8 = load i32* %n2.i, align 4, !tbaa !3
  %9 = cmpxchg i32* %7, i32 %1, i32 %8 seq_cst
  br label %do.cond

if.else.i:                                        ; preds = %if.then
  %o2.i = getelementptr inbounds %struct.stDescriptor* %3, i32 0, i32 3
  %10 = load i32* %o2.i, align 4, !tbaa !3
  %11 = cmpxchg i32* %7, i32 %1, i32 %10 seq_cst
  br label %do.cond

do.cond:                                          ; preds = %if.else.i, %if.then.i
  br i1 %cmp.i, label %do.body, label %lor.rhs.i6

lor.rhs.i6:                                       ; preds = %_ZNKSt9type_infoeqERKS_.exit, %do.cond
  %.pr = load i8* %0, align 1, !tbaa !1
  %cmp4.i5 = icmp eq i8 %.pr, 42
  br i1 %cmp4.i5, label %do.end, label %_ZNKSt9type_infoeqERKS_.exit10

_ZNKSt9type_infoeqERKS_.exit10:                   ; preds = %lor.rhs.i6
  %call.i7 = tail call i32 @strcmp(i8* %0, i8* getelementptr inbounds ([15 x i8]* @_ZTS12stDescriptor, i32 0, i32 0)) nounwind
  %cmp7.i8 = icmp eq i32 %call.i7, 0
  br i1 %cmp7.i8, label %do.body, label %do.end

do.end:                                           ; preds = %lor.rhs.i, %lor.rhs.i6, %_ZNKSt9type_infoeqERKS_.exit10
  ret i32 %1
}

declare i32 @strcmp(i8* nocapture, i8* nocapture) nounwind readonly

!0 = metadata !{metadata !"any pointer", metadata !1}
!1 = metadata !{metadata !"omnipotent char", metadata !2}
!2 = metadata !{metadata !"Simple C/C++ TBAA"}
!3 = metadata !{metadata !"int", metadata !1}
