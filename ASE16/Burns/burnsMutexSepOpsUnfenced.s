; ModuleID = 'burnsMutexSepOps.cpp'
target datalayout = "e-p:32:32:32-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:32:64-f32:32:32-f64:32:64-v64:64:64-v128:128:128-a0:0:64-f80:32:32-n8:16:32-S128"
target triple = "i386-pc-linux-gnu"

@f0 = global i8 0, align 1
@f1 = global i8 0, align 1
@i = global i32 0, align 4

define void @_Z5p1_aqv() nounwind {
entry:
  store i8 1, i8* @f0, align 1
  br label %while.cond

while.cond:                                       ; preds = %while.body, %entry
  %0 = load i8* @f1, align 1
  %tobool = trunc i8 %0 to i1
  %conv = zext i1 %tobool to i32
  %cmp = icmp ne i32 %conv, 0
  br i1 %cmp, label %while.body, label %while.end

while.body:                                       ; preds = %while.cond
  br label %while.cond

while.end:                                        ; preds = %while.cond
  ret void
}

define void @_Z6p1_relv() nounwind {
entry:
  store i8 0, i8* @f0, align 1
  ret void
}

define void @_Z5p2_aqv() nounwind {
entry:
  br label %retry

retry:                                            ; preds = %if.then, %entry
  br label %while.cond

while.cond:                                       ; preds = %while.body, %retry
  %0 = load i8* @f0, align 1
  %tobool = trunc i8 %0 to i1
  %conv = zext i1 %tobool to i32
  %cmp = icmp ne i32 %conv, 0
  br i1 %cmp, label %while.body, label %while.end

while.body:                                       ; preds = %while.cond
  br label %while.cond

while.end:                                        ; preds = %while.cond
  store i8 1, i8* @f1, align 1
  %1 = load i8* @f0, align 1
  %tobool1 = trunc i8 %1 to i1
  %conv2 = zext i1 %tobool1 to i32
  %cmp3 = icmp ne i32 %conv2, 0
  br i1 %cmp3, label %if.then, label %if.end

if.then:                                          ; preds = %while.end
  store i8 0, i8* @f1, align 1
  br label %retry

if.end:                                           ; preds = %while.end
  ret void
}

define void @_Z6p2_relv() nounwind {
entry:
  store i8 0, i8* @f1, align 1
  ret void
}

define i32 @main() nounwind {
entry:
  ret i32 0
}
