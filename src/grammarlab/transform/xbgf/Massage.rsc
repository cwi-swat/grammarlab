@contributor{Vadim Zaytsev - vadim@grammarware.net - SWAT, CWI}
module grammarlab::transform::xbgf::Massage

import grammarlab::lib::Sizes;
import grammarlab::language::Grammar;
import grammarlab::language::XScope;
import grammarlab::language::XOutcome;
import grammarlab::transform::xbgf::Brutal;
import grammarlab::transform::Normal;
import grammarlab::compare::Differ;

import List;

// lifting and sinking marks and labels
bool massage_eq({optional(mark(s,x)),mark(s,optional(x))}) = true;
bool massage_eq({optional(label(s,x)),label(s,optional(x))}) = true;
bool massage_eq({star(mark(s,x)),mark(s,star(x))}) = true;
bool massage_eq({star(label(s,x)),label(s,star(x))}) = true;
bool massage_eq({plus(mark(s,x)),mark(s,plus(x))}) = true;
bool massage_eq({plus(label(s,x)),label(s,plus(x))}) = true;
bool massage_eq({not(label(s,x)),label(s,not(x))}) = true;
bool massage_eq({not(mark(s,x)),mark(s,not(x))}) = true;

// combinations of optionality and closures
bool massage_eq({optional(optional(x)),optional(x)}) = true;
bool massage_eq({optional(star(x)),star(x)}) = true;
bool massage_eq({optional(plus(x)),star(x)}) = true;
bool massage_eq({star(optional(x)),star(x)}) = true;
bool massage_eq({star(star(x)),star(x)}) = true;
bool massage_eq({star(plus(x)),star(x)}) = true;
bool massage_eq({plus(optional(x)),star(x)}) = true;
bool massage_eq({plus(star(x)),star(x)}) = true;
bool massage_eq({plus(plus(x)),plus(x)}) = true;

// sequential variants of closures
bool massage_eq({sequence([star(x),star(x)]),star(x)}) = true;
bool massage_eq({sequence([optional(x),star(x)]),star(x)}) = true;
bool massage_eq({sequence([star(x),optional(x)]),star(x)}) = true;
bool massage_eq({sequence([optional(x),plus(x)]),plus(x)}) = true;
bool massage_eq({sequence([plus(x),optional(x)]),plus(x)}) = true;
bool massage_eq({sequence([plus(x),star(x)]),plus(x)}) = true;
bool massage_eq({sequence([star(x),plus(x)]),plus(x)}) = true;
bool massage_eq({sequence([x,star(x)]),plus(x)}) = true;
bool massage_eq({sequence([star(x),x]),plus(x)}) = true;

// disjunctions of optionality and closures, equivalent to x?
bool massage_eq({choice([x,epsilon()]),optional(x)}) = true;
bool massage_eq({choice([epsilon(),x]),optional(x)}) = true;
bool massage_eq({choice([optional(x),epsilon()]),optional(x)}) = true;
bool massage_eq({choice([epsilon(),optional(x)]),optional(x)}) = true;
bool massage_eq({choice([optional(x),x]),optional(x)}) = true;
bool massage_eq({choice([x,optional(x)]),optional(x)}) = true;

// disjunctions of optionality and closures, equivalent to x*
bool massage_eq({choice([star(x),x]),star(x)}) = true;
bool massage_eq({choice([x,star(x)]),star(x)}) = true;
bool massage_eq({choice([star(x),plus(x)]),star(x)}) = true;
bool massage_eq({choice([plus(x),star(x)]),star(x)}) = true;
bool massage_eq({choice([star(x),optional(x)]),star(x)}) = true;
bool massage_eq({choice([optional(x),star(x)]),star(x)}) = true;
bool massage_eq({choice([star(x),epsilon()]),star(x)}) = true;
bool massage_eq({choice([epsilon(),star(x)]),star(x)}) = true;
bool massage_eq({choice([plus(x),epsilon()]),star(x)}) = true;
bool massage_eq({choice([epsilon(),plus(x)]),star(x)}) = true;
bool massage_eq({choice([plus(x),optional(x)]),star(x)}) = true;
bool massage_eq({choice([optional(x),plus(x)]),star(x)}) = true;

// disjunctions of optionality and closures, equivalent to x+
bool massage_eq({choice([plus(x),x]),plus(x)}) = true;
bool massage_eq({choice([x,plus(x)]),plus(x)}) = true;

// introducing multiple labels and marks
bool massage_eq({x,choice([label(_,x),label(_,x)])}) = true;
bool massage_eq({x,choice([label(_,x),label(_,x),label(_,x)])}) = true;
bool massage_eq({x,choice([mark(_,x),mark(_,x)])}) = true;
bool massage_eq({x,choice([mark(_,x),mark(_,x),mark(_,x)])}) = true;

// separator lists
bool massage_eq({sequence([x,optional(sequence([y,x]))]),sequence([optional(sequence([x,y])),x])}) = true;
bool massage_eq({sequence([x,plus(sequence([y,x]))]),sequence([plus(sequence([x,y])),x])}) = true;
bool massage_eq({sequence([x,star(sequence([y,x]))]),sequence([star(sequence([x,y])),x])}) = true;
bool massage_eq({sequence([x,star(sequence([y,x]))]),seplistplus(x,y)}) = true;
bool massage_eq({sequence([star(sequence([x,y])),x]),seplistplus(x,y)}) = true;
bool massage_eq({optional(sequence([x,star(sequence([y,x]))])),sepliststar(x,y)}) = true;
bool massage_eq({optional(sequence([star(sequence([x,y])),x])),sepliststar(x,y)}) = true;
bool massage_eq({optional(seplistplus(x,y)),sepliststar(x,y)}) = true;

// Boolean grammars
bool massage_eq({not(not(x)),x}) = true;
bool massage_eq({not(allof([x,y])),choice([not(x),not(y)])}) = true;
bool massage_eq({not(allof([x,y])),choice([not(y),not(x)])}) = true;
bool massage_eq({not(allof([not(x),not(y)])),choice([x,y])}) = true;
bool massage_eq({not(allof([not(x),not(y)])),choice([y,x])}) = true;
bool massage_eq({not(choice([x,y])),allof([not(x),not(y)])}) = true;
bool massage_eq({not(choice([x,y])),allof([not(y),not(x)])}) = true;
bool massage_eq({not(choice([not(x),not(y)])),allof([x,y])}) = true;
bool massage_eq({not(choice([not(x),not(y)])),allof([y,x])}) = true;
bool massage_eq({allof([x,not(y)]),except(x,y)}) = true;

// otherwise, no
default bool massage_eq(GExprSet s) = false;

XResult runMassage(GExpr e1, GExpr e2, XScope w, GGrammar g)
{
	if (massage_eq({e1,e2}))
		return grammarlab::transform::xbgf::Brutal::runReplace(e1,e2,w,g);
	else
		return <problemExpr2("Expressions are not massage-equivalent.",e1,e2),g>;
}
