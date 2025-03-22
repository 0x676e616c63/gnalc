int main() {
    int i = 0;
    while(i < 10)
    {
        int j = i;
        while(j < 10)
        {
            putch(i);
			j = j + 1;
        }
        putch(i);
        i = i + 1;
    }
    int k = i + 1;
    putch(k);
    return 0;
}
