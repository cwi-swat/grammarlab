@contributor{Vadim Zaytsev - vadim@grammarware.net - SWAT, CWI}
module grammarlab::language::glue::Interpreter

import grammarlab::language::glue::Abstract;
import grammarlab::language::Grammar;
import grammarlab::language::XOutcome;
import grammarlab::language::X;
import grammarlab::transform::XBGF;
import grammarlab::transform::SLEIR;
import grammarlab::transform::Normal;
import grammarlab::io::GLUE;
import IO;

public GGrammar execute(loc z) = execute(loadGlue(z));
public GGrammar execute(GLUE sec) = execute(EmptyGrammar,sec);
public GGrammar execute(GGrammar g, loc z) = execute(g,loadGlue(z));
public GGrammar execute(GGrammar g, GLUE sec) = (g | normalise(execute(it,step)) | step <- sec);

public GGrammar execute(GGrammar g, xbgf(XCommand cmd))
{
	XResult r = vtransform(cmd, g);
	if (ok() := r.r)
		return r.g;
	else
	{
		println("[GLUE] XBGF error in <cmd>!");
		thw(r.r);
		// TODO: annotate with red squigglies
		return g;
	}
}

public GGrammar execute(GGrammar g1, glaction(diff(GGrammar g2))) = grammar(g1.N-g2.N, g1.P-g2.P, g1.S-g2.S-g2.N);
public GGrammar execute(GGrammar g1, glaction(include(loc z))) = execute(g1,loadGlue(z));
public GGrammar execute(GGrammar g, glaction(maybexbgf(XCommand cmd)))
// clone of execute(GGrammar g, xbgf(XCommand cmd))
{
	XResult r = vtransform(cmd, g);
	if (ok() := r.r)
	{
		println("[GLUE] XBGF maybe <cmd> executed normally.");
		return r.g;
	}
	else
	{
		println("[GLUE] XBGF error in maybe <cmd>, proceding without changes.");
		report(r.r);
		// TODO: annotate with red squigglies
		return g;
	}
}

public GGrammar execute(GGrammar g1, sleir(liftTopLabels())) = LiftTopLabels(g1);

// TODO
public default GGrammar execute(GGrammar g, GLUEA _) = g;
