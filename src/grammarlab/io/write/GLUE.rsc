@contributor{Vadim Zaytsev - vadim@grammarware.net - SWAT, CWI}
module grammarlab::io::write::GLUE

import grammarlab::language::glue::abstract::Top;
import grammarlab::export::GLUE;
import IO;

public void writeGlue(GLUE g, loc f) = writeFile(f,ppx(g));
