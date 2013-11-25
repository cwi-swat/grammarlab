@contributor{Vadim Zaytsev - vadim@grammarware.net - SWAT, CWI}
module grammarlab::extract::rascal::Name

import String;

str name2string(str s) = (startsWith(s,"\\"))?substring(s,1):s;
