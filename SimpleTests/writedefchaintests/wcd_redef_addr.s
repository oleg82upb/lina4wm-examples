define void @_Test() nounwind readonly {
entry:
 %a = add i32 1, 0
 %r2 = add i32 5, 0
 
loop:
 %r1 = add i32 %r2, 0
 fence singlethread seq_cst
 %cond = icmp eq i32 %a, %r1
 store i32 %a, i32* %r1
 br i1 %cond, label %loop, label %return

return:
 ret void
}