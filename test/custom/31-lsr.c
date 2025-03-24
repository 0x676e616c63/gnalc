int main(){
    int i = 0;
    int j = 0;
    while (i < 10)
    {
        j = 3 * i + 1;
        putch(j);
        i = i + 2;
    }
    putch(i);
    putch(j);
    return 0;
}