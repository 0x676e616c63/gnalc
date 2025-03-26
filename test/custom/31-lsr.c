int fun(int n)
{
    int i = 1;
    int s = 0;
    while (i <= n) {
        s = s + i * i * i;
        i = i + 1;
    }
    return s;
}

int main(){
    putch(fun(1));
    putch(fun(3));
    putch(fun(5));
    putch(fun(7));
    putch(fun(9));
    return 0;
}

