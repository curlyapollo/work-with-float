extern double koef1;
extern double koef2;

double func(double x) {
    return koef1 + koef2 / (x * x * x * x);
}