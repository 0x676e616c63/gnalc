int sum(int n)
{
    int i = 1;
    int sum = 0;
    while (i <= n) {
        sum = sum + i * i * i;
        i = i + 2;
    }
    return sum;
}
int main(){
    putch(sum(5));
    putch(sum(6));
    putch(sum(7));
    putch(sum(8));
    putch(sum(9));
    putch(sum(10));
    putch(sum(20));
    putch(sum(30));
    putch(sum(40));
    putch(sum(50));
    putch(sum(60));
    return 0;
}
// Inline first
// expected:
//   call void @putch(i32 noundef 153)
//   call void @putch(i32 noundef 153)
//   call void @putch(i32 noundef 496)
//   call void @putch(i32 noundef 496)
//   call void @putch(i32 noundef 1225)
//   call void @putch(i32 noundef 1225)
//   call void @putch(i32 noundef 19900)
//   call void @putch(i32 noundef 101025)
//   call void @putch(i32 noundef 319600)
//   call void @putch(i32 noundef 780625)
//   call void @putch(i32 noundef 1619100)