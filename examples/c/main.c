#include <stdio.h>
#include <libmus.h>

int main() {
    int a = 3;
    int b = 5;
    int c = add(a, b);
    printf("Math: %d + %d = %d\n", a, b, c);
    return 0;
}