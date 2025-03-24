int fn2(int a) {
    if (a == 0)
        return 0;
    return fn2(a - 1);
}
int fn3() { return fn2(10); }
int main() {
    fn3();
    return 0;
}