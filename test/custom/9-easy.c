int a = 1, b[2] = {1, 2}, c[2][2] = {1, 2, 3, 4}, d, e[2] = {},
    f[2][3] = {{}, {}};
float h = 1.0, i[2] = {1, 2}, j[2][2] = {{3, 4}};
int func(int kkk) { return 3 + kkk; }
int first_elem(int p[]) { return p[0]; }
int first_elem2(int p[][2]) { return p[0][0]; }
int main() {
    starttime();
    int k[2][2] = {{1, 2}, {3, a}};
    int kk[2] = {1, k[1][1]};
    int l = 2;
    int ll = l + k[1][1];
    float s = 12.222;
    int ss = s;
    int m = l + 1.3;
    int n = 2 * 3;
    int o = 2 / 3;
    int p = 3 % 2;
    int q = 1 + 2 * 3 / 4 * (4 % 2);
    int r = func(1) + n;
    stoptime();
    return r + p + kk[1] + first_elem(k[0]) + first_elem2(k); // 14
}