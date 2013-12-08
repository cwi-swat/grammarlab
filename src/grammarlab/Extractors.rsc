@contributor{Vadim Zaytsev - vadim@grammarware.net - SWAT, CWI}
module grammarlab::Extractors

import grammarlab::language::Grammar;

import grammarlab::io::read::BGF;
import grammarlab::extract::SDF2BGF;
import grammarlab::extract::RelaxNG2BGF;
import grammarlab::extract::RascalADT2BGF;
import grammarlab::extract::RascalSyntax2BGF;
import grammarlab::extract::RascalFunctions2BGF;
import grammarlab::extract::XMLSchemaDefinition2BGF;
import grammarlab::extract::PGF2BGF;

public GGrammar rscd2bgf(loc z) = grammarlab::extract::RascalADT2BGF::extractG(z);
public GGrammar rscs2bgf(loc z) = grammarlab::extract::RascalSyntax2BGF::extractG(z);
public GGrammar rscf2bgf(loc z) = grammarlab::extract::RascalFunctions2BGF::extractG(z);
public GGrammar sdf2bgf(loc z) = grammarlab::extract::SDF2BGF::extractG(z);
public GGrammar bgf2bgf(loc z) = grammarlab::io::read::BGF::readBGF(z);
public GGrammar rng2bgf(loc z) = grammarlab::extract::RelaxNG2BGF::extractG(z);
public GGrammar xsd2bgf(loc z) = grammarlab::extract::XMLSchemaDefinition2BGF::extractG(z);
public GGrammar pgf2bgf(loc z) = grammarlab::extract::PGF2BGF::extractG(z);
//public GGrammar bnf2bgf(loc z); // TODO: connect Grammar Hunter!
