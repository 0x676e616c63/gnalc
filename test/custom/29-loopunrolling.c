// 65_color.sy
// 77_substr.sy
// 94_nested_loops.sy

int a = -1, b = 1;

int inc_a()
{
    int b = a;
    b = b + 1;
    a = b;
    return a;
}

int main()
{
    int k = 5;
    while (k >= 0) {
        if (inc_a() && inc_a() && inc_a()) {
            putint(a); putch(32); putint(b); putch(10);
        }
        if (inc_a() < 14 || inc_a() && inc_a() - inc_a() + 1) {
            putint(a); putch(10);
            b = b * 2;
        } else {
            inc_a();
        }
        k = k - 1;
    }
    putint(a); putch(32); putint(b); putch(10);
    return a;
}


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
