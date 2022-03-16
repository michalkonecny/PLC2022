#include <signal.h>
#include <memory.h>
#include <string.h>
#include <stdio.h>

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

void swapCp(int x, int y)
{ // copy-in
    int tmp;
    tmp = x;
    x = y;
    y = tmp; 
} // no effect!

int main(int argc, char** argv)
{
    int a,b;
    a = 1;
    b = 2;
    
    printf("a = %d, b = %d\n", a, b);
    
    swapCp(a,b);
    printf("swapCp(a,b);\n");
    printf("a = %d, b = %d\n", a, b);
    
    swapRef(a,b);
    printf("swapRef(a,b);\n");
    printf("a = %d, b = %d\n", a, b);
    
    swapRef2(a,b);
    printf("swapRef2(a,b);\n");
    printf("a = %d, b = %d\n", a, b);
    
    swapRef2(a,a);
    printf("swapRef2(a,a);\n");
    printf("a = %d, b = %d\n", a, b);
    
    return 0;
}
