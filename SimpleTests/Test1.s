define void @_Test() nounwind readonly {
entry:
  %a = add i32 4, 0
  %b = add i32 5, 0
  %ptra = alloca i32
  %ptrb = alloca i32
  store i32 %b, i32* %ptrb
  store i32 %a, i32* %ptra 
  %b = add i32 4, %b          
  %a = add i32 4, %a
  br label %return 
  
return:
  ret void
}       

