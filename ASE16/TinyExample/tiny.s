@y = global i32* null, align 4
@x = global i32* null, align 4

define void @p0() nounwind {
entry:
  store i8 1, i32* @x, align 1
  store i8 1, i32* @y, align 1
  fence seq_cst
  %1 = load i32* @y, align 4
  ret void
}

define void @p1() nounwind {
entry:
  store i8 1, i32* @y, align 1
  %0 = load i32* @x, align 4
  ret void
}
