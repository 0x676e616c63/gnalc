int fn() {
    return 1;
}
int main() {
    int i = 100;
    int b = 3;
    while(i < 100) {
        int a = 3 + 5 * b + 2;
        putch(a);
        i = i + 1;
    }
    return 1;
}