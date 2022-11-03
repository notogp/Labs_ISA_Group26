#include<stdio.h>
#include<stdlib.h>

#define N 8 /// order of the filter
#define NT (N+1) /// number of coeffs
#define NB 12 /// number of bits
#define SHAMT 16 /// shift amount

const int bi[NT]={-13, -28, 104, 544, 830, 544, 104, -28, -13}; /// b array

////////////////////////////////////////////////////////////////////////
int myfilter(int x)
{
  static int sx[NT]; /// x shift register
  static int sy[NT-1]; /// y shift register
  static int first_run = 0; /// for cleaning shift registers
  int i; /// index
  int y; /// output sample

  /// clean the buffers
  if (first_run == 0)
  {
    first_run = 1;
    for (i=0; i<NT; i++)
      sx[i] = 0;
  }

  /// shift and insert new sample in x shift register
  for (i=NT-1; i>0; i--)
    sx[i] = sx[i-1];
  sx[0] = x;

  /// make the convolution
  /// Moving average part
  y = 0;
  for (i=0; i<NT; i++)
    y += ((sx[i]*bi[i]) >> SHAMT); // << (SHAMT - NB + 1); 
  //with only a shift by 11 we obtain THD = -64.8433 and the results_c.txt are similar to the results_m.txt
  //with a shift by 16 and then a shift back by 5 (total shift of 11) we obtain a THD = -33.0825
  return y;
}
////////////////////////////////////////////////////////////////////

int main (int argc, char **argv)
{
  FILE *fp_in;
  FILE *fp_out;

  int x;
  int y;

  /// check the command line
  if (argc != 3)
  {
    printf("Use: %s <input_file> <output_file>\n", argv[0]);
    exit(1);
  }
  
  /// open files
  fp_in = fopen(argv[1], "r");
  if (fp_in == NULL)
  {
    printf("Error: cannot open %s\n");
    exit(2);
  }
  fp_out = fopen(argv[2], "w");

  /// check shift amount
  if (SHAMT < ((NB)-1))
  {
    printf("Error shift amount must be at least nbit-1\n");
    exit(3);
  }

  /// get samples and apply filter
  fscanf(fp_in, "%d", &x);
  do{
    y = myfilter(x);
    fprintf(fp_out,"%d\n", y);
    fscanf(fp_in, "%d", &x);
  } while (!feof(fp_in));

  fclose(fp_in);
  fclose(fp_out);

  return 0;

}
