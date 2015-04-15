inline @push(){ 
L_0: v_0 = memory[ @bot];
L_1: v_1 = memory[ v_0];
L_2: v_2 = memory[ @deq];
L_3: %arrayidx = GetElementPtr %2 %1 
L_4: skip;
L_5_(v_arrayidx,v_elem): if :: true -> memory[v_arrayidx] = v_elem; goto L_5;
	:: true -> %inc = %1  + 1 
fi;
L_5: %inc = %1  + 1 
L_6_(v_arrayidx,v_elem): if :: true -> memory[v_arrayidx] = v_elem; goto L_6;
	:: true -> skip;
fi;
L_6: skip;
L_7_(v_arrayidx,v_elem)(v_0,v_inc): if :: true -> memory[v_arrayidx] = v_elem; goto L_7_(v_0,v_inc);
	:: true -> RET  void
fi;
L_7_(v_0,v_inc): if :: true -> memory[v_0] = v_inc; goto L_7;
	:: true -> RET  void
fi;
L_8_(v_arrayidx,v_elem)(v_0,v_inc): memory[v_arrayidx] = v_elem; goto L_8_(v_0,v_inc);
L_7: RET  void
L_8_(v_0,v_inc): memory[v_0] = v_inc; goto L_8;
L_8: skip;
}

inline @dequeue(){ 
L_0: v_0 = memory[ @age];
L_1: v_1 = memory[ v_0];
L_2: v_2 = memory[ @bot];
L_3: v_3 = memory[ v_2];
L_4: %shr = %1  >>[A] 16 
L_5: %cmp = (%3  > %shr )
L_6: if :: [%cmp] -> goto L_7;
	:: [else] -> goto L_15;
fi;
L_7: v_4 = memory[ @deq];
L_15: phi([-1 , entry(PC:6)], [%. , if.end(PC:14)])
L_8: %arrayidx = GetElementPtr %4 %shr 
L_16: RET %retval.0 
L_9: v_5 = memory[ v_arrayidx];
L_17: skip;L_10: %add5 = %1  + 65536 
L_11: %6 = CAS(%0 , %1 , %add5 )
L_12: %7 = (%6  == %1 )
L_13: Select
L_14: goto L_15;

}

inline @pop(){ 
L_0: v_0 = memory[ @bot];
L_1: v_1 = memory[ v_0];
L_2: %cmp = (%1  == 0 )
L_3: if :: [%cmp] -> goto L_27;
	:: [else] -> goto L_4;
fi;
L_27: phi([-1 , if.end9(PC:27)], [-1 , entry(PC:3)], [%3 , if.end(PC:27)], [%3 , if.then6(PC:21)])
L_4: %dec = %1  + -1 
L_28: RET %retval.0 
L_5: skip;
L_29: skip;L_6_(v_0,v_dec): if :: true -> memory[v_0] = v_dec; goto L_6;
	:: true -> v_2 = memory[ @deq];
fi;
L_6: v_2 = memory[ @deq];
L_7_(v_0,v_dec): if :: true -> memory[v_0] = v_dec; goto L_7;
	:: true -> %arrayidx = GetElementPtr %2 %dec 
fi;
L_7: %arrayidx = GetElementPtr %2 %dec 
L_8_(v_0,v_dec): if :: true -> memory[v_0] = v_dec; goto L_8;
	:: true -> v_3 = memory[ v_arrayidx];
fi;
L_8: v_3 = memory[ v_arrayidx];
L_9_(v_0,v_dec): if :: true -> memory[v_0] = v_dec; goto L_9;
	:: true -> v_4 = memory[ @age];
fi;
L_9: v_4 = memory[ @age];
L_10_(v_0,v_dec): if :: true -> memory[v_0] = v_dec; goto L_10;
	:: true -> v_5 = memory[ v_4];
fi;
L_10: v_5 = memory[ v_4];
L_11_(v_0,v_dec): if :: true -> memory[v_0] = v_dec; goto L_11;
	:: true -> %shr = %5  >>[A] 16 
fi;
L_11: %shr = %5  >>[A] 16 
L_12_(v_0,v_dec): if :: true -> memory[v_0] = v_dec; goto L_12;
	:: true -> %cmp1 = (%dec  > %shr )
fi;
L_12: %cmp1 = (%dec  > %shr )
L_13_(v_0,v_dec): if :: true -> memory[v_0] = v_dec; goto L_13;
	:: [%cmp1] -> goto L_27_(v_0,v_dec);
	:: [else] -> goto L_14_(v_0,v_dec);
fi;
L_13: if :: [%cmp1] -> goto L_27;
	:: [else] -> goto L_14;
fi;
L_27_(v_0,v_dec): if :: true -> memory[v_0] = v_dec; goto L_27;
	:: true -> phi([-1 , if.end9], [-1 , entry], [%3 , if.end(PC:13)], [%3 , if.then6])
fi;
L_14_(v_0,v_dec): if :: true -> memory[v_0] = v_dec; goto L_14;
	:: true -> skip;
fi;
L_14: skip;
L_28_(v_0,v_dec): if :: true -> memory[v_0] = v_dec; goto L_28;
	:: true -> RET %retval.0 
fi;
L_15_(v_0,v_dec)(v_0,0): if :: true -> memory[v_0] = v_dec; goto L_15_(v_0,0);
	:: true -> %and = %5  & 65535 
fi;
L_15_(v_0,0): if :: true -> memory[v_0] = 0; goto L_15;
	:: true -> %and = %5  & 65535 
fi;
L_29_(v_0,v_dec): memory[v_0] = v_dec; goto L_29;
L_16_(v_0,v_dec)(v_0,0): if :: true -> memory[v_0] = v_dec; goto L_16_(v_0,0);
	:: true -> %add = %and  + 1 
fi;
L_15: %and = %5  & 65535 
L_16_(v_0,0): if :: true -> memory[v_0] = 0; goto L_16;
	:: true -> %add = %and  + 1 
fi;
L_17_(v_0,v_dec)(v_0,0): if :: true -> memory[v_0] = v_dec; goto L_17_(v_0,0);
	:: true -> %cmp5 = (%dec  == %shr )
fi;
L_16: %add = %and  + 1 
L_17_(v_0,0): if :: true -> memory[v_0] = 0; goto L_17;
	:: true -> %cmp5 = (%dec  == %shr )
fi;
L_18_(v_0,v_dec)(v_0,0): if :: true -> memory[v_0] = v_dec; goto L_18_(v_0,0);
	:: [%cmp5] -> goto L_19_(v_0,v_dec)(v_0,0);
	:: [else] -> goto L_24_(v_0,v_dec)(v_0,0);
fi;
L_17: %cmp5 = (%dec  == %shr )
L_18_(v_0,0): if :: true -> memory[v_0] = 0; goto L_18;
	:: [%cmp5] -> goto L_19_(v_0,0);
	:: [else] -> goto L_24_(v_0,0);
fi;
L_19_(v_0,v_dec)(v_0,0): memory[v_0] = v_dec; goto L_19_(v_0,0);
L_24_(v_0,v_dec)(v_0,0): if :: true -> memory[v_0] = v_dec; goto L_24_(v_0,0);
	:: true -> phi([%.pre , if.then6.if.end9_crit_edge], [%4 , if.end3(PC:18)])
fi;
L_18: if :: [%cmp5] -> goto L_19;
	:: [else] -> goto L_24;
fi;
L_19_(v_0,0): memory[v_0] = 0; goto L_19;
L_24_(v_0,0): if :: true -> memory[v_0] = 0; goto L_24;
	:: true -> phi([%.pre , if.then6.if.end9_crit_edge], [%4 , if.end3(PC:24)])
fi;
L_25_(v_0,v_dec)(v_0,0): if :: true -> memory[v_0] = v_dec; goto L_25_(v_0,0);
	:: true -> skip;
fi;
L_19: %6 = CAS(%4 , %5 , %add )
L_24: phi([%.pre , if.then6.if.end9_crit_edge(PC:23)], [%4 , if.end3(PC:24)])
L_25_(v_0,0): if :: true -> memory[v_0] = 0; goto L_25;
	:: true -> skip;
fi;
L_26_(v_0,v_dec)(v_0,0)(v_8,v_add): if :: true -> memory[v_0] = v_dec; goto L_26_(v_0,0)(v_8,v_add);
	:: true -> goto L_27_(v_0,v_dec)(v_0,0)(v_8,v_add);
fi;
L_20: %7 = (%6  == %5 )
L_25: skip;
L_26_(v_0,0)(v_8,v_add): if :: true -> memory[v_0] = 0; goto L_26_(v_8,v_add);
	:: true -> goto L_27_(v_0,0)(v_8,v_add);
fi;
L_27_(v_0,v_dec)(v_0,0)(v_8,v_add): if :: true -> memory[v_0] = v_dec; goto L_27_(v_0,0)(v_8,v_add);
	:: true -> phi([-1 , if.end9(PC:26)], [-1 , entry], [%3 , if.end], [%3 , if.then6])
fi;
L_21: if :: [%7] -> goto L_27;
	:: [else] -> goto L_22;
fi;
L_26_(v_8,v_add): if :: true -> memory[v_8] = v_add; goto L_26;
	:: true -> goto L_27_(v_8,v_add);
fi;
L_27_(v_0,0)(v_8,v_add): if :: true -> memory[v_0] = 0; goto L_27_(v_8,v_add);
	:: true -> phi([-1 , if.end9(PC:27)], [-1 , entry], [%3 , if.end], [%3 , if.then6])
fi;
L_28_(v_0,v_dec)(v_0,0)(v_8,v_add): if :: true -> memory[v_0] = v_dec; goto L_28_(v_0,0)(v_8,v_add);
	:: true -> RET %retval.0 
fi;
L_22: v_.pre = memory[ @age];
L_26: goto L_27;
L_27_(v_8,v_add): if :: true -> memory[v_8] = v_add; goto L_27;
	:: true -> phi([-1 , if.end9(PC:27)], [-1 , entry], [%3 , if.end], [%3 , if.then6])
fi;
L_28_(v_0,0)(v_8,v_add): if :: true -> memory[v_0] = 0; goto L_28_(v_8,v_add);
	:: true -> RET %retval.0 
fi;
L_29_(v_0,v_dec)(v_0,0)(v_8,v_add): memory[v_0] = v_dec; goto L_29_(v_0,0)(v_8,v_add);
L_23: goto L_24;
L_28_(v_8,v_add): if :: true -> memory[v_8] = v_add; goto L_28;
	:: true -> RET %retval.0 
fi;
L_29_(v_0,0)(v_8,v_add): memory[v_0] = 0; goto L_29_(v_8,v_add);
L_29_(v_8,v_add): memory[v_8] = v_add; goto L_29;

}



