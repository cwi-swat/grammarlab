@contributor{Vadim Zaytsev - vadim@grammarware.net - SWAT, CWI}
module grammarlab::Extractors

import grammarlab::extract::RascalADT2BGF;
import grammarlab::extract::RascalSyntax2BGF;

GGrammar rscd2bgf(loc z) = grammarlab::extract::RascalADT2BGF::extractG(z);
GGrammar rscs2bgf(loc z) = grammarlab::extract::RascalSyntax2BGF::extractG(z);
