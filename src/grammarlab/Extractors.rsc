@contributor{Vadim Zaytsev - vadim@grammarware.net - SWAT, CWI}
module grammarlab::Extractors

import grammarlab::extract::RascalADT2BGF;
import grammarlab::extract::RascalSyntax2BGF;
import grammarlab::io::read::BGF;
import grammarlab::extract::SDF2BGF;

GGrammar rscd2bgf(loc z) = grammarlab::extract::RascalADT2BGF::extractG(z);
GGrammar rscs2bgf(loc z) = grammarlab::extract::RascalSyntax2BGF::extractG(z);
GGrammar sdf2bgf(loc z) = grammarlab::extract::SDF2BGF::extractG(z);
GGrammar bgf2bgf(loc z) = grammarlab::io::read::BGF::readBGF(z);
