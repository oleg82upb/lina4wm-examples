short ax = 0, ay = 0;
//scenarios only write and observe x and y
//must observe only atomic transactions


inline tabort(px,py)
{
	atomic{
	 assert(ay == py);
	 assert(ax == px);
	 }
}

inline t11(px,py)
{
	atomic{
	 ax = 1;
	 //short ly = ay;
	 assert(ay == py);
	 assert(ax == px);
	 }
}

inline t21(px,py)
{
	atomic{
	 ay = 1;
	 //short lx = ax;
	 assert(ay == py);
	 assert(ax == px);
	 }
}

inline t12(px,py)
{
	atomic{
	 ax = 1;
	 //short lx = ax;
	 //short ly = ay;
	 assert(ay == py);
	 assert(ax == px);
	 }
}

inline t22(px,py)
{
	atomic{
	 ay = 1;
	 //short ly = ay;
	 //short lx = ax;
	 assert(ay == py);
	 assert(ax == px);
	 }
}


//IRIW
inline t13(px,py)
{
	atomic{
	 ax = 1;
	 assert(ay == py);
	 assert(ax == px);
	}
}

inline t23(px,py)
{
	atomic{
	 ay = 1;
	 assert(ay == py);
	 assert(ax == px);
	}
}

inline t33(px,py)
{
	atomic{
	//short lx = ax;
	//short ly = ay;
	assert(ay == py);
	assert(ax == px);
	}
}

inline t43(px,py)
{
	atomic{
	//short ly = ay;
	//short lx = ax;
	assert(ay == py);
	assert(ax == px);
	}
}