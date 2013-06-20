; ModuleID = 'spinlock.c'
target datalayout = "e-p:32:32:32-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:32:64-f32:32:32-f64:32:64-v64:64:64-v128:128:128-a0:0:64-f80:32:32-n8:16:32-S128"
target triple = "i386-pc-linux-gnu"

@ptrX = internal global i32 1, align 4

define void @aquire() nounwind {
entry:
  br label %while.body

while.body:                                       ; preds = %entry, %while.end
  %0 = cmpxchg i32* @ptrX, i32 1, i32 0 seq_cst
  %1 = icmp eq i32 %0, 1
  br i1 %1, label %if.then, label %if.end

if.then:                                          ; preds = %while.body
  ret void

if.end:                                           ; preds = %while.body
  br label %while.cond1

while.cond1:                                      ; preds = %while.body2, %if.end
  %2 = load i32* @ptrX, align 4
  %cmp = icmp eq i32 %2, 0
  br i1 %cmp, label %while.body2, label %while.end

while.body2:                                      ; preds = %while.cond1
  br label %while.cond1

while.end:                                        ; preds = %while.cond1
  br label %while.body
}

define void @release() nounwind {
entry:
  store i32 1, i32* @ptrX, align 4
  ret void
}

define i32 @tryaquire() nounwind {
entry:
  %retval = alloca i32, align 4
  %0 = cmpxchg i32* @ptrX, i32 1, i32 0 seq_cst
  %1 = icmp eq i32 %0, 1
  br i1 %1, label %if.then, label %if.end

if.then:                                          ; preds = %entry
  store i32 1, i32* %retval
  br label %return

if.end:                                           ; preds = %entry
  store i32 0, i32* %retval
  br label %return

return:                                           ; preds = %if.end, %if.then
  %2 = load i32* %retval
  ret i32 %2
}

define i32 @main(i32 %argc, i8** %argv) nounwind {
entry:
  %retval = alloca i32, align 4
  %argc.addr = alloca i32, align 4
  %argv.addr = alloca i8**, align 4
  store i32 0, i32* %retval
  store i32 %argc, i32* %argc.addr, align 4
  store i8** %argv, i8*** %argv.addr, align 4
  ret i32 0
}
