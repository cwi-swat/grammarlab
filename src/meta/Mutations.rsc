@contributor{Vadim Zaytsev - vadim@grammarware.net - UvA}
module meta::Mutations

import IO;
import Set;
import List;
import String;
import grammarlab::lib::Sizes;

void main()
{
	// massage
	int cx = 0;
	list[str] pair;
	//header("Massage");
	str buf = "@contributor{Vadim Zaytsev - vadim@grammarware.net - UvA}
	'@contributor{Generated by meta::Mutations, do not edit manually!}
	'@doc{Contains $$CX$$ mutations intentionally generalised from massage-equivalence.}
	'module grammarlab::transform::sleir::Massage
	'
	'import grammarlab::language::Grammar;
	'import grammarlab::language::SLEIR;
	'";
	for(
		str line <- readFileLines(|project://grammarlab/src/grammarlab/transform/XBGF.rsc|),
		/bool massage_eq\(\{<zet:[^}]+>\}\) = true; \/\/@<left:[^-]*>-<right:.*>$/ := line,
		pair := split(", ",zet)
	)
	{
		//println("Left: .<left>.; right: .<right>.; pair: .<pair>.!");
		cx += 1;
		if (len(pair)!=2 || (isEmpty(left) && isEmpty(right)))
			buf += "//ERROR: <pair[0]> =\> <pair[1]>";
		elseif (isEmpty(left) && !isEmpty(right))
			buf += function("massage","Massage<right>",pair[1],pair[0]);
		elseif (!isEmpty(left) && isEmpty(right))
			buf += function("massage","Massage<left>",pair[0],pair[1]);
		else
		{
			buf += function("massage","Massage<left>2<right>",pair[0],pair[1]);
			buf += function("massage","Massage<right>2<left>",pair[1],pair[0]);
			cx += 1;
		}
	}
	writeFile(|project://grammarlab/src/grammarlab/transform/sleir/Massage.rsc|,replaceAll(buf,"$$CX$$","<cx>"));
	// narrow and widen
	//bool narrowing( star(e), plus(e) ) = true; //#Star-Plus
	cx = 0;
	buf = "@contributor{Vadim Zaytsev - vadim@grammarware.net - UvA}
	'@contributor{Generated by meta::Mutations, do not edit manually!}
	'@doc{Contains $$CX$$ mutations intentionally generalised from narrow-/widen-equivalence.}
	'module grammarlab::transform::sleir::Width
	'
	'import grammarlab::language::Grammar;
	'import grammarlab::language::SLEIR;
	'";
	for(
		str line <- readFileLines(|project://grammarlab/src/grammarlab/transform/XBGF.rsc|),
		//contains(" //#",line),
		/bool narrowing\( <from:[^ ]+>, <to:[^ ]+> \) = eqE\(e1,e2\); \/\/#<left:[^-]+>-<right:.*>$/ := line
	)
	{
		from = replaceFirst(from,"1","");
		to = replaceFirst(to,"2","");
		if (from != "e")
			{buf += function("narrow","Narrow<left>2<right>",from,to);cx+=1;}
		if (to != "e")
			{buf += function("widen","Widen<right>2<left>",to,from);cx+=1;}
	}
	writeFile(|project://grammarlab/src/grammarlab/transform/sleir/Width.rsc|,replaceAll(buf,"$$CX$$","<cx>"));
	
	// Finally, let’s update the ADT
	sleir = |project://grammarlab/src/grammarlab/transform/|;
	lst = {"<name>(<args>)" |
		g <- [sleir+"sleir/"+f | f <- listEntries(sleir+"sleir"), endsWith(f,".rsc")]+(sleir+"SLEIR.rsc"),
		//g <- [|project://grammarlab/src/grammarlab/transform/sleir/Massage.rsc|],		
		line <- readFileLines(g),
		/public GGrammar mutate\(<name:[a-zA-Z0-9]+>\(<args:[^)]*>\), GGrammar g\)$/ := line
		};
	
	writeFile(|project://grammarlab/src/grammarlab/language/SLEIR.rsc|,
	"@contributor{Vadim Zaytsev - vadim@grammarware.net - UvA}
	'@contributor{Generated by meta::Mutations, do not edit manually!}
	'@doc{The suite consists of <len(lst)> mutations intentionally generalised from XBGF operators.}
	'module grammarlab::language::SLEIR
	'
	'import grammarlab::language::Grammar;
	'import grammarlab::language::X;
	'
	'alias MSequence = list[MCommand];
	'
	'data MCommand
	'	= "+intercalate("\n\t| ",sort(lst))+"
	';");
}

str function(str base, str name, str from, str to) =
	"
	'// SLEIR:<name>
	'@doc{<base> ⊢ <name>, Type III, page 9}
	'public GGrammar mutate(<name>(), GGrammar g)
	'{
	'	g.P = visit(g.P){case <from> =\> <to>};
	'	return g;
	'}";
