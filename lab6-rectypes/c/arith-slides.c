#include <stdio.h>
#include <stdlib.h>

// leaf node structure:
typedef struct { int n; } ExpNum;

// operator node structure:
typedef enum {PLUS, TIMES} Operator;

typedef struct
{ 
    Operator op;
    struct EXPNODE * subExpLeft;
    struct EXPNODE * subExpRight;
      // incomplete struct, completion below
      // (struct EXPNODE = Expression)
}
ExpBinaryOp; // the name of the new record type


typedef union
{
    ExpBinaryOp expBinOp; // either this (an operator + 2 children)
    ExpNum expNum; // or this (a number)
}
ExpNodeUnion; // the name of the new union type

typedef enum {EXPNUM, EXPBINOP} ExpNodeVariant;

typedef struct EXPNODE 
   // struct named EXPNODE to complete the struct on lines 9,10
{
    ExpNodeVariant variant; // discriminant
    ExpNodeUnion content; // the union
} 
Expression;


int countNodes(Expression * expr)
{
    int result = 1;
    
    if ( (*expr).variant == EXPBINOP )
    {
        result = result + countNodes((*expr).content.expBinOp.subExpLeft);
        result = result + countNodes((*expr).content.expBinOp.subExpRight);
    }
    
    return result;
}

Expression * create_3(){
    Expression * num3 = malloc(sizeof(Expression));
    (* num3).variant = EXPNUM;
    (* num3).content.expNum.n = 3;
    return num3; 
}

Expression * create_3_BAD(){
    Expression num3;
    num3.variant = EXPNUM;
    num3.content.expNum.n = 3;
    return &num3; 
}

Expression create_3_no_pointers(){
    Expression num3;
    num3.variant = EXPNUM;
    num3.content.expNum.n = 3;
    return num3; 
}

int main(int argc, char *argv[])
{
    // construct the expression plus(1, times(2, 3))
    // first, create the three leafs of the tree:
    Expression * num1 = malloc(sizeof(Expression));
    (* num1).variant = EXPNUM; // indicate variant
    (* num1).content.expNum.n = 1; // initialise component

    Expression * num2 = malloc(sizeof(Expression));
    (* num2).variant = EXPNUM;
    (* num2).content.expNum.n = 2;

    Expression * num3 = malloc(sizeof(Expression));
    (* num3).variant = EXPNUM;
    (* num3).content.expNum.n = 3;

    // create the root node of times(2, 3):
    ExpBinaryOp temp1 = { TIMES, num2, num3 };
    Expression * expTimes = malloc(sizeof(Expression));
    (* expTimes).variant = EXPBINOP;
    (* expTimes).content.expBinOp = temp1;

    // create the root node of plus(1, times(2, 3)):
    ExpBinaryOp temp2 = { PLUS, num1, expTimes };
    Expression * expPlus = malloc(sizeof(Expression));
    (* expPlus).variant = EXPBINOP;
    (* expPlus).content.expBinOp = temp2;

    // test the countNodes function:
    int n = countNodes(expPlus);
    printf("countNodes(expPlus) = %d\n", n);

    return 0;
}
