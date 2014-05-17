@contributor{Vadim Zaytsev - vadim@grammarware.net - SWAT, CWI}
module grammarlab::transform::Normal

import grammarlab::language::Grammar;
import grammarlab::lib::Squeeze;
import grammarlab::lib::Sizes;
import grammarlab::transform::SLEIR;
//import List; //toSet

public GGrammar  normanon(GGrammar g)   =  RetireSs(RetireLs(g));
public GProdList normanon(GProdList ps) = [RetireSs(RetireLs(p)) | p <- ps];
public GProd     normanon(GProd p)      =  RetireSs(RetireLs(p));
public GExpr     normanon(GExpr e)      =  RetireSs(RetireLs(e));

public GGrammar normalise(GGrammar g)
{
	GProdList ps = normalise(g.P);
	if (isEmpty(ps))
		return grammar([], [], g.S);
	else
		return grammar(squeeze([p.lhs | p <- ps]), ps, g.S);
	// retired definition: [n | n<-g.N, n in [p.lhs | p <- ps] || n in g.S]
}

// remove duplicate production rules
public GProdList normalise([L1*,GProd X1,L2*,X1,L3*]) = normalise([*L1,X1,*L2,*L3]);

public GProdList normalise(GProdList prods) = [normalise(p) | GProd p <- prods, p.rhs != nothing()]; 

public GProdSet normalise(GProdSet prods) = {normalise(p) | GProd p <- prods, p.rhs != nothing()}; 

public GProd normalise(GProd p) = production (p.lhs, normalise(p.rhs));

public GExpr normalise(GExpr e)
{
	// Algebraic normalisations; TODO: others needed?
	return innermost visit(e)
	{
		// an empty sequence is ε
		case sequence([]) => epsilon()
		// an trivial sequence is its only element
		case sequence([GExpr e1]) => e1
		// an empty choice is φ (“nothing to choose from”)
		case choice([]) => empty()
		// a trivial choice is its only element
		case choice([GExpr e2]) => e2
		// an optional ε is still ε
		case optional(epsilon()) => epsilon()
		// an optional φ is ε (“there is an option to fail”)
		case optional(empty()) => epsilon()
		// an empty label is useless
		case label("",e4) => e4
		// a one or more ε is still ε
		case plus(epsilon()) => epsilon()
		// a zero or more ε is still ε
		case star(epsilon()) => epsilon()
		// an ε-separated star-list is a Kleene star
		case sepliststar(X1,epsilon()) => star(X1)
		// an ε-separated plus-list is a Kleene plus
		case seplistplus(X2,epsilon()) => plus(X2)
		// a separated star-list of empty elements is a Kleene star
		case sepliststar(epsilon(),X3) => star(X3)
		// a separated plus-list of empty elements is a Kleene star
		case seplistplus(epsilon(),X4) => star(X4)
		// inline nested sequences
		case sequence([L1*,sequence(L0),L2*]) => sequence(L1+L0+L2)
		// ε is skipped over in a sequence
		case sequence([L3*,epsilon(),L4*]) => sequence(L3+L4)
		// if φ is a part of a sequence, the whole sequence is φ
		case sequence([_*,empty(),_*]) => empty()
		// inline nested choices
		case choice([L5*,choice(L),L6*]) => choice(L5+L+L6)
		// φ is skipped over in a choice
		case choice([L7*,empty(),L8*]) => choice(L7+L8)
		// remove duplicate alternatives in a choice
		case choice([*L9,X5,*L10,X5,*L11]) => choice([*L9,X5,*L10,*L11])
		// an empty conjunction is φ (“all of nothing”)
		case allof([]) => empty()
		// a trivial conjunction is its own only element
		case allof([GExpr e3]) => e3
		// inline nested conjunctions
		case allof([K1*,allof(K0),K2*]) => allof(K1+K0+K2)
		// α is skipped over in a conjunction
		case allof([K3*,anything(),L2*]) => allof(K3+K4)
		// remove duplicate alternatives in a conjunction
		case allof([K5*,X6,K6*,X6,K7*]) => allof([*K5,X6,*K6,*K7])
		// if φ is a part of a conjunction, the whole conjunction is φ
		case allof([_*,empty(),_*]) => empty()
		// having X and not X in the same conjunction will always fail
		case allof([_*,X7,_*,not(X7),_*]) => empty()
		// having X and not X in the same disjunction will always succeed
		case choice([_*,X7,_*,not(X7),_*]) => anything()
		// not nothing is everything
		case not(empty()) => anything()
		// not everything is nothing
		case not(anything()) => empty()
		// “except nothing” is useless
		case except(X8,empty()) => X8
		// “except everything” will fail
		case except(_,anything()) => empty()
		// “nothing except …” will fail
		case except(empty(),_) => empty()
		// “everything except …” is just negation
		case except(anything(),X9) => not(X9)
		// “except not” is a conjunction
		case except(X10,not(X11)) => allof([X10,X11])
		// having X and not X in the except construct will always fail
		case except(X14,not(X14)) => empty()
		// disregarding special metasyntactical trick
		case sequence([N1*,nothing(),N2*]) => sequence(N1+N2)
		case choice([N3*,nothing(),N4*]) => choice(N3+N4)
		case allof([N5*,nothing(),N6*]) => allof(N5+N6)
		// TODO: make it safe by catching other places for nothing()? 
	};
}

GGrammar tw(GExpr e)
{
	return grammar(["foo"],[production("foo",e)],[]);
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
