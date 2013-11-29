@contributor{Vadim Zaytsev - vadim@grammarware.net - SWAT, CWI}
module grammarlab::language::glue::concrete::Colours

import vis::Figure;
import util::IDE;

Color colSpecial     = rgb(0x78,0x8A,0xFC); // ε, φ, α
Color colNonterminal = rgb(0x48,0x5A,0xCC); // nonterminals
Color colTerminal    = rgb(0x00,0x99,0x00); // terminals
Color colCommand     = rgb(0xBB,0x00,0x00); // xbgf commands
Color colMutation    = rgb(0xCC,0xFF,0xCC); // mutations (background)
Color colExtra       = rgb(0xFF,0xFF,0xCC); // other commands (background)
Color colComment     = gray(0xCC);          // comments
Color colLabel       = gray(0x99);          // labels and marks

public set[Contribution] getGLColours()
= {categories((
	"NonterminalLabel":	{foregroundColor(colLabel),italic()},
	"MetaSkipped":		{foregroundColor(colSpecial),bold()},
	"MetaVariable":		{foregroundColor(colCommand),bold()},
	"MetaAmbiguity":		{foregroundColor(colCommand),backgroundColor(colMutation),bold()},
	"MetaKeyword":		{foregroundColor(colCommand),backgroundColor(colExtra),bold()},
	"Identifier":		{foregroundColor(colNonterminal)},
	"Constant":			{foregroundColor(colTerminal)},
	"Comment":			{foregroundColor(colComment),italic()}
	//"StringLiteral":	{foregroundColor(rgb(0x2A,0xA1,0x98))},
	//"Variable":		{foregroundColor(rgb(0x26,0x8B,0xD2))},
	//"Type":			{foregroundColor(rgb(0x74,0x8B,0x00))},
	//"MetaAmbiguity":	{foregroundColor(rgb(0xaf,0x00,0x00)),
	//	bold(), italic()},
	//"Todo":			{foregroundColor(rgb(0xaf,0x00,0x00)),
	//	bold()},
	//"MetaKeyword":	{foregroundColor(rgb(0x85,0x99,0x00))}//,
  ))};

