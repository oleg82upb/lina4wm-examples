type KeySpace = int;

/*
record Location {
       key: KeySpace;
       gen: int;
}
*/

const unique null: KeySpace;
axiom null == 0;

var length: int;

type keyType = [int]KeySpace;
type genType = [int]int;
var key: keyType;
var gen: genType;

procedure Member(x: KeySpace) returns (r: bool)
{
  var mylength, i: int;
  var v: KeySpace;

  assume x > 0;

  i := 0;
  mylength := length;
  while(i < mylength) {
    while(i != mylength) {
      i := i + 1;

      v := key[i];

      if(v == x) {
        r := true;
        return;
      }
    }
    mylength := length;
  }
  r := false;
  return;
}

procedure Insert(x: KeySpace)
{
  var mylength, i: int;
  var added: bool;
  var holes: [int]int;
  var nholes: int;
  var v: KeySpace;

  assume x > 0;

  added := false;
  nholes := 0;

  mylength := length;
  i := 1;
  while(i <= mylength) {
    v := key[i];
    if(v == null) { 
      nholes := nholes + 1;
      holes[nholes] := i;
    }
    i := i + 1;
  }

  while(!added && nholes > 0) {
    atomic {
      added := (key[holes[nholes]] == null);
      if(added) {
        key[holes[nholes]] := x;
      }
    }
    nholes := nholes - 1;
  }

  while(!added) {
    atomic {
      length := length + 1;
      i := length;
    }
    atomic {
      added := (key[i] == null);
      if(added) {
        key[i] := x;
      }
    }
  }
  assert added;
}

procedure Delete(x: KeySpace)
{
  var mylength, i: int;
  var todo: [int]int;
  var gen: [int]int;
  var ntodo: int;
  var removed: bool;
  var v: KeySpace;
  var g: int;

  assume x > 0;

  ntodo := 0;

  mylength := length;
  i := 1;
  while(i <= mylength) {
    g := gen[i];
    v := key[i];
    if(v == null) { 
      ntodo := ntodo + 1;
      todo[ntodo] := i;
      gen[ntodo] := g;
    }
    i := i + 1;
  }

  i := 0;
  while(i <= ntodo) {
    atomic {
      removed := (gen[todo[i]] == gen[i]);
      if(removed) {
        key[todo[i]] := null;
	gen[todo[i]] := gen[todo[i]] + 1;
      }
    }
    i := i + 1;
  }

  assert removed;
}