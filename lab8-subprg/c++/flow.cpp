#include <stdio.h>
#include <math.h>

float distance(float flow1, float flow2)
{
    return fabs(flow1 - flow2);
}

// adjustDistribution attempts to change the values
// of the parameters if they are quite close together
// so that they are more apart.
// Nevertheless, the sum of the values stays the same.
void adjustDistribution(float & flow1, float & flow2)
{
    if ( distance(flow1,flow2) < 5 )
    {
        float average = (flow1 + flow2)/2;
        flow1 = average + 10 * (flow1 - average) - 1;
        flow2 = average + 10 * (flow2 - average) + 1;
    }
}

void printF1F2F3(float f1, float f2, float f3)
{
    printf("f1 = %4.1f, f2 = %4.1f, f3 = %4.1f\n", f1, f2, f3);
}

int main(int argc, char** argv)
{
    float f1, f2, f3;
    f1 = 0; f2 = 0; f3 = 1;
    
    printF1F2F3(f1,f2,f3);
    adjustDistribution(f1,f2);
    printF1F2F3(f1,f2,f3);
    adjustDistribution(f2,f3);
    printF1F2F3(f1,f2,f3);
    adjustDistribution(f2,f2); // this does not look right...what happens exactly?
    printF1F2F3(f1,f2,f3);
}

