@contributor{Vadim Zaytsev - vadim@grammarware.net - SWAT, CWI}
module grammarlab::lib::Location

@doc{
Synopsis: Convert a string value to a (source code) location.

Description:
# Converts string `s` to a location.
# If the scheme is not provided, it is assumed to be `cwd`.

Examples:
<screen>
import String;
toLocation("http://grammarware.net");
toLocation("rascal://lang::rascal::syntax::Rascal");
toLocation("document.xml");
</screen>
}
public loc toLocation(/<car:.*>\:\/\/<cdr:.*>/) = |<car>://<cdr>|; 
public default loc toLocation(str s) = |cwd:///<s>|;

test bool s2lsa() = toLocation("http://grammarware.net") == |http://grammarware.net|;
test bool s2lsap() = toLocation("http://grammarware.net/works") == |http://grammarware.net/works|;
test bool s2lsaps() = toLocation("http://grammarware.net/is/") == |http://grammarware.net/is/|;
test bool s2lsapf() = toLocation("http://grammarware.net/writes/#NPGR2013") == |http://grammarware.net/writes/#NPGR2013|;
test bool s2la() = toLocation("cwd:///") == |cwd:///|;
test bool s2lr() = toLocation("rascal://lang::xml::DOM") == |rascal://lang::xml::DOM|;
test bool s2lp() = toLocation("project:///grammarlab/src/grammarlab/language/Grammar.rsc") == |project:///grammarlab/src/grammarlab/language/Grammar.rsc|;
test bool s2lsapq() = toLocation("https://maps.google.com/maps?q=Lauriergracht,+Jordaan,+Amsterdam,+The+Netherlands&hl=en&sll=37.0625,-95.677068&sspn=68.848233,93.076172&oq=lauriergracht&hnear=Lauriergracht,+Amsterdam,+Noord-Holland,+The+Netherlands&t=m&z=17")
	== |https://maps.google.com/maps?q=Lauriergracht,+Jordaan,+Amsterdam,+The+Netherlands&hl=en&sll=37.0625,-95.677068&sspn=68.848233,93.076172&oq=lauriergracht&hnear=Lauriergracht,+Amsterdam,+Noord-Holland,+The+Netherlands&t=m&z=17|;
test bool s2lunk() = toLocation("bla") == |cwd:///bla|;
