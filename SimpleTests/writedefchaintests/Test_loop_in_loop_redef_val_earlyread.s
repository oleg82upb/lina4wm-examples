define void @_Test() nounwind readonly {
entry:
 %a = add i32 1, 0
 %r1 = alloca i32
 
loop1:
 %b = add i32 %a, 1
 %cond = icmp eq i32 %a, %b
 br i1 %cond, label %loop1part2, label %loop2
 
loop1part2:
 %r2 = load i32* %r1
 br i1 %cond, label %loop1, label %return
 
loop2:
 fence singlethread seq_cst
 store i32 %b, i32* %r1
 %cond2 = icmp eq i32 %r1, %b
 br i1 %cond2, label %loop1part2, label %loop2

return:
  ret void
}