@contributor{Vadim Zaytsev - vadim@grammarware.net - SWAT, CWI}
// Automatically generates test cases for yaccification and deyaccification.
// Covers both transformations and mutations.
module meta::GenYacc

import grammarlab::io::GLUE;
import grammarlab::language::glue::Abstract;
import grammarlab::language::X;
import grammarlab::language::Grammar;
import grammarlab::transform::Normal;
import Relation;
import Set;

// Code clone from grammarlab::transform::xbgf::Yacc
rel[GProd,GProdList] yp = 
	{
		<production("a",sequence([nonterminal("c"),star(nonterminal("b"))])),
			[production("a",sequence([nonterminal("a"),nonterminal("b")])),
			production("a",nonterminal("b"))]>,
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

GLUE psg2gl(GProdList ps, GGrammar g) = [ xbgf(importG(ps)), sleir(deyaccifyAll()), glaction(diff(g)) ];

void main()
{
	int cx = 1;
	for (GProd p <- domain(yp))
	{
		str n = "<cx>";
		writeGlue(
			[
				xbgf(importG(yp2Lps(p))),
				xbgf(yaccify(yp2RpsV(p))),
				glaction(diff(yp2RgV(p)))
			],
			|project://grammarlab/src/test/set/xbgf/yaccify<n>.glue|
		);
		writeGlue(
			[
				xbgf(importG(yp2RpsV(p))),
				xbgf(deyaccify(yp2n(p))),
				glaction(diff(yp2Lg(p)))
			],
			|project://grammarlab/src/test/set/xbgf/deyaccify<n>.glue|
		);
		writeGlue(
			[
				xbgf(importG(yp2RpsV(p))),
				sleir(deyaccifyAll()),
				glaction(diff(yp2Lg(p)))
			],
			|project://grammarlab/src/test/set/sleir/deyaccify1V<n>.glue|
		);
		writeGlue(
			[
				xbgf(importG(yp2RpsH(p))),
				sleir(deyaccifyAll()),
				glaction(diff(yp2Lg(p)))
			],
			|project://grammarlab/src/test/set/sleir/deyaccify1H<n>.glue|
		);
		int dx = 1;
		for (GProd q <- domain(yp))
		{
			str m = "<dx>";
			writeGlue(
				psg2gl(yp2RpsVV(p,q),yp2Lg(p,q)),
				|project://grammarlab/src/test/set/sleir/deyaccify2VV<n><m>.glue|);
			writeGlue(
				psg2gl(yp2RpsVH(p,q),yp2Lg(p,q)),
				|project://grammarlab/src/test/set/sleir/deyaccify2VH<n><m>.glue|);
			writeGlue(
				psg2gl(yp2RpsHV(p,q),yp2Lg(p,q)),
				|project://grammarlab/src/test/set/sleir/deyaccify2HV<n><m>.glue|);
			writeGlue(
				psg2gl(yp2RpsHH(p,q),yp2Lg(p,q)),
				|project://grammarlab/src/test/set/sleir/deyaccify2HH<n><m>.glue|);
			dx += 1;
		}
		cx += 1;
	}
}
