int main() {
    int a = getint();
    int b = getint();
    int c = getint();
    if (a > b && b > c)
        if (c > a)
            putint(a);
        else
            putint(b);

}