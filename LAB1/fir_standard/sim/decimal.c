#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#define FIRST_N 201
double to_fixed(int num, int den)
{
    int nden = 0;
    for (size_t i=0; i<den; i++)
    {
        nden |= 1 << i;
    }
    num &= nden;

    double fixed = -((num & (1<<den-1)) >> den-1);
    for (size_t i=0; i<den-1; i++)
    {
        int bit = ((num & (1<<i)) >> i);
        double bit_val = bit / pow(2, den-i-1);
        fixed += bit_val;
    }
    return fixed;
}

int main(int* argc, char** argv)
{
    int num = 0;
    int den = 12;
    FILE *fp_res_m;
    FILE *fp_res_c;
    FILE *fp_samp_m;
    double num_f = 0.0;
    double first_m[FIRST_N];
    double first_c[FIRST_N];
    int first_samp_m[FIRST_N];

    fp_samp_m = fopen("samples.txt", "r");
    for (size_t i=0; i<FIRST_N; i++)
    {
        fscanf(fp_samp_m, "%d", &num);
        first_samp_m[i] = num;
    }
    fclose(fp_samp_m);

    fp_res_m = fopen("results_m.txt", "r");
    for (size_t i=0; i<FIRST_N; i++)
    {
        fscanf(fp_res_m, "%d", &num);
        num_f = to_fixed(num, den);
        // printf("%d -> %f\n", num, num_f);
        first_m[i] = num_f;
    }
    fclose(fp_res_m);

    fp_res_c = fopen("results_c.txt", "r");
    for (size_t i=0; i<FIRST_N; i++)
    {
        fscanf(fp_res_c, "%d", &num);
        num_f = to_fixed(num, den);
        // printf("%d -> %f\n", num, num_f);
        first_c[i] = num_f;
    }
    fclose(fp_res_c);

    // print the two arrays
    for (size_t i=0; i<FIRST_N; i++)
    {
        printf("index:%d, res_m:%f, res_c:%f, samp:%d\n", i, first_m[i], first_c[i],  first_samp_m[i]);
    }
    // while (!feof(fp_res_m))
    // {
    //     fscanf(fp_res_m, "%d", &num);
    //     num_f = to_fixed(num, den);
    //     printf("%d -> %f\n", num, num_f);
    // }
    // fclose(fp_res_m);
    // printf("\n\n\n\n\n\n");
    // fp_res_c = fopen("results_c.txt", "r");
    // while (!feof(fp_res_c))
    // {
    //     fscanf(fp_res_c, "%d", &num);
    //     num_f = to_fixed(num, den);
    //     printf("%d -> %f\n", num, num_f);
    // }
    // fclose(fp_res_c);

    return 0;
}