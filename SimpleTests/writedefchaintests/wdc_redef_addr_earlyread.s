define void @_Test() nounwind readonly {
entry:
 %a = add i32 1, 0
 %r1 = alloca i32
 
loop:
 %r2 = load i32* %r1
 %r1 = load i32* %a
 fence singlethread seq_cst
 %cond = icmp eq i32 %a, %r1
 store i32 %a, i32* %r1
 br i1 %cond, label %loop, label %return

return:
 ret void
}