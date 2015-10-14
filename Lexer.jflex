import java_cup.runtime.*;

%%

%class Lexer
%line
%column
%cupsym ClassSymbol
%cup

%{

private Symbol symbol (int type) {
        return new Symbol (type, yyline, yycolumn);
}

private Symbol symbol (int type, Object value) {
        return new Symbol (type, yyline, yycolumn, value);
}

%}

entier = [0-9]+
puissance = ('e'[0-9]+)?
virgule_flottante = entier('.'entier)?puissance|'.'entier.puissance

identificateur = [a-zA-Z][a-zA-Z0-9_\-]*

caractere = "0x"[0-9][0-9A-Fa-f]|'\''[.]?'\''
whitespace = [ \t\v\n\f]
%%

"/*" ~"*/" 		{}

"//" ~\n 		{}

[\"] ~[\"] 		{ return symbol(ClassSymbol.STRING_LITERAL, yytext()); }

"integer" 		{ return symbol(ClassSymbol.TYPESIMPLE , IdType.INTEGER); }
"character" 	{ return symbol(ClassSymbol.TYPESIMPLE, IdType.CHARACTER); }
"float" 		{ return symbol(ClassSymbol.TYPESIMPLE, IdType.FLOAT); }
"boolean" 		{ return symbol(ClassSymbol.TYPESIMPLE, IdType.BOOLEAN); }
"string" 		{ return symbol(ClassSymbol.TYPESIMPLE, IdType.STRING); }

"true" 			{ return symbol(ClassSymbol.TRUE); }
"false" 		{ return symbol(ClassSymbol.FALSE); }
"null" 			{ return symbol(ClassSymbol.NULL); }

"list of" 		{ return symbol(ClassSymbol.LISTOF); }
"static" 		{ return symbol(ClassSymbol.STATIC); }
"structure" 	{ return symbol(ClassSymbol.STRUCTURE); }
"type" 			{ return symbol(ClassSymbol.TYPE); }

"class" 		{ return symbol(ClassSymbol.CLASS); }
"function" 		{ return symbol(ClassSymbol.FUNCTION); }
"procedure" 	{ return symbol(ClassSymbol.PROCEDURE); }

"break" 		{ return symbol(ClassSymbol.BREAK); }
"stop" 			{ return symbol(ClassSymbol.STOP); }
"return" 		{ return symbol(ClassSymbol.RETURN); }

"foreach" 		{ return symbol(ClassSymbol.FOREACH); }
"in" 			{ return symbol(ClassSymbol.IN); }
"while" 		{ return symbol(ClassSymbol.WHILE); }
"repeat" 		{ return symbol(ClassSymbol.REPEAT); }
"if" 			{ return symbol(ClassSymbol.IF); }
"else" 			{ return symbol(ClassSymbol.ELSE); }

{identificateur} { System.out.println("identificateur : "+yytext()); return symbol(ClassSymbol.IDENTIFICATEUR, yytext()); }

{caractere} 	{ return symbol(ClassSymbol.CARACTERE, yytext());}
{entier} 		{ return symbol(ClassSymbol.ENTIER, Integer.parseInt(yytext())); }
{virgule_flottante} { return symbol(ClassSymbol.VIRGULE_FLOTTANTE);}
{whitespace} 	{}

";"				{ return symbol(ClassSymbol.POINT_VIRGULE); }
"{"				{ return symbol(ClassSymbol.ACCOLADE_OUVRANTE); }
"}"				{ return symbol(ClassSymbol.ACCOLADE_FERMANTE); }
","				{ return symbol(ClassSymbol.VIRGULE); }
":"				{ return symbol(ClassSymbol.DEUX_POINT); }
"="				{ return symbol(ClassSymbol.EGAL); }
"("				{ return symbol(ClassSymbol.PARENTHESE_OUVRANTE); }
")"				{ return symbol(ClassSymbol.PARENTHESE_FERMANTE); }
"["				{ return symbol(ClassSymbol.CROCHET_OUVRANT); }
"]"				{ return symbol(ClassSymbol.CROCHET_FERMANT); }
"!"				{ return symbol(ClassSymbol.EXCLAMATION); }
"~"				{ return symbol(ClassSymbol.TILDE); }
"-"				{ return symbol(ClassSymbol.CADRATIN); }
"+"				{ return symbol(ClassSymbol.PLUS); }
"*"				{ return symbol(ClassSymbol.ETOILE); }
"/"				{ return symbol(ClassSymbol.BARRE_OBLIQUE); }
"%"				{ return symbol(ClassSymbol.POURCENT); }
"<"				{ return symbol(ClassSymbol.CHEVRON_INFERIEUR); }
">"				{ return symbol(ClassSymbol.CHEVRON_SUPERIEUR); }
"^"				{ return symbol(ClassSymbol.CIRCONFLEXE); }
"."				{ return symbol(ClassSymbol.POINT); }

"+="			{ return symbol(ClassSymbol.ADD_ASSIGN); }
"-="			{ return symbol(ClassSymbol.SUB_ASSIGN); }
"*="			{ return symbol(ClassSymbol.MUL_ASSIGN); }
"/="			{ return symbol(ClassSymbol.DIV_ASSIGN); }
"%="			{ return symbol(ClassSymbol.MOD_ASSIGN); }
"++"			{ return symbol(ClassSymbol.INC_OP); }
"--"			{ return symbol(ClassSymbol.DEC_OP); }
"&&"			{ return symbol(ClassSymbol.AND_OP); }
"||"			{ return symbol(ClassSymbol.OR_OP); }
"<="			{ return symbol(ClassSymbol.LE_OP); }
">="			{ return symbol(ClassSymbol.GE_OP); }
"=="			{ return symbol(ClassSymbol.EQ_OP); }
"!="			{ return symbol(ClassSymbol.NE_OP); }

. { System.out.println("error : token inconnu : "+ yytext() +". line:"+yyline+", column:"+yycolumn); }
