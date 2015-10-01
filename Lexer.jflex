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

";"				{ return symbol(POINT_VIRGULE); }
"{"				{ return symbol(ACCOLADE_OUVRANTE); }
"}"				{ return symbol(ACCOLADE_FERMANTE); }
","				{ return symbol(VIRGULE);}
":"				{ return symbol(DEUX_POINT);}
"="				{ return symbol(EGAL);}
"("				{ return symbol(PARENTHESE_OUVRANTE);}
")"				{ return symbol(PARENTHESE_FERMANTE);}
"["				{ return symbol(CROCHET_OUVRANT); }
"]"				{ return symbol(CROCHET_FERMANT); }
"."				{ return symbol(POINT); }
"&"				{ return symbol(ESPERLUETTTE); }
"!"				{ return symbol(EXCLAMATION); }
"~"				{ return symbol(TILDE); }
"-"				{ return symbol(CADRATIN); }
"+"				{ return symbol(PLUS); }
"*"				{ return symbol(ETOILE); }
"/"				{ return symbol(BARRE_OBLIQUE); }
"%"				{ return symbol(POURCENT); }
"<"				{ return symbol(CHEVRON_INFERIEUR); }
">"				{ return symbol(CHEVRON_SUPERIEUR); }
"^"				{ return symbol(CIRCONFLEXE); }
"|"				{ return symbol(PIPE); }
"?"				{ return symbol(INTERROGATION); }

//Opérateurs

"..."				{ return symbol(ELLIPSIS); }
">>="				{ return symbol(RIGHT_ASSIGN); }
"<<="				{ return symbol(LEFT_ASSIGN); }
"+="				{ return symbol(ADD_ASSIGN); }
"-="				{ return symbol(SUB_ASSIGN); }
"*="				{ return symbol(MUL_ASSIGN); }
"/="				{ return symbol(DIV_ASSIGN); }
"%="				{ return symbol(MOD_ASSIGN); }
"&="				{ return symbol(AND_ASSIGN); }
"^="				{ return symbol(XOR_ASSIGN); }
"|="				{ return symbol(OR_ASSIGN); }
">>"				{ return symbol(RIGHT_OP); }
"<<"				{ return symbol(LEFT_OP); }
"++"				{ return symbol(INC_OP); }
"--"				{ return symbol(DEC_OP); }
"->"				{ return symbol(PTR_OP); }
"&&"				{ return symbol(AND_OP); }
"||"				{ return symbol(OR_OP); }
"<="				{ return symbol(LE_OP); }
">="				{ return symbol(GE_OP); }
"=="				{ return symbol(EQ_OP); }
"!="				{ return symbol(NE_OP); }

//commentaires

<YYINITIAL>"/*" { yybegin(COMMENT); }
<YYINITIAL>"/**" { yybegin(COMMENT); }
<COMMENT>"*/" { yybegin(YYINITIAL); }
<COMMENT>"**/" { yybegin(YYINITIAL); }


// caracteres echappements entre guillemets

<YYINITIAL>'\"' { yybegin(STRING); return symbol(ClassSymbol.STRING_LITERAL);}

<STRING>'\"' { yybegin(YYINITIAL); }
