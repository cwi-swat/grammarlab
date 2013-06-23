@contributor{Vadim Zaytsev - vadim@grammarware.net - SWAT, CWI}
module grammarlab::transform::Normal;

import grammarlab::language::Grammar;
import grammarlab::lib::Squeeze;

public GGrammar normalise(GGrammar g)
{
	list[str] nts = g.nts;
	GProds ps = normalise(g.prods);
	
	for (n <- toSet(g.roots) + {n | /nonterminal(n) := ps})
		if (n notin nts)
		{
			g.nts += n;
			ps[n] = [];
		}
	return grammar(nts, g.roots, ps);
}

public GProds normalise(GProds ps) = (key:normalise(ps[key]) | key <- domain(ps));

// remove duplicate production rules
public GProdList normalise([L1*,GProd X1,L2*,X1,L3*]) = normalise([*L1,X1,*L2,*L3]);

public GProdList normalise(GProdList prods) = [normalise(p) | p <- prods]; 

public GProdSet normalise(GProdSet prods) = {normalise(p) | p <- prods}; 

public GProd normalise(GProd p) = production (p.lhs, normalise(p.rhs));

public GExpr normalise(GExpr e)
{
	// Algebraic normalisations; TODO: others needed?
	return innermost visit(e)
	{
		case sequence([]) => epsilon()
		case sequence([GExpr e1]) => e1
		case choice([]) => empty()
		case choice([GExpr e2]) => e2
		case optional(epsilon()) => epsilon()
		case optional(empty()) => epsilon()                             // not present in Prolog
		case selectable("",e4) => e4									// not present in Prolog
		case labelled("",e5) => e5										// not present in Prolog
		case plus(epsilon()) => epsilon()
		case star(epsilon()) => epsilon()
		case sepliststar(X1,epsilon()) => star(X1)
		case seplistplus(X2,epsilon()) => plus(X2)
		case sepliststar(epsilon(),X3) => star(X3)
		case seplistplus(epsilon(),X4) => star(X4)
		case sequence([L1*,sequence(L0),L2*]) => sequence(L1+L0+L2)
		case sequence([L3*,epsilon(),L4*]) => sequence(L3+L4)
		case sequence([_*,empty(),_*]) => empty()
		case choice([L5*,choice(L),L6*]) => choice(L5+L+L6)
		case choice([L7*,empty(),L8*]) => choice(L7+L8)
		case choice([*L9,X5,*L10,X5,*L11]) => choice([*L9,X5,*L10,*L11])
		// normalisations on Boolean grammars!
		case allof([]) => empty()
		case allof([GExpr e3]) => e3
		case allof([K1*,allof(K0),K2*]) => allof(K1+K0+K2)
		case allof([K3*,anything(),L2*]) => allof(K3+K4)
		case allof([K5*,X6,K6*,X6,K7*]) => allof([*K5,X6,*K6,*K7])
		case allof([_*,empty(),_*]) => empty()
		case allof([_*,X7,_*,not(X7),_*]) => empty()
		case choice([_*,X7,_*,not(X7),_*]) => anything()
		case not(empty()) => anything()
		case not(anything()) => empty()
	};
}

GGrammar tw(GExpr e)
{
	return grammar([foo],[],[production("foo",e)]);
}

test bool n1() {return normalise(tw(sequence([])))==tw(epsilon());}
test bool n2() {return normalise(tw(sequence([terminal("1")])))==tw(terminal("1"));}
test bool n3() {return normalise(tw(choice([])))==tw(empty());}
test bool n4() {return normalise(tw(choice([terminal("1")])))==tw(terminal("1"));}
test bool n5() {return normalise(tw(optional(epsilon())))==tw(epsilon());}
test bool n6() {return normalise(tw(plus(epsilon())))==tw(epsilon());}
test bool n7() {return normalise(tw(star(epsilon())))==tw(epsilon());}
test bool n8() {return normalise(tw(sequence([terminal("1"),sequence([terminal("2"),terminal("3")])])))
                               ==tw(sequence([terminal("1"),terminal("2"),terminal("3")]));}
test bool n9() {return normalise(tw(sequence([sequence([terminal("1"),terminal("2")]),terminal("3")])))
                               ==tw(sequence([terminal("1"),terminal("2"),terminal("3")]));}
test bool n10(){return normalise(tw(sequence([terminal("1"),epsilon(),terminal("2"),epsilon()])))
                               ==tw(sequence([terminal("1"),terminal("2")]));}
test bool n11(){return normalise(tw(choice([terminal("1"),choice([terminal("2"),terminal("3")])])))
                               ==tw(choice([terminal("1"),terminal("2"),terminal("3")]));}
test bool n12(){return normalise(tw(choice([choice([terminal("1"),terminal("2")]),terminal("3")])))
                               ==tw(choice([terminal("1"),terminal("2"),terminal("3")]));}
test bool n13(){return normalise(tw(choice([terminal("1"),terminal("2"),terminal("2"),terminal("3")])))
                               ==tw(choice([terminal("1"),terminal("2"),terminal("3")]));}
test bool n14(){return normalise(production("N",sequence([epsilon(),nonterminal("a"),nonterminal("b")])))
							  == production("N",sequence([nonterminal("a"),nonterminal("b")]));}
test bool n15(){return normalise(production("N",sequence([empty(),nonterminal("a"),nonterminal("b")])))
							  == production("N",empty());}
test bool n16(){return normalise(production("N",allof([epsilon(),nonterminal("a"),not(nonterminal("a"))])))
							  == production("N",empty());}
