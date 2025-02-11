void fn0() { }
int fn1() { return 1; }
int fn2()
{
    fn0();
    fn1();
    return 1;
}
int fn3() {
    return fn2();
}
int main() {
    fn3();
    return 0;
}