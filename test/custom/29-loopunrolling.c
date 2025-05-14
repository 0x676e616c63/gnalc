int FourWhile() {
    int a;
    a = 5;
    int b;
    int c;
    b = 6;
    c = 7;
    int d;
    d = 10;
    while (a < 20) {
        a = a + 3;
        while(b < 10){
            b = b + 1;
            while(c == 7){
                c = c - 1;
                while(d < 20){
                    d = d + 3;
                }
                d = d - 1;
            }
            c = c + 1;
        }
        b = b - 2;
    }

    return (a + (b + d) + c);
}

int main() {
    return FourWhile();
}

// // Can't get trec
// int main() {
//     int i = 4;
//     int j = 0;
//     int k = 0;
//     while (i < 19) {
//         while (j < 100) {
//             while (k < 100) {
//                 k = k + 1;
//             }
//             j = j + 1;
//         }
//         putint(i);
//         i = i + 1;
//     }
//     putint(i);
//     return 0;
// }

// // Can't get trec
// // Very slowly run ConstantPropagationPass when fully unroll
// // 52_scope
// int a = 7;

// int func() {
//     int b = a;
//     int a = 1;
//     if (a == b) {
//         a = a + 1;
//         return 1;
//     }
//     else
//         return 0;
// }

// int main() {
//     int result = 0;
//     int i = 0;
//     while (i < 100) {
//         if (func() == 1)
//             result = result + 1;
//         i = i + 1;
//     }
//     if (result < 100)
//         putint(1);
//     else
//         putint(0);
//     return 0;
// }
