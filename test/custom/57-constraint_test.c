int main()
{
    int N = 1;
    int a = getint();
    while (N > 0) {
        if (a * -120 > 0) {
            putch(99);
        } else {
            putch(100);
        }
        N = N - 1;
    }
    return 0;
}
