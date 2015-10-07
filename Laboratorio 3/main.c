#include <stdio.h>
#include <stdlib.h>
#include <math.h>

double tanh(double x){
    double x3=x*x*x;
    double x5=x*x*x*x*x;
    double x7=x*x*x*x*x*x*x;
    double x9=x*x*x*x*x*x*x*x*x;
    double x11=x*x*x*x*x*x*x*x*x*x*x;
    double x13=x*x*x*x*x*x*x*x*x*x*x*x*x;
    double x15=x*x*x*x*x*x*x*x*x*x*x*x*x;
    double x17=x*x*x*x*x*x*x*x*x*x*x*x*x*x*x;
    double x19=x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x*x;
    double sum=x-0.333333*x3+0.133333*x5-0.053968*x7+0.021869*x9-0.00886325*x11+0.00359216*x13-0.00145389*x15+0.000604682*x17-0.00005291*x19;
    //double sum=x-0.333333*x3+0.133333*x5-0.053968*x7;
    return sum;
}

double factorial(double x){
    double i=x;
    while(i!=1){
        x*=i-1;
        i--;
    }
    return x;
}

int main()
{   double nB,n;
    for(n=6.0;n<=10.0;n++){
        nB=(pow(4.0,n)*(pow(4.0,n)-1))/(factorial(2.0*n));
        printf("\n%f = %f\n",n,nB);
    }
    printf("\n%f\n",tanh(1.3));
    return 0;
}

