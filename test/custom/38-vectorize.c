// void foo(int A[], int B[], int C[], int D[]) {
//     A[0] = B[0] * C[0] + D[7];
//     A[1] = B[1] * C[1] + D[6];
//     A[2] = B[2] * C[2] + D[5];
//     A[3] = B[3] * C[3] + D[4];
//     A[4] = B[4] * C[4] + D[3];
//     A[5] = B[5] * C[5] + D[2];
//     A[6] = B[6] * C[6] + D[1];
//     A[7] = B[7] * C[7] + D[0];
// }

// void bar(int A[], int B[], int C[], int D[]) {
//     int i = 0;
//     while (i < 10)
//     {
//         A[i + 0] = B[i + 0] * C[i + 0] + D[i + 7];
//         A[i + 1] = B[i + 1] * C[i + 1] + D[i + 6];
//         A[i + 2] = B[i + 2] * C[i + 2] + D[i + 5];
//         A[i + 3] = B[i + 3] * C[i + 3] + D[i + 4];
//         A[i + 4] = B[i + 4] * C[i + 4] + D[i + 3];
//         A[i + 5] = B[i + 5] * C[i + 5] + D[i + 2];
//         A[i + 6] = B[i + 6] * C[i + 6] + D[i + 1];
//         A[i + 7] = B[i + 7] * C[i + 7] + D[i + 0];
//         i = i + 4;
//     }
// }
void bar_no_shuffle(int A[], int B[], int C[], int D[]) {
    int i = 0;
    while (i < 10)
    {
        A[i] = B[i] * C[i] + D[i + 7];
        i = i + 1;
    }
}
// void loop_aa() {
//     int a[10][2] = {1, 2, 3, 4, 5, 6, 7, 8, 9, 10};
//     int i = 0;
//     while (i < 10)
//     {
//         int j = 0;
//         while (j < 2) {
//             putint(a[i][j]);
//             j = j + 1;
//         }
//         i = i + 1;
//     }
// }
//
// int main() {
//     int a[10] = {1, 2, 3, 4, 5, 6, 7, 8, 9, 10};
//     int b, c, d, e, f, g, h, j, k;
//     int i = getch();
//     b = a[i+0];
//     c = 5;
//     d = b + c;
//     e = a[i+1];
//     f = 6;
//     g = e + f;
//     h = a[i+2];
//     j = 7;
//     k = h + j;
//     i = i + 1;
//     putarray(10, a);
// }