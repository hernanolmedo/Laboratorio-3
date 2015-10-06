#include <stdio.h>
#include <stdlib.h>

float tanh(float x){
    float x3=x*x*x;
    float x5=x*x*x*x*x;
    float x7=x*x*x*x*x*x*x;
    float x9=x*x*x*x*x*x*x*x*x;
    float sum=x-0.333333*x3+0.133333*x5-0.053968*x7+0.021869*x9;
    //float sum=x-0.333333*x3+0.133333*x5-0.053968*x7;
    return sum;
}

int main()
{
    printf("\n%f\n",tanh(5.0));
    return 0;
}

