int main() {
    int a;
    a = 21;
    int b;
    b = 6;
    while (a < 20) {
        a = a + 3;
        if (b < 10) {
            b = b + 1;
        }
        b = b - 2;
    }

    putint(a + b);
    return 0;
}