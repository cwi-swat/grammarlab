@contributor{Vadim Zaytsev - vadim@grammarware.net - SWAT, CWI}
// MOCKUP: SHOULD BE GENERATED? 
module grammarlab::language::glue::MapExts2A

import grammarlab::language::glue::Abstract;
import grammarlab::language::glue::Actions;
import grammarlab::language::glue::Productions;
// A lot of things are needed to transform grammars :~-(
import grammarlab::language::Grammar;
import grammarlab::language::X;
import grammarlab::transform::XBGF;
import IO;

public loc toLocation(str s) = (/\|<car:.*>\:\/\/<cdr:.*>\|/ := s) ? |<car>://<cdr>| : |cwd:///<s>|;

GLUEA glimplode((GlueCommand)`<GlueKextract _> <GlueWord w> <GlueLoc z>.`)
	= glaction(extract(mapSrc(w),toLocation("<z>")));

GExternalType mapSrc("RascalADT") = GETrscd();
GExternalType mapSrc("RascalSyntax") = GETrscs();
GExternalType mapSrc("SDF") = GETsdf();
GExternalType mapSrc("BGF") = GETbgf();
GExternalType mapSrc("RelaxNG") = GETrng();
GExternalType mapSrc("XSD") = GETxsd();
GExternalType mapSrc("PGF") = GETpgf();
default GExternalType mapSrc(str s)
{
	throw "Unknown extractor <s>";
}