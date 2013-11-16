@contributor{Vadim Zaytsev - vadim@grammarware.net - SWAT, CWI}
module \test::GLUE

import String;
import IO;
import grammarlab::io::GLUE;

test bool main()
{
	loc base = |project://grammarlab/src/test/set/|;
	for
	(
		str d <- ["diff","xbgf","sleir"],
		str f <- listEntries(base+d),
		endsWith(f,".glue")
	)
	{
		loc uri = base+"<d>/<f>";
		println("Parsing <uri>...");
		loadGlue(uri);
	}
	return true;
}
