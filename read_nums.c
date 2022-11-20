#include <stdio.h>

extern int left, right;
extern double koef1, koef2;

void read_nums(FILE *input) {
    fscanf(input, "%lf", &koef1);
    fscanf(input, "%lf", &koef2);
    fscanf(input, "%d", &left);
    fscanf(input,"%d", &right);
}
