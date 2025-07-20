// int main() {
//     int a;
//     a = getint();
//     int b = 3;
//     while (b < a) {
//     b = b + 2;
//     putint(b);
//     }
//     return 0;
// }
int doubleWhile() {
    int i;
    i = 5;
    int j;
    j = 7;
    while (i < 100) {
        i = i + 30;
        while(j < 100){
            j = j + 6;
        }
        j = j - 100;
    }
    return (j);
}

int main() {
    return doubleWhile();
}
