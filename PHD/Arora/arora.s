@bot = common global i32* null, align 4
@deq = common global i32* null, align 4
@age = common global i32* null, align 4

define void @pushBottom(i32 %elem) nounwind optsize {
entry:
  %0 = load i32** @bot, align 4, !tbaa !0
  %1 = load i32* %0, align 4, !tbaa !3
  %2 = load i32** @deq, align 4, !tbaa !0
  %idx = getelementptr inbounds i32* %2, i32 %1
  store i32 %elem, i32* %idx, align 4, !tbaa !3
  %inc = add i32 %1, 1
  ;; <<< fence required for PSO >>>
  store i32 %inc, i32* %0, align 4, !tbaa !3
  ret void
}

define i32 @popTop() nounwind optsize {
entry:
  %0 = load i32** @age, align 4, !tbaa !0
  %1 = load i32* %0, align 4, !tbaa !3
  %2 = load i32** @bot, align 4, !tbaa !0
  %3 = load i32* %2, align 4, !tbaa !3
  %shr = ashr i32 %1, 16
  %cmp = icmp ugt i32 %3, %shr
  br i1 %cmp, label %if.end, label %return

if.end:                                          
  %4 = load i32** @deq, align 4, !tbaa !0
  %idx = getelementptr inbounds i32* %4, i32 %shr
  %5 = load i32* %idx, align 4, !tbaa !3
  %add5 = add i32 %1, 65536
  %6 = cmpxchg i32* %0, i32 %1, i32 %add5 seq_cst
  %7 = icmp eq i32 %6, %1
  %. = select i1 %7, i32 %5, i32 -2
  br label %return

return:                                         
  %retval.0 = phi i32 [ -1, %entry ], [ %., %if.end ]
  ret i32 %retval.0
}

define i32 @popBottom() nounwind {
entry:
  %0 = load i32** @bot
  %1 = load i32* %0
  %cmp = icmp eq i32 %1, 0
  br i1 %cmp, label %return, label %if.end			
  					
if.end:                                           
  %dec = add i32 %1, -1
  store i32 %dec, i32* %0
  %2 = load i32** @deq
  %idx = getelementptr inbounds i32* %2, i32 %dec
  %3 = load i32* %idx
  %4 = load i32** @age
;; <<< fence required for TSO >>>
  %5 = load i32* %4
  %shr = ashr i32 %5, 16
  %cmp1 = icmp ugt i32 %dec, %shr
  br i1 %cmp1, label %return, label %if.end3
  
if.end3:  
  store i32 0, i32* %0, align 4, !tbaa !3
  %and = and i32 %5, 65535
  %add = add nsw i32 %and, 1
  %cmp5 = icmp eq i32 %dec, %shr
  br i1 %cmp5, label %if.then6, label %if.end9

if.then6:
  %6 = cmpxchg i32* %4, i32 %5, i32 %add seq_cst
  %7 = icmp eq i32 %6, %5
  br i1 %7, label %return, label %if.then7

if.then7:
  %.pre = load i32** @age, align 4, !tbaa !0
  br label %if.end9

if.end9:
  %8 = phi i32* [ %.pre, %if.then7 ], [ %4, %if.end3 ]
  store i32 %add, i32* %8, align 4, !tbaa !3
  br label %return
 
return:
  %retval.0 = phi i32 [ -1, %if.end9 ], 
      [ -1, %entry ], [ %3, %if.end ], [ %3, %if.then6 ]
  ret i32 %retval.0
}