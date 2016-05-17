// Start of user code operational SC model
// This code will not be regenerated, if you change it. Delete the file 
// or remove the first and last line of the file, if you want it to be regenerated.  
#define NULL 0

/*Speicher*/
short memory[MEM_SIZE];


inline write(adr, value)
{
	memory[adr] = value;
}
	
inline read(adr, target)
{
	target = memory[adr];
}


inline flush() {
	skip;	// no action
}

inline mfence() {
	skip; //no action
}

//Note, LLVM returns a tuple (i32, i1), the value read and a success bit.
//Sometimes the follow up code uses the succes bit but usually the read value. 
//Adjust CAS semantics, if necessary. 
inline cas(adr, oldValue, newValue, returnValue) {
	atomic{
		returnValue = memory[adr];
		if 	:: memory[adr] == oldValue
				-> memory[adr] = newValue;
			:: else -> skip;;
		fi;
	}
}

// End of user code
