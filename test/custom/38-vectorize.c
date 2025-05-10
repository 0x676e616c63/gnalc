
int relu_reg(int a)
{
    if (a > 0x7F) return 0x7F;
    if (a < 0) return 0;
    return a;
}

int model(int a[][5])
{
    if (+ relu_reg( + a[0][0] *   85 + a[0][1] *   23 + a[0][2] *  -82 + a[0][3] * -103 + a[0][4] * -123 + a[1][0] *   64 + a[1][1] * -120 + a[1][2] *   50 + a[1][3] *  -59 + a[1][4] *   47 + a[2][0] * -111 + a[2][1] *  -67 + a[2][2] * -106 + a[2][3] *  -75 + a[2][4] * -102 + a[3][0] *   34 + a[3][1] *  -39 + a[3][2] *   65 + a[3][3] *   47 + a[3][4] *  113 + a[4][0] *  110 + a[4][1] *   47 + a[4][2] *   -4 + a[4][3] *   80 + a[4][4] *   46) *   39
        > 0)
        return 1;
    return 0;
}

int main()
{
    int N = getint();
    int a[5][5];
    while (N > 0) {
        int i = 0;
        while (i < 5) {
            int j = 0;
            while (j < 5) {
                a[i][j] = getint();
                j = j + 1;
            }
            i = i + 1;
        }
        if (model(a)) {
            // cat
            putch(99); putch(97); putch(116); putch(10);
        } else {
            // dog
            putch(100); putch(111); putch(103); putch(10);
        }
        N = N - 1;
    }
    return 0;
}
