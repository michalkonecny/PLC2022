#include <stdio.h>
#include <ctype.h>
#include <stdbool.h>

// typedef enum {detached, semidetached, terrace} HouseCategory;

int main(int argc, char *argv[])
{
    // HouseCategory hc = terrace; // =2
    // hc = hc + 1;

    // printf("number 65 = %d \n", 65); // \n = new line
    // printf("char 'a' = %c \n", 'a');
    // printf("char toupper('a') = %c \n", toupper('a'));
    // printf("string \"amigo\" = %s \n", "amigo");

    // printf("char 'a'+1 = %c\n", 'a'+1);
    // printf("number 'a' = %d\n", 'a');
    // printf("number toupper('a') = %d\n", toupper('a'));
    // printf("number toupper(97) = %d\n", toupper(97));
    // printf("char toupper(97) = %c\n", toupper(97));
    // printf("number \"amigo\" = %d\n", "amigo");
    // printf("string 'a' = %s \n", 'a');

    char resultString[10]; // space for up to 9 characters + terminating 0
    int resultInt;
    char input[] = "result == 123 heh?";
    int numberOfCorrectParses = sscanf(input, "result = %d", &resultInt);
    printf("resultInt = %d \n", resultInt);

    return 0;
}
