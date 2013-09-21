@contributor{Vadim Zaytsev - vadim@grammarware.net - SWAT, CWI}
module grammarlab::lib::Sizes

import Relation;
import String;
import List;
import Set;
import Map;

// one length to rule them all
public int len(list[&T] x)     = List::size(x);
public int len(set[&T] x)      = Set::size(x);
public int len(map[&T1,&T2] x) = Map::size(x);
public int len(rel[&T1,&T2] x) = Relation::size(x);
public int len(str x)          = String::size(x);

// one isempty to rule them all
public bool isEmpty(list[&T] x)     = List::isEmpty(x);
public bool isEmpty(set[&T] x)      = Set::isEmpty(x);
public bool isEmpty(map[&T1,&T2] x) = Map::isEmpty(x);
public bool isEmpty(rel[&T1,&T2] x) = Relation::isEmpty(x);
public bool isEmpty(str x)          = x=="";

// one istrivial to rule them all
// TODO: which way is better - readable/higherlevel or Rascal/lowerlevel?
public bool isTrivial([&T x])             = true;
public default bool isTrivial(list[&T] x) = false;
public bool isTrivial({&T x})             = true;
public default bool isTrivial(set[&T] x)  = false;
public bool isTrivial(map[&T1,&T2] x)     = len(x) == 1;
public bool isTrivial(rel[&T1,&T2] x)     = len(x) == 1;
public bool isTrivial(str x)              = len(x) == 1;

// count the number of unique members
public int ulen(list[&T] x)             = Set::size(List::toSet(x));
public int ulen( set[&T] x)             = Set::size(x);
public int ulen( set[&T] x, list[&T] y) = Set::size(x+List::toSet(y));
public int ulen(list[&T] x,  set[&T] y) = Set::size(y+List::toSet(x));
