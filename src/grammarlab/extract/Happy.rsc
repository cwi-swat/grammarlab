@contributor{Vadim Zaytsev - vadim@grammarware.net - SWAT, CWI; UvA}
module grammarlab::extract::Happy

import util::IDE;
import ParseTree;
import IO;

start syntax HappyGrammar = HappyPragma+;

layout HappyLayoutList = HappyLayout* !>> [\t-\n \r \  ] !>> "//";
lexical HappyLayout = [\t-\n \r \  ] | HappyComment ;
lexical HappyComment = @category="Comment" [{] HappyCommentPart+ [}];
lexical HappyCommentPart = ![}\'] | [\'] ![\']+ [\'];

lexical HappyPragmaName = "tokentype" | "token" | "left" | "name" | [%];

syntax HappyPragma = "%" HappyPragmaName HappyWord*;
lexical HappyWord = HappySWord | HappyQWord;
lexical HappySWord = [a-zA-Z]+ !>> [a-zA-Z];
lexical HappyQWord = [\"] ![\"]+ [\"];

Tree getHG(loc z) = parse(#start[HappyGrammar],z).top;
Tree getHG(str _, loc z) = getHG(z);

public void regHappy()
{
	registerLanguage("Happy","y",getHG);
}

public void go()
{
	clearLanguages();
	Tree t = char(0);
	try
		t = getHG(|home://projects/zoo/haskell/cactus/HaskellParser.y|);
	catch ParseError:
		println("Ungrammatical!");
	if (/amb(_) := t)
		println("Ambiguous!");
	else
		regHappy();
}

public void do()
{
	loc c = |home:///projects/zoo/haskell/cactus/HaskellParser.y|;
	println(c);
	getHG(c);
}