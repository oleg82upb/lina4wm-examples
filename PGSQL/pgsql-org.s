; ModuleID = 'pgsql.c'
target datalayout = "e-p:32:32:32-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:32:64-f32:32:32-f64:32:64-v64:64:64-v128:128:128-a0:0:64-f80:32:32-n8:16:32-S128"
target triple = "i386-pc-linux-gnu"

%union.pthread_attr_t = type { i32, [32 x i8] }

@latch1 = global i8 1, align 1
@flag1 = global i8 1, align 1
@latch2 = global i8 0, align 1
@flag2 = global i8 0, align 1
@__unbuffered_tmp2 = global i8 0, align 1
@.str = private unnamed_addr constant [17 x i8] c"!latch1 || flag1\00", align 1
@.str1 = private unnamed_addr constant [8 x i8] c"pgsql.c\00", align 1
@__PRETTY_FUNCTION__.worker_1 = private unnamed_addr constant [23 x i8] c"void *worker_1(void *)\00", align 1
@.str2 = private unnamed_addr constant [17 x i8] c"!latch2 || flag2\00", align 1
@__PRETTY_FUNCTION__.worker_2 = private unnamed_addr constant [23 x i8] c"void *worker_2(void *)\00", align 1

define noalias i8* @worker_1(i8* nocapture %arg) nounwind {
entry:
  %0 = load volatile i8* @latch1, align 1, !tbaa !0, !range !3
  %1 = and i8 %0, 1
  %tobool = icmp eq i8 %1, 0
  br i1 %tobool, label %if.then, label %if.end8

if.then:                                          ; preds = %entry
  %2 = load volatile i8* @latch1, align 1, !tbaa !0, !range !3
  %3 = and i8 %2, 1
  %tobool1 = icmp eq i8 %3, 0
  br i1 %tobool1, label %return, label %if.end

if.end:                                           ; preds = %if.then
  %4 = load volatile i8* @latch1, align 1, !tbaa !0, !range !3
  %5 = and i8 %4, 1
  %tobool3 = icmp eq i8 %5, 0
  br i1 %tobool3, label %cond.end, label %lor.lhs.false

lor.lhs.false:                                    ; preds = %if.end
  %6 = load volatile i8* @flag1, align 1, !tbaa !0, !range !3
  %7 = and i8 %6, 1
  %tobool4 = icmp eq i8 %7, 0
  br i1 %tobool4, label %cond.false, label %cond.end

cond.false:                                       ; preds = %lor.lhs.false
  tail call void @__assert_fail(i8* getelementptr inbounds ([17 x i8]* @.str, i32 0, i32 0), i8* getelementptr inbounds ([8 x i8]* @.str1, i32 0, i32 0), i32 30, i8* getelementptr inbounds ([23 x i8]* @__PRETTY_FUNCTION__.worker_1, i32 0, i32 0)) noreturn nounwind
  unreachable

cond.end:                                         ; preds = %lor.lhs.false, %if.end
  store volatile i8 0, i8* @latch1, align 1, !tbaa !0
  %8 = load volatile i8* @flag1, align 1, !tbaa !0, !range !3
  %9 = and i8 %8, 1
  %tobool5 = icmp eq i8 %9, 0
  br i1 %tobool5, label %if.end8, label %if.then6

if.then6:                                         ; preds = %cond.end
  store volatile i8 0, i8* @flag1, align 1, !tbaa !0
  store volatile i8 1, i8* @flag2, align 1, !tbaa !0
  fence seq_cst
  store volatile i8 1, i8* @latch2, align 1, !tbaa !0
  br label %if.end8

if.end8:                                          ; preds = %if.then6, %cond.end, %entry
  %j.0 = phi i32 [ 0, %entry ], [ 1, %cond.end ], [ 1, %if.then6 ]
  %10 = load volatile i8* @latch1, align 1, !tbaa !0, !range !3
  %11 = and i8 %10, 1
  %tobool9 = icmp eq i8 %11, 0
  br i1 %tobool9, label %if.then12, label %if.end26

if.then12:                                        ; preds = %if.end8
  %12 = load volatile i8* @latch1, align 1, !tbaa !0, !range !3
  %13 = and i8 %12, 1
  %tobool13 = icmp eq i8 %13, 0
  br i1 %tobool13, label %return, label %if.end15

if.end15:                                         ; preds = %if.then12
  %14 = load volatile i8* @latch1, align 1, !tbaa !0, !range !3
  %15 = and i8 %14, 1
  %tobool16 = icmp eq i8 %15, 0
  br i1 %tobool16, label %cond.end21, label %lor.lhs.false17

lor.lhs.false17:                                  ; preds = %if.end15
  %16 = load volatile i8* @flag1, align 1, !tbaa !0, !range !3
  %17 = and i8 %16, 1
  %tobool18 = icmp eq i8 %17, 0
  br i1 %tobool18, label %cond.false20, label %cond.end21

cond.false20:                                     ; preds = %lor.lhs.false17
  tail call void @__assert_fail(i8* getelementptr inbounds ([17 x i8]* @.str, i32 0, i32 0), i8* getelementptr inbounds ([8 x i8]* @.str1, i32 0, i32 0), i32 44, i8* getelementptr inbounds ([23 x i8]* @__PRETTY_FUNCTION__.worker_1, i32 0, i32 0)) noreturn nounwind
  unreachable

cond.end21:                                       ; preds = %lor.lhs.false17, %if.end15
  store volatile i8 0, i8* @latch1, align 1, !tbaa !0
  %18 = load volatile i8* @flag1, align 1, !tbaa !0, !range !3
  %19 = and i8 %18, 1
  %tobool22 = icmp eq i8 %19, 0
  br i1 %tobool22, label %if.end24, label %if.then23

if.then23:                                        ; preds = %cond.end21
  store volatile i8 0, i8* @flag1, align 1, !tbaa !0
  store volatile i8 1, i8* @flag2, align 1, !tbaa !0
  fence seq_cst
  store volatile i8 1, i8* @latch2, align 1, !tbaa !0
  br label %if.end24

if.end24:                                         ; preds = %cond.end21, %if.then23
  %inc25 = add nsw i32 %j.0, 1
  br label %if.end26

if.end26:                                         ; preds = %if.end8, %if.end24
  %j.1 = phi i32 [ %j.0, %if.end8 ], [ %inc25, %if.end24 ]
  %20 = load volatile i8* @latch1, align 1, !tbaa !0, !range !3
  %21 = and i8 %20, 1
  %tobool27 = icmp eq i8 %21, 0
  %cmp29 = icmp slt i32 %j.1, 4
  %or.cond = and i1 %tobool27, %cmp29
  br i1 %or.cond, label %if.then30, label %if.end44

if.then30:                                        ; preds = %if.end26
  %22 = load volatile i8* @latch1, align 1, !tbaa !0, !range !3
  %23 = and i8 %22, 1
  %tobool31 = icmp eq i8 %23, 0
  br i1 %tobool31, label %return, label %if.end33

if.end33:                                         ; preds = %if.then30
  %24 = load volatile i8* @latch1, align 1, !tbaa !0, !range !3
  %25 = and i8 %24, 1
  %tobool34 = icmp eq i8 %25, 0
  br i1 %tobool34, label %cond.end39, label %lor.lhs.false35

lor.lhs.false35:                                  ; preds = %if.end33
  %26 = load volatile i8* @flag1, align 1, !tbaa !0, !range !3
  %27 = and i8 %26, 1
  %tobool36 = icmp eq i8 %27, 0
  br i1 %tobool36, label %cond.false38, label %cond.end39

cond.false38:                                     ; preds = %lor.lhs.false35
  tail call void @__assert_fail(i8* getelementptr inbounds ([17 x i8]* @.str, i32 0, i32 0), i8* getelementptr inbounds ([8 x i8]* @.str1, i32 0, i32 0), i32 58, i8* getelementptr inbounds ([23 x i8]* @__PRETTY_FUNCTION__.worker_1, i32 0, i32 0)) noreturn nounwind
  unreachable

cond.end39:                                       ; preds = %lor.lhs.false35, %if.end33
  store volatile i8 0, i8* @latch1, align 1, !tbaa !0
  %28 = load volatile i8* @flag1, align 1, !tbaa !0, !range !3
  %29 = and i8 %28, 1
  %tobool40 = icmp eq i8 %29, 0
  br i1 %tobool40, label %if.end42, label %if.then41

if.then41:                                        ; preds = %cond.end39
  store volatile i8 0, i8* @flag1, align 1, !tbaa !0
  store volatile i8 1, i8* @flag2, align 1, !tbaa !0
  fence seq_cst
  store volatile i8 1, i8* @latch2, align 1, !tbaa !0
  br label %if.end42

if.end42:                                         ; preds = %cond.end39, %if.then41
  %inc43 = add nsw i32 %j.1, 1
  br label %if.end44

if.end44:                                         ; preds = %if.end26, %if.end42
  %j.2 = phi i32 [ %j.1, %if.end26 ], [ %inc43, %if.end42 ]
  %30 = load volatile i8* @latch1, align 1, !tbaa !0, !range !3
  %31 = and i8 %30, 1
  %tobool45 = icmp eq i8 %31, 0
  %cmp47 = icmp slt i32 %j.2, 4
  %or.cond282 = and i1 %tobool45, %cmp47
  br i1 %or.cond282, label %if.then48, label %if.end62

if.then48:                                        ; preds = %if.end44
  %32 = load volatile i8* @latch1, align 1, !tbaa !0, !range !3
  %33 = and i8 %32, 1
  %tobool49 = icmp eq i8 %33, 0
  br i1 %tobool49, label %return, label %if.end51

if.end51:                                         ; preds = %if.then48
  %34 = load volatile i8* @latch1, align 1, !tbaa !0, !range !3
  %35 = and i8 %34, 1
  %tobool52 = icmp eq i8 %35, 0
  br i1 %tobool52, label %cond.end57, label %lor.lhs.false53

lor.lhs.false53:                                  ; preds = %if.end51
  %36 = load volatile i8* @flag1, align 1, !tbaa !0, !range !3
  %37 = and i8 %36, 1
  %tobool54 = icmp eq i8 %37, 0
  br i1 %tobool54, label %cond.false56, label %cond.end57

cond.false56:                                     ; preds = %lor.lhs.false53
  tail call void @__assert_fail(i8* getelementptr inbounds ([17 x i8]* @.str, i32 0, i32 0), i8* getelementptr inbounds ([8 x i8]* @.str1, i32 0, i32 0), i32 72, i8* getelementptr inbounds ([23 x i8]* @__PRETTY_FUNCTION__.worker_1, i32 0, i32 0)) noreturn nounwind
  unreachable

cond.end57:                                       ; preds = %lor.lhs.false53, %if.end51
  store volatile i8 0, i8* @latch1, align 1, !tbaa !0
  %38 = load volatile i8* @flag1, align 1, !tbaa !0, !range !3
  %39 = and i8 %38, 1
  %tobool58 = icmp eq i8 %39, 0
  br i1 %tobool58, label %if.end62, label %if.then59

if.then59:                                        ; preds = %cond.end57
  store volatile i8 0, i8* @flag1, align 1, !tbaa !0
  store volatile i8 1, i8* @flag2, align 1, !tbaa !0
  fence seq_cst
  store volatile i8 1, i8* @latch2, align 1, !tbaa !0
  br label %if.end62

if.end62:                                         ; preds = %if.then59, %cond.end57, %if.end44
  %40 = load volatile i8* @latch1, align 1, !tbaa !0, !range !3
  %41 = and i8 %40, 1
  %tobool64 = icmp eq i8 %41, 0
  br i1 %tobool64, label %if.then67, label %if.end81

if.then67:                                        ; preds = %if.end62
  %42 = load volatile i8* @latch1, align 1, !tbaa !0, !range !3
  %43 = and i8 %42, 1
  %tobool68 = icmp eq i8 %43, 0
  br i1 %tobool68, label %return, label %if.end70

if.end70:                                         ; preds = %if.then67
  %44 = load volatile i8* @latch1, align 1, !tbaa !0, !range !3
  %45 = and i8 %44, 1
  %tobool71 = icmp eq i8 %45, 0
  br i1 %tobool71, label %cond.end76, label %lor.lhs.false72

lor.lhs.false72:                                  ; preds = %if.end70
  %46 = load volatile i8* @flag1, align 1, !tbaa !0, !range !3
  %47 = and i8 %46, 1
  %tobool73 = icmp eq i8 %47, 0
  br i1 %tobool73, label %cond.false75, label %cond.end76

cond.false75:                                     ; preds = %lor.lhs.false72
  tail call void @__assert_fail(i8* getelementptr inbounds ([17 x i8]* @.str, i32 0, i32 0), i8* getelementptr inbounds ([8 x i8]* @.str1, i32 0, i32 0), i32 89, i8* getelementptr inbounds ([23 x i8]* @__PRETTY_FUNCTION__.worker_1, i32 0, i32 0)) noreturn nounwind
  unreachable

cond.end76:                                       ; preds = %lor.lhs.false72, %if.end70
  store volatile i8 0, i8* @latch1, align 1, !tbaa !0
  %48 = load volatile i8* @flag1, align 1, !tbaa !0, !range !3
  %49 = and i8 %48, 1
  %tobool77 = icmp eq i8 %49, 0
  br i1 %tobool77, label %if.end81, label %if.then78

if.then78:                                        ; preds = %cond.end76
  store volatile i8 0, i8* @flag1, align 1, !tbaa !0
  store volatile i8 1, i8* @flag2, align 1, !tbaa !0
  fence seq_cst
  store volatile i8 1, i8* @latch2, align 1, !tbaa !0
  br label %if.end81

if.end81:                                         ; preds = %if.then78, %cond.end76, %if.end62
  %j.3 = phi i32 [ 0, %if.end62 ], [ 1, %cond.end76 ], [ 1, %if.then78 ]
  %50 = load volatile i8* @latch1, align 1, !tbaa !0, !range !3
  %51 = and i8 %50, 1
  %tobool82 = icmp eq i8 %51, 0
  br i1 %tobool82, label %if.then85, label %if.end99

if.then85:                                        ; preds = %if.end81
  %52 = load volatile i8* @latch1, align 1, !tbaa !0, !range !3
  %53 = and i8 %52, 1
  %tobool86 = icmp eq i8 %53, 0
  br i1 %tobool86, label %return, label %if.end88

if.end88:                                         ; preds = %if.then85
  %54 = load volatile i8* @latch1, align 1, !tbaa !0, !range !3
  %55 = and i8 %54, 1
  %tobool89 = icmp eq i8 %55, 0
  br i1 %tobool89, label %cond.end94, label %lor.lhs.false90

lor.lhs.false90:                                  ; preds = %if.end88
  %56 = load volatile i8* @flag1, align 1, !tbaa !0, !range !3
  %57 = and i8 %56, 1
  %tobool91 = icmp eq i8 %57, 0
  br i1 %tobool91, label %cond.false93, label %cond.end94

cond.false93:                                     ; preds = %lor.lhs.false90
  tail call void @__assert_fail(i8* getelementptr inbounds ([17 x i8]* @.str, i32 0, i32 0), i8* getelementptr inbounds ([8 x i8]* @.str1, i32 0, i32 0), i32 103, i8* getelementptr inbounds ([23 x i8]* @__PRETTY_FUNCTION__.worker_1, i32 0, i32 0)) noreturn nounwind
  unreachable

cond.end94:                                       ; preds = %lor.lhs.false90, %if.end88
  store volatile i8 0, i8* @latch1, align 1, !tbaa !0
  %58 = load volatile i8* @flag1, align 1, !tbaa !0, !range !3
  %59 = and i8 %58, 1
  %tobool95 = icmp eq i8 %59, 0
  br i1 %tobool95, label %if.end97, label %if.then96

if.then96:                                        ; preds = %cond.end94
  store volatile i8 0, i8* @flag1, align 1, !tbaa !0
  store volatile i8 1, i8* @flag2, align 1, !tbaa !0
  fence seq_cst
  store volatile i8 1, i8* @latch2, align 1, !tbaa !0
  br label %if.end97

if.end97:                                         ; preds = %cond.end94, %if.then96
  %inc98 = add nsw i32 %j.3, 1
  br label %if.end99

if.end99:                                         ; preds = %if.end81, %if.end97
  %j.4 = phi i32 [ %j.3, %if.end81 ], [ %inc98, %if.end97 ]
  %60 = load volatile i8* @latch1, align 1, !tbaa !0, !range !3
  %61 = and i8 %60, 1
  %tobool100 = icmp eq i8 %61, 0
  %cmp102 = icmp slt i32 %j.4, 4
  %or.cond283 = and i1 %tobool100, %cmp102
  br i1 %or.cond283, label %if.then103, label %if.end117

if.then103:                                       ; preds = %if.end99
  %62 = load volatile i8* @latch1, align 1, !tbaa !0, !range !3
  %63 = and i8 %62, 1
  %tobool104 = icmp eq i8 %63, 0
  br i1 %tobool104, label %return, label %if.end106

if.end106:                                        ; preds = %if.then103
  %64 = load volatile i8* @latch1, align 1, !tbaa !0, !range !3
  %65 = and i8 %64, 1
  %tobool107 = icmp eq i8 %65, 0
  br i1 %tobool107, label %cond.end112, label %lor.lhs.false108

lor.lhs.false108:                                 ; preds = %if.end106
  %66 = load volatile i8* @flag1, align 1, !tbaa !0, !range !3
  %67 = and i8 %66, 1
  %tobool109 = icmp eq i8 %67, 0
  br i1 %tobool109, label %cond.false111, label %cond.end112

cond.false111:                                    ; preds = %lor.lhs.false108
  tail call void @__assert_fail(i8* getelementptr inbounds ([17 x i8]* @.str, i32 0, i32 0), i8* getelementptr inbounds ([8 x i8]* @.str1, i32 0, i32 0), i32 117, i8* getelementptr inbounds ([23 x i8]* @__PRETTY_FUNCTION__.worker_1, i32 0, i32 0)) noreturn nounwind
  unreachable

cond.end112:                                      ; preds = %lor.lhs.false108, %if.end106
  store volatile i8 0, i8* @latch1, align 1, !tbaa !0
  %68 = load volatile i8* @flag1, align 1, !tbaa !0, !range !3
  %69 = and i8 %68, 1
  %tobool113 = icmp eq i8 %69, 0
  br i1 %tobool113, label %if.end115, label %if.then114

if.then114:                                       ; preds = %cond.end112
  store volatile i8 0, i8* @flag1, align 1, !tbaa !0
  store volatile i8 1, i8* @flag2, align 1, !tbaa !0
  fence seq_cst
  store volatile i8 1, i8* @latch2, align 1, !tbaa !0
  br label %if.end115

if.end115:                                        ; preds = %cond.end112, %if.then114
  %inc116 = add nsw i32 %j.4, 1
  br label %if.end117

if.end117:                                        ; preds = %if.end99, %if.end115
  %j.5 = phi i32 [ %j.4, %if.end99 ], [ %inc116, %if.end115 ]
  %70 = load volatile i8* @latch1, align 1, !tbaa !0, !range !3
  %71 = and i8 %70, 1
  %tobool118 = icmp eq i8 %71, 0
  %cmp120 = icmp slt i32 %j.5, 4
  %or.cond284 = and i1 %tobool118, %cmp120
  br i1 %or.cond284, label %if.then121, label %if.end135

if.then121:                                       ; preds = %if.end117
  %72 = load volatile i8* @latch1, align 1, !tbaa !0, !range !3
  %73 = and i8 %72, 1
  %tobool122 = icmp eq i8 %73, 0
  br i1 %tobool122, label %return, label %if.end124

if.end124:                                        ; preds = %if.then121
  %74 = load volatile i8* @latch1, align 1, !tbaa !0, !range !3
  %75 = and i8 %74, 1
  %tobool125 = icmp eq i8 %75, 0
  br i1 %tobool125, label %cond.end130, label %lor.lhs.false126

lor.lhs.false126:                                 ; preds = %if.end124
  %76 = load volatile i8* @flag1, align 1, !tbaa !0, !range !3
  %77 = and i8 %76, 1
  %tobool127 = icmp eq i8 %77, 0
  br i1 %tobool127, label %cond.false129, label %cond.end130

cond.false129:                                    ; preds = %lor.lhs.false126
  tail call void @__assert_fail(i8* getelementptr inbounds ([17 x i8]* @.str, i32 0, i32 0), i8* getelementptr inbounds ([8 x i8]* @.str1, i32 0, i32 0), i32 131, i8* getelementptr inbounds ([23 x i8]* @__PRETTY_FUNCTION__.worker_1, i32 0, i32 0)) noreturn nounwind
  unreachable

cond.end130:                                      ; preds = %lor.lhs.false126, %if.end124
  store volatile i8 0, i8* @latch1, align 1, !tbaa !0
  %78 = load volatile i8* @flag1, align 1, !tbaa !0, !range !3
  %79 = and i8 %78, 1
  %tobool131 = icmp eq i8 %79, 0
  br i1 %tobool131, label %if.end135, label %if.then132

if.then132:                                       ; preds = %cond.end130
  store volatile i8 0, i8* @flag1, align 1, !tbaa !0
  store volatile i8 1, i8* @flag2, align 1, !tbaa !0
  fence seq_cst
  store volatile i8 1, i8* @latch2, align 1, !tbaa !0
  br label %if.end135

if.end135:                                        ; preds = %if.then132, %cond.end130, %if.end117
  %80 = load volatile i8* @latch1, align 1, !tbaa !0, !range !3
  %81 = and i8 %80, 1
  %tobool137 = icmp eq i8 %81, 0
  br i1 %tobool137, label %if.then140, label %if.end154

if.then140:                                       ; preds = %if.end135
  %82 = load volatile i8* @latch1, align 1, !tbaa !0, !range !3
  %83 = and i8 %82, 1
  %tobool141 = icmp eq i8 %83, 0
  br i1 %tobool141, label %return, label %if.end143

if.end143:                                        ; preds = %if.then140
  %84 = load volatile i8* @latch1, align 1, !tbaa !0, !range !3
  %85 = and i8 %84, 1
  %tobool144 = icmp eq i8 %85, 0
  br i1 %tobool144, label %cond.end149, label %lor.lhs.false145

lor.lhs.false145:                                 ; preds = %if.end143
  %86 = load volatile i8* @flag1, align 1, !tbaa !0, !range !3
  %87 = and i8 %86, 1
  %tobool146 = icmp eq i8 %87, 0
  br i1 %tobool146, label %cond.false148, label %cond.end149

cond.false148:                                    ; preds = %lor.lhs.false145
  tail call void @__assert_fail(i8* getelementptr inbounds ([17 x i8]* @.str, i32 0, i32 0), i8* getelementptr inbounds ([8 x i8]* @.str1, i32 0, i32 0), i32 148, i8* getelementptr inbounds ([23 x i8]* @__PRETTY_FUNCTION__.worker_1, i32 0, i32 0)) noreturn nounwind
  unreachable

cond.end149:                                      ; preds = %lor.lhs.false145, %if.end143
  store volatile i8 0, i8* @latch1, align 1, !tbaa !0
  %88 = load volatile i8* @flag1, align 1, !tbaa !0, !range !3
  %89 = and i8 %88, 1
  %tobool150 = icmp eq i8 %89, 0
  br i1 %tobool150, label %if.end154, label %if.then151

if.then151:                                       ; preds = %cond.end149
  store volatile i8 0, i8* @flag1, align 1, !tbaa !0
  store volatile i8 1, i8* @flag2, align 1, !tbaa !0
  fence seq_cst
  store volatile i8 1, i8* @latch2, align 1, !tbaa !0
  br label %if.end154

if.end154:                                        ; preds = %if.then151, %cond.end149, %if.end135
  %j.6 = phi i32 [ 0, %if.end135 ], [ 1, %cond.end149 ], [ 1, %if.then151 ]
  %90 = load volatile i8* @latch1, align 1, !tbaa !0, !range !3
  %91 = and i8 %90, 1
  %tobool155 = icmp eq i8 %91, 0
  br i1 %tobool155, label %if.then158, label %if.end172

if.then158:                                       ; preds = %if.end154
  %92 = load volatile i8* @latch1, align 1, !tbaa !0, !range !3
  %93 = and i8 %92, 1
  %tobool159 = icmp eq i8 %93, 0
  br i1 %tobool159, label %return, label %if.end161

if.end161:                                        ; preds = %if.then158
  %94 = load volatile i8* @latch1, align 1, !tbaa !0, !range !3
  %95 = and i8 %94, 1
  %tobool162 = icmp eq i8 %95, 0
  br i1 %tobool162, label %cond.end167, label %lor.lhs.false163

lor.lhs.false163:                                 ; preds = %if.end161
  %96 = load volatile i8* @flag1, align 1, !tbaa !0, !range !3
  %97 = and i8 %96, 1
  %tobool164 = icmp eq i8 %97, 0
  br i1 %tobool164, label %cond.false166, label %cond.end167

cond.false166:                                    ; preds = %lor.lhs.false163
  tail call void @__assert_fail(i8* getelementptr inbounds ([17 x i8]* @.str, i32 0, i32 0), i8* getelementptr inbounds ([8 x i8]* @.str1, i32 0, i32 0), i32 162, i8* getelementptr inbounds ([23 x i8]* @__PRETTY_FUNCTION__.worker_1, i32 0, i32 0)) noreturn nounwind
  unreachable

cond.end167:                                      ; preds = %lor.lhs.false163, %if.end161
  store volatile i8 0, i8* @latch1, align 1, !tbaa !0
  %98 = load volatile i8* @flag1, align 1, !tbaa !0, !range !3
  %99 = and i8 %98, 1
  %tobool168 = icmp eq i8 %99, 0
  br i1 %tobool168, label %if.end170, label %if.then169

if.then169:                                       ; preds = %cond.end167
  store volatile i8 0, i8* @flag1, align 1, !tbaa !0
  store volatile i8 1, i8* @flag2, align 1, !tbaa !0
  fence seq_cst
  store volatile i8 1, i8* @latch2, align 1, !tbaa !0
  br label %if.end170

if.end170:                                        ; preds = %cond.end167, %if.then169
  %inc171 = add nsw i32 %j.6, 1
  br label %if.end172

if.end172:                                        ; preds = %if.end154, %if.end170
  %j.7 = phi i32 [ %j.6, %if.end154 ], [ %inc171, %if.end170 ]
  %100 = load volatile i8* @latch1, align 1, !tbaa !0, !range !3
  %101 = and i8 %100, 1
  %tobool173 = icmp eq i8 %101, 0
  %cmp175 = icmp slt i32 %j.7, 4
  %or.cond285 = and i1 %tobool173, %cmp175
  br i1 %or.cond285, label %if.then176, label %if.end190

if.then176:                                       ; preds = %if.end172
  %102 = load volatile i8* @latch1, align 1, !tbaa !0, !range !3
  %103 = and i8 %102, 1
  %tobool177 = icmp eq i8 %103, 0
  br i1 %tobool177, label %return, label %if.end179

if.end179:                                        ; preds = %if.then176
  %104 = load volatile i8* @latch1, align 1, !tbaa !0, !range !3
  %105 = and i8 %104, 1
  %tobool180 = icmp eq i8 %105, 0
  br i1 %tobool180, label %cond.end185, label %lor.lhs.false181

lor.lhs.false181:                                 ; preds = %if.end179
  %106 = load volatile i8* @flag1, align 1, !tbaa !0, !range !3
  %107 = and i8 %106, 1
  %tobool182 = icmp eq i8 %107, 0
  br i1 %tobool182, label %cond.false184, label %cond.end185

cond.false184:                                    ; preds = %lor.lhs.false181
  tail call void @__assert_fail(i8* getelementptr inbounds ([17 x i8]* @.str, i32 0, i32 0), i8* getelementptr inbounds ([8 x i8]* @.str1, i32 0, i32 0), i32 176, i8* getelementptr inbounds ([23 x i8]* @__PRETTY_FUNCTION__.worker_1, i32 0, i32 0)) noreturn nounwind
  unreachable

cond.end185:                                      ; preds = %lor.lhs.false181, %if.end179
  store volatile i8 0, i8* @latch1, align 1, !tbaa !0
  %108 = load volatile i8* @flag1, align 1, !tbaa !0, !range !3
  %109 = and i8 %108, 1
  %tobool186 = icmp eq i8 %109, 0
  br i1 %tobool186, label %if.end188, label %if.then187

if.then187:                                       ; preds = %cond.end185
  store volatile i8 0, i8* @flag1, align 1, !tbaa !0
  store volatile i8 1, i8* @flag2, align 1, !tbaa !0
  fence seq_cst
  store volatile i8 1, i8* @latch2, align 1, !tbaa !0
  br label %if.end188

if.end188:                                        ; preds = %cond.end185, %if.then187
  %inc189 = add nsw i32 %j.7, 1
  br label %if.end190

if.end190:                                        ; preds = %if.end172, %if.end188
  %j.8 = phi i32 [ %j.7, %if.end172 ], [ %inc189, %if.end188 ]
  %110 = load volatile i8* @latch1, align 1, !tbaa !0, !range !3
  %111 = and i8 %110, 1
  %tobool191 = icmp eq i8 %111, 0
  %cmp193 = icmp slt i32 %j.8, 4
  %or.cond286 = and i1 %tobool191, %cmp193
  br i1 %or.cond286, label %if.then194, label %if.end208

if.then194:                                       ; preds = %if.end190
  %112 = load volatile i8* @latch1, align 1, !tbaa !0, !range !3
  %113 = and i8 %112, 1
  %tobool195 = icmp eq i8 %113, 0
  br i1 %tobool195, label %return, label %if.end197

if.end197:                                        ; preds = %if.then194
  %114 = load volatile i8* @latch1, align 1, !tbaa !0, !range !3
  %115 = and i8 %114, 1
  %tobool198 = icmp eq i8 %115, 0
  br i1 %tobool198, label %cond.end203, label %lor.lhs.false199

lor.lhs.false199:                                 ; preds = %if.end197
  %116 = load volatile i8* @flag1, align 1, !tbaa !0, !range !3
  %117 = and i8 %116, 1
  %tobool200 = icmp eq i8 %117, 0
  br i1 %tobool200, label %cond.false202, label %cond.end203

cond.false202:                                    ; preds = %lor.lhs.false199
  tail call void @__assert_fail(i8* getelementptr inbounds ([17 x i8]* @.str, i32 0, i32 0), i8* getelementptr inbounds ([8 x i8]* @.str1, i32 0, i32 0), i32 190, i8* getelementptr inbounds ([23 x i8]* @__PRETTY_FUNCTION__.worker_1, i32 0, i32 0)) noreturn nounwind
  unreachable

cond.end203:                                      ; preds = %lor.lhs.false199, %if.end197
  store volatile i8 0, i8* @latch1, align 1, !tbaa !0
  %118 = load volatile i8* @flag1, align 1, !tbaa !0, !range !3
  %119 = and i8 %118, 1
  %tobool204 = icmp eq i8 %119, 0
  br i1 %tobool204, label %if.end208, label %if.then205

if.then205:                                       ; preds = %cond.end203
  store volatile i8 0, i8* @flag1, align 1, !tbaa !0
  store volatile i8 1, i8* @flag2, align 1, !tbaa !0
  fence seq_cst
  store volatile i8 1, i8* @latch2, align 1, !tbaa !0
  br label %if.end208

if.end208:                                        ; preds = %if.then205, %cond.end203, %if.end190
  %120 = load volatile i8* @latch1, align 1, !tbaa !0, !range !3
  %121 = and i8 %120, 1
  %tobool210 = icmp eq i8 %121, 0
  br i1 %tobool210, label %if.then213, label %if.end227

if.then213:                                       ; preds = %if.end208
  %122 = load volatile i8* @latch1, align 1, !tbaa !0, !range !3
  %123 = and i8 %122, 1
  %tobool214 = icmp eq i8 %123, 0
  br i1 %tobool214, label %return, label %if.end216

if.end216:                                        ; preds = %if.then213
  %124 = load volatile i8* @latch1, align 1, !tbaa !0, !range !3
  %125 = and i8 %124, 1
  %tobool217 = icmp eq i8 %125, 0
  br i1 %tobool217, label %cond.end222, label %lor.lhs.false218

lor.lhs.false218:                                 ; preds = %if.end216
  %126 = load volatile i8* @flag1, align 1, !tbaa !0, !range !3
  %127 = and i8 %126, 1
  %tobool219 = icmp eq i8 %127, 0
  br i1 %tobool219, label %cond.false221, label %cond.end222

cond.false221:                                    ; preds = %lor.lhs.false218
  tail call void @__assert_fail(i8* getelementptr inbounds ([17 x i8]* @.str, i32 0, i32 0), i8* getelementptr inbounds ([8 x i8]* @.str1, i32 0, i32 0), i32 206, i8* getelementptr inbounds ([23 x i8]* @__PRETTY_FUNCTION__.worker_1, i32 0, i32 0)) noreturn nounwind
  unreachable

cond.end222:                                      ; preds = %lor.lhs.false218, %if.end216
  store volatile i8 0, i8* @latch1, align 1, !tbaa !0
  %128 = load volatile i8* @flag1, align 1, !tbaa !0, !range !3
  %129 = and i8 %128, 1
  %tobool223 = icmp eq i8 %129, 0
  br i1 %tobool223, label %if.end227, label %if.then224

if.then224:                                       ; preds = %cond.end222
  store volatile i8 0, i8* @flag1, align 1, !tbaa !0
  store volatile i8 1, i8* @flag2, align 1, !tbaa !0
  fence seq_cst
  store volatile i8 1, i8* @latch2, align 1, !tbaa !0
  br label %if.end227

if.end227:                                        ; preds = %if.then224, %cond.end222, %if.end208
  %j.9 = phi i32 [ 0, %if.end208 ], [ 1, %cond.end222 ], [ 1, %if.then224 ]
  %130 = load volatile i8* @latch1, align 1, !tbaa !0, !range !3
  %131 = and i8 %130, 1
  %tobool228 = icmp eq i8 %131, 0
  br i1 %tobool228, label %if.then231, label %if.end245

if.then231:                                       ; preds = %if.end227
  %132 = load volatile i8* @latch1, align 1, !tbaa !0, !range !3
  %133 = and i8 %132, 1
  %tobool232 = icmp eq i8 %133, 0
  br i1 %tobool232, label %return, label %if.end234

if.end234:                                        ; preds = %if.then231
  %134 = load volatile i8* @latch1, align 1, !tbaa !0, !range !3
  %135 = and i8 %134, 1
  %tobool235 = icmp eq i8 %135, 0
  br i1 %tobool235, label %cond.end240, label %lor.lhs.false236

lor.lhs.false236:                                 ; preds = %if.end234
  %136 = load volatile i8* @flag1, align 1, !tbaa !0, !range !3
  %137 = and i8 %136, 1
  %tobool237 = icmp eq i8 %137, 0
  br i1 %tobool237, label %cond.false239, label %cond.end240

cond.false239:                                    ; preds = %lor.lhs.false236
  tail call void @__assert_fail(i8* getelementptr inbounds ([17 x i8]* @.str, i32 0, i32 0), i8* getelementptr inbounds ([8 x i8]* @.str1, i32 0, i32 0), i32 220, i8* getelementptr inbounds ([23 x i8]* @__PRETTY_FUNCTION__.worker_1, i32 0, i32 0)) noreturn nounwind
  unreachable

cond.end240:                                      ; preds = %lor.lhs.false236, %if.end234
  store volatile i8 0, i8* @latch1, align 1, !tbaa !0
  %138 = load volatile i8* @flag1, align 1, !tbaa !0, !range !3
  %139 = and i8 %138, 1
  %tobool241 = icmp eq i8 %139, 0
  br i1 %tobool241, label %if.end243, label %if.then242

if.then242:                                       ; preds = %cond.end240
  store volatile i8 0, i8* @flag1, align 1, !tbaa !0
  store volatile i8 1, i8* @flag2, align 1, !tbaa !0
  fence seq_cst
  store volatile i8 1, i8* @latch2, align 1, !tbaa !0
  br label %if.end243

if.end243:                                        ; preds = %cond.end240, %if.then242
  %inc244 = add nsw i32 %j.9, 1
  br label %if.end245

if.end245:                                        ; preds = %if.end227, %if.end243
  %j.10 = phi i32 [ %j.9, %if.end227 ], [ %inc244, %if.end243 ]
  %140 = load volatile i8* @latch1, align 1, !tbaa !0, !range !3
  %141 = and i8 %140, 1
  %tobool246 = icmp eq i8 %141, 0
  %cmp248 = icmp slt i32 %j.10, 4
  %or.cond287 = and i1 %tobool246, %cmp248
  br i1 %or.cond287, label %if.then249, label %if.end263

if.then249:                                       ; preds = %if.end245
  %142 = load volatile i8* @latch1, align 1, !tbaa !0, !range !3
  %143 = and i8 %142, 1
  %tobool250 = icmp eq i8 %143, 0
  br i1 %tobool250, label %return, label %if.end252

if.end252:                                        ; preds = %if.then249
  %144 = load volatile i8* @latch1, align 1, !tbaa !0, !range !3
  %145 = and i8 %144, 1
  %tobool253 = icmp eq i8 %145, 0
  br i1 %tobool253, label %cond.end258, label %lor.lhs.false254

lor.lhs.false254:                                 ; preds = %if.end252
  %146 = load volatile i8* @flag1, align 1, !tbaa !0, !range !3
  %147 = and i8 %146, 1
  %tobool255 = icmp eq i8 %147, 0
  br i1 %tobool255, label %cond.false257, label %cond.end258

cond.false257:                                    ; preds = %lor.lhs.false254
  tail call void @__assert_fail(i8* getelementptr inbounds ([17 x i8]* @.str, i32 0, i32 0), i8* getelementptr inbounds ([8 x i8]* @.str1, i32 0, i32 0), i32 234, i8* getelementptr inbounds ([23 x i8]* @__PRETTY_FUNCTION__.worker_1, i32 0, i32 0)) noreturn nounwind
  unreachable

cond.end258:                                      ; preds = %lor.lhs.false254, %if.end252
  store volatile i8 0, i8* @latch1, align 1, !tbaa !0
  %148 = load volatile i8* @flag1, align 1, !tbaa !0, !range !3
  %149 = and i8 %148, 1
  %tobool259 = icmp eq i8 %149, 0
  br i1 %tobool259, label %if.end261, label %if.then260

if.then260:                                       ; preds = %cond.end258
  store volatile i8 0, i8* @flag1, align 1, !tbaa !0
  store volatile i8 1, i8* @flag2, align 1, !tbaa !0
  fence seq_cst
  store volatile i8 1, i8* @latch2, align 1, !tbaa !0
  br label %if.end261

if.end261:                                        ; preds = %cond.end258, %if.then260
  %inc262 = add nsw i32 %j.10, 1
  br label %if.end263

if.end263:                                        ; preds = %if.end245, %if.end261
  %j.11 = phi i32 [ %j.10, %if.end245 ], [ %inc262, %if.end261 ]
  %150 = load volatile i8* @latch1, align 1, !tbaa !0, !range !3
  %151 = and i8 %150, 1
  %tobool264 = icmp eq i8 %151, 0
  %cmp266 = icmp slt i32 %j.11, 4
  %or.cond288 = and i1 %tobool264, %cmp266
  br i1 %or.cond288, label %if.then267, label %return

if.then267:                                       ; preds = %if.end263
  %152 = load volatile i8* @latch1, align 1, !tbaa !0, !range !3
  %153 = and i8 %152, 1
  %tobool268 = icmp eq i8 %153, 0
  br i1 %tobool268, label %return, label %if.end270

if.end270:                                        ; preds = %if.then267
  %154 = load volatile i8* @latch1, align 1, !tbaa !0, !range !3
  %155 = and i8 %154, 1
  %tobool271 = icmp eq i8 %155, 0
  br i1 %tobool271, label %cond.end276, label %lor.lhs.false272

lor.lhs.false272:                                 ; preds = %if.end270
  %156 = load volatile i8* @flag1, align 1, !tbaa !0, !range !3
  %157 = and i8 %156, 1
  %tobool273 = icmp eq i8 %157, 0
  br i1 %tobool273, label %cond.false275, label %cond.end276

cond.false275:                                    ; preds = %lor.lhs.false272
  tail call void @__assert_fail(i8* getelementptr inbounds ([17 x i8]* @.str, i32 0, i32 0), i8* getelementptr inbounds ([8 x i8]* @.str1, i32 0, i32 0), i32 248, i8* getelementptr inbounds ([23 x i8]* @__PRETTY_FUNCTION__.worker_1, i32 0, i32 0)) noreturn nounwind
  unreachable

cond.end276:                                      ; preds = %lor.lhs.false272, %if.end270
  store volatile i8 0, i8* @latch1, align 1, !tbaa !0
  %158 = load volatile i8* @flag1, align 1, !tbaa !0, !range !3
  %159 = and i8 %158, 1
  %tobool277 = icmp eq i8 %159, 0
  br i1 %tobool277, label %return, label %if.then278

if.then278:                                       ; preds = %cond.end276
  store volatile i8 0, i8* @flag1, align 1, !tbaa !0
  store volatile i8 1, i8* @flag2, align 1, !tbaa !0
  fence seq_cst
  store volatile i8 1, i8* @latch2, align 1, !tbaa !0
  br label %return

return:                                           ; preds = %if.end263, %cond.end276, %if.then278, %if.then267, %if.then249, %if.then231, %if.then213, %if.then194, %if.then176, %if.then158, %if.then140, %if.then121, %if.then103, %if.then85, %if.then67, %if.then48, %if.then30, %if.then12, %if.then
  ret i8* null
}

declare void @__assert_fail(i8*, i8*, i32, i8*) noreturn nounwind

define noalias i8* @worker_2(i8* nocapture %arg) nounwind {
entry:
  %0 = load volatile i8* @latch2, align 1, !tbaa !0, !range !3
  %1 = and i8 %0, 1
  %tobool = icmp eq i8 %1, 0
  br i1 %tobool, label %if.then, label %if.end8

if.then:                                          ; preds = %entry
  %2 = load volatile i8* @latch2, align 1, !tbaa !0, !range !3
  %3 = and i8 %2, 1
  %tobool1 = icmp eq i8 %3, 0
  br i1 %tobool1, label %return, label %if.end

if.end:                                           ; preds = %if.then
  %4 = load volatile i8* @latch2, align 1, !tbaa !0, !range !3
  %5 = and i8 %4, 1
  %tobool3 = icmp eq i8 %5, 0
  br i1 %tobool3, label %cond.end, label %lor.lhs.false

lor.lhs.false:                                    ; preds = %if.end
  %6 = load volatile i8* @flag2, align 1, !tbaa !0, !range !3
  %7 = and i8 %6, 1
  %tobool4 = icmp eq i8 %7, 0
  br i1 %tobool4, label %cond.false, label %cond.end

cond.false:                                       ; preds = %lor.lhs.false
  tail call void @__assert_fail(i8* getelementptr inbounds ([17 x i8]* @.str2, i32 0, i32 0), i8* getelementptr inbounds ([8 x i8]* @.str1, i32 0, i32 0), i32 267, i8* getelementptr inbounds ([23 x i8]* @__PRETTY_FUNCTION__.worker_2, i32 0, i32 0)) noreturn nounwind
  unreachable

cond.end:                                         ; preds = %lor.lhs.false, %if.end
  store volatile i8 0, i8* @latch2, align 1, !tbaa !0
  %8 = load volatile i8* @flag2, align 1, !tbaa !0, !range !3
  %9 = and i8 %8, 1
  %tobool5 = icmp eq i8 %9, 0
  br i1 %tobool5, label %if.end8, label %if.then6

if.then6:                                         ; preds = %cond.end
  store volatile i8 0, i8* @flag2, align 1, !tbaa !0
  store volatile i8 1, i8* @flag1, align 1, !tbaa !0
  fence seq_cst
  store volatile i8 1, i8* @latch1, align 1, !tbaa !0
  br label %if.end8

if.end8:                                          ; preds = %if.then6, %cond.end, %entry
  %j.0 = phi i32 [ 0, %entry ], [ 1, %cond.end ], [ 1, %if.then6 ]
  %10 = load volatile i8* @latch2, align 1, !tbaa !0, !range !3
  %11 = and i8 %10, 1
  %tobool9 = icmp eq i8 %11, 0
  br i1 %tobool9, label %if.then12, label %if.end26

if.then12:                                        ; preds = %if.end8
  %12 = load volatile i8* @latch2, align 1, !tbaa !0, !range !3
  %13 = and i8 %12, 1
  %tobool13 = icmp eq i8 %13, 0
  br i1 %tobool13, label %return, label %if.end15

if.end15:                                         ; preds = %if.then12
  %14 = load volatile i8* @latch2, align 1, !tbaa !0, !range !3
  %15 = and i8 %14, 1
  %tobool16 = icmp eq i8 %15, 0
  br i1 %tobool16, label %cond.end21, label %lor.lhs.false17

lor.lhs.false17:                                  ; preds = %if.end15
  %16 = load volatile i8* @flag2, align 1, !tbaa !0, !range !3
  %17 = and i8 %16, 1
  %tobool18 = icmp eq i8 %17, 0
  br i1 %tobool18, label %cond.false20, label %cond.end21

cond.false20:                                     ; preds = %lor.lhs.false17
  tail call void @__assert_fail(i8* getelementptr inbounds ([17 x i8]* @.str2, i32 0, i32 0), i8* getelementptr inbounds ([8 x i8]* @.str1, i32 0, i32 0), i32 280, i8* getelementptr inbounds ([23 x i8]* @__PRETTY_FUNCTION__.worker_2, i32 0, i32 0)) noreturn nounwind
  unreachable

cond.end21:                                       ; preds = %lor.lhs.false17, %if.end15
  store volatile i8 0, i8* @latch2, align 1, !tbaa !0
  %18 = load volatile i8* @flag2, align 1, !tbaa !0, !range !3
  %19 = and i8 %18, 1
  %tobool22 = icmp eq i8 %19, 0
  br i1 %tobool22, label %if.end24, label %if.then23

if.then23:                                        ; preds = %cond.end21
  store volatile i8 0, i8* @flag2, align 1, !tbaa !0
  store volatile i8 1, i8* @flag1, align 1, !tbaa !0
  fence seq_cst
  store volatile i8 1, i8* @latch1, align 1, !tbaa !0
  br label %if.end24

if.end24:                                         ; preds = %cond.end21, %if.then23
  %inc25 = add nsw i32 %j.0, 1
  br label %if.end26

if.end26:                                         ; preds = %if.end8, %if.end24
  %j.1 = phi i32 [ %j.0, %if.end8 ], [ %inc25, %if.end24 ]
  %20 = load volatile i8* @latch2, align 1, !tbaa !0, !range !3
  %21 = and i8 %20, 1
  %tobool27 = icmp eq i8 %21, 0
  %cmp29 = icmp slt i32 %j.1, 4
  %or.cond = and i1 %tobool27, %cmp29
  br i1 %or.cond, label %if.then30, label %if.end44

if.then30:                                        ; preds = %if.end26
  %22 = load volatile i8* @latch2, align 1, !tbaa !0, !range !3
  %23 = and i8 %22, 1
  %tobool31 = icmp eq i8 %23, 0
  br i1 %tobool31, label %return, label %if.end33

if.end33:                                         ; preds = %if.then30
  %24 = load volatile i8* @latch2, align 1, !tbaa !0, !range !3
  %25 = and i8 %24, 1
  %tobool34 = icmp eq i8 %25, 0
  br i1 %tobool34, label %cond.end39, label %lor.lhs.false35

lor.lhs.false35:                                  ; preds = %if.end33
  %26 = load volatile i8* @flag2, align 1, !tbaa !0, !range !3
  %27 = and i8 %26, 1
  %tobool36 = icmp eq i8 %27, 0
  br i1 %tobool36, label %cond.false38, label %cond.end39

cond.false38:                                     ; preds = %lor.lhs.false35
  tail call void @__assert_fail(i8* getelementptr inbounds ([17 x i8]* @.str2, i32 0, i32 0), i8* getelementptr inbounds ([8 x i8]* @.str1, i32 0, i32 0), i32 292, i8* getelementptr inbounds ([23 x i8]* @__PRETTY_FUNCTION__.worker_2, i32 0, i32 0)) noreturn nounwind
  unreachable

cond.end39:                                       ; preds = %lor.lhs.false35, %if.end33
  store volatile i8 0, i8* @latch2, align 1, !tbaa !0
  %28 = load volatile i8* @flag2, align 1, !tbaa !0, !range !3
  %29 = and i8 %28, 1
  %tobool40 = icmp eq i8 %29, 0
  br i1 %tobool40, label %if.end42, label %if.then41

if.then41:                                        ; preds = %cond.end39
  store volatile i8 0, i8* @flag2, align 1, !tbaa !0
  store volatile i8 1, i8* @flag1, align 1, !tbaa !0
  fence seq_cst
  store volatile i8 1, i8* @latch1, align 1, !tbaa !0
  br label %if.end42

if.end42:                                         ; preds = %cond.end39, %if.then41
  %inc43 = add nsw i32 %j.1, 1
  br label %if.end44

if.end44:                                         ; preds = %if.end26, %if.end42
  %j.2 = phi i32 [ %j.1, %if.end26 ], [ %inc43, %if.end42 ]
  %30 = load volatile i8* @latch2, align 1, !tbaa !0, !range !3
  %31 = and i8 %30, 1
  %tobool45 = icmp eq i8 %31, 0
  %cmp47 = icmp slt i32 %j.2, 4
  %or.cond282 = and i1 %tobool45, %cmp47
  br i1 %or.cond282, label %if.then48, label %if.end62

if.then48:                                        ; preds = %if.end44
  %32 = load volatile i8* @latch2, align 1, !tbaa !0, !range !3
  %33 = and i8 %32, 1
  %tobool49 = icmp eq i8 %33, 0
  br i1 %tobool49, label %return, label %if.end51

if.end51:                                         ; preds = %if.then48
  %34 = load volatile i8* @latch2, align 1, !tbaa !0, !range !3
  %35 = and i8 %34, 1
  %tobool52 = icmp eq i8 %35, 0
  br i1 %tobool52, label %cond.end57, label %lor.lhs.false53

lor.lhs.false53:                                  ; preds = %if.end51
  %36 = load volatile i8* @flag2, align 1, !tbaa !0, !range !3
  %37 = and i8 %36, 1
  %tobool54 = icmp eq i8 %37, 0
  br i1 %tobool54, label %cond.false56, label %cond.end57

cond.false56:                                     ; preds = %lor.lhs.false53
  tail call void @__assert_fail(i8* getelementptr inbounds ([17 x i8]* @.str2, i32 0, i32 0), i8* getelementptr inbounds ([8 x i8]* @.str1, i32 0, i32 0), i32 304, i8* getelementptr inbounds ([23 x i8]* @__PRETTY_FUNCTION__.worker_2, i32 0, i32 0)) noreturn nounwind
  unreachable

cond.end57:                                       ; preds = %lor.lhs.false53, %if.end51
  store volatile i8 0, i8* @latch2, align 1, !tbaa !0
  %38 = load volatile i8* @flag2, align 1, !tbaa !0, !range !3
  %39 = and i8 %38, 1
  %tobool58 = icmp eq i8 %39, 0
  br i1 %tobool58, label %if.end62, label %if.then59

if.then59:                                        ; preds = %cond.end57
  store volatile i8 0, i8* @flag2, align 1, !tbaa !0
  store volatile i8 1, i8* @flag1, align 1, !tbaa !0
  fence seq_cst
  store volatile i8 1, i8* @latch1, align 1, !tbaa !0
  br label %if.end62

if.end62:                                         ; preds = %if.then59, %cond.end57, %if.end44
  %40 = load volatile i8* @latch2, align 1, !tbaa !0, !range !3
  %41 = and i8 %40, 1
  %tobool64 = icmp eq i8 %41, 0
  br i1 %tobool64, label %if.then67, label %if.end81

if.then67:                                        ; preds = %if.end62
  %42 = load volatile i8* @latch2, align 1, !tbaa !0, !range !3
  %43 = and i8 %42, 1
  %tobool68 = icmp eq i8 %43, 0
  br i1 %tobool68, label %return, label %if.end70

if.end70:                                         ; preds = %if.then67
  %44 = load volatile i8* @latch2, align 1, !tbaa !0, !range !3
  %45 = and i8 %44, 1
  %tobool71 = icmp eq i8 %45, 0
  br i1 %tobool71, label %cond.end76, label %lor.lhs.false72

lor.lhs.false72:                                  ; preds = %if.end70
  %46 = load volatile i8* @flag2, align 1, !tbaa !0, !range !3
  %47 = and i8 %46, 1
  %tobool73 = icmp eq i8 %47, 0
  br i1 %tobool73, label %cond.false75, label %cond.end76

cond.false75:                                     ; preds = %lor.lhs.false72
  tail call void @__assert_fail(i8* getelementptr inbounds ([17 x i8]* @.str2, i32 0, i32 0), i8* getelementptr inbounds ([8 x i8]* @.str1, i32 0, i32 0), i32 317, i8* getelementptr inbounds ([23 x i8]* @__PRETTY_FUNCTION__.worker_2, i32 0, i32 0)) noreturn nounwind
  unreachable

cond.end76:                                       ; preds = %lor.lhs.false72, %if.end70
  store volatile i8 0, i8* @latch2, align 1, !tbaa !0
  %48 = load volatile i8* @flag2, align 1, !tbaa !0, !range !3
  %49 = and i8 %48, 1
  %tobool77 = icmp eq i8 %49, 0
  br i1 %tobool77, label %if.end81, label %if.then78

if.then78:                                        ; preds = %cond.end76
  store volatile i8 0, i8* @flag2, align 1, !tbaa !0
  store volatile i8 1, i8* @flag1, align 1, !tbaa !0
  fence seq_cst
  store volatile i8 1, i8* @latch1, align 1, !tbaa !0
  br label %if.end81

if.end81:                                         ; preds = %if.then78, %cond.end76, %if.end62
  %j.3 = phi i32 [ 0, %if.end62 ], [ 1, %cond.end76 ], [ 1, %if.then78 ]
  %50 = load volatile i8* @latch2, align 1, !tbaa !0, !range !3
  %51 = and i8 %50, 1
  %tobool82 = icmp eq i8 %51, 0
  br i1 %tobool82, label %if.then85, label %if.end99

if.then85:                                        ; preds = %if.end81
  %52 = load volatile i8* @latch2, align 1, !tbaa !0, !range !3
  %53 = and i8 %52, 1
  %tobool86 = icmp eq i8 %53, 0
  br i1 %tobool86, label %return, label %if.end88

if.end88:                                         ; preds = %if.then85
  %54 = load volatile i8* @latch2, align 1, !tbaa !0, !range !3
  %55 = and i8 %54, 1
  %tobool89 = icmp eq i8 %55, 0
  br i1 %tobool89, label %cond.end94, label %lor.lhs.false90

lor.lhs.false90:                                  ; preds = %if.end88
  %56 = load volatile i8* @flag2, align 1, !tbaa !0, !range !3
  %57 = and i8 %56, 1
  %tobool91 = icmp eq i8 %57, 0
  br i1 %tobool91, label %cond.false93, label %cond.end94

cond.false93:                                     ; preds = %lor.lhs.false90
  tail call void @__assert_fail(i8* getelementptr inbounds ([17 x i8]* @.str2, i32 0, i32 0), i8* getelementptr inbounds ([8 x i8]* @.str1, i32 0, i32 0), i32 330, i8* getelementptr inbounds ([23 x i8]* @__PRETTY_FUNCTION__.worker_2, i32 0, i32 0)) noreturn nounwind
  unreachable

cond.end94:                                       ; preds = %lor.lhs.false90, %if.end88
  store volatile i8 0, i8* @latch2, align 1, !tbaa !0
  %58 = load volatile i8* @flag2, align 1, !tbaa !0, !range !3
  %59 = and i8 %58, 1
  %tobool95 = icmp eq i8 %59, 0
  br i1 %tobool95, label %if.end97, label %if.then96

if.then96:                                        ; preds = %cond.end94
  store volatile i8 0, i8* @flag2, align 1, !tbaa !0
  store volatile i8 1, i8* @flag1, align 1, !tbaa !0
  fence seq_cst
  store volatile i8 1, i8* @latch1, align 1, !tbaa !0
  br label %if.end97

if.end97:                                         ; preds = %cond.end94, %if.then96
  %inc98 = add nsw i32 %j.3, 1
  br label %if.end99

if.end99:                                         ; preds = %if.end81, %if.end97
  %j.4 = phi i32 [ %j.3, %if.end81 ], [ %inc98, %if.end97 ]
  %60 = load volatile i8* @latch2, align 1, !tbaa !0, !range !3
  %61 = and i8 %60, 1
  %tobool100 = icmp eq i8 %61, 0
  %cmp102 = icmp slt i32 %j.4, 4
  %or.cond283 = and i1 %tobool100, %cmp102
  br i1 %or.cond283, label %if.then103, label %if.end117

if.then103:                                       ; preds = %if.end99
  %62 = load volatile i8* @latch2, align 1, !tbaa !0, !range !3
  %63 = and i8 %62, 1
  %tobool104 = icmp eq i8 %63, 0
  br i1 %tobool104, label %return, label %if.end106

if.end106:                                        ; preds = %if.then103
  %64 = load volatile i8* @latch2, align 1, !tbaa !0, !range !3
  %65 = and i8 %64, 1
  %tobool107 = icmp eq i8 %65, 0
  br i1 %tobool107, label %cond.end112, label %lor.lhs.false108

lor.lhs.false108:                                 ; preds = %if.end106
  %66 = load volatile i8* @flag2, align 1, !tbaa !0, !range !3
  %67 = and i8 %66, 1
  %tobool109 = icmp eq i8 %67, 0
  br i1 %tobool109, label %cond.false111, label %cond.end112

cond.false111:                                    ; preds = %lor.lhs.false108
  tail call void @__assert_fail(i8* getelementptr inbounds ([17 x i8]* @.str2, i32 0, i32 0), i8* getelementptr inbounds ([8 x i8]* @.str1, i32 0, i32 0), i32 342, i8* getelementptr inbounds ([23 x i8]* @__PRETTY_FUNCTION__.worker_2, i32 0, i32 0)) noreturn nounwind
  unreachable

cond.end112:                                      ; preds = %lor.lhs.false108, %if.end106
  store volatile i8 0, i8* @latch2, align 1, !tbaa !0
  %68 = load volatile i8* @flag2, align 1, !tbaa !0, !range !3
  %69 = and i8 %68, 1
  %tobool113 = icmp eq i8 %69, 0
  br i1 %tobool113, label %if.end115, label %if.then114

if.then114:                                       ; preds = %cond.end112
  store volatile i8 0, i8* @flag2, align 1, !tbaa !0
  store volatile i8 1, i8* @flag1, align 1, !tbaa !0
  fence seq_cst
  store volatile i8 1, i8* @latch1, align 1, !tbaa !0
  br label %if.end115

if.end115:                                        ; preds = %cond.end112, %if.then114
  %inc116 = add nsw i32 %j.4, 1
  br label %if.end117

if.end117:                                        ; preds = %if.end99, %if.end115
  %j.5 = phi i32 [ %j.4, %if.end99 ], [ %inc116, %if.end115 ]
  %70 = load volatile i8* @latch2, align 1, !tbaa !0, !range !3
  %71 = and i8 %70, 1
  %tobool118 = icmp eq i8 %71, 0
  %cmp120 = icmp slt i32 %j.5, 4
  %or.cond284 = and i1 %tobool118, %cmp120
  br i1 %or.cond284, label %if.then121, label %if.end135

if.then121:                                       ; preds = %if.end117
  %72 = load volatile i8* @latch2, align 1, !tbaa !0, !range !3
  %73 = and i8 %72, 1
  %tobool122 = icmp eq i8 %73, 0
  br i1 %tobool122, label %return, label %if.end124

if.end124:                                        ; preds = %if.then121
  %74 = load volatile i8* @latch2, align 1, !tbaa !0, !range !3
  %75 = and i8 %74, 1
  %tobool125 = icmp eq i8 %75, 0
  br i1 %tobool125, label %cond.end130, label %lor.lhs.false126

lor.lhs.false126:                                 ; preds = %if.end124
  %76 = load volatile i8* @flag2, align 1, !tbaa !0, !range !3
  %77 = and i8 %76, 1
  %tobool127 = icmp eq i8 %77, 0
  br i1 %tobool127, label %cond.false129, label %cond.end130

cond.false129:                                    ; preds = %lor.lhs.false126
  tail call void @__assert_fail(i8* getelementptr inbounds ([17 x i8]* @.str2, i32 0, i32 0), i8* getelementptr inbounds ([8 x i8]* @.str1, i32 0, i32 0), i32 354, i8* getelementptr inbounds ([23 x i8]* @__PRETTY_FUNCTION__.worker_2, i32 0, i32 0)) noreturn nounwind
  unreachable

cond.end130:                                      ; preds = %lor.lhs.false126, %if.end124
  store volatile i8 0, i8* @latch2, align 1, !tbaa !0
  %78 = load volatile i8* @flag2, align 1, !tbaa !0, !range !3
  %79 = and i8 %78, 1
  %tobool131 = icmp eq i8 %79, 0
  br i1 %tobool131, label %if.end135, label %if.then132

if.then132:                                       ; preds = %cond.end130
  store volatile i8 0, i8* @flag2, align 1, !tbaa !0
  store volatile i8 1, i8* @flag1, align 1, !tbaa !0
  fence seq_cst
  store volatile i8 1, i8* @latch1, align 1, !tbaa !0
  br label %if.end135

if.end135:                                        ; preds = %if.then132, %cond.end130, %if.end117
  %80 = load volatile i8* @latch2, align 1, !tbaa !0, !range !3
  %81 = and i8 %80, 1
  %tobool137 = icmp eq i8 %81, 0
  br i1 %tobool137, label %if.then140, label %if.end154

if.then140:                                       ; preds = %if.end135
  %82 = load volatile i8* @latch2, align 1, !tbaa !0, !range !3
  %83 = and i8 %82, 1
  %tobool141 = icmp eq i8 %83, 0
  br i1 %tobool141, label %return, label %if.end143

if.end143:                                        ; preds = %if.then140
  %84 = load volatile i8* @latch2, align 1, !tbaa !0, !range !3
  %85 = and i8 %84, 1
  %tobool144 = icmp eq i8 %85, 0
  br i1 %tobool144, label %cond.end149, label %lor.lhs.false145

lor.lhs.false145:                                 ; preds = %if.end143
  %86 = load volatile i8* @flag2, align 1, !tbaa !0, !range !3
  %87 = and i8 %86, 1
  %tobool146 = icmp eq i8 %87, 0
  br i1 %tobool146, label %cond.false148, label %cond.end149

cond.false148:                                    ; preds = %lor.lhs.false145
  tail call void @__assert_fail(i8* getelementptr inbounds ([17 x i8]* @.str2, i32 0, i32 0), i8* getelementptr inbounds ([8 x i8]* @.str1, i32 0, i32 0), i32 367, i8* getelementptr inbounds ([23 x i8]* @__PRETTY_FUNCTION__.worker_2, i32 0, i32 0)) noreturn nounwind
  unreachable

cond.end149:                                      ; preds = %lor.lhs.false145, %if.end143
  store volatile i8 0, i8* @latch2, align 1, !tbaa !0
  %88 = load volatile i8* @flag2, align 1, !tbaa !0, !range !3
  %89 = and i8 %88, 1
  %tobool150 = icmp eq i8 %89, 0
  br i1 %tobool150, label %if.end154, label %if.then151

if.then151:                                       ; preds = %cond.end149
  store volatile i8 0, i8* @flag2, align 1, !tbaa !0
  store volatile i8 1, i8* @flag1, align 1, !tbaa !0
  fence seq_cst
  store volatile i8 1, i8* @latch1, align 1, !tbaa !0
  br label %if.end154

if.end154:                                        ; preds = %if.then151, %cond.end149, %if.end135
  %j.6 = phi i32 [ 0, %if.end135 ], [ 1, %cond.end149 ], [ 1, %if.then151 ]
  %90 = load volatile i8* @latch2, align 1, !tbaa !0, !range !3
  %91 = and i8 %90, 1
  %tobool155 = icmp eq i8 %91, 0
  br i1 %tobool155, label %if.then158, label %if.end172

if.then158:                                       ; preds = %if.end154
  %92 = load volatile i8* @latch2, align 1, !tbaa !0, !range !3
  %93 = and i8 %92, 1
  %tobool159 = icmp eq i8 %93, 0
  br i1 %tobool159, label %return, label %if.end161

if.end161:                                        ; preds = %if.then158
  %94 = load volatile i8* @latch2, align 1, !tbaa !0, !range !3
  %95 = and i8 %94, 1
  %tobool162 = icmp eq i8 %95, 0
  br i1 %tobool162, label %cond.end167, label %lor.lhs.false163

lor.lhs.false163:                                 ; preds = %if.end161
  %96 = load volatile i8* @flag2, align 1, !tbaa !0, !range !3
  %97 = and i8 %96, 1
  %tobool164 = icmp eq i8 %97, 0
  br i1 %tobool164, label %cond.false166, label %cond.end167

cond.false166:                                    ; preds = %lor.lhs.false163
  tail call void @__assert_fail(i8* getelementptr inbounds ([17 x i8]* @.str2, i32 0, i32 0), i8* getelementptr inbounds ([8 x i8]* @.str1, i32 0, i32 0), i32 380, i8* getelementptr inbounds ([23 x i8]* @__PRETTY_FUNCTION__.worker_2, i32 0, i32 0)) noreturn nounwind
  unreachable

cond.end167:                                      ; preds = %lor.lhs.false163, %if.end161
  store volatile i8 0, i8* @latch2, align 1, !tbaa !0
  %98 = load volatile i8* @flag2, align 1, !tbaa !0, !range !3
  %99 = and i8 %98, 1
  %tobool168 = icmp eq i8 %99, 0
  br i1 %tobool168, label %if.end170, label %if.then169

if.then169:                                       ; preds = %cond.end167
  store volatile i8 0, i8* @flag2, align 1, !tbaa !0
  store volatile i8 1, i8* @flag1, align 1, !tbaa !0
  fence seq_cst
  store volatile i8 1, i8* @latch1, align 1, !tbaa !0
  br label %if.end170

if.end170:                                        ; preds = %cond.end167, %if.then169
  %inc171 = add nsw i32 %j.6, 1
  br label %if.end172

if.end172:                                        ; preds = %if.end154, %if.end170
  %j.7 = phi i32 [ %j.6, %if.end154 ], [ %inc171, %if.end170 ]
  %100 = load volatile i8* @latch2, align 1, !tbaa !0, !range !3
  %101 = and i8 %100, 1
  %tobool173 = icmp eq i8 %101, 0
  %cmp175 = icmp slt i32 %j.7, 4
  %or.cond285 = and i1 %tobool173, %cmp175
  br i1 %or.cond285, label %if.then176, label %if.end190

if.then176:                                       ; preds = %if.end172
  %102 = load volatile i8* @latch2, align 1, !tbaa !0, !range !3
  %103 = and i8 %102, 1
  %tobool177 = icmp eq i8 %103, 0
  br i1 %tobool177, label %return, label %if.end179

if.end179:                                        ; preds = %if.then176
  %104 = load volatile i8* @latch2, align 1, !tbaa !0, !range !3
  %105 = and i8 %104, 1
  %tobool180 = icmp eq i8 %105, 0
  br i1 %tobool180, label %cond.end185, label %lor.lhs.false181

lor.lhs.false181:                                 ; preds = %if.end179
  %106 = load volatile i8* @flag2, align 1, !tbaa !0, !range !3
  %107 = and i8 %106, 1
  %tobool182 = icmp eq i8 %107, 0
  br i1 %tobool182, label %cond.false184, label %cond.end185

cond.false184:                                    ; preds = %lor.lhs.false181
  tail call void @__assert_fail(i8* getelementptr inbounds ([17 x i8]* @.str2, i32 0, i32 0), i8* getelementptr inbounds ([8 x i8]* @.str1, i32 0, i32 0), i32 392, i8* getelementptr inbounds ([23 x i8]* @__PRETTY_FUNCTION__.worker_2, i32 0, i32 0)) noreturn nounwind
  unreachable

cond.end185:                                      ; preds = %lor.lhs.false181, %if.end179
  store volatile i8 0, i8* @latch2, align 1, !tbaa !0
  %108 = load volatile i8* @flag2, align 1, !tbaa !0, !range !3
  %109 = and i8 %108, 1
  %tobool186 = icmp eq i8 %109, 0
  br i1 %tobool186, label %if.end188, label %if.then187

if.then187:                                       ; preds = %cond.end185
  store volatile i8 0, i8* @flag2, align 1, !tbaa !0
  store volatile i8 1, i8* @flag1, align 1, !tbaa !0
  fence seq_cst
  store volatile i8 1, i8* @latch1, align 1, !tbaa !0
  br label %if.end188

if.end188:                                        ; preds = %cond.end185, %if.then187
  %inc189 = add nsw i32 %j.7, 1
  br label %if.end190

if.end190:                                        ; preds = %if.end172, %if.end188
  %j.8 = phi i32 [ %j.7, %if.end172 ], [ %inc189, %if.end188 ]
  %110 = load volatile i8* @latch2, align 1, !tbaa !0, !range !3
  %111 = and i8 %110, 1
  %tobool191 = icmp eq i8 %111, 0
  %cmp193 = icmp slt i32 %j.8, 4
  %or.cond286 = and i1 %tobool191, %cmp193
  br i1 %or.cond286, label %if.then194, label %if.end208

if.then194:                                       ; preds = %if.end190
  %112 = load volatile i8* @latch2, align 1, !tbaa !0, !range !3
  %113 = and i8 %112, 1
  %tobool195 = icmp eq i8 %113, 0
  br i1 %tobool195, label %return, label %if.end197

if.end197:                                        ; preds = %if.then194
  %114 = load volatile i8* @latch2, align 1, !tbaa !0, !range !3
  %115 = and i8 %114, 1
  %tobool198 = icmp eq i8 %115, 0
  br i1 %tobool198, label %cond.end203, label %lor.lhs.false199

lor.lhs.false199:                                 ; preds = %if.end197
  %116 = load volatile i8* @flag2, align 1, !tbaa !0, !range !3
  %117 = and i8 %116, 1
  %tobool200 = icmp eq i8 %117, 0
  br i1 %tobool200, label %cond.false202, label %cond.end203

cond.false202:                                    ; preds = %lor.lhs.false199
  tail call void @__assert_fail(i8* getelementptr inbounds ([17 x i8]* @.str2, i32 0, i32 0), i8* getelementptr inbounds ([8 x i8]* @.str1, i32 0, i32 0), i32 404, i8* getelementptr inbounds ([23 x i8]* @__PRETTY_FUNCTION__.worker_2, i32 0, i32 0)) noreturn nounwind
  unreachable

cond.end203:                                      ; preds = %lor.lhs.false199, %if.end197
  store volatile i8 0, i8* @latch2, align 1, !tbaa !0
  %118 = load volatile i8* @flag2, align 1, !tbaa !0, !range !3
  %119 = and i8 %118, 1
  %tobool204 = icmp eq i8 %119, 0
  br i1 %tobool204, label %if.end208, label %if.then205

if.then205:                                       ; preds = %cond.end203
  store volatile i8 0, i8* @flag2, align 1, !tbaa !0
  store volatile i8 1, i8* @flag1, align 1, !tbaa !0
  fence seq_cst
  store volatile i8 1, i8* @latch1, align 1, !tbaa !0
  br label %if.end208

if.end208:                                        ; preds = %if.then205, %cond.end203, %if.end190
  %120 = load volatile i8* @latch2, align 1, !tbaa !0, !range !3
  %121 = and i8 %120, 1
  %tobool210 = icmp eq i8 %121, 0
  br i1 %tobool210, label %if.then213, label %if.end227

if.then213:                                       ; preds = %if.end208
  %122 = load volatile i8* @latch2, align 1, !tbaa !0, !range !3
  %123 = and i8 %122, 1
  %tobool214 = icmp eq i8 %123, 0
  br i1 %tobool214, label %return, label %if.end216

if.end216:                                        ; preds = %if.then213
  %124 = load volatile i8* @latch2, align 1, !tbaa !0, !range !3
  %125 = and i8 %124, 1
  %tobool217 = icmp eq i8 %125, 0
  br i1 %tobool217, label %cond.end222, label %lor.lhs.false218

lor.lhs.false218:                                 ; preds = %if.end216
  %126 = load volatile i8* @flag2, align 1, !tbaa !0, !range !3
  %127 = and i8 %126, 1
  %tobool219 = icmp eq i8 %127, 0
  br i1 %tobool219, label %cond.false221, label %cond.end222

cond.false221:                                    ; preds = %lor.lhs.false218
  tail call void @__assert_fail(i8* getelementptr inbounds ([17 x i8]* @.str2, i32 0, i32 0), i8* getelementptr inbounds ([8 x i8]* @.str1, i32 0, i32 0), i32 418, i8* getelementptr inbounds ([23 x i8]* @__PRETTY_FUNCTION__.worker_2, i32 0, i32 0)) noreturn nounwind
  unreachable

cond.end222:                                      ; preds = %lor.lhs.false218, %if.end216
  store volatile i8 0, i8* @latch2, align 1, !tbaa !0
  %128 = load volatile i8* @flag2, align 1, !tbaa !0, !range !3
  %129 = and i8 %128, 1
  %tobool223 = icmp eq i8 %129, 0
  br i1 %tobool223, label %if.end227, label %if.then224

if.then224:                                       ; preds = %cond.end222
  store volatile i8 0, i8* @flag2, align 1, !tbaa !0
  store volatile i8 1, i8* @flag1, align 1, !tbaa !0
  fence seq_cst
  store volatile i8 1, i8* @latch1, align 1, !tbaa !0
  br label %if.end227

if.end227:                                        ; preds = %if.then224, %cond.end222, %if.end208
  %j.9 = phi i32 [ 0, %if.end208 ], [ 1, %cond.end222 ], [ 1, %if.then224 ]
  %130 = load volatile i8* @latch2, align 1, !tbaa !0, !range !3
  %131 = and i8 %130, 1
  %tobool228 = icmp eq i8 %131, 0
  br i1 %tobool228, label %if.then231, label %if.end245

if.then231:                                       ; preds = %if.end227
  %132 = load volatile i8* @latch2, align 1, !tbaa !0, !range !3
  %133 = and i8 %132, 1
  %tobool232 = icmp eq i8 %133, 0
  br i1 %tobool232, label %return, label %if.end234

if.end234:                                        ; preds = %if.then231
  %134 = load volatile i8* @latch2, align 1, !tbaa !0, !range !3
  %135 = and i8 %134, 1
  %tobool235 = icmp eq i8 %135, 0
  br i1 %tobool235, label %cond.end240, label %lor.lhs.false236

lor.lhs.false236:                                 ; preds = %if.end234
  %136 = load volatile i8* @flag2, align 1, !tbaa !0, !range !3
  %137 = and i8 %136, 1
  %tobool237 = icmp eq i8 %137, 0
  br i1 %tobool237, label %cond.false239, label %cond.end240

cond.false239:                                    ; preds = %lor.lhs.false236
  tail call void @__assert_fail(i8* getelementptr inbounds ([17 x i8]* @.str2, i32 0, i32 0), i8* getelementptr inbounds ([8 x i8]* @.str1, i32 0, i32 0), i32 431, i8* getelementptr inbounds ([23 x i8]* @__PRETTY_FUNCTION__.worker_2, i32 0, i32 0)) noreturn nounwind
  unreachable

cond.end240:                                      ; preds = %lor.lhs.false236, %if.end234
  store volatile i8 0, i8* @latch2, align 1, !tbaa !0
  %138 = load volatile i8* @flag2, align 1, !tbaa !0, !range !3
  %139 = and i8 %138, 1
  %tobool241 = icmp eq i8 %139, 0
  br i1 %tobool241, label %if.end243, label %if.then242

if.then242:                                       ; preds = %cond.end240
  store volatile i8 0, i8* @flag2, align 1, !tbaa !0
  store volatile i8 1, i8* @flag1, align 1, !tbaa !0
  fence seq_cst
  store volatile i8 1, i8* @latch1, align 1, !tbaa !0
  br label %if.end243

if.end243:                                        ; preds = %cond.end240, %if.then242
  %inc244 = add nsw i32 %j.9, 1
  br label %if.end245

if.end245:                                        ; preds = %if.end227, %if.end243
  %j.10 = phi i32 [ %j.9, %if.end227 ], [ %inc244, %if.end243 ]
  %140 = load volatile i8* @latch2, align 1, !tbaa !0, !range !3
  %141 = and i8 %140, 1
  %tobool246 = icmp eq i8 %141, 0
  %cmp248 = icmp slt i32 %j.10, 4
  %or.cond287 = and i1 %tobool246, %cmp248
  br i1 %or.cond287, label %if.then249, label %if.end263

if.then249:                                       ; preds = %if.end245
  %142 = load volatile i8* @latch2, align 1, !tbaa !0, !range !3
  %143 = and i8 %142, 1
  %tobool250 = icmp eq i8 %143, 0
  br i1 %tobool250, label %return, label %if.end252

if.end252:                                        ; preds = %if.then249
  %144 = load volatile i8* @latch2, align 1, !tbaa !0, !range !3
  %145 = and i8 %144, 1
  %tobool253 = icmp eq i8 %145, 0
  br i1 %tobool253, label %cond.end258, label %lor.lhs.false254

lor.lhs.false254:                                 ; preds = %if.end252
  %146 = load volatile i8* @flag2, align 1, !tbaa !0, !range !3
  %147 = and i8 %146, 1
  %tobool255 = icmp eq i8 %147, 0
  br i1 %tobool255, label %cond.false257, label %cond.end258

cond.false257:                                    ; preds = %lor.lhs.false254
  tail call void @__assert_fail(i8* getelementptr inbounds ([17 x i8]* @.str2, i32 0, i32 0), i8* getelementptr inbounds ([8 x i8]* @.str1, i32 0, i32 0), i32 443, i8* getelementptr inbounds ([23 x i8]* @__PRETTY_FUNCTION__.worker_2, i32 0, i32 0)) noreturn nounwind
  unreachable

cond.end258:                                      ; preds = %lor.lhs.false254, %if.end252
  store volatile i8 0, i8* @latch2, align 1, !tbaa !0
  %148 = load volatile i8* @flag2, align 1, !tbaa !0, !range !3
  %149 = and i8 %148, 1
  %tobool259 = icmp eq i8 %149, 0
  br i1 %tobool259, label %if.end261, label %if.then260

if.then260:                                       ; preds = %cond.end258
  store volatile i8 0, i8* @flag2, align 1, !tbaa !0
  store volatile i8 1, i8* @flag1, align 1, !tbaa !0
  fence seq_cst
  store volatile i8 1, i8* @latch1, align 1, !tbaa !0
  br label %if.end261

if.end261:                                        ; preds = %cond.end258, %if.then260
  %inc262 = add nsw i32 %j.10, 1
  br label %if.end263

if.end263:                                        ; preds = %if.end245, %if.end261
  %j.11 = phi i32 [ %j.10, %if.end245 ], [ %inc262, %if.end261 ]
  %150 = load volatile i8* @latch2, align 1, !tbaa !0, !range !3
  %151 = and i8 %150, 1
  %tobool264 = icmp eq i8 %151, 0
  %cmp266 = icmp slt i32 %j.11, 4
  %or.cond288 = and i1 %tobool264, %cmp266
  br i1 %or.cond288, label %if.then267, label %return

if.then267:                                       ; preds = %if.end263
  %152 = load volatile i8* @latch2, align 1, !tbaa !0, !range !3
  %153 = and i8 %152, 1
  %tobool268 = icmp eq i8 %153, 0
  br i1 %tobool268, label %return, label %if.end270

if.end270:                                        ; preds = %if.then267
  %154 = load volatile i8* @latch2, align 1, !tbaa !0, !range !3
  %155 = and i8 %154, 1
  %tobool271 = icmp eq i8 %155, 0
  br i1 %tobool271, label %cond.end276, label %lor.lhs.false272

lor.lhs.false272:                                 ; preds = %if.end270
  %156 = load volatile i8* @flag2, align 1, !tbaa !0, !range !3
  %157 = and i8 %156, 1
  %tobool273 = icmp eq i8 %157, 0
  br i1 %tobool273, label %cond.false275, label %cond.end276

cond.false275:                                    ; preds = %lor.lhs.false272
  tail call void @__assert_fail(i8* getelementptr inbounds ([17 x i8]* @.str2, i32 0, i32 0), i8* getelementptr inbounds ([8 x i8]* @.str1, i32 0, i32 0), i32 455, i8* getelementptr inbounds ([23 x i8]* @__PRETTY_FUNCTION__.worker_2, i32 0, i32 0)) noreturn nounwind
  unreachable

cond.end276:                                      ; preds = %lor.lhs.false272, %if.end270
  store volatile i8 0, i8* @latch2, align 1, !tbaa !0
  %158 = load volatile i8* @flag2, align 1, !tbaa !0, !range !3
  %159 = and i8 %158, 1
  %tobool277 = icmp eq i8 %159, 0
  br i1 %tobool277, label %return, label %if.then278

if.then278:                                       ; preds = %cond.end276
  store volatile i8 0, i8* @flag2, align 1, !tbaa !0
  store volatile i8 1, i8* @flag1, align 1, !tbaa !0
  fence seq_cst
  store volatile i8 1, i8* @latch1, align 1, !tbaa !0
  br label %return

return:                                           ; preds = %if.end263, %cond.end276, %if.then278, %if.then267, %if.then249, %if.then231, %if.then213, %if.then194, %if.then176, %if.then158, %if.then140, %if.then121, %if.then103, %if.then85, %if.then67, %if.then48, %if.then30, %if.then12, %if.then
  ret i8* null
}

define i32 @main() nounwind {
entry:
  %t1 = alloca i32, align 4
  %t2 = alloca i32, align 4
  %call = call i32 @pthread_create(i32* %t1, %union.pthread_attr_t* null, i8* (i8*)* @worker_1, i8* null) nounwind
  %call1 = call i32 @pthread_create(i32* %t2, %union.pthread_attr_t* null, i8* (i8*)* @worker_2, i8* null) nounwind
  ret i32 0
}

declare i32 @pthread_create(i32*, %union.pthread_attr_t*, i8* (i8*)*, i8*) nounwind

!0 = metadata !{metadata !"_Bool", metadata !1}
!1 = metadata !{metadata !"omnipotent char", metadata !2}
!2 = metadata !{metadata !"Simple C/C++ TBAA", null}
!3 = metadata !{i8 0, i8 2}                       
