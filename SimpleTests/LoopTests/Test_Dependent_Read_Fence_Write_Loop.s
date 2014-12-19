define void @_Test() nounwind readonly {
entry:
  %b = add i32 5, 0
  %r1 = alloca i32
  br label %loop

loop: 
  %0 = load i32* %r1, align 4, !tbaa !0
  fence singlethread seq_cst             ; yields void
  store i32 %0, i32* %r1
  %a = add i32 6, 0
  %plus = add i32 %a, %b
  br label %loop
return:
  ret void
} 