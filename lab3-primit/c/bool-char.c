#include <stdio.h>
#include <ctype.h>

int getNumber()
{
    char input[100];
    int result;
    int haveResult = 0; /* false */

    while (! haveResult)
    {
        printf("Input one number: ");
        fgets((char *)&input, 100, stdin); // get a string from user
        if ( 1 == sscanf(input, "%d", &result) ) // parse string as decimal integer
        {
            haveResult = 1; /* true */
        }
        else
        {
            printf("Invalid number, please try again.\n");
        }
    }
    return result;
}


int main(int argc, char *argv[])
{
    int n = getNumber();

    while ( n = 0 ) // [nasty error]
    {
        printf("Please, input a non-zero number.\n");
        n = getNumber();
    }

    // [notice the conversion of int to a string]
    printf("You typed: %d\n", n);

    // [conditional expression example]
//     printf("n > 0 ? 100 : -100 = %d\n", n > 0 ? 100 : -100);

    // [check a function working with a char:]
//     printf("toupper(97) = '%c'\n", 97, toupper(97));

    return 0;
}
