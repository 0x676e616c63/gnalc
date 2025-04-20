int k;

float params_fa40(float x0[], float x1[]) {
  float arr[10] = {
      x0[k] + x1[k]};
  if (0) {
    return k;
  } else {
    return params_fa40(x0, x0);
  }
}

int params_mix(float x3[]) {
  float arr[10] = {x3[k]};
  if (0) {
    return k;
  } else {
    return params_mix(arr);
  }
}

int main() {
  float arr[40][3];

  k = getint();

  float ret2 = params_fa40(
      arr[0], arr[1]);
  int ret3 = params_mix(arr[1]);

  return 0;
}
