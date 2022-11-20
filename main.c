#include <stdio.h>
#include <stdlib.h>
#include <time.h>

int left, right;
double koef1, koef2;

extern void read_nums(FILE* input);
extern double integration();
extern void print(FILE* output, double sum);
extern void random_read(int seed);
extern int64_t time_dif(struct timespec timeA, struct timespec timeB);

int main(int argc, char** argv) {
    FILE *input, *output;
    struct timespec start;
    struct timespec end;
    int64_t elapsed_ns;
    input = fopen(argv[1], "r");
    output = fopen(argv[2], "w");
    if (argc == 4) {
        random_read(atoi(argv[3]));
    }
    else {
        read_nums(input);
    }
    double sum;
    clock_gettime(CLOCK_MONOTONIC, &start);
    sum = integration();
    clock_gettime(CLOCK_MONOTONIC, &end);
    elapsed_ns = time_dif(end, start);
    printf("Elapsed: %ld ns\n", elapsed_ns);
    print(output, sum);
    return 0;
}
