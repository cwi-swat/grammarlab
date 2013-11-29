@contributor{Vadim Zaytsev - vadim@grammarware.net - SWAT, CWI}
@contributor{ADT2PP}
module grammarlab::export::GLUE

import grammarlab::language::glue::abstract::Top;
// import grammarlab::language::glue::Scope;
import grammarlab::language::SLEIR;
import grammarlab::language::Grammar;
import grammarlab::language::X;
import grammarlab::export::Grammar;
import grammarlab::export::XBNF;
import grammarlab::lib::RascalPlus;
import grammarlab::lib::ebnf::Glue;
import String;

public str ppx(GLUE cmdlst) = mapjoin(ppx,cmdlst,"\n");

public str ppx(GLUEA::xbgf(XCommand tcmd)) = ppxbgf(tcmd);
public str ppx(GLUEA::sleir(MCommand mcmd)) = ppx(mcmd);
public str ppx(GLUEA::glaction(LCommand acmd)) = ppx(acmd);
public default str ppx(GLUEA smth) = "??<smth>??";

public str ppx(LCommand::diff(GGrammar g)) = "diff\n\t<ppx(g)>.";
public str ppx(LCommand::include(loc z)) = "include <z> .";
public default str ppx(LCommand smth) = "??L??<smth>??";

public str ppx(MCommand::AbridgeAll()) = "AbridgeAll.";
public str ppx(MCommand::DeyaccifyAll()) = "DeyaccifyAll.";
public str ppx(MCommand::LiftTopLabels()) = "LiftTopLabels.";
public default str ppx(MCommand smth) = "??M??<smth>??";

str ppxbgf(renameL(GLabel x, GLabel y)) = "rename [<x>] to [<y>] globally.";
str ppxbgf(renameN(GNonTerm x, GNonTerm y)) = "rename <x> to <y> globally.";
str ppxbgf(renameS(GMark x, GMark y, XScope w)) = "rename \<<x>\> to \<<y>\> <pps(w)>.";
str ppxbgf(renameT(GTerm x, GTerm y)) = "rename \"<x>\" to \"<y>\" globally.";
public str ppxbgf(XCommand tcmd) = replaceLast(replaceFirst(ppx(tcmd,GlueEBNFpp),"(","\n\t"),")","\n.");
