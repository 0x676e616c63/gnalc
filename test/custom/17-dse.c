int ref(int a)
{
    a = a + 1;
    return a;
}
int main() {
    int a = 2;
    a = 3;
    ref(a);
    a = 4;
    return 0;
}