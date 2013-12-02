@contributor{Vadim Zaytsev - vadim@grammarware.net - SWAT, CWI; UvA}
module grammarlab::extract::HaskellADT2BGF

import IO;
import List;
import String;
import grammarlab::language::Grammar;
import grammarlab::lib::Sizes;

str cleanupComments(str s)
{
	return s;
	if (/<b:.*>\{\-[^-]*\-\}<a:.*>/ := s)
		return b+a;
	else
		return s;
}

list[str] firstTokens(list[str] ss) = [trim(firstToken(s)) | str s <- tail(ss)];
str firstToken(str s)
{
	ts = split(" ",s);
	if (ts[0] == "{-")
		return ts[indexOf(ts,"-}")+1];
	else
		return ts[0];
}

GGrammar extractG(loc z)
{
	str s = cleanupComments(readFile(z));
	println("!<s>!");
	datas = split("data ",s); 
	types = split("type ",s); 
	if (len(datas)>1)
		println("Found <len(datas)-1> type definitions in <z>: <firstTokens(datas)>."); 
	if (len(types)>1)
		println("Found <len(types)-1> aliases in <z>: <firstTokens(types)>."); 
	return grammar([],[],[]);
}

public void main()
{
	g = extractG(|project://grammarlab/src/test/set/extract/hadt/AbstractSyntax.hs|);
}