#include <stdio.h>
#include <stdlib.h>

extern int left, right;
extern double koef1, koef2;

void random_read(int seed) {
    srand(seed);
    left = -10 + rand() % 20;
    right = left + rand() % 40;
    koef1 = -200 + rand() % 400 + rand() % 1000 / 1000.0l;
    koef2 = -200 + rand() % 400 + rand() % 1000 / 1000.0l;
    printf("left: %d\nright: %d\na: %lf\nb: %lf\n", left, right, koef1, koef2);
}