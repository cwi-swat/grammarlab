@contributor{Vadim Zaytsev - vadim@grammarware.net - UvA}
module grammarlab::Exporters

import IO;
import grammarlab::language::Grammar;
import grammarlab::io::write::BGF;
import grammarlab::export::Grammar;
import grammarlab::export::RascalADT;
import grammarlab::export::RascalSyntax;

public void bgf2bnf(loc z, str _, GGrammar g) = writeFile(z,grammarlab::export::Grammar::ppx(g));
public void bgf2bgf(loc z, str _, GGrammar g) = grammarlab::io::write::BGF::writeBGF(g,z);
public void bgf2rscd(loc z, str n, GGrammar g) = writeFile(z,grammarlab::export::RascalADT::exportRascalADT(n,g));
public void bgf2rscs(loc z, str n, GGrammar g) = writeFile(z,grammarlab::export::RascalSyntax::exportRascalSyntax(n,g));
