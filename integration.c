extern int left, right;
extern double koef1, koef2;

extern double func(double x);


double integration() {
    double sum = 0;
    for (int i = 0; i < (right - left) * 10000; ++i) {
        double x_i = left + 0.0001 * i;
        double x_i1 = left + 0.0001 * (i + 1);
        sum += func((x_i + x_i1) / 2) * (x_i1 - x_i);
    }
    return sum;
}

