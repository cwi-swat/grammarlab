@contributor{Vadim Zaytsev - vadim@grammarware.net - SWAT, CWI}
module grammarlab::io::read::GLUE

import grammarlab::language::glue::concrete::Top;
import grammarlab::language::glue::abstract::Top;
import grammarlab::language::glue::implode::Top;

public GLUE loadGlue(loc z) = glimplode(getGlue(z));
public GLUE loadGlue(str s) = glimplode(getGlue(s));
