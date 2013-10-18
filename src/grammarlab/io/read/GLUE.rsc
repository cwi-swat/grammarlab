@contributor{Vadim Zaytsev - vadim@grammarware.net - SWAT, CWI}
module grammarlab::io::read::GLUE

import grammarlab::language::glue::Concrete;
import grammarlab::language::glue::Abstract;
import grammarlab::language::glue::Mapper;

public GLUE loadGlue(loc z) = glimplode(getGlue(z));
public GLUE loadGlue(str s) = glimplode(getGlue(s));
