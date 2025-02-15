int insertsort(int a[])
{
        int j = 111;
        while(j>9&&3<a[j])
        {
            a[j+1]=a[j];
            j = j - 1;
        }
        a[j+1]=3;
    return 0;
}
