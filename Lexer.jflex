import java_cup.runtime.*;

%%

%class Lexer
%line
%column
%cupsym ClassSymbol
%cup


%xstate COMMENT
%xstate STRING

%{

private StringBuffer buffer;

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

fonction = [a-zA-Z][a-zA-Z1-9_\-]

caractere = "0x"[0-9][0-9A-Fa-f]|'\''[[.]?{whitespace}\0[EOF]'\''
whitespace = [ \t\v\n\f]
%%

//Mots clefs 

"integer" { return symbol(ClassSymbol.TYPE , IdType.INTEGER); }
"character" { return symbol(ClassSymbol.TYPE, IdType.CHARACTER); }
"float" { return symbol(ClassSymbol.TYPE, IdType.FLOAT); }
"boolean" { return symbol(ClassSymbol.TYPE, IdType.BOOLEAN); }
"string" { return symbol(ClassSymbol.TYPE, IdType.STRING); }
"list of " { return symbol(ClassSymbol.TYPE, IdType.LISTOF); }
 

"class" { return symbol(ClassSymbol.CLASS); }
"static" { return symbol(ClassSymbol.STATIC); }
"function" { return symbol(ClassSymbol.FUNCTION); }
"procedure" { return symbol(ClassSymbol.PROCEDURE); }
"return" { return symbol(ClassSymbol.RETURN); }
"for" { return symbol(ClassSymbol.FOR); }
"while" { return symbol(ClassSymbol.WHILE); }
"if" { return symbol(ClassSymbol.IF); }
"else" { return symbol(ClassSymbol.ELSE); }
"switch" { return symbol(ClassSymbol.SWITCH); }
"case" { return symbol(ClassSymbol.CASE); }


{fonction} { buffer.append(yytext()); return symbol(ClassSymbol.FONCTION, buffer); }
{caractere} { return symbol(ClassSymbol.CARACTERE, yytext());}
{entier} { return symbol(ClassSymbol.ENTIER, Character.getNumericValue(yytext()));}
{virgule_flottante} {return symbol(ClassSymbol.VIRGULE_FLOTTANTE);}
{whitespace} {}


//Symboles

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
"."				{ return symbol(ClassSymbol.POINT); }
"&"				{ return symbol(ClassSymbol.ESPERLUETTTE); }
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
"|"				{ return symbol(ClassSymbol.PIPE); }
"?"				{ return symbol(ClassSymbol.INTERROGATION); }

//Opérateurs

"..."				{ return symbol(ClassSymbol.ELLIPSIS); }
">>="				{ return symbol(ClassSymbol.RIGHT_ASSIGN); }
"<<="				{ return symbol(ClassSymbol.LEFT_ASSIGN); }
"+="				{ return symbol(ClassSymbol.ADD_ASSIGN); }
"-="				{ return symbol(ClassSymbol.SUB_ASSIGN); }
"*="				{ return symbol(ClassSymbol.MUL_ASSIGN); }
"/="				{ return symbol(ClassSymbol.DIV_ASSIGN); }
"%="				{ return symbol(ClassSymbol.MOD_ASSIGN); }
"&="				{ return symbol(ClassSymbol.AND_ASSIGN); }
"^="				{ return symbol(ClassSymbol.XOR_ASSIGN); }
"|="				{ return symbol(ClassSymbol.OR_ASSIGN); }
">>"				{ return symbol(ClassSymbol.RIGHT_OP); }
"<<"				{ return symbol(ClassSymbol.LEFT_OP); }
"++"				{ return symbol(ClassSymbol.INC_OP); }
"--"				{ return symbol(ClassSymbol.DEC_OP); }
"->"				{ return symbol(ClassSymbol.PTR_OP); }
"&&"				{ return symbol(ClassSymbol.AND_OP); }
"||"				{ return symbol(ClassSymbol.OR_OP); }
"<="				{ return symbol(ClassSymbol.LE_OP); }
">="				{ return symbol(ClassSymbol.GE_OP); }
"=="				{ return symbol(ClassSymbol.EQ_OP); }
"!="				{ return symbol(ClassSymbol.NE_OP); }

//commentaires

<YYINITIAL>"/*" { yybegin(COMMENT); }
<YYINITIAL>"/**" { yybegin(COMMENT); }
<COMMENT>"*/" { yybegin(YYINITIAL); }
<COMMENT>"**/" { yybegin(YYINITIAL); }


// caracteres echappements entre guillemets

<YYINITIAL>'\"' { yybegin(STRING); return symbol(ClassSymbol.STRING_LITERAL); }

<STRING>'\"' { yybegin(YYINITIAL); }
