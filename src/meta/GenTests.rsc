@contributor{Vadim Zaytsev - vadim@grammarware.net - SWAT, CWI}
// Automatically generates test cases for yaccification, deyaccification and abridging.
// Covers both transformations and mutations.
module meta::GenTests

import grammarlab::language::Grammar;
import grammarlab::language::SLEIR;
import grammarlab::language::X;
import grammarlab::io::GLUE;
import grammarlab::language::glue::abstract::Top;
import grammarlab::transform::Normal;
import Relation;
import Set;

// Code clone from grammarlab::transform::xbgf::Yacc
rel[GProd,GProdList] yp = 
	{
		<production("a",sequence([nonterminal("c"),star(nonterminal("b"))])),
			[production("a",sequence([nonterminal("a"),nonterminal("b")])),
			production("a",nonterminal("c"))]>,
		<production("d",plus(nonterminal("e"))),
			[production("d",sequence([nonterminal("d"),nonterminal("e")])),
			production("d",nonterminal("e"))]>,
		<production("f",sequence([star(nonterminal("g")),nonterminal("h")])),
			[production("f",sequence([nonterminal("g"),nonterminal("f")])),
			production("f",nonterminal("h"))]>,
		<production("k",plus(nonterminal("m"))),
			[production("k",sequence([nonterminal("m"),nonterminal("k")])),
			production("k",nonterminal("m"))]>,
		<production("n",star(nonterminal("p"))),
			[production("n",sequence([nonterminal("p"),nonterminal("n")])),
			production("n",epsilon())]>,
		<production("q",star(nonterminal("r"))),
			[production("q",sequence([nonterminal("q"),nonterminal("r")])),
			production("q",epsilon())]>
	};

GProdList abr =
	[
		production("a",nonterminal("a")),
		production("b",mark("m1",nonterminal("b"))),
		production("c",label("m2",nonterminal("c"))),
		production("d",label("m3",mark("m4",nonterminal("d"))))
	];

GProd     yp2Lp(GProd p) = p;
GProdList yp2Lps(GProd p) = [yp2Lp(p)];
GProdList yp2Lps(GProd p1, GProd p2) = [yp2Lp(p1),yp2Lp(p2)];
GGrammar  yp2Lg(GProd p) = normalise(grammar([p.lhs],yp2Lps(p),[]));
GGrammar  yp2Lg(GProd p1, GProd p2) = normalise(grammar([p1.lhs],yp2Lps(p1,p2),[]));

GProdList yp2RpsV(GProd p) = getOneFrom(yp[p]);
GGrammar  yp2RgV(GProd p) = normalise(grammar([p.lhs],yp2RpsV(p),[]));
GProd     yp2RpH(GProd p) = production(p.lhs,choice([q.rhs | GProd q <- yp2RpsV(p)]));
GProdList yp2RpsH(GProd p) = [yp2RpH(p)];
GGrammar  yp2RgH(GProd p) = normalise(grammar([p.lhs],yp2RpsH(p),[]));

GProdList yp2RpsVV(GProd p1, GProd p2) = yp2RpsV(p1)+yp2RpsV(p2);
GProdList yp2RpsVH(GProd p1, GProd p2) = yp2RpsV(p1)+yp2RpsH(p2);
GProdList yp2RpsHV(GProd p1, GProd p2) = yp2RpsH(p1)+yp2RpsV(p2);
GProdList yp2RpsHH(GProd p1, GProd p2) = yp2RpsH(p1)+yp2RpsH(p2);

str yp2n(GProd p) = p.lhs;

GLUE psg2gl(GProdList ps, GLUEA cmd, GGrammar g) = [ xbgf(importG(ps)), cmd, glaction(diff(g)) ];

void main()
{
	int cx = 1;
	for (GProd p <- domain(yp))
	{
		str n = "<cx>";
		// (de)yaccification test cases for transformations and mutations
		writeGlue(
			psg2gl(yp2Lps(p), xbgf(yaccify(yp2RpsV(p))), yp2RgV(p)),
			|project://grammarlab/src/test/set/xbgf/yaccifyV<n>.glue|);
		writeGlue(
			psg2gl(yp2Lps(p), xbgf(yaccify(yp2RpsH(p))), yp2RgH(p)),
			|project://grammarlab/src/test/set/xbgf/yaccifyH<n>.glue|);
		writeGlue(
			psg2gl(yp2RpsV(p), xbgf(deyaccify(yp2n(p))), yp2Lg(p)),
			|project://grammarlab/src/test/set/xbgf/deyaccifyV<n>.glue|);
		writeGlue(
			psg2gl(yp2RpsH(p), xbgf(deyaccify(yp2n(p))), yp2Lg(p)),
			|project://grammarlab/src/test/set/xbgf/deyaccifyH<n>.glue|);
		writeGlue(
			psg2gl(yp2RpsV(p), sleir(DeyaccifyAll()), yp2Lg(p)),
			|project://grammarlab/src/test/set/sleir/deyaccify1V<n>.glue|);
		writeGlue(
			psg2gl(yp2RpsH(p), sleir(DeyaccifyAll()), yp2Lg(p)),
			|project://grammarlab/src/test/set/sleir/deyaccify1H<n>.glue|);
		int dx = 1;
		for (GProd q <- domain(yp))
		{
			if(p==q)continue;
			str m = "<dx>";
			// (de)yaccification test cases with a broader scope for mutations
			writeGlue(
				psg2gl(yp2RpsVV(p,q), sleir(DeyaccifyAll()), yp2Lg(p,q)),
				|project://grammarlab/src/test/set/sleir/deyaccify2VV<n><m>.glue|);
			writeGlue(
				psg2gl(yp2RpsVH(p,q), sleir(DeyaccifyAll()), yp2Lg(p,q)),
				|project://grammarlab/src/test/set/sleir/deyaccify2VH<n><m>.glue|);
			writeGlue(
				psg2gl(yp2RpsHV(p,q), sleir(DeyaccifyAll()), yp2Lg(p,q)),
				|project://grammarlab/src/test/set/sleir/deyaccify2HV<n><m>.glue|);
			writeGlue(
				psg2gl(yp2RpsHH(p,q), sleir(DeyaccifyAll()), yp2Lg(p,q)),
				|project://grammarlab/src/test/set/sleir/deyaccify2HH<n><m>.glue|);
			dx += 1;
		}
		cx += 1;
	}
	cx = 1;
	for (GProd p <- abr)
	{
		str n = "<cx>";
		writeGlue(
			psg2gl([p,production(p.lhs,terminal("leaf"))], xbgf(abridge(p)), grammar([p.lhs],[production(p.lhs,terminal("leaf"))],[])),
			|project://grammarlab/src/test/set/xbgf/abridge<n>.glue|);
		writeGlue(
			psg2gl([p,production(p.lhs,terminal("leaf"))], sleir(AbridgeAll()), grammar([p.lhs],[production(p.lhs,terminal("leaf"))],[])),
			|project://grammarlab/src/test/set/sleir/abridge1_<n>.glue|);
		int dx = 1;
		for (GProd q <- abr)
		{
			str m = "<dx>";
			writeGlue(
				psg2gl([p,q,production(p.lhs,terminal("leaf"))], sleir(AbridgeAll()), grammar([p.lhs],[production(p.lhs,terminal("leaf"))],[])),
				|project://grammarlab/src/test/set/sleir/abridge2_<n><m>.glue|);
			dx += 1;
		}
		cx += 1;
	}
}
