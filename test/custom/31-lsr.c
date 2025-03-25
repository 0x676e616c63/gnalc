int sum(int a, int b)
{
    int ret = 0;
    while(a < b)
    {
        ret = ret + a;
        a = a + 1;
    }
    return ret;
}
int main(){
    sum(1, 2);
    return 0;
}