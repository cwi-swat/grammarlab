@contributor{Vadim Zaytsev - vadim@grammarware.net - SWAT, CWI}
@contributor{ADT2PP}
module grammarlab::export::GLUE

import grammarlab::language::glue::Abstract;
import grammarlab::language::X;
import grammarlab::export::Grammar;
import grammarlab::export::XBNF;
import grammarlab::lib::RascalPlus;
import grammarlab::lib::ebnf::Glue;
import String;

public str ppx(GLUE cmdlst) = mapjoin(ppx,cmdlst,"\n");

public str ppx(GLUEA::xbgf(XCommand tcmd))
	= replaceLast(replaceFirst(ppx(tcmd,GlueEBNFpp),"(","\n\t"),")","\n.");
public str ppx(GLUEA::sleir(MCommand mcmd)) = "sleir(<ppx(mcmd)>)";
public str ppx(GLUEA::glaction(LCommand acmd)) = ppx(acmd);
public default str ppx(GLUEA smth) = "??<smth>??";

public str ppx(LCommand::diff(GGrammar g)) = "diff\n<ppx(g)>.)";
public str ppx(LCommand::include(loc z)) = "include <z> .";
public default str ppx(LCommand smth) = "??<smth>??";

public str ppx(MCommand::liftTopLabels()) = "LiftTopLabels.";
public str ppx(MCommand::deyaccifyAll()) = "DeYaccifyAll.";
public default str ppx(MCommand smth) = "??<smth>??";

