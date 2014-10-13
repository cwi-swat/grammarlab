@contributor{Vadim Zaytsev - vadim@grammarware.net - SWAT, CWI; UvA}
// MOCKUP: SHOULD BE GENERATED? 
module grammarlab::language::glue::implode::Actions

import lang::json::\syntax::JSON;
import lang::json::ast::JSON;
//import lang::json::ast::Implode;
import grammarlab::language::glue::implode::JSONImplode;

import grammarlab::language::glue::implode::XBGF; // damn you, Rascal!
import grammarlab::language::glue::abstract::Top;
import grammarlab::language::glue::concrete::Actions;
import grammarlab::language::glue::concrete::BGF;
// A lot of things are needed to transform grammars :~-(
import grammarlab::language::Grammar;
import grammarlab::language::X;
import grammarlab::transform::XBGF;
import IO;

public loc toLocation(str s) = (/\|<car:.*>\:\/\/<cdr:.*>\|/ := s) ? |<car>://<cdr>| : |cwd:///<s>|;

GLUEA glimplode((GlueCommand)`<GlueKdiff _><GlueProduction+ ps>.`)
	= glaction(diff(transform(importG(mapPs(ps)),EmptyGrammar).g));
GLUEA glimplode((GlueCommand)`<GlueKmerge _><GlueProduction+ ps>.`)
	= glaction(merge(transform(importG(mapPs(ps)),EmptyGrammar).g));
GLUEA glimplode((GlueCommand)`<GlueKinclude _><GlueLoc z>.`)
	= glaction(include(toLocation("<z>")));
GLUEA glimplode((GlueCommand)`<GlueKannotate _><JSONText meta>.`)
	= metadata(lang::json::ast::Implode::buildAST(meta).members);
GLUEA glimplode((GlueCommand)`<GlueKmaybexbgf _><GlueCommand c>`)
{
	if (xbgf(t) := glimplode(c))
		return glaction(maybexbgf(t));
	else
		throw "Only maybe-XBGF commands supported!";
}
