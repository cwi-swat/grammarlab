@contributor{Vadim Zaytsev - vadim@grammarware.net - SWAT, CWI}
module grammarlab::compare::Differ

import IO;
import List;
import grammarlab::language::Grammar;
import grammarlab::transform::Normal;
import grammarlab::lib::Squeeze;
import grammarlab::export::Grammar;

tuple[bool,GExprList,GExprList] tryMatchChoices(GExprList L1, GExprList L2) = tryMatchChoices([],L1,[],L2,false);
tuple[bool,GExprList,GExprList] tryMatchChoices(GExprList es1, [], GExprList es2, GExprList L2, false) = <false,[],[]>; 
tuple[bool,GExprList,GExprList] tryMatchChoices(GExprList es1, [], GExprList es2, GExprList L2, true) = <true,es1,es2+L2>;
tuple[bool,GExprList,GExprList] tryMatchChoices(GExprList es1, GExprList L1, GExprList es2, [], bool hit) = <false,[],[]>;
tuple[bool,GExprList,GExprList] tryMatchChoices(GExprList es1, GExprList L1, GExprList es2, GExprList L2, bool hit)
{
	for (y <- L2)
	{
		for (x <- L1)
			if (eqE(x,y))
				return tryMatchChoices(es1,L1-x,es2,L2-y,true);
		if (hit)
			es2 += y;
		else
			es1 += y;
		L2 -= y;
	}
	return <false,[],[]>;
}

// expression equality
public bool eqE(choice([GExpr e1]), choice([GExpr e2])) = eqE(e1,e2);
public bool eqE(choice(L1), choice(L2))
{
	for (x <- L1, y <- L2)
		if (eqE(x,y))
			return eqE(choice(L1 - x), choice(L2 - y));
	return false;
}
public bool eqE(allof([GExpr e1]), allof([GExpr e2])) = eqE(e1,e2);
public bool eqE(allof(L1), allof(L2))
{
	for (x <- L1, y <- L2)
		if (eqE(x,y))
			return eqE(allof(L1 - x), allof(L2 - y));
	return false;
}

public bool eqE(except(GExpr e1a, GExpr e1b), except(GExpr e2a, GExpr e2b)) = eqE(e1a,e2a) && eqE(e1b,e2b);

public bool eqE(sequence(L1), sequence(L2))
{
	if (size(L1) != size(L2)) return false;
	for (i <- [0..size(L1)-1])
		//if (choice(L3) := L1[i] && choice(L4) := L2[i])
		if (!eqE(L1[i],L2[i])) return false;
	return true;
}

public bool eqE(label(str X1, GExpr E1), label(str X2, GExpr E2)) = X1==X2 && eqE(E1,E2);
public bool eqE(mark(str X1, GExpr E1), mark(str X2, GExpr E2)) = X1==X2 && eqE(E1,E2);
public bool eqE(not(GExpr E1), not(GExpr E2)) =  eqE(E1,E2);
public bool eqE(optional(GExpr E1), optional(GExpr E2)) =  eqE(E1,E2);
public bool eqE(star(GExpr E1), star(GExpr E2)) =  eqE(E1,E2);
public bool eqE(plus(GExpr E1), plus(GExpr E2)) =  eqE(E1,E2);
public bool eqE(seplistplus(GExpr E11, GExpr E12), seplistplus(GExpr E21, GExpr E22)) =  eqE(E11,E21) && eqE(E12,E22);
public bool eqE(sepliststar(GExpr E11, GExpr E12), sepliststar(GExpr E21, GExpr E22)) =  eqE(E11,E21) && eqE(E12,E22);

public bool eqE(nonterminal(str n1), nonterminal(n1)) = true;
public bool eqE(terminal(str t1), terminal(t1)) = true;
public bool eqE(val(GValue v1), val(v1)) = true;

public default bool eqE(GExpr e1, GExpr e2) = e1 == e2;

public bool eqP(production(str x, GExpr e1), production(x, GExpr e2)) = eqE(e1,e2);
public bool eqP(GProd p1, GProd p2) = p1 == p2;

public bool eqPs(GProdList ps1, GProdList ps2) = gdt(ps1,ps2) == <[],[]>;

// order-preserving comparison
public bool eqEsO(GExprList L1, GExprList L2) = len(L1)==len(L2) && (true | eqE(L1[i],L2[i]) | int i <- [0..len(L1)]);

// not order-preserving comparison
public bool eqEsN([], []) = true;
public default bool eqEsN(GExprList L1, GExprList L2)
{
	for (GExpr e1 <- L1, GExpr e2 <- L2)
		if (eqE(e1,e2))
			return eqEsN(L1-e1, L2-e2);
	return false;
}

// generic differ, returns unmatched production rules
tuple[GProdList,GProdList] gdt(GProdList ps1, GProdList ps2)
{
	ps3 = normalise(ps1);
	ps4 = normalise(ps2);
	if (toSet(ps3)==toSet(ps4)) return <[],[]>;
	return <
		[p | p <- ps3, isEmpty([q | q <- ps4, eqP(p,q)])],
		[p | p <- ps4, isEmpty([q | q <- ps3, eqP(p,q)])]
	>;
}

// silent
public bool gdts(GGrammar g1, GGrammar g2)
{
	if (toSet(g1.N)!=toSet(g2.N)) return false;
	if (toSet(g2.S)!=toSet(g2.S)) return false;
	<unmatched1,unmatched2> = gdt(g1.P,g2.P);
	if (isEmpty(unmatched1) && isEmpty(unmatched2)) return true;
	// TODO keep trying?
	return false;
}

// verbose
public bool gdtv(GGrammar g1, GGrammar g2)
{
	bool res = true;
	if (toSet(g1.S)!=toSet(g2.S))
	{
		println("Different roots: <g1.S> vs <g2.S>.");
		res = false;
	}
	if (toSet(g1.N)!=toSet(g2.N))
	{
		println("Unmatched nonterminal sets:\n - <toSet(g1.N)-toSet(g2.N)>\nvs\n - <toSet(g2.N)-toSet(g1.N)>");
		res = false;
	}
	<unmatched1,unmatched2> = gdt(g1.P,g2.P);
	if (isEmpty(unmatched1) && isEmpty(unmatched2))
		return res;
	else
		res = false;
	println("Grammars differ!");
	for (str nt <- squeeze(g1.N + g2.N))
	{
		println(" - Fail on <nt>:");
		for (p:production(nt,_) <- unmatched1)
			println("   - <ppx(p)>");
		println("   vs");
		for (p:production(nt,_) <- unmatched2)
			println("   - <ppx(p)>");
	}
	//for (u <- unmatched1)
	//	println(u);
	//println("vs");
	//for (u <- unmatched2)
	//	println(u);
	// TODO keep trying?
	return false;
}

test bool dtE1() = gdts(
	grammar(["foo"],[production("foo",epsilon())],[]),
	grammar(["foo"],[production("foo",epsilon())],[])
);
test bool dtF1() = gdts(
	grammar(["foo"],[production("foo",empty())],[]),
	grammar(["foo"],[production("foo",empty())],[])
);
test bool dtA1() = gdts(
	grammar(["foo"],[production("foo",anything())],[]),
	grammar(["foo"],[production("foo",anything())],[])
);
test bool dtV1() = gdts(
	grammar(["foo"],[production("foo",val(integer()))],[]),
	grammar(["foo"],[production("foo",val(integer()))],[])
);
test bool dtV2() = !gdts(
	grammar(["foo"],[production("foo",val(integer()))],[]),
	grammar(["foo"],[production("foo",val(string()))],[])
);
test bool dtV3() = !gdts(
	grammar(["foo"],[production("foo",val(integer()))],[]),
	grammar(["foo"],[production("foo",val(boolean()))],[])
);
test bool dtV4() = !gdts(
	grammar(["foo"],[production("foo",val(string()))],[]),
	grammar(["foo"],[production("foo",val(integer()))],[])
);
test bool dtV5() = gdts(
	grammar(["foo"],[production("foo",val(string()))],[]),
	grammar(["foo"],[production("foo",val(string()))],[])
);
test bool dtV6() = !gdts(
	grammar(["foo"],[production("foo",val(string()))],[]),
	grammar(["foo"],[production("foo",val(boolean()))],[])
);
test bool dtV7() = !gdts(
	grammar(["foo"],[production("foo",val(boolean()))],[]),
	grammar(["foo"],[production("foo",val(integer()))],[])
);
test bool dtV8() = !gdts(
	grammar(["foo"],[production("foo",val(boolean()))],[]),
	grammar(["foo"],[production("foo",val(string()))],[])
);
test bool dtV9() = gdts(
	grammar(["foo"],[production("foo",val(boolean()))],[]),
	grammar(["foo"],[production("foo",val(boolean()))],[])
);
test bool dtT1() = gdts(
	grammar(["foo"],[production("foo",terminal("1"))],[]),
	grammar(["foo"],[production("foo",terminal("1"))],[])
);
test bool dtT2() = !gdts(
	grammar(["foo"],[production("foo",terminal("1"))],[]),
	grammar(["foo"],[production("foo",terminal("2"))],[])
);
test bool dtN1() = gdts(
	grammar(["foo"],[production("foo",nonterminal("bar"))],[]),
	grammar(["foo"],[production("foo",nonterminal("bar"))],[])
);
test bool dtN2() = !gdts(
	grammar(["foo"],[production("foo",nonterminal("bar"))],[]),
	grammar(["foo"],[production("foo",nonterminal("wez"))],[])
);
test bool dtS1() = gdts(
	grammar(["foo"],[production("foo",label("one",nonterminal("foo")))],[]),
	grammar(["foo"],[production("foo",label("one",nonterminal("foo")))],[])
);
test bool dtS2() = gdts(
	grammar(["foo"],[production("foo",mark("one",nonterminal("foo")))],[]),
	grammar(["foo"],[production("foo",mark("one",nonterminal("foo")))],[])
);
test bool dtS3() = !gdts(
	grammar(["foo"],[production("foo",label("one",nonterminal("foo")))],[]),
	grammar(["foo"],[production("foo",mark("one",nonterminal("foo")))],[])
);
test bool dtS4() = !gdts(
	grammar(["foo"],[production("foo",label("one",nonterminal("foo")))],[]),
	grammar(["foo"],[production("foo",label("two",nonterminal("foo")))],[])
);
test bool dtS5() = !gdts(
	grammar(["foo"],[production("foo",label("one",nonterminal("foo")))],[]),
	grammar(["foo"],[production("foo",label("one",nonterminal("bar")))],[])
);
test bool dtS6() = !gdts(
	grammar(["foo"],[production("foo",label("one",nonterminal("foo")))],[]),
	grammar(["foo"],[production("foo",label("two",nonterminal("bar")))],[])
);
test bool dtS7() = !gdts(
	grammar(["foo"],[production("foo",mark("one",nonterminal("foo")))],[]),
	grammar(["foo"],[production("foo",mark("two",nonterminal("foo")))],[])
);
test bool dtS8() = !gdts(
	grammar(["foo"],[production("foo",mark("one",nonterminal("foo")))],[]),
	grammar(["foo"],[production("foo",mark("one",nonterminal("bar")))],[])
);
test bool dtS9() = !gdts(
	grammar(["foo"],[production("foo",mark("one",nonterminal("foo")))],[]),
	grammar(["foo"],[production("foo",mark("two",nonterminal("bar")))],[])
);
test bool dtR1() = gdts(
	grammar(["foo"],[production("foo",star(terminal("1")))],[]),
	grammar(["foo"],[production("foo",star(terminal("1")))],[])
);
test bool dtR2() = gdts(
	grammar(["foo"],[production("foo",plus(terminal("1")))],[]),
	grammar(["foo"],[production("foo",plus(terminal("1")))],[])
);
test bool dtR3() = gdts(
	grammar(["foo"],[production("foo",optional(terminal("1")))],[]),
	grammar(["foo"],[production("foo",optional(terminal("1")))],[])
);
test bool dtR4() = !gdts(
	grammar(["foo"],[production("foo",star(terminal("1")))],[]),
	grammar(["foo"],[production("foo",star(terminal("2")))],[])
);
test bool dtR5() = !gdts(
	grammar(["foo"],[production("foo",plus(terminal("1")))],[]),
	grammar(["foo"],[production("foo",plus(terminal("2")))],[])
);
test bool dtR6() = !gdts(
	grammar(["foo"],[production("foo",optional(terminal("1")))],[]),
	grammar(["foo"],[production("foo",optional(terminal("2")))],[])
);
test bool dtC1() = gdts(
	grammar(["foo"],[production("foo",choice([terminal("1")]))],[]),
	grammar(["foo"],[production("foo",choice([terminal("1")]))],[])
);
test bool dtC2() = gdts(
	grammar(["foo"],[production("foo",choice([terminal("1"),terminal("2")]))],[]),
	grammar(["foo"],[production("foo",choice([terminal("2"),terminal("1")]))],[])
);
test bool dtO1() = gdts(
	grammar(["foo"],[production("foo",sequence([terminal("1"),epsilon()]))],[]),
	grammar(["foo"],[production("foo",terminal("1"))],[])
);
test bool dtO2() = !gdts(
	grammar(["foo"],[production("foo",sequence([terminal("1"),terminal("2")]))],[]),
	grammar(["foo"],[production("foo",sequence([terminal("2"),terminal("1")]))],[])
);
test bool dtSL1() = gdts(
	grammar(["foo"],[production("foo",sepliststar(nonterminal("foo"),terminal(",")))],[]),
	grammar(["foo"],[production("foo",sepliststar(nonterminal("foo"),terminal(",")))],[])
);
test bool dtSL2() = gdts(
	grammar(["foo"],[production("foo",seplistplus(nonterminal("foo"),terminal(",")))],[]),
	grammar(["foo"],[production("foo",seplistplus(nonterminal("foo"),terminal(",")))],[])
);
test bool dtSL3() = !gdts(
	grammar(["foo"],[production("foo",sepliststar(nonterminal("foo"),terminal(",")))],[]),
	grammar(["foo"],[production("foo",seplistplus(nonterminal("foo"),terminal(",")))],[])
);
test bool dtSL4() = !gdts(
	grammar(["foo"],[production("foo",sepliststar(nonterminal("foo"),terminal(",")))],[]),
	grammar(["foo"],[production("foo",sepliststar(nonterminal("bar"),terminal(",")))],[])
);
test bool dtSL5() = !gdts(
	grammar(["foo"],[production("foo",sepliststar(nonterminal("foo"),terminal(",")))],[]),
	grammar(["foo"],[production("foo",sepliststar(nonterminal("foo"),terminal(";")))],[])
);
test bool dtSL6() = !gdts(
	grammar(["foo"],[production("foo",sepliststar(nonterminal("foo"),terminal(",")))],[]),
	grammar(["foo"],[production("foo",sepliststar(nonterminal("bar"),terminal(";")))],[])
);
test bool dtSL7() = !gdts(
	grammar(["foo"],[production("foo",seplistplus(nonterminal("foo"),terminal(",")))],[]),
	grammar(["foo"],[production("foo",seplistplus(nonterminal("bar"),terminal(",")))],[])
);
test bool dtSL8() = !gdts(
	grammar(["foo"],[production("foo",seplistplus(nonterminal("foo"),terminal(",")))],[]),
	grammar(["foo"],[production("foo",seplistplus(nonterminal("foo"),terminal(";")))],[])
);
test bool dtSL9() = !gdts(
	grammar(["foo"],[production("foo",seplistplus(nonterminal("foo"),terminal(",")))],[]),
	grammar(["foo"],[production("foo",seplistplus(nonterminal("bar"),terminal(";")))],[])
);