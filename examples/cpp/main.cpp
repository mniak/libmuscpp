#include <iostream>
#include <libmus.hpp>

using namespace std;

int main()
{
    int a = 3;
    int b = 5;
    int c = add(a, b);
    cout << "Math: " << a << " + " << b << " = " << c << endl;
    return 0;
}
