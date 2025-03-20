

int func(int i) {
	int a = 1;
    int n = 4;
    int j = 0;
    while (j < n) {
//        putch(a);
        a = a + i;
        j = j + 1;
        if (j > n) {
            putch(j);
            break;
        }
    }
    return a;
}
//
//int main() {
//    int a = func(7);
//    return a;
//}

//int func(int i) {
//	int a[6] = {1, 2, 3, 4, 5, 6};
//    int n = 6;
//    int j = 0;
//    while (j < n) {
//        a[j] = a[j] + i;
//        j = j + 1;
//    }
//    return a[3];
//}
//
int main() {
    int a = func(7);
    return a;
}
