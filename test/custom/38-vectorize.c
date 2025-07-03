void foo(int A[], int B[], int C[], int D[]) {
    A[0] = B[0] * C[0] + D[7];
    A[1] = B[1] * C[1] + D[6];
    A[2] = B[2] * C[2] + D[5];
    A[3] = B[3] * C[3] + D[4];
    A[4] = B[4] * C[4] + D[3];
    A[5] = B[5] * C[5] + D[2];
    A[6] = B[6] * C[6] + D[1];
    A[7] = B[7] * C[7] + D[0];
}
int main() {
    int a[10] = {1, 2, 3, 4, 5, 6, 7, 8, 9, 10};
    int b, c, d, e, f, g, h, j, k;
    int i = getch();
    b = a[i+0];
    c = 5;
    d = b + c;
    e = a[i+1];
    f = 6;
    g = e + f;
    h = a[i+2];
    j = 7;
    k = h + j;
    i = i + 1;
    putarray(10, a);
}