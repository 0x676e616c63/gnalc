int sum = 0;
int array[20];

int f(int i, int j) {
  sum = sum + 1;
  if (i >= j || i >= 20) return 0;
  array[i] = 1;
  if (i == 0) return array[0];
  else return array[i - 1];
}

int g(int i, int j) {
  sum = sum + 2;
  if (i >= j || i >= 20) return 1;
  array[i] = 0;
  if (i == 0) return array[0];
  else return array[i - 1];
}

int h(int i) {
  sum = sum + 3;
  if (i < 0 || i >= 20) return 0;
  return array[i];
}

int main() {
  int i = 0;
  i = 0;
  while (i < 20) {
    if (g(0, i) || g(1, i) || g(2, i) || g(3, i) || g(4, i) || g(5, i) ||
        g(6, i) || g(7, i) || g(8, i) || g(9, i) || g(10, i) || g(11, i) ||
        g(12, i) || g(13, i) ||
        g(18, i) || g(19, i));
    i = i + 1;
  }
  i = 1;
  while (i < 20 && f(i - 1, i))
    i = i + 1;

  return 0;
}