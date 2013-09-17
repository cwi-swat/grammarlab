@contributor{Vadim Zaytsev - vadim@grammarware.net - SWAT, CWI}
module grammarlab::lib::Haskell

import List;

public num summap(num(&T) f, list[&T] xs) = sum(mapper(xs,f));
// TODO: count which one of the three is faster
//public num summap(num(&T) f, list[&T] xs) = sum([f(x) | &T x <- xs]);
//public num summap(num(&T) f, list[&T] xs) = (0 | it + f(x) | &T x <- xs);