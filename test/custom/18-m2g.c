int main() {
    int a, b = 8, c = 12;
    a = b + c;
    return a;
    int d = 9;
    a = a * d;
    return a;
    const int A = 4;
    a = (A - b) * c;
    return a;
    return a;
}

//const int ascii_0 = 48;
//
//int my_getint()
//{
//    int sum = 0, c;
//
//    while (1) {
//        c = getch() - ascii_0;
//        if (c < 0 || c > 9) {
//            continue;
//        } else {
//            break;
//        }
//    }
//    sum = c;
//
//    while (1) {
//        c = getch() - ascii_0;
//        if (c >= 0 && c <= 9) {
//            sum = sum * 10 + c;
//        } else {
//            break;
//        }
//    }
//
//    return sum;
//}


//int a, b, d;
//
//int set_a(int val) { a = val; return a; }
//int set_b(int val) { b = val; return b; }
//int set_d(int val) { d = val; return d; }
//
//int main()
//{
//    a = 2; b = 3;
//    if (set_a(0) && set_b(1)) {}
//    putint(a); putch(32);
//    putint(b); putch(32);
//
//    a = 2; b = 3;
//    if (set_a(0) && set_b(1)) ;
//    putint(a); putch(32);
//    putint(b); putch(10);
//
//    const int c = 1;
//    d = 2;
//    if (c >= 1 && set_d(3)) ;
//    putint(d); putch(32);
//    if (c <= 1 || set_d(4)) {}
//    putint(d); putch(10);
//
//    if (16 >= (3 - (2 + 1))) { putch(65); }
//    if ((25 - 7) != (36 - 6 * 3)) putch(66);
//    if (1 < 8 != 7 % 2) { putch(67); }
//    if (3 > 4 == 0) { putch(68); }
//    if (1 == 0x66 <= 077) putch(69);
//    if (5 - 6 == -!0) putch(70);
//    putch(10);
//
//    int i0 = 0, i1 = 1, i2 = 2, i3 = 3, i4 = 4;
//    while (i0 && i1) putch(32);
//    if (i0 || i1) putch(67);
//    if (i0 >= i1 || i1 <= i0) putch(72);
//    if (i2 >= i1 && i4 != i3) { putch(73); }
//    if (i0 == !i1 && i3 < i3 || i4 >= i4) { putch(74); }
//    if (i0 == !i1 || i3 < i3 && i4 >= i4) putch(75);
//    putch(10);
//
//    return 0;
//}


//int doubleWhile() {
//    int i;
//    i = 5;
//    int j;
//    j = 7;
//    while (i < 100) {
//        i = i + 30;
//        while(j < 100){
//            j = j + 6;
//        }
//        j = j - 100;
//    }
//    return (j);
//}
//
//int main() {
//    return doubleWhile();
//}


//int whileIf() {
//    int a;
//    a = 0;
//    int b;
//    b = 0;
//    while (a < 100) {
//        if (a == 5) {
//            b = 25;
//        }
//        else if (a == 10) {
//            b = 42;
//        }
//        else {
//            b = a * 2;
//        }
//        a = a + 1;
//    }
//    return (b);
//}


//int main(){
//    int i = 0;
//    if (i+1 == 1)
//        return 1;
//    else
//        return 0;
//}

//int main(){
//    int i;
//    i = 0;
//    int sum;
//    sum = 0;
//    while(i < 100){
//        if(i == 50){
//            i = i + 1;
//            continue;
//        }
//        sum = sum + i;
//        i = i + 1;
//    }
//    return sum;
//}

//float myabs(float num) {
//    if(num>0){
//        return num;
//    }
//    if(num<0){
//        return -num;
//    }
//}

//int a;
//int func(int p){
//    p = p - 1;
//    return p;
//}
//int main(){
//    int b;
//    a = 10;
//    b = func(a);
//    return b;
//}
