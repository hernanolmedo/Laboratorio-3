#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>


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
    return sum;
}

int main(int argc,char **argv){
    extern char *optarg;
//    extern int *optind;
    int c,i,err=0;
    int nflag=0;
    char *nname="VALORES_N";
    char usage[]="usage: %s -n \"0 VALORES\"\n";

    while((c=getopt(argc,argv,"n:"))!=-1){
        switch(c){
            case 'n':
                nflag=1;
                nname=optarg;
                break;
            case '?':
                err=1;
                break;
        }
        if(nflag==0){
            fprintf(stderr,"%s: missing -n option\n",argv[0]);
            fprintf(stderr,usage,argv[0]);
            exit(1);
        }
        if(optind<argc){
            for(;optind<argc;optind++){
                printf("Argumento no permitido:\"%s\"\n",argv[optind]);
                printf("La sintaxis es: -n \"VALOR X\"\n");
                exit(1);
                }
            }
        if(err){
            fprintf(stderr,usage,argv[0]);
            exit(1);
        }

        for(i = 0; i < 1000000; i++){
            tanh(atof(nname));
        }

        printf("\n\n");
        printf("tanh(%s)=%f\n",nname,tanh(atof(nname)));
        exit(0);
    }
    return 0;
}

