#include <signal.h>
#include <memory.h>
#include <string.h>
#include <stdio.h>

// first define a few subprograms

void swapRef(int& x, int& y)
{ // \& = reference
    int tmp;
    tmp = x;
    x = y;
    y = tmp;
} // swaps two variables!

void swapRef2(int& x, int& y)
{ // \& = reference
    x = x + y; 
    y = x - y; // (= (x + y) - y using original values)
    x = x - y; // (= (x + y) - x using original values)
} // swaps two variables unless they are aliasing!

// define a type of pointers to subprograms such as swapRef
typedef void (* BinaryByRef)(int &, int &);

// declare a variable whose value points to a function
BinaryByRef chosenSwapFunction;

// declare a variable that holds an array of functions
BinaryByRef mySwapFunctions[] = { swapRef, swapRef2 };


// the following function cannot be added to mySwapFunctions
// because its parameters are of a different kind

void swapCp(int x, int y)
{ // copy-in
    int tmp;
    tmp = x;
    x = y;
    y = tmp; 
} // no effect!


int main(int argc, char *argv[])
{
    int a,b;
    a = 1;
    b = 2;
    
    printf("a = %d, b = %d\n", a, b);
    
    mySwapFunctions[0] = swapRef;
    // mySwapFunctions[0] = swapCp; // compiler ERROR
    chosenSwapFunction = mySwapFunctions[0];
    
    
    // execute the function that chosenSwapFunction points to
    (* chosenSwapFunction)(a,b);
    printf("(* chosenSwapFunction)(a,b);\n");
    printf("a = %d, b = %d\n", a, b);
    
    return 0;
}
