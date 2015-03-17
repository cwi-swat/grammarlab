@contributor{Vadim Zaytsev - vadim@grammarware.net - SWAT, CWI}
module grammarlab::language::glue::Interpreter

import grammarlab::language::glue::abstract::Top;
import grammarlab::language::SLEIR;
import grammarlab::language::Grammar;
import grammarlab::language::XOutcome;
import grammarlab::language::X;
import grammarlab::transform::XBGF;
import grammarlab::transform::SLEIR;
import grammarlab::transform::Merge;
import grammarlab::transform::Normal;
import grammarlab::io::GLUE;
import grammarlab::io::Grammar;
import grammarlab::compare::Differ;
import grammarlab::language::GET;
import grammarlab::Extractors;
import grammarlab::Exporters;
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

public GGrammar execute(GGrammar g1, glaction(diff(GGrammar g2)))
	= grammar(g1.N-g2.N, gdt(g1.P,g2.P)<0>, g1.S-g2.S-g2.N);
public GGrammar execute(GGrammar g1, glaction(merge(GGrammar g2)))
	= mergeGs(g1,g2);
public GGrammar execute(GGrammar g1, glaction(include(loc z))) = execute(g1,loadGlue(z));
public GGrammar execute(GGrammar g, greedy(GLUE cmds))
{
	println("[GLUE] Greedy mode on.");
	for (GLUEA cmd <- cmds)
		g = mergeGs(g,execute(g,cmd));
	println("[GLUE] Greedy mode off.");
	return g;
}
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
		println("[GLUE] XBGF error in maybe <cmd>, proceeding without changes.");
		report(r.r);
		// TODO: annotate with red squigglies
		return g;
	}
}

public GGrammar execute(GGrammar g1, sleir(MCommand mcmd))
{
	println("[SLEIR] <mcmd>");
	return grammarlab::transform::SLEIR::mutate(mcmd,g1);
}

//TODO: deal with extractors in a separate file
public GGrammar execute(GGrammar g, glaction(extract(GExternalType t, loc z))) = getG(t,z);

// TODO: generate?
public GGrammar getG(GETrscd(), loc z) = rscd2bgf(z);
public GGrammar getG(GETrscs(), loc z) = rscs2bgf(z);
public GGrammar getG(GETrscf(), loc z) = rscf2bgf(z);
public GGrammar getG(GETsdf(), loc z) = sdf2bgf(z);
public GGrammar getG(GETbgf(), loc z) = bgf2bgf(z);
public GGrammar getG(GETrng(), loc z) = rng2bgf(z);
public GGrammar getG(GETxsd(), loc z) = xsd2bgf(z);
public GGrammar getG(GETpgf(), loc z) = pgf2bgf(z);
public default GGrammar getG(GExternalType t, loc z)
{
	println("Unknown external type: <t>");
}

public GGrammar execute(GGrammar g, glaction(export(GExternalType t, loc z, str n)))
{
	putG(t,z,n,g);
	return g;
}

// TODO: generate
//public void putG(GETbnf(), loc z, str n, GGrammar g) = bgf2bnf(z,n,g);
public void putG(GETbgf(), loc z, str n, GGrammar g) = bgf2bgf(z,n,g);
public void putG(GETrscd(), loc z, str n, GGrammar g) = bgf2rscd(z,n,g);
public void putG(GETrscs(), loc z, str n, GGrammar g) = bgf2rscs(z,n,g);
public default void putG(GExternalType t, loc z, str n, GGrammar g)
{
	println("Unknown external type: <t>");
}

// TODO
public default GGrammar execute(GGrammar g, GLUEA c)
{
	println("[GLUE] Command not executed: <c>");
	return g;
}
