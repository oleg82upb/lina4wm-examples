define void @_Test() nounwind readonly {
entry:
 %r1 = alloca i32
 
loop:
 %a = add i32 %a, 1
 %r2 = load i32* %r1
 fence singlethread seq_cst
 %cond = icmp eq i32 %a, %r1
 store i32 %a, i32* %r1
 br i1 %cond, label %loop, label %return

return:
 ret void
}