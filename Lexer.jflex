import java_cup.runtime.*;
import IdType.java;

%%

%class Lexer
%line
%column
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

fonction = [a-zA-Z][a-zA-Z1-9_\-]

%%


"integer" { return symbol(ClassSymbol.TYPE,IdType.INTEGER); }
"character" { return symbol(ClassSymbol.TYPE,IdType.CHARACTER); }
"float" { return symbol(ClassSymbol.TYPE,IdType.FLOAT); }
"boolean" { return symbol(ClassSymbol.TYPE,IdType.BOOLEAN); }
"string" { return symbol(ClassSymbol.TYPE,IdType.STRING); }

"/*" { yybegin(COMMENT); }
"/**" { yybegin(COMMENT); }
"*/" { yybegin(YYINITIAL); }
"**/" { yybegin(YYINITIAL); }

"procedure" { return symbol(ClassSymbol.PROCEDURE); }
