#include <stdio.h>
#include <libmus.h>

void main() {
    int a = 3;
    int b = 5;
    int c = add(a, b);
    printf("Math: %d + %d = %d\n", a, b, c);
}