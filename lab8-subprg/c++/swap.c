#include <signal.h>
#include <memory.h>
#include <string.h>
#include <stdio.h>

void swapRef(int * x, int * y)
{
    int tmp;
    tmp = *x;
    *x = *y;
    *y = tmp;
} // swaps two variables!

void swapCp(int x, int y) // copy-in
{
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
    
    swapRef(&a,&b); // "&a" means: the reference of the variable a
    printf("swapRef(&a,&b);\n");
    printf("a = %d, b = %d\n", a, b);
    
    return 0;
}
