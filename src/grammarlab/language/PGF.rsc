@contributor{Vadim Zaytsev - vadim@grammarware.net - SWAT, CWI}
module grammarlab::language::PGF

extend lang::std::Layout;
extend lang::std::Id;

start syntax PGFFile = PGFCat+ cs;
syntax PGFCat = "category" "{" {PGFName ","}+ elems "}" "\<:" PGFName super ";";
syntax PGFName = Id name;

test bool tryPGF() =
	/amb(_) !:=
	parse(#start[PGFFile], |home:///projects/slps/topics/grammars/type/pgf/figure2.txt|);