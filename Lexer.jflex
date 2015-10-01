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

caractere = "0x"[0-9][0-9A-Fa-f]
whitespace = [ \t\v\n\f]
%%

//Mots clefs 

"integer" { return symbol(ClassSymbol.TYPE , IdType.INTEGER); }
"character" { return symbol(ClassSymbol.TYPE, IdType.CHARACTER); }
"float" { return symbol(ClassSymbol.TYPE, IdType.FLOAT); }
"boolean" { return symbol(ClassSymbol.TYPE, IdType.BOOLEAN); }
"string" { return symbol(ClassSymbol.TYPE, IdType.STRING); }
"list of " { return symbol(ClassSymbol.TYPE, IdType.LISTOF); }
 

"class" { return symbol(ClassSymbol.MOTCLEFS, MotClefs.CLASS); }
"static" { return symbol(ClassSymbol.MOTCLEFS, MotClefs.STATIC); }
"function" { return symbol(ClassSymbol.MOTCLEFS, MotClefs.FUNCTION); }
"procedure" { return symbol(ClassSymbol.MOTCLEFS, MotClefs.PROCEDURE); }
"return" { return symbol(ClassSymbol.MOTCLEFS, MotClefs.RETURN); }
"for" { return symbol(ClassSymbol.MOTCLEFS, MotClefs.); }
"while" { return symbol(ClassSymbol.MOTCLEFS, MotClefs.PROCEDURE); }
"if" { return symbol(ClassSymbol.MOTCLEFS, MotClefs.PROCEDURE); }
"else" { return symbol(ClassSymbol.MOTCLEFS, MotClefs.PROCEDURE); }
"switch" { return symbol(ClassSymbol.MOTCLEFS, MotClefs.PROCEDURE); }
"case" { return symbol(ClassSymbol.MOTCLEFS, MotClefs.PROCEDURE); }

{fonction} { buffer.append(yytext()); return symbol(ClassSymbol.FONCTION, buffer);}
{whitespace} {}

//Symboles

";"				{ return symbol(ClassSymbol.LANGAGESYMBOLES, LangageSymboles.POINT_VIRGULE); }
"{"				{ return symbol(ClassSymbol.LANGAGESYMBOLES, LangageSymboles.ACCOLADE_OUVRANTE); }
"}"				{ return symbol(ClassSymbol.LANGAGESYMBOLES, LangageSymboles.ACCOLADE_FERMANTE); }
","				{ return symbol(ClassSymbol.LANGAGESYMBOLES, LangageSymboles.VIRGULE);}
":"				{ return symbol(ClassSymbol.LANGAGESYMBOLES, LangageSymboles.DEUX_POINT);}
"="				{ return symbol(ClassSymbol.LANGAGESYMBOLES, LangageSymboles.EGAL);}
"("				{ return symbol(ClassSymbol.LANGAGESYMBOLES, LangageSymboles.PARENTHESE_OUVRANTE);}
")"				{ return symbol(ClassSymbol.LANGAGESYMBOLES, LangageSymboles.PARENTHESE_FERMANTE);}
"["				{ return symbol(ClassSymbol.LANGAGESYMBOLES, LangageSymboles.CROCHET_OUVRANT); }
"]"				{ return symbol(ClassSymbol.LANGAGESYMBOLES, LangageSymboles.CROCHET_FERMANT); }
"."				{ return symbol(ClassSymbol.LANGAGESYMBOLES, LangageSymboles.POINT); }
"&"				{ return symbol(ClassSymbol.LANGAGESYMBOLES, LangageSymboles.ESPERLUETTTE); }
"!"				{ return symbol(ClassSymbol.LANGAGESYMBOLES, LangageSymboles.EXCLAMATION); }
"~"				{ return symbol(ClassSymbol.LANGAGESYMBOLES, LangageSymboles.TILDE); }
"-"				{ return symbol(ClassSymbol.LANGAGESYMBOLES, LangageSymboles.CADRATIN); }
"+"				{ return symbol(ClassSymbol.LANGAGESYMBOLES, LangageSymboles.PLUS); }
"*"				{ return symbol(ClassSymbol.LANGAGESYMBOLES, LangageSymboles.ETOILE); }
"/"				{ return symbol(ClassSymbol.LANGAGESYMBOLES, LangageSymboles.BARRE_OBLIQUE); }
"%"				{ return symbol(ClassSymbol.LANGAGESYMBOLES, LangageSymboles.POURCENT); }
"<"				{ return symbol(ClassSymbol.LANGAGESYMBOLES, LangageSymboles.CHEVRON_INFERIEUR); }
">"				{ return symbol(ClassSymbol.LANGAGESYMBOLES, LangageSymboles.CHEVRON_SUPERIEUR); }
"^"				{ return symbol(ClassSymbol.LANGAGESYMBOLES, LangageSymboles.CIRCONFLEXE); }
"|"				{ return symbol(ClassSymbol.LANGAGESYMBOLES, LangageSymboles.PIPE); }
"?"				{ return symbol(ClassSymbol.LANGAGESYMBOLES, LangageSymboles.INTERROGATION); }

//Opérateurs

"..."				{ return symbol(ClassSymbol.OPERATORS, Operators.ELLIPSIS); }
">>="				{ return symbol(ClassSymbol.OPERATORS, Operators.RIGHT_ASSIGN); }
"<<="				{ return symbol(ClassSymbol.OPERATORS, Operators.LEFT_ASSIGN); }
"+="				{ return symbol(ClassSymbol.OPERATORS, Operators.ADD_ASSIGN); }
"-="				{ return symbol(ClassSymbol.OPERATORS, Operators.SUB_ASSIGN); }
"*="				{ return symbol(ClassSymbol.OPERATORS, Operators.MUL_ASSIGN); }
"/="				{ return symbol(ClassSymbol.OPERATORS, Operators.DIV_ASSIGN); }
"%="				{ return symbol(ClassSymbol.OPERATORS, Operators.MOD_ASSIGN); }
"&="				{ return symbol(ClassSymbol.OPERATORS, Operators.AND_ASSIGN); }
"^="				{ return symbol(ClassSymbol.OPERATORS, Operators.XOR_ASSIGN); }
"|="				{ return symbol(ClassSymbol.OPERATORS, Operators.OR_ASSIGN); }
">>"				{ return symbol(ClassSymbol.OPERATORS, Operators.RIGHT_OP); }
"<<"				{ return symbol(ClassSymbol.OPERATORS, Operators.LEFT_OP); }
"++"				{ return symbol(ClassSymbol.OPERATORS, Operators.INC_OP); }
"--"				{ return symbol(ClassSymbol.OPERATORS, Operators.DEC_OP); }
"->"				{ return symbol(ClassSymbol.OPERATORS, Operators.PTR_OP); }
"&&"				{ return symbol(ClassSymbol.OPERATORS, Operators.AND_OP); }
"||"				{ return symbol(ClassSymbol.OPERATORS, Operators.OR_OP); }
"<="				{ return symbol(ClassSymbol.OPERATORS, Operators.LE_OP); }
">="				{ return symbol(ClassSymbol.OPERATORS, Operators.GE_OP); }
"=="				{ return symbol(ClassSymbol.OPERATORS, Operators.EQ_OP); }
"!="				{ return symbol(ClassSymbol.OPERATORS, Operators.NE_OP); }

//commentaires

<YYINITIAL>"/*" { yybegin(COMMENT); }
<YYINITIAL>"/**" { yybegin(COMMENT); }
<COMMENT>"*/" { yybegin(YYINITIAL); }
<COMMENT>"**/" { yybegin(YYINITIAL); }


// caracteres echappements entre guillemets

<YYINITIAL>'\"' { yybegin(STRING); return symbol(ClassSymbol.STRING_LITERAL);}

<STRING>'\"' { yybegin(YYINITIAL); }
