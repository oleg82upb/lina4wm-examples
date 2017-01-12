short mtxOwner = 0;

inline acquire(id)
{
	atomic{
	 assert(mtxOwner == 0);
	 mtxOwner = id;
	 }
}

inline release(id)
{
	atomic{
	 assert(mtxOwner == id);
	 mtxOwner = 0;
	 }
}



// since our implementations never fail, we can also linearize 
// them even after an actual linearization point. Otherwise, we would have 
// to instrument the exact transition that is the LP, because other processes 
// could observe a wrong state.