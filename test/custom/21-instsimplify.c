int main()
{
    int x = getch();
    int y = getch();
    int a = (x - (x % y)) / y;
    return a;
}
