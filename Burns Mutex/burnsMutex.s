; ModuleID = 'burnsMutex.cpp'
target datalayout = "e-p:32:32:32-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:32:64-f32:32:32-f64:32:64-v64:64:64-v128:128:128-a0:0:64-f80:32:32-n8:16:32-S128"
target triple = "i386-pc-linux-gnu"

@f0 = global i8 0, align 1
@f1 = global i8 0, align 1
@i = global i32 0, align 4

define void @_Z2p1v() nounwind {
entry:
  br label %while.body

while.body:                                       ; preds = %entry, %while.end
  store i8 1, i8* @f0, align 1
  br label %while.cond1

while.cond1:                                      ; preds = %while.body2, %while.body
  %0 = load i8* @f1, align 1
  %tobool = trunc i8 %0 to i1
  %conv = zext i1 %tobool to i32
  %cmp = icmp ne i32 %conv, 0
  br i1 %cmp, label %while.body2, label %while.end

while.body2:                                      ; preds = %while.cond1
  br label %while.cond1

while.end:                                        ; preds = %while.cond1
  %1 = load i32* @i, align 4
  %inc = add nsw i32 %1, 1
  store i32 %inc, i32* @i, align 4
  store i8 0, i8* @f0, align 1
  br label %while.body

return:                                           ; No predecessors!
  ret void
}

define void @_Z2p2v() nounwind {
entry:
  br label %while.body

while.body:                                       ; preds = %entry, %if.end
  br label %while.cond1

while.cond1:                                      ; preds = %while.body2, %while.body
  %0 = load i8* @f0, align 1
  %tobool = trunc i8 %0 to i1
  %conv = zext i1 %tobool to i32
  %cmp = icmp ne i32 %conv, 0
  br i1 %cmp, label %while.body2, label %while.end

while.body2:                                      ; preds = %while.cond1
  br label %while.cond1

while.end:                                        ; preds = %while.cond1
  store i8 1, i8* @f1, align 1
  %1 = load i8* @f0, align 1
  %tobool3 = trunc i8 %1 to i1
  %conv4 = zext i1 %tobool3 to i32
  %cmp5 = icmp eq i32 %conv4, 0
  br i1 %cmp5, label %if.then, label %if.end

if.then:                                          ; preds = %while.end
  %2 = load i32* @i, align 4
  %inc = add nsw i32 %2, 1
  store i32 %inc, i32* @i, align 4
  br label %if.end

if.end:                                           ; preds = %if.then, %while.end
  store i8 0, i8* @f1, align 1
  br label %while.body

return:                                           ; No predecessors!
  ret void
}

define i32 @main() nounwind {
entry:
  ret i32 0
}
