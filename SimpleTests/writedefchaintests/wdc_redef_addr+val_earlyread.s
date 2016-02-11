define void @_Test() nounwind readonly {
entry:
  %r2 = alloca i32
  %r1 = alloca i32
  
loop:
 %a = load i32* %r1
 %r1 = load i32* %r2
 fence singlethread seq_cst
 %cond = icmp eq i32 %a, %r1
 store i32 %a, i32* %r1
 br i1 %cond, label %loop, label %return

return:
 ret void
}