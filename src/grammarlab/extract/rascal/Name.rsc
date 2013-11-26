@contributor{Vadim Zaytsev - vadim@grammarware.net - SWAT, CWI}
module grammarlab::extract::rascal::Name

import String;

str name2string(str s) = (startsWith(s,"\\"))?substring(s,1):s;

str module2name(str s) = replaceAll(split("\n",split("module ",s)[1])[0],"\\","");