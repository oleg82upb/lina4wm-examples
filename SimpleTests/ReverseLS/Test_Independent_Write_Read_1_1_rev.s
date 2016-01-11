define void @_Test_Independent_Write_Read() nounwind readonly {
entry:
  %b = add i32 5, 0
  %r1 = alloca i32
  %r2 = alloca i32
  %0 = load i32* %r2, align 4, !tbaa !0
  store i32 %b, i32* %r1
  %a = add i32 6, 0
  fence singlethread seq_cst             ; yields void
  %plus = add i32 %a, %b
return:
  ret void
} 