@contributor{Vadim Zaytsev - vadim@grammarware.net - UvA}
@doc{This vaguely corresponds to XEDD from SLPS}
module grammarlab::notation::Operations

import grammarlab::language::EBNF;
import grammarlab::lib::ebnf::Default;

public EBNF fromDefault(Metasymbol m) = (m : (m in DefaultEBNF) ? DefaultEBNF[m] : "");
public EBNF fromDefault(Metasymbol m1, Metasymbol m2) = fromDefault(m1) + fromDefault(m2);

@doc{rename-metasymbol(s,v1,v2) from the BX2012 paper (EC-EASST vol. 49, page 5).}
public EBNF rename(EBNF bnf, Metasymbol m, str v1, str v2)
{
	assert m in bnf : "Metasymbol <m> not found in the input notation.";
	assert bnf[m] == v1 : "Metasymbol <m> is \"<bnf[m]>\", expected \"<v1>\".";
	return bnf + (m:v2);
}

@doc{introduce-metasymbol(s,v) from the BX2012 paper (EC-EASST vol. 49, page 5).}
public EBNF introduce(EBNF bnf, Metasymbol m, str v)
{
	assert m notin bnf : "Metasymbol <m> already found in the input notation.";
	return bnf + (m:v);
}

@doc{eliminate-metasymbol(s,v) from the BX2012 paper (EC-EASST vol. 49, page 5).}
public EBNF eliminate(EBNF bnf, Metasymbol m, str v)
{
	assert m in bnf : "Metasymbol <m> not found in the input notation.";
	assert bnf[m] == v : "Metasymbol <m> is \"<bnf[m]>\", expected \"<v>\".";
	return bnf - (m:v);
}

@doc{A simple union, with some extra assertions}
public EBNF add(EBNF bnf1, EBNF bnf2)
{
	for (m <- bnf1, m in bnf2)
		assert bnf1[m] == bnf2[m] : "Notations disagree on metasymbol <m>";
	return bnf1 + bnf2;
}

public EBNF add(EBNF bnf1, set[Metasymbol] bnfset2) = bnf1 - (k:fromDefault(k) | k <- bnfset2);

@doc{A simple difference}
public EBNF sub(EBNF bnf1, EBNF bnf2) = bnf1 - bnf2;
// TODO: special rules for nonterminals_may_start_with()
// TODO: special rules for nonterminals_may_contain()

public EBNF sub(EBNF bnf1, set[Metasymbol] bnfset2) = bnf1 - (k:"" | k <- bnfset2);

@doc{A strict difference with some extra assertions}
public EBNF ssub(EBNF bnf1, EBNF bnf2)
{
	for (m <- bnf1, m in bnf2)
		assert bnf1[m] == bnf2[m] : "Notations disagree on metasymbol <m>";
	return bnf1 - bnf2;
}

public EBNF subadd(EBNF bnf1, set[Metasymbol] bnfset2, set[Metasymbol] bnfset3) = add(sub(bnf1,bnfset2),bnfset3);
