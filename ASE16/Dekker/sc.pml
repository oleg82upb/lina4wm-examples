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
	
inline cas(adr, oldValue, newValue, returnValue) {
	atomic{
		if 	:: memory[adr] == oldValue
				-> {
					memory[adr] = newValue;
					returnValue = true;
					}
			:: else -> returnValue = false;
		fi;
	}
}

// End of user code
