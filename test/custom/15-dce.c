int side_effect() { putch(48); }
int no_side_effect() {
    int s = 2;
    return 1;
}
int main() {
    int a = 2;
    side_effect();
    no_side_effect();
    return a + 1;
}