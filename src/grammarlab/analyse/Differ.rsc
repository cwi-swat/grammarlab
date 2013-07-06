@contributor{Vadim Zaytsev - vadim@grammarware.net - SWAT, CWI}
module analyse::Differ

import language::Grammar;
import transform::Normal;
import List;
import IO;

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

public bool eqE(sequence(L1), sequence(L2))
{
	if (size(L1) != size(L2)) return false;
	for (i <- [0..size(L1)-1])
		//if (choice(L3) := L1[i] && choice(L4) := L2[i])
		if (!eqE(L1[i],L2[i])) return false;
	return true;
}

public bool eqE(labelled(str X1, GExpr E1), labelled(X1, GExpr E2)) = eqE(E1,E2);
public bool eqE(selectable(str X1, GExpr E1), selectable(X1, GExpr E2)) = eqE(E1,E2);
public bool eqE(marked(GExpr E1), marked(GExpr E2)) =  eqE(E1,E2);
public bool eqE(not(GExpr E1), not(GExpr E2)) =  eqE(E1,E2);
public bool eqE(optional(GExpr E1), optional(GExpr E2)) =  eqE(E1,E2);
public bool eqE(star(GExpr E1), star(GExpr E2)) =  eqE(E1,E2);
public bool eqE(plus(GExpr E1), plus(GExpr E2)) =  eqE(E1,E2);
public bool eqE(seplistplus(GExpr E11, GExpr E12), seplistplus(GExpr E21, GExpr E22)) =  eqE(E11,E21) && eqE(E12,E22);
public bool eqE(sepliststar(GExpr E11, GExpr E12), sepliststar(GExpr E21, GExpr E22)) =  eqE(E11,E21) && eqE(E12,E22);

public bool eqE(GExpr e1, GExpr e2) = e1 == e2; // default


public bool eqP(production(str x, GExpr e1), production(x, GExpr e2)) = eqE(e1,e2);
public bool eqP(GProd p1, GProd p2) = p1 == p2;

// generic differ, returns unmatched production rules
tuple[GProdList,GProdList] gdt(GProdList ps1, GProdList ps2)
{
	ps3 = normalise(ps1);
	ps4 = normalise(ps2);
	if (toSet(ps3)==toSet(ps4)) return <[],[]>;
	unmatched1 = ps3 - ps4;
	unmatched2 = ps4 - ps3;
	for (u <- unmatched1)
		if (production(str l,str x,GExpr e1) := u)
			for (production(l,x,GExpr e2) <- unmatched2)
				if (eqE(e1,e2))
					{
						unmatched2 -= production(l,x,e2);
						unmatched1 -= u;
						break;
					}
	return <unmatched1,unmatched2>;
}

// silent
public bool gdts(grammar(rs1,ps1), grammar(rs2,ps2))
{
	if (toSet(rs1)!=toSet(rs2)) return false;
	<unmatched1,unmatched2> = gdt(ps1,ps2);
	if (isEmpty(unmatched1) && isEmpty(unmatched2)) return true;
	// TODO keep trying?
	return false;
}

// verbose
public bool gdtv(grammar(rs1,ps1), grammar(rs2,ps2))
{
	if (toSet(rs1)!=toSet(rs2))
	{
		println("Different roots: <rs1> vs <rs2>.");
		return false;
	}
	<unmatched1,unmatched2> = gdt(ps1,ps2);
	if (isEmpty(unmatched1) && isEmpty(unmatched2)) return true;
	println("Grammars differ!");
	//public set[str] definedNs(GProdList ps) = {s | production(_,str s,_) <- ps};
	for (nt <- {n | production(_, str n, _) <- unmatched1 + unmatched2})
	{
		println(" - Fail on <nt>:");
		for (p <- unmatched1, production(_,nt,_) := p)
			println("   - <p>");
		println("   vs");
		for (p <- unmatched2, production(_,nt,_) := p)
			println("   - <p>");
	}
	//for (u <- unmatched1)
	//	println(u);
	//println("vs");
	//for (u <- unmatched2)
	//	println(u);
	// TODO keep trying?
	return false;
}
