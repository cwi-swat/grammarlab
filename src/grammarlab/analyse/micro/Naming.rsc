@contributor{Vadim Zaytsev - vadim@grammarware.net - SWAT, CWI}
module grammarlab::analyse::micro::Naming

import grammarlab::language::Grammar;
import grammarlab::language::Micro;

// NB: the "set[str]" parts are not needed, since the default case nicely covers them
// set[str] check4mp(camelCase(), GGrammar g) = {n | str n <- g.nts, /^([A-Z][a-z]*)+$/ := n};
bool check4mp(camelCase(), GGrammar g, str n) = n in g.nts && /^([A-Z][a-z]*)+$/       := n;
bool check4mp(mixedCase(), GGrammar g, str n) = n in g.nts && /^[a-z]+([A-Z][a-z]*)+$/ := n;
bool check4mp(lowerCase(), GGrammar g, str n) = n in g.nts && /^[a-z]+$/               := n;
bool check4mp(upperCase(), GGrammar g, str n) = n in g.nts && /^[A-Z]+$/               := n;
     
bool check4mp(camelCaseLax(), GGrammar g, str n) = n in g.nts && /^[\_]*([A-Z][a-z\d]*[\s\_\/\-\:\.\%]*)+$/                          := n;
bool check4mp(mixedCaseLax(), GGrammar g, str n) = n in g.nts && /^[\_]*[a-z]+[\s\_\/\-\:\.\%]*([A-Z\d][a-z\d]*[\s\_\/\-\:\.\%]*)+$/ := n;
bool check4mp(lowerCaseLax(), GGrammar g, str n) = n in g.nts && /^[a-z\d\s\_\/\-\:\.\%]+$/                                          := n;
bool check4mp(upperCaseLax(), GGrammar g, str n) = n in g.nts && /^[A-Z\d\s\_\/\-\:\.\%]+$/                                          := n;

// The next ones are a bit more tricky. What we want, is:
//  - more than one word
//  - camelcase, mixedcase or separated
//  - separators can be spaces, dashes, slashes and underscores
bool check4mp(miltiword(), GGrammar g, str n)
	=  /^[a-zA-Z][a-z]*([A-Z][a-z]*)+$/ := n
	|| /^[a-zA-Z]+([\s\_\/\-\:\.\%]+[a-zA-Z]+)+$/ := n;
bool check4mp(miltiwordLax(), GGrammar g, str n)
	=  /^\w[a-z\d]*([A-Z\d][a-z\d]*)+$/ := n
	|| /^[\s\_\/\-\:\.\%]*\w+([\s\_\/\-\:\.\%]+\w+)+$/ := n;
