; ModuleID = 'seqlock.c'
target datalayout = "e-p:32:32:32-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:32:64-f32:32:32-f64:32:64-v64:64:64-v128:128:128-a0:0:64-f80:32:32-n8:16:32-S128"
target triple = "i386-pc-linux-gnu"

@x1 = global i32 0, align 4
@x2 = global i32 0, align 4
@c = global i32 0, align 4

define void @write(i32 %word1, i32 %word2) nounwind {
entry:
  %word1.addr = alloca i32, align 4
  %word2.addr = alloca i32, align 4
  store i32 %word1, i32* %word1.addr, align 4
  store i32 %word2, i32* %word2.addr, align 4
  %0 = load i32* @c, align 4
  %inc = add nsw i32 %0, 1
  store i32 %inc, i32* @c, align 4
  %1 = load i32* %word1.addr, align 4
  store i32 %1, i32* @x1, align 4
  %2 = load i32* %word2.addr, align 4
  store i32 %2, i32* @x2, align 4
  %3 = load i32* @c, align 4
  %inc1 = add nsw i32 %3, 1
  store i32 %inc1, i32* @c, align 4
  ret void
}

define void @read(i32* %word) nounwind {
entry:
  %word.addr = alloca i32*, align 4
  %c0 = alloca i32, align 4
  store i32* %word, i32** %word.addr, align 4
  store i32 0, i32* %c0, align 4
  br label %do.body

do.body:                                          ; preds = %do.cond3, %entry
  br label %do.body1

do.body1:                                         ; preds = %do.cond, %do.body
  %0 = load i32* @c, align 4
  store i32 %0, i32* %c0, align 4
  br label %do.cond

do.cond:                                          ; preds = %do.body1
  %1 = load i32* %c0, align 4
  %rem = srem i32 %1, 2
  %tobool = icmp ne i32 %rem, 0
  br i1 %tobool, label %do.body1, label %do.end

do.end:                                           ; preds = %do.cond
  %2 = load i32* @x1, align 4
  %3 = load i32** %word.addr, align 4
  %arrayidx = getelementptr inbounds i32* %3, i32 0
  store i32 %2, i32* %arrayidx, align 4
  %4 = load i32* @x2, align 4
  %5 = load i32** %word.addr, align 4
  %arrayidx2 = getelementptr inbounds i32* %5, i32 1
  store i32 %4, i32* %arrayidx2, align 4
  br label %do.cond3

do.cond3:                                         ; preds = %do.end
  %6 = load i32* @c, align 4
  %7 = load i32* %c0, align 4
  %cmp = icmp ne i32 %6, %7
  br i1 %cmp, label %do.body, label %do.end4

do.end4:                                          ; preds = %do.cond3
  ret void
}

define i32 @main(i32 %argc, i8** %arv) nounwind {
entry:
  %retval = alloca i32, align 4
  %argc.addr = alloca i32, align 4
  %arv.addr = alloca i8**, align 4
  store i32 0, i32* %retval
  store i32 %argc, i32* %argc.addr, align 4
  store i8** %arv, i8*** %arv.addr, align 4
  ret i32 0
}
