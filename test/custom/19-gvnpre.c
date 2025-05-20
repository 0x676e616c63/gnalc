int arr2[10][2][3][2][4][8][7];

void loop2() {
  int a, b, c, d, e, f, g;
  a = 0;
  while (a < 10) {
    b = 0;
    while (b < 2) {
      c = 0;
      while (c < 3) {
        d = 0;
        while (d < 2) {
                arr2[a][b][c][d][e][f][g] = a + b + d + g;
          d = d + 1;
        }
        c = c + 1;
      }
      b = b + 1;
    }
    a = a + 1;
  }
}


int main() {
  loop2();
    putarray(10 * 2 * 3 * 2 * 4 * 8 * 7, arr2);
  return 1;
}
