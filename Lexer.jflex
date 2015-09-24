import java_cup.runtime.*;
import IdType.java;

%%

%class Lexer
%line
%column
%cupsym ClassSymbol
%cup


%state COMMENT

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

fonction = [a-zA-Z][a-zA-Z1-9_\-]
caractere = "0x"[0-9][0-9A-Fa-f]
virgule_flottante = entier('.'entier)?puissance|'.'entier.puissance

%%

//Mots clefs 

"integer" { return symbol(ClassSymbol.TYPE , IdType.INTEGER); }
"character" { return symbol(ClassSymbol.TYPE,IdType.CHARACTER); }
"float" { return symbol(ClassSymbol.TYPE,IdType.FLOAT); }
"boolean" { return symbol(ClassSymbol.TYPE,IdType.BOOLEAN); }
"string" { return symbol(ClassSymbol.TYPE,IdType.STRING); }
"list of " { return symbol(ClassSymbol.TYPE,IdType.LISTOF); }
 
"procedure" { return symbol(ClassSymbol.PROCEDURE); }

//commentaires

<YYINITIAL>"/*" { yybegin(COMMENT); }
<YYINITIAL>"/**" { yybegin(COMMENT); }
<COMMENT>"*/" { yybegin(YYINITIAL); }
<COMMENT>"**/" { yybegin(YYINITIAL); }

// caracteres echappements entre guillemets

<YYINITIAL>'"' { yybegin(COMMENT); }

<COMMENT>'"' { yybegin(YYINITIAL); }
