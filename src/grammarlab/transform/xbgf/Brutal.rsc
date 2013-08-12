@contributor{Vadim Zaytsev - vadim@grammarware.net - SWAT, CWI}
module grammarlab::transform::xbgf::Brutal

//import lib::Rascalware;
import grammarlab::language::Grammar;
import grammarlab::language::X;
import grammarlab::language::XScope;
import grammarlab::language::XOutcome;
import grammarlab::transform::xbgf::Util;
import grammarlab::transform::Normal;
import grammarlab::compare::Differ;

XResult runReplace(GExpr e1, GExpr e2, XScope w, GGrammar g)
{
	GProdList ps1,ps2,ps3,ps4;
	<ps1,ps2,ps3> = splitPbyW(g.prods, w);
	ps4 = performReplace(e1,e2,ps2);
	if (ps2 == ps4)
		{
			ps4 = performReplace(normalise(e1),normalise(e2),ps2); // TODO check if needed
			if (ps2 == ps4)
				return <problemExpr2("Vacuous replace",e1,e2),g>;
		}
	return <ok(),grammar(g.roots, ps1 + normalise(ps4) + ps3)>;
}

GProdList performReplace(GExpr e1, GExpr e2, GProdList ps)
{
	GExprList L5;
	switch(e1)
	{
		case sequence(L1):
		{
			if (sequence(L4) := e2) L5 = L4; else L5 = [e2];
			return visit(ps){case sequence(L2) => sequence(replaceSubsequence(L2,L1,L5))};
		}
		case choice(L1): 
		{
			if (choice(L4) := e2) L5 = L4; else L5 = [e2];
			return visit(ps){case choice(L2) => choice(replaceChoice(L2,L1,L5))};
		}
		default:
			return visit(ps){case e1 => e2}
	}
}

GExprList replaceSubsequence(GExprList where, GExprList what, GExprList with)
{
	if (eqE(sequence(where),sequence(what))) return with;
	int i = 0, sz = len(what);
	while (i+sz <= len(where))
	{
		if (eqE(sequence(slice(where,i,sz)),sequence(what)))
			return slice(where,0,i) + with + slice(where, i+sz, len(where)-i-sz);
		i+=1;
	}
	return where;
}

GExprList replaceChoice(GExprList where, GExprList what, GExprList with)
{
	if (eqE(choice(where),choice(what))) return with;
	unmatched = where;
	<res,es1,es2> = grammarlab::compare::Differ::tryMatchChoices(what,where);
	if (res)
		return es1 + with + es2;
	else
		return where;
}
