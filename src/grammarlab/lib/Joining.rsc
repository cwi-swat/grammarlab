@contributor{Vadim Zaytsev - vadim@grammarware.net - SWAT, CWI}
module grammarlab::lib::Joining

import Set;
import List;

// joins a list of strings with a separator
public str joinStrings([], _) = "";
public str joinStrings(list[str] ss) = joinStrings(ss,", ");
public str joinStrings(list[str] ss, str w) = (ss[0] | it + w + s | s <- tail(ss));
// TODO: in newer versions of Rascal, sort() is defined on sets too
public str joinStrings(set[str] ss) = joinStrings(sort(toList(ss)),", ");
public str joinStrings(set[str] ss, str w) = joinStrings(sort(toList(ss)),w);

public str mapjoin(&T1(&T2) f, list[&T2] xs, str sep) = joinStrings(mapper(xs,f),sep);
public str mapjoin(&T1(&T2) f, list[&T2] xs) = joinStrings(mapper(xs,f)," ");
public str mapjoin(&T1(&T2) f, set[&T2] xs, str sep) = joinStrings(toList(mapper(xs,f)),sep);
