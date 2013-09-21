@contributor{Vadim Zaytsev - vadim@grammarware.net - SWAT, CWI}
module grammarlab::lib::RascalPlus

import Set;
import List;

// joins a list of strings with a separator
// (if some of the following code doesn’t work, update Rascal)
public str joinStrings(list[str] ss) = intercalate(", ",ss);
public str joinStrings(list[str] ss, str w) = intercalate(w,ss);
public str joinStrings(set[str]  ss) = intercalate(", ",sort(ss));
public str joinStrings(set[str]  ss, str w) = intercalate(w,sort(ss));

public str mapjoin(&T1(&T2) f, list[&T2] xs, str sep) = joinStrings(mapper(xs,f),sep);
public str mapjoin(&T1(&T2) f, list[&T2] xs) = joinStrings(mapper(xs,f)," ");
public str mapjoin(&T1(&T2) f, set[&T2] xs, str sep) = joinStrings(toList(mapper(xs,f)),sep);

public num summap(num(&T) f, list[&T] xs) = sum(mapper(xs,f));
// TODO: count which one of the three is faster
//public num summap(num(&T) f, list[&T] xs) = sum([f(x) | &T x <- xs]);
//public num summap(num(&T) f, list[&T] xs) = (0 | it + f(x) | &T x <- xs);