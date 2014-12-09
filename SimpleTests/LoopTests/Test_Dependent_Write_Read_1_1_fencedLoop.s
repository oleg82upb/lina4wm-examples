define void @_Test() nounwind readonly {
entry:
  %b = add i32 5, 0
  %r1 = alloca i32
  store i32 %b, i32* %r1
  %0 = load i32* %r1, align 4, !tbaa !0
  %a = add i32 1, 0
loop:
  fence singlethread seq_cst             ; yields void
  %plus = add i32 %a, %b
  %cond = icmp eq i32 %a, %b
  %a = add i32 %a, 1
  br i1 %cond, label %return, label %loop

return:
  ret void
} 