int main() {
    int a[10] = {1, 2, 3, 4, 5, 6, 7, 8, 9, 10};
    int b, c, d, e, f, g, h, j, k;
    int i = 0;
    while(i < 5) {
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
    }
}