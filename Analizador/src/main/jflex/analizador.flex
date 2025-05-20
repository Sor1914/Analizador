package api;

import java_cup.runtime.*;

%%
%class AnalizadorLexico
%public
%cup
%char
%line
%column

%{
    public void imprimirLexema(String lexema, long columna, int linea) {
        System.out.println("Lexema: " + lexema + " Columna: " + columna + " Línea: " + linea);
    }

    public Symbol getToken(int tipo, Object valor) {
        return new Symbol(tipo, yyline, yycolumn, valor);
    }
%}

// Expresiones regulares
letra = [a-zA-Z]
digito = [0-9]
identificador = {letra}({letra}|{digito}|_)*
entero = {digito}+
flotante = {digito}+"."{digito}+
cadena = \"([^\"\n])*\"
espacio = [ \t\r\n]+
comentario = "//".*

%%

// Palabras clave
"DEFINE"        { imprimirLexema(yytext(), yycolumn, yyline); return getToken(sym.DEFINE, yytext()); }
"PRINT"         { imprimirLexema(yytext(), yycolumn, yyline); return getToken(sym.PRINT, yytext()); }
"IF"            { imprimirLexema(yytext(), yycolumn, yyline); return getToken(sym.IF, yytext()); }
"THEN"          { imprimirLexema(yytext(), yycolumn, yyline); return getToken(sym.THEN, yytext()); }
"ELSE"          { imprimirLexema(yytext(), yycolumn, yyline); return getToken(sym.ELSE, yytext()); }
"ELSEIF"        { imprimirLexema(yytext(), yycolumn, yyline); return getToken(sym.ELSEIF, yytext()); }
"WHILE"         { imprimirLexema(yytext(), yycolumn, yyline); return getToken(sym.WHILE, yytext()); }
"LOOP"          { imprimirLexema(yytext(), yycolumn, yyline); return getToken(sym.LOOP, yytext()); }
"FUNCTION"      { imprimirLexema(yytext(), yycolumn, yyline); return getToken(sym.FUNCTION, yytext()); }
"RETURN"        { imprimirLexema(yytext(), yycolumn, yyline); return getToken(sym.RETURN, yytext()); }
"END"           { imprimirLexema(yytext(), yycolumn, yyline); return getToken(sym.END, yytext()); }
"DO"            { imprimirLexema(yytext(), yycolumn, yyline); return getToken(sym.DO, yytext()); }

// Booleanos
"true"          { imprimirLexema(yytext(), yycolumn, yyline); return getToken(sym.TRUE, true); }
"false"         { imprimirLexema(yytext(), yycolumn, yyline); return getToken(sym.FALSE, false); }

// Operadores lógicos
"AND"           { imprimirLexema(yytext(), yycolumn, yyline); return getToken(sym.AND, yytext()); }
"OR"            { imprimirLexema(yytext(), yycolumn, yyline); return getToken(sym.OR, yytext()); }
"NOT"           { imprimirLexema(yytext(), yycolumn, yyline); return getToken(sym.NOT, yytext()); }

// Operadores aritméticos
"+"             { imprimirLexema(yytext(), yycolumn, yyline); return getToken(sym.SUMA, yytext()); }
"-"             { imprimirLexema(yytext(), yycolumn, yyline); return getToken(sym.RESTA, yytext()); }
"*"             { imprimirLexema(yytext(), yycolumn, yyline); return getToken(sym.MULTIPLICACION, yytext()); }
"/"             { imprimirLexema(yytext(), yycolumn, yyline); return getToken(sym.DIVISION, yytext()); }

// Operadores relacionales
"<="            { imprimirLexema(yytext(), yycolumn, yyline); return getToken(sym.MENOR_IGUAL, yytext()); }
">="            { imprimirLexema(yytext(), yycolumn, yyline); return getToken(sym.MAYOR_IGUAL, yytext()); }
"=="            { imprimirLexema(yytext(), yycolumn, yyline); return getToken(sym.IGUALDAD, yytext()); }
"!="            { imprimirLexema(yytext(), yycolumn, yyline); return getToken(sym.DIFERENTE, yytext()); }
"<"             { imprimirLexema(yytext(), yycolumn, yyline); return getToken(sym.MENOR, yytext()); }
">"             { imprimirLexema(yytext(), yycolumn, yyline); return getToken(sym.MAYOR, yytext()); }

// Símbolos
"="             { imprimirLexema(yytext(), yycolumn, yyline); return getToken(sym.ASIGNACION, yytext()); }
"("             { imprimirLexema(yytext(), yycolumn, yyline); return getToken(sym.PAR_IZQ, yytext()); }
")"             { imprimirLexema(yytext(), yycolumn, yyline); return getToken(sym.PAR_DER, yytext()); }
","             { imprimirLexema(yytext(), yycolumn, yyline); return getToken(sym.COMA, yytext()); }
";"             { imprimirLexema(yytext(), yycolumn, yyline); return getToken(sym.PUNTOYCOMA, yytext()); }

// Literales y variables
{entero}        { imprimirLexema(yytext(), yycolumn, yyline); return getToken(sym.ENTERO, Integer.parseInt(yytext())); }
{flotante}      { imprimirLexema(yytext(), yycolumn, yyline); return getToken(sym.FLOTANTE, Double.parseDouble(yytext())); }
{cadena}        { imprimirLexema(yytext(), yycolumn, yyline); return getToken(sym.CADENA, yytext()); }
{identificador} { imprimirLexema(yytext(), yycolumn, yyline); return getToken(sym.ID, yytext()); }

// Ignorados
{comentario}    { /* ignorar */ }
{espacio}       { /* ignorar */ }

// Cualquier otro carácter ilegal
.               { System.err.println("Caracter ilegal: " + yytext()); return getToken(sym.ERROR, yytext()); }
