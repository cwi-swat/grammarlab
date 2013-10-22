@contributor{Vadim Zaytsev - vadim@grammarware.net - SWAT, CWI}
module grammarlab::io::GLUE

extend grammarlab::io::read::GLUE;
extend grammarlab::io::write::GLUE;

// crappy test code, can be removed later in favour of proper testing
public void t()
{
	writeGlue(loadGlue(
	|project://grammarlab/src/meta/GlueAdapt.glue|),
	|project://grammarlab/src/TestOutput.glue|);
	writeGlue(loadGlue(
	|project://grammarlab/src/TestOutput.glue|),
	|project://grammarlab/src/TestOutput2.glue|);

	writeGlue(loadGlue(
	|project://grammarlab/src/meta/GlueLanguage.glue|),
	|project://grammarlab/src/TestOutput.glue|);
	writeGlue(loadGlue(
	|project://grammarlab/src/TestOutput.glue|),
	|project://grammarlab/src/TestOutput2.glue|);
}
