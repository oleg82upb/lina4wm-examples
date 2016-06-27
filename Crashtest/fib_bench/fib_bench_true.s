; ModuleID = 'fib_bench_true.c'
target datalayout = "e-p:32:32:32-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:32:64-f32:32:32-f64:32:64-v64:64:64-v128:128:128-a0:0:64-f80:32:32-n8:16:32-S128"
target triple = "i386-pc-linux-gnu"

%union.pthread_attr_t = type { i32, [32 x i8] }

@i = global i32 1, align 4
@j = global i32 1, align 4
@.str = private unnamed_addr constant [2 x i8] c"0\00", align 1
@.str1 = private unnamed_addr constant [17 x i8] c"fib_bench_true.c\00", align 1
@__PRETTY_FUNCTION__.main = private unnamed_addr constant [23 x i8] c"int main(int, char **)\00", align 1

define noalias i8* @t1(i8* nocapture %arg) nounwind {
entry:
  %0 = load volatile i32* @j, align 4, !tbaa !0
  %1 = load volatile i32* @i, align 4, !tbaa !0
  %add = add nsw i32 %1, %0
  store volatile i32 %add, i32* @i, align 4, !tbaa !0
  %2 = load volatile i32* @j, align 4, !tbaa !0
  %3 = load volatile i32* @i, align 4, !tbaa !0
  %add.1 = add nsw i32 %3, %2
  store volatile i32 %add.1, i32* @i, align 4, !tbaa !0
  %4 = load volatile i32* @j, align 4, !tbaa !0
  %5 = load volatile i32* @i, align 4, !tbaa !0
  %add.2 = add nsw i32 %5, %4
  store volatile i32 %add.2, i32* @i, align 4, !tbaa !0
  %6 = load volatile i32* @j, align 4, !tbaa !0
  %7 = load volatile i32* @i, align 4, !tbaa !0
  %add.3 = add nsw i32 %7, %6
  store volatile i32 %add.3, i32* @i, align 4, !tbaa !0
  %8 = load volatile i32* @j, align 4, !tbaa !0
  %9 = load volatile i32* @i, align 4, !tbaa !0
  %add.4 = add nsw i32 %9, %8
  store volatile i32 %add.4, i32* @i, align 4, !tbaa !0
  ret i8* null
}

define noalias i8* @t2(i8* nocapture %arg) nounwind {
entry:
  %0 = load volatile i32* @i, align 4, !tbaa !0
  %1 = load volatile i32* @j, align 4, !tbaa !0
  %add = add nsw i32 %1, %0
  store volatile i32 %add, i32* @j, align 4, !tbaa !0
  %2 = load volatile i32* @i, align 4, !tbaa !0
  %3 = load volatile i32* @j, align 4, !tbaa !0
  %add.1 = add nsw i32 %3, %2
  store volatile i32 %add.1, i32* @j, align 4, !tbaa !0
  %4 = load volatile i32* @i, align 4, !tbaa !0
  %5 = load volatile i32* @j, align 4, !tbaa !0
  %add.2 = add nsw i32 %5, %4
  store volatile i32 %add.2, i32* @j, align 4, !tbaa !0
  %6 = load volatile i32* @i, align 4, !tbaa !0
  %7 = load volatile i32* @j, align 4, !tbaa !0
  %add.3 = add nsw i32 %7, %6
  store volatile i32 %add.3, i32* @j, align 4, !tbaa !0
  %8 = load volatile i32* @i, align 4, !tbaa !0
  %9 = load volatile i32* @j, align 4, !tbaa !0
  %add.4 = add nsw i32 %9, %8
  store volatile i32 %add.4, i32* @j, align 4, !tbaa !0
  ret i8* null
}

define i32 @main(i32 %argc, i8** nocapture %argv) nounwind {
entry:
  %id1 = alloca i32, align 4
  %id2 = alloca i32, align 4
  %call = call i32 @pthread_create(i32* %id1, %union.pthread_attr_t* null, i8* (i8*)* @t1, i8* null) nounwind
  %call1 = call i32 @pthread_create(i32* %id2, %union.pthread_attr_t* null, i8* (i8*)* @t2, i8* null) nounwind
  %0 = load volatile i32* @i, align 4, !tbaa !0
  %cmp = icmp sgt i32 %0, 144
  br i1 %cmp, label %if.then, label %lor.lhs.false

lor.lhs.false:                                    ; preds = %entry
  %1 = load volatile i32* @j, align 4, !tbaa !0
  %cmp2 = icmp sgt i32 %1, 144
  br i1 %cmp2, label %if.then, label %if.end

if.then:                                          ; preds = %lor.lhs.false, %entry
  call void @__assert_fail(i8* getelementptr inbounds ([2 x i8]* @.str, i32 0, i32 0), i8* getelementptr inbounds ([17 x i8]* @.str1, i32 0, i32 0), i32 47, i8* getelementptr inbounds ([23 x i8]* @__PRETTY_FUNCTION__.main, i32 0, i32 0)) noreturn nounwind
  unreachable

if.end:                                           ; preds = %lor.lhs.false
  ret i32 0
}

declare i32 @pthread_create(i32*, %union.pthread_attr_t*, i8* (i8*)*, i8*) nounwind

declare void @__assert_fail(i8*, i8*, i32, i8*) noreturn nounwind

!0 = metadata !{metadata !"int", metadata !1}
!1 = metadata !{metadata !"omnipotent char", metadata !2}
!2 = metadata !{metadata !"Simple C/C++ TBAA", null}
