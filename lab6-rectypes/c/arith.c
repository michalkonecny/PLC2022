#include <stdio.h>
#include <stdlib.h>

// leaf node structures:
typedef struct { int value; } ArithExpInt;
typedef struct { double value; } ArithExpDouble;

// An enumerated type for indicating in each binary
// node which operator the node represents.
typedef enum { TIMES, PLUS, POWER } BinaryOperator;

typedef struct
{ 
    BinaryOperator op;
    struct ARITHEXP * subExprLeft;
    struct ARITHEXP * subExprRight;
      // incomplete struct, completion below
      // (struct ARITHEXP = ArithExp)
}
ArithExpBinary; // the name of the new record type

typedef union
{
    ArithExpBinary binExpr; // either this (an operator + 2 children)
    ArithExpInt intExpr; // or this (an integer)
    ArithExpDouble dblExpr; // or this (a floating-point number)
}
ArithExpUnion; // the name of the new union type

typedef enum { INTEXPR, DOUBLEEXPR, BINARYEXPR } ArithExpRepr; // discriminant values

typedef struct ARITHEXP
   // struct named ARITHEXP to complete the struct on lines 13,14
{
    ArithExpRepr repr; // discriminant
    ArithExpUnion content; // the union
} 
ArithExp;


ArithExp * newInt(int value)
{
    ArithExp * result = malloc(sizeof(ArithExp));
    (* result).repr = INTEXPR; // indicate discriminant
    (* result).content.intExpr.value = value; // initialise content
    return result;
}

ArithExp * newDouble(double value)
{
    ArithExp * result = malloc(sizeof(ArithExp));
    (* result).repr = DOUBLEEXPR; // indicate discriminant
    (* result).content.dblExpr.value = value; // initialise content
    return result;
}

ArithExp * newBinaryOp(BinaryOperator op, ArithExp * subExpLeft, ArithExp * subExpRight)
{
    ArithExp * result = malloc(sizeof(ArithExp));
    (* result).repr = BINARYEXPR; // indicate discriminant
    // initialise the content using the .expBinOp "view" of the space:
    ArithExpBinary content =  { op, subExpLeft, subExpRight };
    (* result).content.binExpr = content; // copying the whole record

    return result;
}


ArithExp * newPlus(ArithExp * subExpLeft, ArithExp * subExpRight)
{
    return newBinaryOp(PLUS, subExpLeft, subExpRight);
}

ArithExp * newTimes(ArithExp * subExpLeft, ArithExp * subExpRight)
{
    return newBinaryOp(TIMES, subExpLeft, subExpRight);
}

ArithExp * newPower(ArithExp * subExpLeft, ArithExp * subExpRight)
{
    return newBinaryOp(POWER, subExpLeft, subExpRight);
}

int countNodes(ArithExp * expr)
{
    int result = 1;

    if ( (*expr).repr == BINARYEXPR )
    {
        /* TASK 6.2(c) (Q5) */


    }

    return result;
}

void incrementAllNumbers(ArithExp * expr)
{
    // investigate the type of node:
    if ( (*expr).repr == INTEXPR )
    {
        // it is an integer, so increment it:
        (*expr).content.intExpr.value ++;
    }

    if ( (*expr).repr == DOUBLEEXPR )
    {
        // it is a floating point number, so increment it:
        (*expr).content.dblExpr.value =
            (*expr).content.dblExpr.value + 1.0;
    }

    if ( (*expr).repr == BINARYEXPR )
    {
        // it is a binaru operator, so recurse to both operands:
        incrementAllNumbers((*expr).content.binExpr.subExprLeft);
        incrementAllNumbers((*expr).content.binExpr.subExprRight);
    }
}

int main(int argc, char *argv[])
{
    // construct the expression 2 * (3 + 0.5):
    ArithExp * exp1 = newTimes(newInt(2), newPlus(newInt(3), newDouble(0.5)));

    // construct the expression exp1 ^ exp1:
    ArithExp * exp2 = newPower(exp1, exp1);

    incrementAllNumbers(exp1);
    incrementAllNumbers(exp2);
    
    // test the countNodes function:
    printf("countNodes(exp1) = %d\n", countNodes(exp1));
    printf("countNodes(exp2) = %d\n", countNodes(exp2));

    return 0;
}

