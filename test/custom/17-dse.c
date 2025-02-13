int only_read_0(int a[])
{
    return a[0];
}

int main()
{
    int arr1[10] = {1,2,3,4,5,6,7,8,9};
    arr1[1] = 2;
    arr1[1] = 2;
    arr1[3] = 2;
    only_read_0(arr1);
    int arr2[10];
    int i = 0;
    while(i < 10)
    {
        arr2[i] = i;
        i = i + 1;
    }
    only_read_0(arr2);
    return 0;
}
