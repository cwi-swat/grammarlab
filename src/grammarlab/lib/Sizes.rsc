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
public bool isEmpty(str x)          = (x=="");