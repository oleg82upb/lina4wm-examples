define void @_Test_Independent_Write_Read() nounwind readonly {
entry:
  %b = add i32 5, 0
  %r2 = alloca i32
  store i32 %b, i32* %r1
  %0 = load i32* %r2, align 4, !tbaa !0
  %a = add i32 6, 0	
  %val_success = cmpxchg i32* %r1, i32 %b, i32 %a seq_cst
return:
  ret void
} 