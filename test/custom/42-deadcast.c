int n = 100;
int ks = 15;
int ps = 4;
float input[2000][2000];
float kernel[15][15];
float conv_output[2000][2000];
float pooling_output[493][493];

float max(float a, float b) {
    if (a > b) {
        return a;
    } else {
        return b;
    }
}

float exp(float x) {
    return 1;
}

float sigmoid(float x) {
    return 1;
}

void kernel_conv_pooling(float A[][2000], float B[][2000], float C[][493], float kernel[][15], int n, int ks, int ps) {
    int i, j, k, l;
    float v;
    i = 0;
    while (i < n) {
        j = 0;
        while (j < n) {
            v = A[i * ps][j * ps];
            k = 0;
            while (k < ps) {
                l = 0;
                while (l < ps) {
                    v = max(v, A[i * ps + k][j * ps + l]);
                    l =l+ 1;
                }
                k =k+ 1;
            }
            C[i][j] = v;
            j =j+ 1;
        }
        i =i+ 1;
    }

}

int main() {
    int os = (n - 2 * ks + 2) / ps;
    kernel_conv_pooling(input, conv_output, pooling_output, kernel, n, ks, ps);
    return 0;
}
