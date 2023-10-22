#lang brag

program : PROG-START stmt_list PROG-STOP DOLLAR DOLLAR

stmt_list : stmt [stmt_list]* | ""

stmt : ID ASSIGN-OP expr DELIMIT ; id = expr;
     | COND-START boolean COND-STOP stmt DELIMIT ; if (boolean) stmt;
     | LOOP-START boolean stmt_list LOOP-END DELIMIT ; while (boolean) linelist endwhile;
     | READ ID DELIMIT ; read id;
     | WRITE expr DELIMIT ; write expr;
     | GOTO ID DELIMIT ; goto id;
     | GOSUB ID DELIMIT ; gosub id;
     | RETURN DELIMIT ; return;
     | BREAK DELIMIT ; break;
     | END DELIMIT ; end;

boolean : TRUE 
        | FALSE 
        | expr bool-op expr

bool-op : LESS | GREATER | GREATER-EQUAL | LESS-EQUAL | NOT-EQUAL | ASSIGN-OP ; < > >= <= <> =

expr : (ID | DIGIT | numsign DIGIT) [etail]*

etail : ADD-OP expr | SUB-OP expr | MULT-OP expr | DIV-OP expr | ""

numsign : ADD-OP | SUB-OP | ""





