#include <stdio.h>

typedef enum {detached, semidetached, terrace} HouseCategory;

int main(int argc, char *argv[])
{
    HouseCategory hc = terrace; // =2
    hc = hc + 1;

    printf("hc = %d\n", hc);

    return 0;
}
