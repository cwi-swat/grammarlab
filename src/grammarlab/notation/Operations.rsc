@contributor{Vadim Zaytsev - vadim@grammarware.net - UvA}
@doc{This vaguely corresponds to XEDD from SLPS}
module grammarlab::notation::Operations

import grammarlab::language::EBNF;

@doc{rename-metasymbol(s,v1,v2) from the BX2012 paper (EC-EASST vol. 49, page 5).}
EBNF rename(EBNF bnf, Metasymbol m, str v1, str v2)
{
	assert m in bnf : "Metasymbol <m> not found in the input notation.";
	assert bnf[m] == v1 : "Metasymbol <m> is \"<bnf[m]>\", expected \"<v1>\".";
	return bnf + (m:v2);
}

@doc{introduce-metasymbol(s,v) from the BX2012 paper (EC-EASST vol. 49, page 5).}
EBNF introduce(EBNF bnf, Metasymbol m, str v)
{
	assert m notin bnf : "Metasymbol <m> already found in the input notation.";
	return bnf + (m:v);
}

@doc{eliminate-metasymbol(s,v) from the BX2012 paper (EC-EASST vol. 49, page 5).}
EBNF eliminate(EBNF bnf, Metasymbol m, str v)
{
	assert m in bnf : "Metasymbol <m> not found in the input notation.";
	assert bnf[m] == v : "Metasymbol <m> is \"<bnf[m]>\", expected \"<v>\".";
	return bnf - (m:v);
}

@doc{A simple union, with some extra assertions}
EBNF add(EBNF bnf1, EBNF bnf2)
{
	for (m <- bnf1, m in bnf2)
		assert bnf1[m] == bnf2[m] : "Notations disagree on metasymbol <m>";
	return bnf1 + bnf2;
}

@doc{A simple difference, with some extra assertions}
EBNF sub(EBNF bnf1, EBNF bnf2)
{
	for (m <- bnf1, m in bnf2)
		assert bnf1[m] == bnf2[m] : "Notations disagree on metasymbol <m>";
	return bnf1 + bnf2;
}
