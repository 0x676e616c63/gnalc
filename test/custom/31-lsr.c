//int fun(int n)
//{
//    int i = 1;
//    int s = 0;
//    while (i <= n) {
//        s = s + i * i * i;
//        i = i + 1;
//    }
//    return s;
//}

int lsr() {
int a[10];
int i = 0;
while( i < 10 ) {
    int j = 3 * i + 2;
//    while( j < 10 ) {
//        j = j + 1;
//    }

    a[j] = a[j] - 2;
    i = i + 2;
}
}

int dep() {
    int i = 0;
    int A[100];
    while (i<100)
    {
        A[2*i+2] = A[4*i] + A[2*i];
        i = i + 1;
    }
    return 1;
}

int main(){
//    putch(fun(1));
//    putch(fun(3));
//    putch(fun(5));
//    putch(fun(7));
//    putch(fun(9));
//    int a = getch();
//    int b = getch();
//    int c = getch();
//    putch(a + b);
//    putch(a + b);
    return 0;
}

