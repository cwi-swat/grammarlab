@contributor{Vadim Zaytsev - vadim@grammarware.net - SWAT, CWI}
module grammarlab::lib::Scoping

//import lib::Rascalware;
import grammarlab::lib::Sizes;
import grammarlab::language::Grammar;
import grammarlab::language::XScope;
import grammarlab::language::XOutcome;
import grammarlab::transform::Normal;
import grammarlab::compare::Differ;
import List; // tail

public XOutcome notFoundP(GProd p) = problemProd("Production rule not found",p);
public XOutcome notFreshN(str n) = notFreshName("Nonterminal",n);
public XOutcome freshN(str n) = freshName("Nonterminal",n);
public XOutcome notFreshName(str name, str n) = problemStr("<name> must be fresh",n);
public XOutcome freshName(str name, str n) = problemStr("<name> must not be fresh",n);

// TODO: refocus these to work with named markers
public GProd unmark (GProd p1)
{
	if (/mark("",_) !:= p1)
		throw "<p1> must contain markers.";
	p2 = innermost visit(p1)
	{
		case mark("",GExpr e) => e
	};
	//return normalise(p2);
	return p2;
}

// CAUTION: removes only empty markers, use a different visitor if needed otherwise
public GProd demark (GProd p1) 
{
	if (/mark("",_) !:= p1)
		throw "<p1> must contain markers.";
	p2 = visit(p1)
	{
		//case sequence([*L1,mark("",GExpr e),*L2]) => sequence(L1 + L2)
		case mark("",_) => epsilon()
	}
	//return p2;
	return normalise(p2);
}

public GProd demarkH (GProd p1) 
{
	if (/mark(_,_) !:= p1)
		throw "<p1> must contain markers.";
	p2 = innermost visit(p1)
	{
		case choice([*L1,mark(_,GExpr e),*L2]) => choice(L1 + L2)
	}
	return p2;
}

public GProd replaceMarker (GProd p1, GExpr e) 
{
	p2 = visit(p1)
	{
		case mark(_,_) => e
	}
	return normalise(p2);
}

// TODO: make it conform to the new label-mark model
// remove selectors from marked subexpressions
public GProd demarkS (GProd p1) 
{
	if (/mark(_,_) !:= p1)
		throw "<p1> must contain markers.";
	p2 = innermost visit(p1)
	{
		case mark("",mark(_, GExpr expr)) => expr
	}
	return normalise(p2);
}

public bool checkScope(GProd p, globally()) = true;
public bool checkScope(GProd p, nowhere()) = false;
public bool checkScope(GProd p, innt(str x)) = p.lhs == x;
public bool checkScope(GProd p, notinnt(str x)) = p.lhs != x;
public bool checkScope(GProd p, inlabel(str x)) = /label(x,_) := p;
public bool checkScope(GProd p, notinlabel(str x)) = /label(x,_) !:= p;
public bool checkScope(GProd p, inmark(str x)) = /mark(x,_) := p;
public bool checkScope(GProd p, notinmark(str x)) = /mark(x,_) !:= p;
public bool checkScope(GProd p, comboscope(w1,w2)) = checkScope(p,w1) && checkScope(p,w2);
public default bool checkScope(GProd p, XScope w) {throw "Unknown context <w>.";}
 
// order-preserving splitting of production rules
// returns <prods before context; prods in context; prods after context>
public tuple[GProdList,GProdList,GProdList] splitPbyW(GProdList ps, XScope w)
{
	if (globally() := w)
		return <[],ps,[]>;
	if (nowhere() := w)
		throw "Splitting by empty scope!";
	if (inlabel(str x) := w && isEmpty(x))
		throw "Empty label is not a proper scope.";
	bool hit = false;
	GProdList ps1 = [], ps2 = [], ps3 = [];
	for (p <- ps)
		if (checkScope(p,w))
			{
				hit = true;
				ps2 += p;
			}
		elseif (hit)
			ps3 += p;
		else
			ps1 += p;
	if (isEmpty(ps2))
		throw "Scope <w> not found.";
	return <ps1,ps2,ps3>;
}

// TODO move it to analyse::Metrics
public set[str] allNs(GGrammar g) = toSet(g.S) + toSet(g.N) + usedNs(g.P);
public set[str] allNs(GProdList ps) = definedNs(ps) + usedNs(ps);
public set[str] allTs(GProdList ps) = {s | /terminal(str s) := ps};
public set[str] usedNs(GProdList ps) = {s | /nonterminal(str s) := ps};
public set[str] definedNs(GProdList ps) = {s | production(str s,_) <- ps};

public GProdList replaceP(GProdList ps, GProd p1, GProd p2)
{
	GProdList ps2 = [];
	for (p <- ps)
		if (eqP(normalise(p),normalise(p1)))
			ps2 += p2;
		else
			ps2 += p;
	return ps2;
}

public bool inProds(GProd p, []) = false;
public default bool inProds(GProd p, GProdList ps) = eqP(normalise(p),normalise(ps[0])) || inProds(p,tail(ps));
