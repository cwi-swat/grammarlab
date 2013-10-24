@contributor{Vadim Zaytsev - vadim@grammarware.net - SWAT, CWI}
// MOCKUP: SHOULD BE GENERATED? 
module grammarlab::language::glue::MapGLA2A

import grammarlab::language::glue::MapXBGF2A; // damn you, Rascal!
import grammarlab::language::glue::Abstract;
import grammarlab::language::glue::Actions;
import grammarlab::language::glue::Productions;
// A lot of things are needed to transform grammars :~-(
import grammarlab::language::Grammar;
import grammarlab::language::X;
import grammarlab::transform::XBGF;
import IO;

public loc toLocation(str s) = (/\|<car:.*>\:\/\/<cdr:.*>\|/ := s) ? |<car>://<cdr>| : |cwd:///<s>|;

GLUEA glimplode((GlueCommand)`<GlueKdiff _><GlueProduction+ ps>.`) = glaction(diff(transform(importG(mapPs(ps)),EmptyGrammar).g));
GLUEA glimplode((GlueCommand)`<GlueKinclude _><GlueLoc z>.`) = glaction(include(toLocation("<z>")));
GLUEA glimplode((GlueCommand)`<GlueKmaybexbgf _><GlueCommand c>`)
{
	if (xbgf(t) := glimplode(c))
		return glaction(maybexbgf(t));
	else
		throw "Only maybe-XBGF commands supported!";
}
