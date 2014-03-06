@contributor{Vadim Zaytsev - vadim@grammarware.net - UvA}
module grammarlab::mapping::BGF2XMLWriter

import grammarlab::language::XHTML;
import grammarlab::io::XHTML;

/*
	problem 1: get the standard Grammar of XHTML
	problem 2: generate/design good ADT for HTML
	problem 3: map XHTML ADT to XML DOM
		solved by grammarlab::language::XHTML
	problem 4: read XML as XHTML ADT
*/

public void main()
{
	writeHTML(grammarlab::language::XHTML::example,|project://grammarlab/data/index.html|);
}