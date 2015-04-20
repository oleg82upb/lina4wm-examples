inline ZN5StackC2Ev(){ 
L_0: %head = GetElementPtr %this 0 0 
L_1: skip;
L_2_(v_head,null): memory[v_head] = null; goto L_2;
L_2: RET  void
L_3: skip;
}

inline ZN5Stack4pushEi(){ 
L_0: %call = Call @_Znwj (8 )
L_1: %val = (i8*->i32*) %call 
L_2: skip;
L_3_(v_val,v_v): if :: true -> memory[v_val] = v_v; goto L_3;
	:: true -> %head = GetElementPtr %this 0 0 
fi;
L_3: %head = GetElementPtr %this 0 0 
L_4_(v_val,v_v): if :: true -> memory[v_val] = v_v; goto L_4;
	:: true -> %next = GetElementPtr %call 4 
fi;
L_4: %next = GetElementPtr %call 4 
L_5_(v_val,v_v): if :: true -> memory[v_val] = v_v; goto L_5;
	:: true -> %0 = (i8*->%class.Node**) %next 
fi;
L_5: %0 = (i8*->%class.Node**) %next 
L_6_(v_val,v_v): if :: true -> memory[v_val] = v_v; goto L_6;
	:: true -> %1 = (%class.Stack*->i32*) %this 
fi;
L_6: %1 = (%class.Stack*->i32*) %this 
L_7_(v_val,v_v): if :: true -> memory[v_val] = v_v; goto L_7;
	:: true -> %2 = (i8*->i32) %call 
fi;
L_7: %2 = (i8*->i32) %call 
L_8_(v_val,v_v): if :: true -> memory[v_val] = v_v; goto L_8;
	:: true -> goto L_9_(v_val,v_v);
fi;
L_8: goto L_9;
L_9_(v_val,v_v): if :: true -> memory[v_val] = v_v; goto L_9;
	:: true -> v_3 = memory[ v_head];
fi;
L_9: v_3 = memory[ v_head];
L_10_(v_val,v_v): if :: true -> memory[v_val] = v_v; goto L_10;
	:: true -> skip;
fi;
L_10: skip;
L_11_(v_val,v_v)(v_0,v_3): if :: true -> memory[v_val] = v_v; goto L_11_(v_0,v_3);
	:: true -> %4 = (%class.Node*->i32) %3 
fi;
L_11_(v_0,v_3): if :: true -> memory[v_0] = v_3; goto L_11;
	:: true -> %4 = (%class.Node*->i32) %3 
fi;
L_12_(v_val,v_v)(v_0,v_3): memory[v_val] = v_v; goto L_12_(v_0,v_3);
L_11: %4 = (%class.Node*->i32) %3 
L_12_(v_0,v_3): memory[v_0] = v_3; goto L_12;
L_12: %5 = CAS(%1 , %4 , %2 )
L_13: %6 = (%5  == %4 )
L_14: if :: [%6] -> goto L_15;
	:: [else] -> goto L_9;
fi;
L_15: RET  void
L_16: skip;
}

inline ZN5Stack3popEv(){ 
L_0: %head = GetElementPtr %this 0 0 
L_1: %0 = (%class.Stack*->i32*) %this 
L_2: goto L_3;
L_3: v_1 = memory[ v_head];
L_4: %cmp = (%1  == null )
L_5: if :: [%cmp] -> goto L_13;
	:: [else] -> goto L_6;
fi;
L_13: phi([null , do.body(PC:5)], [%1 , if.end(PC:12)])
L_6: %next = GetElementPtr %1 0 1 
L_14: RET %retval.0 
L_7: v_2 = memory[ v_next];
L_15: skip;L_8: %3 = (%class.Node*->i32) %1 
L_9: %4 = (%class.Node*->i32) %2 
L_10: %5 = CAS(%0 , %3 , %4 )
L_11: %6 = (%5  == %3 )
L_12: if :: [%6] -> goto L_13;
	:: [else] -> goto L_3;
fi;

}

