@contributor{Vadim Zaytsev - vadim@grammarware.net - SWAT, CWI}
module grammarlab::extract::rascal::Function

import lang::rascal::\syntax::Rascal;
import grammarlab::language::Grammar;
import grammarlab::extract::rascal::Type;
//import String;
import IO;

public GProd mapFunDecl(FunctionDeclaration fd) = mapSig(fd.signature);
GProd mapSig(Signature sig)
	= production("<sig.\type>",label("<sig.name>",mapPars(sig.parameters)));
GExpr mapPars((Parameters)`(<Formals formals><KeywordFormals keywordFormals>)`)
	= sequence([mapPat(p) | /Pattern p := formals]);
GExpr mapPars((Parameters)`(<Formals formals>...<KeywordFormals keywordFormals>)`) 
	= sequence([mapPat(p) | /Pattern p := formals]);

GExpr mapPats({Pattern ","}* pats)
	= sequence([mapPat(p) | /Pattern p := pats]);
GExpr mapPat((Pattern)`{<{Pattern ","}* elements>}`) = star(mapPats(elements)); // set
GExpr mapPat((Pattern)`[<{Pattern ","}* elements>]`) = star(mapPats(elements)); // list
GExpr mapPat((Pattern)`<QualifiedName qualifiedName>`) = nonterminal("<qualifiedName>");
GExpr mapPat((Pattern)`<QualifiedName qualifiedName>*`) = star(nonterminal("<qualifiedName>"));
GExpr mapPat((Pattern)`<Literal literal>`) = nonterminal("<literal>");
GExpr mapPat((Pattern)`<Type t><Name n>`) = mark("<n>",mapType(t));
default GExpr mapPat(Pattern p)
{
	println("Error in the RascalFun extractor: cannot map <p>");
	return empty();
}

GExpr mapType(Type t) = grammarlab::extract::rascal::Type::type2expr(t);
