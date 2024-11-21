/***************************/
/* FILE NAME: LEX_FILE.lex */
/***************************/

/*************/
/* USER CODE */
/*************/
import java_cup.runtime.*;

/******************************/
/* DOLAR DOLAR - DON'T TOUCH! */
/******************************/

%%

/************************************/
/* OPTIONS AND DECLARATIONS SECTION */
/************************************/
   
/*****************************************************/ 
/* Lexer is the name of the class JFlex will create. */
/* The code will be written to the file Lexer.java.  */
/*****************************************************/ 
%class Lexer

/********************************************************************/
/* The current line number can be accessed with the variable yyline */
/* and the current column number with the variable yycolumn.        */
/********************************************************************/
%line
%column

/*******************************************************************************/
/* Note that this has to be the EXACT same name of the class the CUP generates */
/*******************************************************************************/
%cupsym TokenNames

/******************************************************************/
/* CUP compatibility mode interfaces with a CUP generated parser. */
/******************************************************************/
%cup

/****************/
/* DECLARATIONS */
/****************/
/*****************************************************************************/   
/* Code between %{ and %}, both of which must be at the beginning of a line, */
/* will be copied verbatim (letter to letter) into the Lexer class code.     */
/* Here you declare member variables and functions that are used inside the  */
/* scanner actions.                                                          */  
/*****************************************************************************/   
%{
	/*********************************************************************************/
	/* Create a new java_cup.runtime.Symbol with information about the current token */
	/*********************************************************************************/
	private Symbol symbol(int type)               {return new Symbol(type, yyline, yycolumn);}
	private Symbol symbol(int type, Object value) {return new Symbol(type, yyline, yycolumn, value);}

	/*******************************************/
	/* Enable line number extraction from main */
	/*******************************************/
	public int getLine() { return yyline + 1; } 

	/**********************************************/
	/* Enable token position extraction from main */
	/**********************************************/
	public int getTokenStartPosition() { return yycolumn + 1; } 
%}

/***********************/
/* MACRO DECALARATIONS */
/***********************/
LineTerminator = \r|\n|\r\n
WhiteSpace = {LineTerminator} | [ \t]
DIGIT = [0-9]
INTEGER = 0 | ([1-9]DIGITS*)
ID = [a-zA-Z][a-zA-Z0-9]*
IF = if
WHILE = while
NIL = nil
ARRAY = array
INT = int
STRING = string
NEW = new
CLASS = class
RETURN = return
EXTENDS = extends
VOID = void
LETTER = [a-zA-Z]
STRING = (\")LETTER*(\")
LPARENT = \(
RPARENT =  \)
SLPARENT = \[
SRPARENT = \]
BLPARENT = \{
BRPARENT = \}
COMMENT = ( DIGIT | LETTER | (\*) |  (\-)  | (\+) | (\.) | 
(\;) | (\/) | RPARENT | LPARENT | SLPARENT | SRPARENT | BLPARENT | BRPARENT | \. | \;  LineTerminator | WhiteSpace )*
COMMENTS = (//COMMENT )  | (\/)(\*)COMMENT(\*)(\/)                  

/******************************/
/* DOLAR DOLAR - DON'T TOUCH! */
/******************************/

%%

/************************************************************/
/* LEXER matches regular expressions to actions (Java code) */
/************************************************************/

/**************************************************************/
/* YYINITIAL is the state at which the lexer begins scanning. */
/* So these regular expressions will only be matched if the   */
/* scanner is in the start state YYINITIAL.                   */
/**************************************************************/

<YYINITIAL> {


	{IF} { return symbol(TokenNames.IF); }
 
  {WHILE} { return symbol(TokenNames.WHILE); }
  
  {NIL} { return symbol(TokenNames.NIL); }
  
  {ARRAY} { return symbol(TokenNames.ARRAY); }
  
  {INT} { return symbol(TokenNames.INT); }
  
  {STRING} { return symbol(TokenNames.STRING); }
  
  {NEW} { return symbol(TokenNames.NEW); }
  
  {CLASS} { return symbol(TokenNames.CLASS); }
  
  {RETURN} { return symbol(TokenNames.RETURN); }
  
  {EXTENDS} { return symbol(TokenNames.EXTENDS); }
  
  {VOID} { return symbol(TokenNames.VOID); }
  
  {STRINGS} { return symbol(TokenNames.STRINGS, new String(yytext())); }
  
  {RPARENT} { return symbol(TokenNames.RPARENT); }
  
  {LPARENT} { return symbol(TokenNames.LPARENT); }
  
  {SLPARENT} { return symbol(TokenNames.SLPARENT); }
  
  {SRPARENT} { return symbol(TokenNames.SRPARENT); }
  
  {BLPARENT} { return symbol(TokenNames.BLPARENT); }
  
  {BRPARENT} { return symbol(TokenNames.BRPARENT); }
  
  {INTEGER} {
    int value = Integer.parseInt(yytext());
    
    // Check if the integer is in the valid range (0 to 32767)
    if (value >= 0 && value <= 32767) {
      return symbol(TokenNames.INTEGERS, new Integer(value));
    } else {
      // Optionally, throw an error or handle invalid integers
      // For example, return an error symbol
      System.err.println("Integer out of range: " + value);
      return symbol(TokenNames.ERROR, new String(yytext()));
    }
  }
  
  
  {ID} { return symbol(TokenNames.ID, new String(yytext())); }

	{COMMENTS} {
    return symbol(TokenNames.COMMENTS, new String(yytext()));
  }
  
  {WHITE_SPACE} { /* just skip what was found, do nothing */ }
  
  {LINE_TERMINATOR} { /* just skip line terminator, do nothing */ }
  
  <<EOF>> { return symbol(TokenNames.EOF); }
  . { 
    System.err.println("Lexical error, Unrecognized token: " + yytext());
    return symbol(TokenNames.ERROR, new String(yytext())); 
}
}

