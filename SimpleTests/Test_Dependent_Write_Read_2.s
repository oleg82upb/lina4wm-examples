define void @_Test() nounwind readonly {
entry:
  %b = add i32 5, 0
  %r1 = alloca i32
  store i32 %b, i32* %r1
  %0 = load i32* %r1, align 4, !tbaa !0
  %a = add i32 6, 0	
  %val_success = cmpxchg i32* %r1, i32 %b, i32 %a acq_rel monotonic ; yields  { i32, i1 }
return:
  ret void
} 