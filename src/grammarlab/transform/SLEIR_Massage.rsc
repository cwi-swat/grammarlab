@contributor{Vadim Zaytsev - vadim@grammarware.net - SWAT, CWI; UvA}
@contributor{Generated by meta::MassageMutations, do not edit manually!}
@doc{Contains 132 mutations intentionally generalised from massage-equivalence.}
module grammarlab::transform::SLEIR_Massage

import grammarlab::language::Grammar;
import grammarlab::language::SLEIR;

// SLEIR:MassageOptMark2MarkOpt
@doc{massage ⊢ MassageOptMark2MarkOpt, Type III, page 9}
public GGrammar mutate(MassageOptMark2MarkOpt(), GGrammar g)
{
	g.P = visit(g.P){case optional(mark(s,x)) => mark(s,optional(x))};
	return g;
}
// SLEIR:MassageMarkOpt2OptMark
@doc{massage ⊢ MassageMarkOpt2OptMark, Type III, page 9}
public GGrammar mutate(MassageMarkOpt2OptMark(), GGrammar g)
{
	g.P = visit(g.P){case mark(s,optional(x)) => optional(mark(s,x))};
	return g;
}
// SLEIR:MassageOptLabel2LabelOpt
@doc{massage ⊢ MassageOptLabel2LabelOpt, Type III, page 9}
public GGrammar mutate(MassageOptLabel2LabelOpt(), GGrammar g)
{
	g.P = visit(g.P){case optional(label(s,x)) => label(s,optional(x))};
	return g;
}
// SLEIR:MassageLabelOpt2OptLabel
@doc{massage ⊢ MassageLabelOpt2OptLabel, Type III, page 9}
public GGrammar mutate(MassageLabelOpt2OptLabel(), GGrammar g)
{
	g.P = visit(g.P){case label(s,optional(x)) => optional(label(s,x))};
	return g;
}
// SLEIR:MassageStarMark2MarkStar
@doc{massage ⊢ MassageStarMark2MarkStar, Type III, page 9}
public GGrammar mutate(MassageStarMark2MarkStar(), GGrammar g)
{
	g.P = visit(g.P){case star(mark(s,x)) => mark(s,star(x))};
	return g;
}
// SLEIR:MassageMarkStar2StarMark
@doc{massage ⊢ MassageMarkStar2StarMark, Type III, page 9}
public GGrammar mutate(MassageMarkStar2StarMark(), GGrammar g)
{
	g.P = visit(g.P){case mark(s,star(x)) => star(mark(s,x))};
	return g;
}
// SLEIR:MassageStarLabel2LabelStar
@doc{massage ⊢ MassageStarLabel2LabelStar, Type III, page 9}
public GGrammar mutate(MassageStarLabel2LabelStar(), GGrammar g)
{
	g.P = visit(g.P){case star(label(s,x)) => label(s,star(x))};
	return g;
}
// SLEIR:MassageLabelStar2StarLabel
@doc{massage ⊢ MassageLabelStar2StarLabel, Type III, page 9}
public GGrammar mutate(MassageLabelStar2StarLabel(), GGrammar g)
{
	g.P = visit(g.P){case label(s,star(x)) => star(label(s,x))};
	return g;
}
// SLEIR:MassagePlusMark2MarkPlus
@doc{massage ⊢ MassagePlusMark2MarkPlus, Type III, page 9}
public GGrammar mutate(MassagePlusMark2MarkPlus(), GGrammar g)
{
	g.P = visit(g.P){case plus(mark(s,x)) => mark(s,plus(x))};
	return g;
}
// SLEIR:MassageMarkPlus2PlusMark
@doc{massage ⊢ MassageMarkPlus2PlusMark, Type III, page 9}
public GGrammar mutate(MassageMarkPlus2PlusMark(), GGrammar g)
{
	g.P = visit(g.P){case mark(s,plus(x)) => plus(mark(s,x))};
	return g;
}
// SLEIR:MassagePlusLabel2LabelPlus
@doc{massage ⊢ MassagePlusLabel2LabelPlus, Type III, page 9}
public GGrammar mutate(MassagePlusLabel2LabelPlus(), GGrammar g)
{
	g.P = visit(g.P){case plus(label(s,x)) => label(s,plus(x))};
	return g;
}
// SLEIR:MassageLabelPlus2PlusLabel
@doc{massage ⊢ MassageLabelPlus2PlusLabel, Type III, page 9}
public GGrammar mutate(MassageLabelPlus2PlusLabel(), GGrammar g)
{
	g.P = visit(g.P){case label(s,plus(x)) => plus(label(s,x))};
	return g;
}
// SLEIR:MassageNotLabel2LabelNot
@doc{massage ⊢ MassageNotLabel2LabelNot, Type III, page 9}
public GGrammar mutate(MassageNotLabel2LabelNot(), GGrammar g)
{
	g.P = visit(g.P){case not(label(s,x)) => label(s,not(x))};
	return g;
}
// SLEIR:MassageLabelNot2NotLabel
@doc{massage ⊢ MassageLabelNot2NotLabel, Type III, page 9}
public GGrammar mutate(MassageLabelNot2NotLabel(), GGrammar g)
{
	g.P = visit(g.P){case label(s,not(x)) => not(label(s,x))};
	return g;
}
// SLEIR:MassageNotMark2MarkNot
@doc{massage ⊢ MassageNotMark2MarkNot, Type III, page 9}
public GGrammar mutate(MassageNotMark2MarkNot(), GGrammar g)
{
	g.P = visit(g.P){case not(mark(s,x)) => mark(s,not(x))};
	return g;
}
// SLEIR:MassageMarkNot2NotMark
@doc{massage ⊢ MassageMarkNot2NotMark, Type III, page 9}
public GGrammar mutate(MassageMarkNot2NotMark(), GGrammar g)
{
	g.P = visit(g.P){case mark(s,not(x)) => not(mark(s,x))};
	return g;
}
// SLEIR:MassageOptOpt2Opt
@doc{massage ⊢ MassageOptOpt2Opt, Type III, page 9}
public GGrammar mutate(MassageOptOpt2Opt(), GGrammar g)
{
	g.P = visit(g.P){case optional(optional(x)) => optional(x)};
	return g;
}
// SLEIR:MassageOpt2OptOpt
@doc{massage ⊢ MassageOpt2OptOpt, Type III, page 9}
public GGrammar mutate(MassageOpt2OptOpt(), GGrammar g)
{
	g.P = visit(g.P){case optional(x) => optional(optional(x))};
	return g;
}
// SLEIR:MassageOptStar2Star
@doc{massage ⊢ MassageOptStar2Star, Type III, page 9}
public GGrammar mutate(MassageOptStar2Star(), GGrammar g)
{
	g.P = visit(g.P){case optional(star(x)) => star(x)};
	return g;
}
// SLEIR:MassageStar2OptStar
@doc{massage ⊢ MassageStar2OptStar, Type III, page 9}
public GGrammar mutate(MassageStar2OptStar(), GGrammar g)
{
	g.P = visit(g.P){case star(x) => optional(star(x))};
	return g;
}
// SLEIR:MassageOptPlus2Star
@doc{massage ⊢ MassageOptPlus2Star, Type III, page 9}
public GGrammar mutate(MassageOptPlus2Star(), GGrammar g)
{
	g.P = visit(g.P){case optional(plus(x)) => star(x)};
	return g;
}
// SLEIR:MassageStar2OptPlus
@doc{massage ⊢ MassageStar2OptPlus, Type III, page 9}
public GGrammar mutate(MassageStar2OptPlus(), GGrammar g)
{
	g.P = visit(g.P){case star(x) => optional(plus(x))};
	return g;
}
// SLEIR:MassageStarOpt2Star
@doc{massage ⊢ MassageStarOpt2Star, Type III, page 9}
public GGrammar mutate(MassageStarOpt2Star(), GGrammar g)
{
	g.P = visit(g.P){case star(optional(x)) => star(x)};
	return g;
}
// SLEIR:MassageStar2StarOpt
@doc{massage ⊢ MassageStar2StarOpt, Type III, page 9}
public GGrammar mutate(MassageStar2StarOpt(), GGrammar g)
{
	g.P = visit(g.P){case star(x) => star(optional(x))};
	return g;
}
// SLEIR:MassageStarStar2Star
@doc{massage ⊢ MassageStarStar2Star, Type III, page 9}
public GGrammar mutate(MassageStarStar2Star(), GGrammar g)
{
	g.P = visit(g.P){case star(star(x)) => star(x)};
	return g;
}
// SLEIR:MassageStar2StarStar
@doc{massage ⊢ MassageStar2StarStar, Type III, page 9}
public GGrammar mutate(MassageStar2StarStar(), GGrammar g)
{
	g.P = visit(g.P){case star(x) => star(star(x))};
	return g;
}
// SLEIR:MassageStarPlus2Star
@doc{massage ⊢ MassageStarPlus2Star, Type III, page 9}
public GGrammar mutate(MassageStarPlus2Star(), GGrammar g)
{
	g.P = visit(g.P){case star(plus(x)) => star(x)};
	return g;
}
// SLEIR:MassageStar2StarPlus
@doc{massage ⊢ MassageStar2StarPlus, Type III, page 9}
public GGrammar mutate(MassageStar2StarPlus(), GGrammar g)
{
	g.P = visit(g.P){case star(x) => star(plus(x))};
	return g;
}
// SLEIR:MassagePlusOpt2Star
@doc{massage ⊢ MassagePlusOpt2Star, Type III, page 9}
public GGrammar mutate(MassagePlusOpt2Star(), GGrammar g)
{
	g.P = visit(g.P){case plus(optional(x)) => star(x)};
	return g;
}
// SLEIR:MassageStar2PlusOpt
@doc{massage ⊢ MassageStar2PlusOpt, Type III, page 9}
public GGrammar mutate(MassageStar2PlusOpt(), GGrammar g)
{
	g.P = visit(g.P){case star(x) => plus(optional(x))};
	return g;
}
// SLEIR:MassagePlusStar2Star
@doc{massage ⊢ MassagePlusStar2Star, Type III, page 9}
public GGrammar mutate(MassagePlusStar2Star(), GGrammar g)
{
	g.P = visit(g.P){case plus(star(x)) => star(x)};
	return g;
}
// SLEIR:MassageStar2PlusStar
@doc{massage ⊢ MassageStar2PlusStar, Type III, page 9}
public GGrammar mutate(MassageStar2PlusStar(), GGrammar g)
{
	g.P = visit(g.P){case star(x) => plus(star(x))};
	return g;
}
// SLEIR:MassagePlusPlus2Plus
@doc{massage ⊢ MassagePlusPlus2Plus, Type III, page 9}
public GGrammar mutate(MassagePlusPlus2Plus(), GGrammar g)
{
	g.P = visit(g.P){case plus(plus(x)) => plus(x)};
	return g;
}
// SLEIR:MassagePlus2PlusPlus
@doc{massage ⊢ MassagePlus2PlusPlus, Type III, page 9}
public GGrammar mutate(MassagePlus2PlusPlus(), GGrammar g)
{
	g.P = visit(g.P){case plus(x) => plus(plus(x))};
	return g;
}
// SLEIR:MassageSeqStarStar2Star
@doc{massage ⊢ MassageSeqStarStar2Star, Type III, page 9}
public GGrammar mutate(MassageSeqStarStar2Star(), GGrammar g)
{
	g.P = visit(g.P){case sequence([star(x),star(x)]) => star(x)};
	return g;
}
// SLEIR:MassageStar2SeqStarStar
@doc{massage ⊢ MassageStar2SeqStarStar, Type III, page 9}
public GGrammar mutate(MassageStar2SeqStarStar(), GGrammar g)
{
	g.P = visit(g.P){case star(x) => sequence([star(x),star(x)])};
	return g;
}
// SLEIR:MassageSeqOptStar2Star
@doc{massage ⊢ MassageSeqOptStar2Star, Type III, page 9}
public GGrammar mutate(MassageSeqOptStar2Star(), GGrammar g)
{
	g.P = visit(g.P){case sequence([optional(x),star(x)]) => star(x)};
	return g;
}
// SLEIR:MassageStar2SeqOptStar
@doc{massage ⊢ MassageStar2SeqOptStar, Type III, page 9}
public GGrammar mutate(MassageStar2SeqOptStar(), GGrammar g)
{
	g.P = visit(g.P){case star(x) => sequence([optional(x),star(x)])};
	return g;
}
// SLEIR:MassageSeqStarOpt2Star
@doc{massage ⊢ MassageSeqStarOpt2Star, Type III, page 9}
public GGrammar mutate(MassageSeqStarOpt2Star(), GGrammar g)
{
	g.P = visit(g.P){case sequence([star(x),optional(x)]) => star(x)};
	return g;
}
// SLEIR:MassageStar2SeqStarOpt
@doc{massage ⊢ MassageStar2SeqStarOpt, Type III, page 9}
public GGrammar mutate(MassageStar2SeqStarOpt(), GGrammar g)
{
	g.P = visit(g.P){case star(x) => sequence([star(x),optional(x)])};
	return g;
}
// SLEIR:MassageSeqOptPlus2Plus
@doc{massage ⊢ MassageSeqOptPlus2Plus, Type III, page 9}
public GGrammar mutate(MassageSeqOptPlus2Plus(), GGrammar g)
{
	g.P = visit(g.P){case sequence([optional(x),plus(x)]) => plus(x)};
	return g;
}
// SLEIR:MassagePlus2SeqOptPlus
@doc{massage ⊢ MassagePlus2SeqOptPlus, Type III, page 9}
public GGrammar mutate(MassagePlus2SeqOptPlus(), GGrammar g)
{
	g.P = visit(g.P){case plus(x) => sequence([optional(x),plus(x)])};
	return g;
}
// SLEIR:MassageSeqPlusOpt2Plus
@doc{massage ⊢ MassageSeqPlusOpt2Plus, Type III, page 9}
public GGrammar mutate(MassageSeqPlusOpt2Plus(), GGrammar g)
{
	g.P = visit(g.P){case sequence([plus(x),optional(x)]) => plus(x)};
	return g;
}
// SLEIR:MassagePlus2SeqPlusOpt
@doc{massage ⊢ MassagePlus2SeqPlusOpt, Type III, page 9}
public GGrammar mutate(MassagePlus2SeqPlusOpt(), GGrammar g)
{
	g.P = visit(g.P){case plus(x) => sequence([plus(x),optional(x)])};
	return g;
}
// SLEIR:MassageSeqPlusStar2Plus
@doc{massage ⊢ MassageSeqPlusStar2Plus, Type III, page 9}
public GGrammar mutate(MassageSeqPlusStar2Plus(), GGrammar g)
{
	g.P = visit(g.P){case sequence([plus(x),star(x)]) => plus(x)};
	return g;
}
// SLEIR:MassagePlus2SeqPlusStar
@doc{massage ⊢ MassagePlus2SeqPlusStar, Type III, page 9}
public GGrammar mutate(MassagePlus2SeqPlusStar(), GGrammar g)
{
	g.P = visit(g.P){case plus(x) => sequence([plus(x),star(x)])};
	return g;
}
// SLEIR:MassageSeqStarPlus2Plus
@doc{massage ⊢ MassageSeqStarPlus2Plus, Type III, page 9}
public GGrammar mutate(MassageSeqStarPlus2Plus(), GGrammar g)
{
	g.P = visit(g.P){case sequence([star(x),plus(x)]) => plus(x)};
	return g;
}
// SLEIR:MassagePlus2SeqStarPlus
@doc{massage ⊢ MassagePlus2SeqStarPlus, Type III, page 9}
public GGrammar mutate(MassagePlus2SeqStarPlus(), GGrammar g)
{
	g.P = visit(g.P){case plus(x) => sequence([star(x),plus(x)])};
	return g;
}
// SLEIR:MassageSeqXStar2Plus
@doc{massage ⊢ MassageSeqXStar2Plus, Type III, page 9}
public GGrammar mutate(MassageSeqXStar2Plus(), GGrammar g)
{
	g.P = visit(g.P){case sequence([x,star(x)]) => plus(x)};
	return g;
}
// SLEIR:MassagePlus2SeqXStar
@doc{massage ⊢ MassagePlus2SeqXStar, Type III, page 9}
public GGrammar mutate(MassagePlus2SeqXStar(), GGrammar g)
{
	g.P = visit(g.P){case plus(x) => sequence([x,star(x)])};
	return g;
}
// SLEIR:MassageSeqStarX2Plus
@doc{massage ⊢ MassageSeqStarX2Plus, Type III, page 9}
public GGrammar mutate(MassageSeqStarX2Plus(), GGrammar g)
{
	g.P = visit(g.P){case sequence([star(x),x]) => plus(x)};
	return g;
}
// SLEIR:MassagePlus2SeqStarX
@doc{massage ⊢ MassagePlus2SeqStarX, Type III, page 9}
public GGrammar mutate(MassagePlus2SeqStarX(), GGrammar g)
{
	g.P = visit(g.P){case plus(x) => sequence([star(x),x])};
	return g;
}
// SLEIR:MassageOrXEps2Opt
@doc{massage ⊢ MassageOrXEps2Opt, Type III, page 9}
public GGrammar mutate(MassageOrXEps2Opt(), GGrammar g)
{
	g.P = visit(g.P){case choice([x,epsilon()]) => optional(x)};
	return g;
}
// SLEIR:MassageOpt2OrXEps
@doc{massage ⊢ MassageOpt2OrXEps, Type III, page 9}
public GGrammar mutate(MassageOpt2OrXEps(), GGrammar g)
{
	g.P = visit(g.P){case optional(x) => choice([x,epsilon()])};
	return g;
}
// SLEIR:MassageOrEpsX2Opt
@doc{massage ⊢ MassageOrEpsX2Opt, Type III, page 9}
public GGrammar mutate(MassageOrEpsX2Opt(), GGrammar g)
{
	g.P = visit(g.P){case choice([epsilon(),x]) => optional(x)};
	return g;
}
// SLEIR:MassageOpt2OrEpsX
@doc{massage ⊢ MassageOpt2OrEpsX, Type III, page 9}
public GGrammar mutate(MassageOpt2OrEpsX(), GGrammar g)
{
	g.P = visit(g.P){case optional(x) => choice([epsilon(),x])};
	return g;
}
// SLEIR:MassageOrOptEps2Opt
@doc{massage ⊢ MassageOrOptEps2Opt, Type III, page 9}
public GGrammar mutate(MassageOrOptEps2Opt(), GGrammar g)
{
	g.P = visit(g.P){case choice([optional(x),epsilon()]) => optional(x)};
	return g;
}
// SLEIR:MassageOpt2OrOptEps
@doc{massage ⊢ MassageOpt2OrOptEps, Type III, page 9}
public GGrammar mutate(MassageOpt2OrOptEps(), GGrammar g)
{
	g.P = visit(g.P){case optional(x) => choice([optional(x),epsilon()])};
	return g;
}
// SLEIR:MassageOrEpsOpt2Opt
@doc{massage ⊢ MassageOrEpsOpt2Opt, Type III, page 9}
public GGrammar mutate(MassageOrEpsOpt2Opt(), GGrammar g)
{
	g.P = visit(g.P){case choice([epsilon(),optional(x)]) => optional(x)};
	return g;
}
// SLEIR:MassageOpt2OrEpsOpt
@doc{massage ⊢ MassageOpt2OrEpsOpt, Type III, page 9}
public GGrammar mutate(MassageOpt2OrEpsOpt(), GGrammar g)
{
	g.P = visit(g.P){case optional(x) => choice([epsilon(),optional(x)])};
	return g;
}
// SLEIR:MassageOrOptX2Opt
@doc{massage ⊢ MassageOrOptX2Opt, Type III, page 9}
public GGrammar mutate(MassageOrOptX2Opt(), GGrammar g)
{
	g.P = visit(g.P){case choice([optional(x),x]) => optional(x)};
	return g;
}
// SLEIR:MassageOpt2OrOptX
@doc{massage ⊢ MassageOpt2OrOptX, Type III, page 9}
public GGrammar mutate(MassageOpt2OrOptX(), GGrammar g)
{
	g.P = visit(g.P){case optional(x) => choice([optional(x),x])};
	return g;
}
// SLEIR:MassageOrXOpt2Opt
@doc{massage ⊢ MassageOrXOpt2Opt, Type III, page 9}
public GGrammar mutate(MassageOrXOpt2Opt(), GGrammar g)
{
	g.P = visit(g.P){case choice([x,optional(x)]) => optional(x)};
	return g;
}
// SLEIR:MassageOpt2OrXOpt
@doc{massage ⊢ MassageOpt2OrXOpt, Type III, page 9}
public GGrammar mutate(MassageOpt2OrXOpt(), GGrammar g)
{
	g.P = visit(g.P){case optional(x) => choice([x,optional(x)])};
	return g;
}
// SLEIR:MassageOrStar12Star
@doc{massage ⊢ MassageOrStar12Star, Type III, page 9}
public GGrammar mutate(MassageOrStar12Star(), GGrammar g)
{
	g.P = visit(g.P){case choice([star(x),x]) => star(x)};
	return g;
}
// SLEIR:MassageStar2OrStar1
@doc{massage ⊢ MassageStar2OrStar1, Type III, page 9}
public GGrammar mutate(MassageStar2OrStar1(), GGrammar g)
{
	g.P = visit(g.P){case star(x) => choice([star(x),x])};
	return g;
}
// SLEIR:MassageOr1Star2Star
@doc{massage ⊢ MassageOr1Star2Star, Type III, page 9}
public GGrammar mutate(MassageOr1Star2Star(), GGrammar g)
{
	g.P = visit(g.P){case choice([x,star(x)]) => star(x)};
	return g;
}
// SLEIR:MassageStar2Or1Star
@doc{massage ⊢ MassageStar2Or1Star, Type III, page 9}
public GGrammar mutate(MassageStar2Or1Star(), GGrammar g)
{
	g.P = visit(g.P){case star(x) => choice([x,star(x)])};
	return g;
}
// SLEIR:MassageOrStarPlus2Star
@doc{massage ⊢ MassageOrStarPlus2Star, Type III, page 9}
public GGrammar mutate(MassageOrStarPlus2Star(), GGrammar g)
{
	g.P = visit(g.P){case choice([star(x),plus(x)]) => star(x)};
	return g;
}
// SLEIR:MassageStar2OrStarPlus
@doc{massage ⊢ MassageStar2OrStarPlus, Type III, page 9}
public GGrammar mutate(MassageStar2OrStarPlus(), GGrammar g)
{
	g.P = visit(g.P){case star(x) => choice([star(x),plus(x)])};
	return g;
}
// SLEIR:MassageOrPlusStar2Star
@doc{massage ⊢ MassageOrPlusStar2Star, Type III, page 9}
public GGrammar mutate(MassageOrPlusStar2Star(), GGrammar g)
{
	g.P = visit(g.P){case choice([plus(x),star(x)]) => star(x)};
	return g;
}
// SLEIR:MassageStar2OrPlusStar
@doc{massage ⊢ MassageStar2OrPlusStar, Type III, page 9}
public GGrammar mutate(MassageStar2OrPlusStar(), GGrammar g)
{
	g.P = visit(g.P){case star(x) => choice([plus(x),star(x)])};
	return g;
}
// SLEIR:MassageOrStarOpt2Star
@doc{massage ⊢ MassageOrStarOpt2Star, Type III, page 9}
public GGrammar mutate(MassageOrStarOpt2Star(), GGrammar g)
{
	g.P = visit(g.P){case choice([star(x),optional(x)]) => star(x)};
	return g;
}
// SLEIR:MassageStar2OrStarOpt
@doc{massage ⊢ MassageStar2OrStarOpt, Type III, page 9}
public GGrammar mutate(MassageStar2OrStarOpt(), GGrammar g)
{
	g.P = visit(g.P){case star(x) => choice([star(x),optional(x)])};
	return g;
}
// SLEIR:MassageOrOptStar2Star
@doc{massage ⊢ MassageOrOptStar2Star, Type III, page 9}
public GGrammar mutate(MassageOrOptStar2Star(), GGrammar g)
{
	g.P = visit(g.P){case choice([optional(x),star(x)]) => star(x)};
	return g;
}
// SLEIR:MassageStar2OrOptStar
@doc{massage ⊢ MassageStar2OrOptStar, Type III, page 9}
public GGrammar mutate(MassageStar2OrOptStar(), GGrammar g)
{
	g.P = visit(g.P){case star(x) => choice([optional(x),star(x)])};
	return g;
}
// SLEIR:MassageOrStarEps2Star
@doc{massage ⊢ MassageOrStarEps2Star, Type III, page 9}
public GGrammar mutate(MassageOrStarEps2Star(), GGrammar g)
{
	g.P = visit(g.P){case choice([star(x),epsilon()]) => star(x)};
	return g;
}
// SLEIR:MassageStar2OrStarEps
@doc{massage ⊢ MassageStar2OrStarEps, Type III, page 9}
public GGrammar mutate(MassageStar2OrStarEps(), GGrammar g)
{
	g.P = visit(g.P){case star(x) => choice([star(x),epsilon()])};
	return g;
}
// SLEIR:MassageOrEpsStar2Star
@doc{massage ⊢ MassageOrEpsStar2Star, Type III, page 9}
public GGrammar mutate(MassageOrEpsStar2Star(), GGrammar g)
{
	g.P = visit(g.P){case choice([epsilon(),star(x)]) => star(x)};
	return g;
}
// SLEIR:MassageStar2OrEpsStar
@doc{massage ⊢ MassageStar2OrEpsStar, Type III, page 9}
public GGrammar mutate(MassageStar2OrEpsStar(), GGrammar g)
{
	g.P = visit(g.P){case star(x) => choice([epsilon(),star(x)])};
	return g;
}
// SLEIR:MassageOrPlusEps2Star
@doc{massage ⊢ MassageOrPlusEps2Star, Type III, page 9}
public GGrammar mutate(MassageOrPlusEps2Star(), GGrammar g)
{
	g.P = visit(g.P){case choice([plus(x),epsilon()]) => star(x)};
	return g;
}
// SLEIR:MassageStar2OrPlusEps
@doc{massage ⊢ MassageStar2OrPlusEps, Type III, page 9}
public GGrammar mutate(MassageStar2OrPlusEps(), GGrammar g)
{
	g.P = visit(g.P){case star(x) => choice([plus(x),epsilon()])};
	return g;
}
// SLEIR:MassageOrEpsPlus2Star
@doc{massage ⊢ MassageOrEpsPlus2Star, Type III, page 9}
public GGrammar mutate(MassageOrEpsPlus2Star(), GGrammar g)
{
	g.P = visit(g.P){case choice([epsilon(),plus(x)]) => star(x)};
	return g;
}
// SLEIR:MassageStar2OrEpsPlus
@doc{massage ⊢ MassageStar2OrEpsPlus, Type III, page 9}
public GGrammar mutate(MassageStar2OrEpsPlus(), GGrammar g)
{
	g.P = visit(g.P){case star(x) => choice([epsilon(),plus(x)])};
	return g;
}
// SLEIR:MassageOrPlusOpt2Star
@doc{massage ⊢ MassageOrPlusOpt2Star, Type III, page 9}
public GGrammar mutate(MassageOrPlusOpt2Star(), GGrammar g)
{
	g.P = visit(g.P){case choice([plus(x),optional(x)]) => star(x)};
	return g;
}
// SLEIR:MassageStar2OrPlusOpt
@doc{massage ⊢ MassageStar2OrPlusOpt, Type III, page 9}
public GGrammar mutate(MassageStar2OrPlusOpt(), GGrammar g)
{
	g.P = visit(g.P){case star(x) => choice([plus(x),optional(x)])};
	return g;
}
// SLEIR:MassageOrOptPlus2Star
@doc{massage ⊢ MassageOrOptPlus2Star, Type III, page 9}
public GGrammar mutate(MassageOrOptPlus2Star(), GGrammar g)
{
	g.P = visit(g.P){case choice([optional(x),plus(x)]) => star(x)};
	return g;
}
// SLEIR:MassageStar2OrOptPlus
@doc{massage ⊢ MassageStar2OrOptPlus, Type III, page 9}
public GGrammar mutate(MassageStar2OrOptPlus(), GGrammar g)
{
	g.P = visit(g.P){case star(x) => choice([optional(x),plus(x)])};
	return g;
}
// SLEIR:MassageOrPlusX2Plus
@doc{massage ⊢ MassageOrPlusX2Plus, Type III, page 9}
public GGrammar mutate(MassageOrPlusX2Plus(), GGrammar g)
{
	g.P = visit(g.P){case choice([plus(x),x]) => plus(x)};
	return g;
}
// SLEIR:MassagePlus2OrPlusX
@doc{massage ⊢ MassagePlus2OrPlusX, Type III, page 9}
public GGrammar mutate(MassagePlus2OrPlusX(), GGrammar g)
{
	g.P = visit(g.P){case plus(x) => choice([plus(x),x])};
	return g;
}
// SLEIR:MassageOrXPlus2Plus
@doc{massage ⊢ MassageOrXPlus2Plus, Type III, page 9}
public GGrammar mutate(MassageOrXPlus2Plus(), GGrammar g)
{
	g.P = visit(g.P){case choice([x,plus(x)]) => plus(x)};
	return g;
}
// SLEIR:MassagePlus2OrXPlus
@doc{massage ⊢ MassagePlus2OrXPlus, Type III, page 9}
public GGrammar mutate(MassagePlus2OrXPlus(), GGrammar g)
{
	g.P = visit(g.P){case plus(x) => choice([x,plus(x)])};
	return g;
}
// SLEIR:MassageOrLabels2
@doc{massage ⊢ MassageOrLabels2, Type III, page 9}
public GGrammar mutate(MassageOrLabels2(), GGrammar g)
{
	g.P = visit(g.P){case choice([label(_,x),label(_,x)]) => x};
	return g;
}
// SLEIR:MassageOrLabels3
@doc{massage ⊢ MassageOrLabels3, Type III, page 9}
public GGrammar mutate(MassageOrLabels3(), GGrammar g)
{
	g.P = visit(g.P){case choice([label(_,x),label(_,x),label(_,x)]) => x};
	return g;
}
// SLEIR:MassageOrMarks2
@doc{massage ⊢ MassageOrMarks2, Type III, page 9}
public GGrammar mutate(MassageOrMarks2(), GGrammar g)
{
	g.P = visit(g.P){case choice([mark(_,x),mark(_,x)]) => x};
	return g;
}
// SLEIR:MassageOrMarks3
@doc{massage ⊢ MassageOrMarks3, Type III, page 9}
public GGrammar mutate(MassageOrMarks3(), GGrammar g)
{
	g.P = visit(g.P){case choice([mark(_,x),mark(_,x),mark(_,x)]) => x};
	return g;
}
// SLEIR:MassageSeqXOpt2SeqOptX
@doc{massage ⊢ MassageSeqXOpt2SeqOptX, Type III, page 9}
public GGrammar mutate(MassageSeqXOpt2SeqOptX(), GGrammar g)
{
	g.P = visit(g.P){case sequence([x,optional(sequence([y,x]))]) => sequence([optional(sequence([x,y])),x])};
	return g;
}
// SLEIR:MassageSeqOptX2SeqXOpt
@doc{massage ⊢ MassageSeqOptX2SeqXOpt, Type III, page 9}
public GGrammar mutate(MassageSeqOptX2SeqXOpt(), GGrammar g)
{
	g.P = visit(g.P){case sequence([optional(sequence([x,y])),x]) => sequence([x,optional(sequence([y,x]))])};
	return g;
}
// SLEIR:MassageSeqXPlus2SeqPlusX
@doc{massage ⊢ MassageSeqXPlus2SeqPlusX, Type III, page 9}
public GGrammar mutate(MassageSeqXPlus2SeqPlusX(), GGrammar g)
{
	g.P = visit(g.P){case sequence([x,plus(sequence([y,x]))]) => sequence([plus(sequence([x,y])),x])};
	return g;
}
// SLEIR:MassageSeqPlusX2SeqXPlus
@doc{massage ⊢ MassageSeqPlusX2SeqXPlus, Type III, page 9}
public GGrammar mutate(MassageSeqPlusX2SeqXPlus(), GGrammar g)
{
	g.P = visit(g.P){case sequence([plus(sequence([x,y])),x]) => sequence([x,plus(sequence([y,x]))])};
	return g;
}
// SLEIR:MassageSeqXStar2SeqStarX
@doc{massage ⊢ MassageSeqXStar2SeqStarX, Type III, page 9}
public GGrammar mutate(MassageSeqXStar2SeqStarX(), GGrammar g)
{
	g.P = visit(g.P){case sequence([x,star(sequence([y,x]))]) => sequence([star(sequence([x,y])),x])};
	return g;
}
// SLEIR:MassageSeqStarX2SeqXStar
@doc{massage ⊢ MassageSeqStarX2SeqXStar, Type III, page 9}
public GGrammar mutate(MassageSeqStarX2SeqXStar(), GGrammar g)
{
	g.P = visit(g.P){case sequence([star(sequence([x,y])),x]) => sequence([x,star(sequence([y,x]))])};
	return g;
}
// SLEIR:MassageSeqXStar2SLPlus
@doc{massage ⊢ MassageSeqXStar2SLPlus, Type III, page 9}
public GGrammar mutate(MassageSeqXStar2SLPlus(), GGrammar g)
{
	g.P = visit(g.P){case sequence([x,star(sequence([y,x]))]) => seplistplus(x,y)};
	return g;
}
// SLEIR:MassageSLPlus2SeqXStar
@doc{massage ⊢ MassageSLPlus2SeqXStar, Type III, page 9}
public GGrammar mutate(MassageSLPlus2SeqXStar(), GGrammar g)
{
	g.P = visit(g.P){case seplistplus(x,y) => sequence([x,star(sequence([y,x]))])};
	return g;
}
// SLEIR:MassageSeqStarX2SLPlus
@doc{massage ⊢ MassageSeqStarX2SLPlus, Type III, page 9}
public GGrammar mutate(MassageSeqStarX2SLPlus(), GGrammar g)
{
	g.P = visit(g.P){case sequence([star(sequence([x,y])),x]) => seplistplus(x,y)};
	return g;
}
// SLEIR:MassageSLPlus2SeqStarX
@doc{massage ⊢ MassageSLPlus2SeqStarX, Type III, page 9}
public GGrammar mutate(MassageSLPlus2SeqStarX(), GGrammar g)
{
	g.P = visit(g.P){case seplistplus(x,y) => sequence([star(sequence([x,y])),x])};
	return g;
}
// SLEIR:MassageOptSeqXStar2SLStar
@doc{massage ⊢ MassageOptSeqXStar2SLStar, Type III, page 9}
public GGrammar mutate(MassageOptSeqXStar2SLStar(), GGrammar g)
{
	g.P = visit(g.P){case optional(sequence([x,star(sequence([y,x]))])) => sepliststar(x,y)};
	return g;
}
// SLEIR:MassageSLStar2OptSeqXStar
@doc{massage ⊢ MassageSLStar2OptSeqXStar, Type III, page 9}
public GGrammar mutate(MassageSLStar2OptSeqXStar(), GGrammar g)
{
	g.P = visit(g.P){case sepliststar(x,y) => optional(sequence([x,star(sequence([y,x]))]))};
	return g;
}
// SLEIR:MassageOptSeqStarX2SLStar
@doc{massage ⊢ MassageOptSeqStarX2SLStar, Type III, page 9}
public GGrammar mutate(MassageOptSeqStarX2SLStar(), GGrammar g)
{
	g.P = visit(g.P){case optional(sequence([star(sequence([x,y])),x])) => sepliststar(x,y)};
	return g;
}
// SLEIR:MassageSLStar2OptSeqStarX
@doc{massage ⊢ MassageSLStar2OptSeqStarX, Type III, page 9}
public GGrammar mutate(MassageSLStar2OptSeqStarX(), GGrammar g)
{
	g.P = visit(g.P){case sepliststar(x,y) => optional(sequence([star(sequence([x,y])),x]))};
	return g;
}
// SLEIR:MassageOptSLPlus2SLStar
@doc{massage ⊢ MassageOptSLPlus2SLStar, Type III, page 9}
public GGrammar mutate(MassageOptSLPlus2SLStar(), GGrammar g)
{
	g.P = visit(g.P){case optional(seplistplus(x,y)) => sepliststar(x,y)};
	return g;
}
// SLEIR:MassageSLStar2OptSLPlus
@doc{massage ⊢ MassageSLStar2OptSLPlus, Type III, page 9}
public GGrammar mutate(MassageSLStar2OptSLPlus(), GGrammar g)
{
	g.P = visit(g.P){case sepliststar(x,y) => optional(seplistplus(x,y))};
	return g;
}
// SLEIR:MassageNotNot2X
@doc{massage ⊢ MassageNotNot2X, Type III, page 9}
public GGrammar mutate(MassageNotNot2X(), GGrammar g)
{
	g.P = visit(g.P){case not(not(x)) => x};
	return g;
}
// SLEIR:MassageX2NotNot
@doc{massage ⊢ MassageX2NotNot, Type III, page 9}
public GGrammar mutate(MassageX2NotNot(), GGrammar g)
{
	g.P = visit(g.P){case x => not(not(x))};
	return g;
}
// SLEIR:MassageNotAndXY2OrNotXY
@doc{massage ⊢ MassageNotAndXY2OrNotXY, Type III, page 9}
public GGrammar mutate(MassageNotAndXY2OrNotXY(), GGrammar g)
{
	g.P = visit(g.P){case not(allof([x,y])) => choice([not(x),not(y)])};
	return g;
}
// SLEIR:MassageOrNotXY2NotAndXY
@doc{massage ⊢ MassageOrNotXY2NotAndXY, Type III, page 9}
public GGrammar mutate(MassageOrNotXY2NotAndXY(), GGrammar g)
{
	g.P = visit(g.P){case choice([not(x),not(y)]) => not(allof([x,y]))};
	return g;
}
// SLEIR:MassageNotAndXY2OrNotYX
@doc{massage ⊢ MassageNotAndXY2OrNotYX, Type III, page 9}
public GGrammar mutate(MassageNotAndXY2OrNotYX(), GGrammar g)
{
	g.P = visit(g.P){case not(allof([x,y])) => choice([not(y),not(x)])};
	return g;
}
// SLEIR:MassageOrNotYX2NotAndXY
@doc{massage ⊢ MassageOrNotYX2NotAndXY, Type III, page 9}
public GGrammar mutate(MassageOrNotYX2NotAndXY(), GGrammar g)
{
	g.P = visit(g.P){case choice([not(y),not(x)]) => not(allof([x,y]))};
	return g;
}
// SLEIR:MassageNotAndNotXY2OrXY
@doc{massage ⊢ MassageNotAndNotXY2OrXY, Type III, page 9}
public GGrammar mutate(MassageNotAndNotXY2OrXY(), GGrammar g)
{
	g.P = visit(g.P){case not(allof([not(x),not(y)])) => choice([x,y])};
	return g;
}
// SLEIR:MassageOrXY2NotAndNotXY
@doc{massage ⊢ MassageOrXY2NotAndNotXY, Type III, page 9}
public GGrammar mutate(MassageOrXY2NotAndNotXY(), GGrammar g)
{
	g.P = visit(g.P){case choice([x,y]) => not(allof([not(x),not(y)]))};
	return g;
}
// SLEIR:MassageNotAndNotXY2OrYX
@doc{massage ⊢ MassageNotAndNotXY2OrYX, Type III, page 9}
public GGrammar mutate(MassageNotAndNotXY2OrYX(), GGrammar g)
{
	g.P = visit(g.P){case not(allof([not(x),not(y)])) => choice([y,x])};
	return g;
}
// SLEIR:MassageOrYX2NotAndNotXY
@doc{massage ⊢ MassageOrYX2NotAndNotXY, Type III, page 9}
public GGrammar mutate(MassageOrYX2NotAndNotXY(), GGrammar g)
{
	g.P = visit(g.P){case choice([y,x]) => not(allof([not(x),not(y)]))};
	return g;
}
// SLEIR:MassageNotOrXY2AndNotXY
@doc{massage ⊢ MassageNotOrXY2AndNotXY, Type III, page 9}
public GGrammar mutate(MassageNotOrXY2AndNotXY(), GGrammar g)
{
	g.P = visit(g.P){case not(choice([x,y])) => allof([not(x),not(y)])};
	return g;
}
// SLEIR:MassageAndNotXY2NotOrXY
@doc{massage ⊢ MassageAndNotXY2NotOrXY, Type III, page 9}
public GGrammar mutate(MassageAndNotXY2NotOrXY(), GGrammar g)
{
	g.P = visit(g.P){case allof([not(x),not(y)]) => not(choice([x,y]))};
	return g;
}
// SLEIR:MassageNotOrXY2AndNotYX
@doc{massage ⊢ MassageNotOrXY2AndNotYX, Type III, page 9}
public GGrammar mutate(MassageNotOrXY2AndNotYX(), GGrammar g)
{
	g.P = visit(g.P){case not(choice([x,y])) => allof([not(y),not(x)])};
	return g;
}
// SLEIR:MassageAndNotYX2NotOrXY
@doc{massage ⊢ MassageAndNotYX2NotOrXY, Type III, page 9}
public GGrammar mutate(MassageAndNotYX2NotOrXY(), GGrammar g)
{
	g.P = visit(g.P){case allof([not(y),not(x)]) => not(choice([x,y]))};
	return g;
}
// SLEIR:MassageNotOrNotXY2AndXY
@doc{massage ⊢ MassageNotOrNotXY2AndXY, Type III, page 9}
public GGrammar mutate(MassageNotOrNotXY2AndXY(), GGrammar g)
{
	g.P = visit(g.P){case not(choice([not(x),not(y)])) => allof([x,y])};
	return g;
}
// SLEIR:MassageAndXY2NotOrNotXY
@doc{massage ⊢ MassageAndXY2NotOrNotXY, Type III, page 9}
public GGrammar mutate(MassageAndXY2NotOrNotXY(), GGrammar g)
{
	g.P = visit(g.P){case allof([x,y]) => not(choice([not(x),not(y)]))};
	return g;
}
// SLEIR:MassageNotOrNotXY2AndYX
@doc{massage ⊢ MassageNotOrNotXY2AndYX, Type III, page 9}
public GGrammar mutate(MassageNotOrNotXY2AndYX(), GGrammar g)
{
	g.P = visit(g.P){case not(choice([not(x),not(y)])) => allof([y,x])};
	return g;
}
// SLEIR:MassageAndYX2NotOrNotXY
@doc{massage ⊢ MassageAndYX2NotOrNotXY, Type III, page 9}
public GGrammar mutate(MassageAndYX2NotOrNotXY(), GGrammar g)
{
	g.P = visit(g.P){case allof([y,x]) => not(choice([not(x),not(y)]))};
	return g;
}
// SLEIR:MassageAndNot2Except
@doc{massage ⊢ MassageAndNot2Except, Type III, page 9}
public GGrammar mutate(MassageAndNot2Except(), GGrammar g)
{
	g.P = visit(g.P){case allof([x,not(y)]) => except(x,y)};
	return g;
}
// SLEIR:MassageExcept2AndNot
@doc{massage ⊢ MassageExcept2AndNot, Type III, page 9}
public GGrammar mutate(MassageExcept2AndNot(), GGrammar g)
{
	g.P = visit(g.P){case except(x,y) => allof([x,not(y)])};
	return g;
}