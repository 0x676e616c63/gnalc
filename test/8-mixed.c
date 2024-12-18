int a = 1, b[2] = {1,2}, c[2][2] = {{1,2},{3,4}}, d, e[2] = {}, f[2][3] = {{}, {}};
float h = 1.0, i[2] = {1, 2}, j[2][2] = {{3, 4}};

int func1(int x) {
    return x + 1;
}

int func2(float x) {
    return func1(3) + 1;
    return 2;
}

int main() {
    if (1 > 2 && 2 < 3) {
        func2(3.0);
    }
    {
        float a = 1.0;
        {
            float a = -1.0;
            a = 2.0;
        }
        a = 3.0;
    }
    a = 4;
    int a[2][2][2] = {1, 2, 3, 4, 5, 6};
    return 0;
}