@contributor{Vadim Zaytsev - vadim@grammarware.net - SWAT, CWI}
module grammarlab::language::glue::Interpreter

import grammarlab::language::glue::Abstract;
import grammarlab::language::Grammar;
import grammarlab::language::XOutcome;
import grammarlab::language::X;
import grammarlab::transform::XBGF;

public GGrammar execute(GGrammar g, xbgf(XCommand cmd))
{
	XResult r = transform(cmd, g);
	if (ok() := r.r)
		return r.g;
	else
		// TODO: annotate with red squigglies
		return g;
}

public GGrammar execute(GGrammar g1, glaction(diff(GGrammar g2))) = grammar(g1.N-g2.N, g1.P-g2.P, g1.S-g2.S-g2.N);

// TODO
public default GGrammar execute(GGrammar g, GLUEA _) = g;
