; ModuleID = 'arora-deque.c'
target datalayout = "e-p:32:32:32-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:32:64-f32:32:32-f64:32:64-v64:64:64-v128:128:128-a0:0:64-f80:32:32-n8:16:32-S128"
target triple = "i386-pc-linux-gnu"

@bot = common global i32* null, align 4
@deq = common global i32* null, align 4
@age = common global i32* null, align 4
@top = common global i32* null, align 4

define void @push(i32 %elem) nounwind {
entry:
  %elem.addr = alloca i32, align 4
  %localBot = alloca i32, align 4
  store i32 %elem, i32* %elem.addr, align 4
  %0 = load i32** @bot, align 4
  %1 = load i32* %0, align 4
  store i32 %1, i32* %localBot, align 4
  %2 = load i32* %elem.addr, align 4
  %3 = load i32* %localBot, align 4
  %4 = load i32** @deq, align 4
  %arrayidx = getelementptr inbounds i32* %4, i32 %3
  store i32 %2, i32* %arrayidx, align 4
  %5 = load i32* %localBot, align 4
  %inc = add i32 %5, 1
  store i32 %inc, i32* %localBot, align 4
  %6 = load i32* %localBot, align 4
  %7 = load i32** @bot, align 4
  store i32 %6, i32* %7, align 4
  ret void
}

define i32 @dequeue() nounwind {
entry:
  %retval = alloca i32, align 4
  %oldAge = alloca i32, align 4
  %localBot = alloca i32, align 4
  %elem = alloca i32, align 4
  %newAge = alloca i32, align 4
  %0 = load i32** @age, align 4
  %1 = load i32* %0, align 4
  store i32 %1, i32* %oldAge, align 4
  %2 = load i32** @bot, align 4
  %3 = load i32* %2, align 4
  store i32 %3, i32* %localBot, align 4
  %4 = load i32* %localBot, align 4
  %5 = load i32* %oldAge, align 4
  %shr = ashr i32 %5, 16
  %cmp = icmp ule i32 %4, %shr
  br i1 %cmp, label %if.then, label %if.end

if.then:                                          ; preds = %entry
  store i32 -1, i32* %retval
  br label %return

if.end:                                           ; preds = %entry
  %6 = load i32* %oldAge, align 4
  %shr1 = ashr i32 %6, 16
  %7 = load i32** @deq, align 4
  %arrayidx = getelementptr inbounds i32* %7, i32 %shr1
  %8 = load i32* %arrayidx, align 4
  store i32 %8, i32* %elem, align 4
  %9 = load i32* %oldAge, align 4
  store i32 %9, i32* %newAge, align 4
  %10 = load i32* %newAge, align 4
  %shr2 = ashr i32 %10, 16
  %add = add nsw i32 %shr2, 1
  %shl = shl i32 %add, 16
  %11 = load i32* %newAge, align 4
  %and = and i32 %11, 65535
  %or = or i32 %shl, %and
  store i32 %or, i32* %newAge, align 4
  %12 = load i32** @age, align 4
  %13 = load i32* %oldAge, align 4
  %14 = load i32* %newAge, align 4
  %15 = cmpxchg i32* %12, i32 %13, i32 %14 seq_cst
  %16 = icmp eq i32 %15, %13
  br i1 %16, label %if.then3, label %if.end4

if.then3:                                         ; preds = %if.end
  %17 = load i32* %elem, align 4
  store i32 %17, i32* %retval
  br label %return

if.end4:                                          ; preds = %if.end
  store i32 -2, i32* %retval
  br label %return

return:                                           ; preds = %if.end4, %if.then3, %if.then
  %18 = load i32* %retval
  ret i32 %18
}

define i32 @pop() nounwind {
entry:
  %retval = alloca i32, align 4
  %localBot = alloca i32, align 4
  %elem = alloca i32, align 4
  %oldAge = alloca i32, align 4
  %newAge = alloca i32, align 4
  %0 = load i32** @bot, align 4
  %1 = load i32* %0, align 4
  store i32 %1, i32* %localBot, align 4
  %2 = load i32* %localBot, align 4
  %cmp = icmp eq i32 %2, 0
  br i1 %cmp, label %if.then, label %if.end

if.then:                                          ; preds = %entry
  store i32 -1, i32* %retval
  br label %return

if.end:                                           ; preds = %entry
  %3 = load i32* %localBot, align 4
  %dec = add i32 %3, -1
  store i32 %dec, i32* %localBot, align 4
  %4 = load i32* %localBot, align 4
  %5 = load i32** @bot, align 4
  store i32 %4, i32* %5, align 4
  %6 = load i32* %localBot, align 4
  %7 = load i32** @deq, align 4
  %arrayidx = getelementptr inbounds i32* %7, i32 %6
  %8 = load i32* %arrayidx, align 4
  store i32 %8, i32* %elem, align 4
  %9 = load i32** @age, align 4
  %10 = load i32* %9, align 4
  store i32 %10, i32* %oldAge, align 4
  %11 = load i32* %localBot, align 4
  %12 = load i32* %oldAge, align 4
  %shr = ashr i32 %12, 16
  %cmp1 = icmp ugt i32 %11, %shr
  br i1 %cmp1, label %if.then2, label %if.end3

if.then2:                                         ; preds = %if.end
  %13 = load i32* %elem, align 4
  store i32 %13, i32* %retval
  br label %return

if.end3:                                          ; preds = %if.end
  %14 = load i32** @bot, align 4
  store i32 0, i32* %14, align 4
  %15 = load i32* %oldAge, align 4
  %and = and i32 %15, 65535
  %add = add nsw i32 %and, 1
  %or = or i32 0, %add
  store i32 %or, i32* %newAge, align 4
  %16 = load i32* %localBot, align 4
  %17 = load i32* %oldAge, align 4
  %shr4 = ashr i32 %17, 16
  %cmp5 = icmp eq i32 %16, %shr4
  br i1 %cmp5, label %if.then6, label %if.end9

if.then6:                                         ; preds = %if.end3
  %18 = load i32** @age, align 4
  %19 = load i32* %oldAge, align 4
  %20 = load i32* %newAge, align 4
  %21 = cmpxchg i32* %18, i32 %19, i32 %20 seq_cst
  %22 = icmp eq i32 %21, %19
  br i1 %22, label %if.then7, label %if.end8

if.then7:                                         ; preds = %if.then6
  %23 = load i32* %elem, align 4
  store i32 %23, i32* %retval
  br label %return

if.end8:                                          ; preds = %if.then6
  br label %if.end9

if.end9:                                          ; preds = %if.end8, %if.end3
  %24 = load i32* %newAge, align 4
  %25 = load i32** @age, align 4
  store i32 %24, i32* %25, align 4
  store i32 -1, i32* %retval
  br label %return

return:                                           ; preds = %if.end9, %if.then7, %if.then2, %if.then
  %26 = load i32* %retval
  ret i32 %26
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
