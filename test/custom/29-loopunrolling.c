// v 65_color.sy
// v 77_substr.sy
// v 94_nested_loops.sy
// v 82_long_func
// v 28_side_effect2
// v 83_long_array

// PUC = 4:
// ~/data3/dev/gnalc/build/test git:[iropt]
// llvm-link 2>&1 ./gnalc_test_temp/2025-05-17_00-54-21/sylib.ll ../../test/custom/29-loopunrolling.gg -o ./test.bc
// ~/data3/dev/gnalc/build/test git:[iropt]
// lli test.bc
// 101
// 21
// 25
// 200
// 15
// 102
// 10 20 30 40 50 60 70 80
// 5 10 15 20 5 10 15 20 5 10 15 20 25 /// ERROR
// 103
// 31 172 126
// 104
// 25
// 22
// TOTAL: 0H-0M-0S-0us

// Test Case 2: 数组修改，检查余数处理是否正确访问数组
int test_array_modification() {
    int arr[10] = {1, 2, 3, 4, 5, 6, 7, 8, 9, 10};
    int n_arr;
    int k; // 用于打印

    // Case 2.2: n_arr = 5.
    // U=3: 主循环1次 (arr[0]..arr[2]), 余数2次 (arr[3], arr[4]).
    // U=4: 主循环1次 (arr[0]..arr[3]), 余数1次 (arr[4]).

    n_arr = 5;
    k = 0;
    while (k < n_arr) {
        putint(arr[k]);
        if (k < n_arr - 1) {
            putch(32);
        }
        k = k + 1;
    }
    // 预期: 1 2 3 4 5

    return 0;
}

int main() {
    test_array_modification();
    return 0;
}

// // Test Case 1: 简单累加，不同迭代次数和可能的余数
// int test_simple_summation() {
//     int sum;
//     int i;
//     int n;

//     putint(101); putch(10); // Test Case ID

//     // Case 1.1: n = 7.
//     // 如果展开因子 U=3, 主循环迭代2次 (0,1,2 和 3,4,5), 余数1次 (6).
//     // 如果展开因子 U=4, 主循环迭代1次 (0,1,2,3), 余数3次 (4,5,6).
//     sum = 0;
//     i = 0;
//     n = 7; // 迭代: 0, 1, 2, 3, 4, 5, 6
//     while (i < n) {
//         sum = sum + i;
//         i = i + 1;
//     }
//     putint(sum); // 预期: 0+1+2+3+4+5+6 = 21
//     putch(10);

//     // Case 1.2: n = 5.
//     // 如果展开因子 U=3, 主循环迭代1次 (0,1,2), 余数2次 (3,4).
//     // 如果展开因子 U=4, 主循环迭代1次 (0,1,2,3), 余数1次 (4).
//     sum = 0;
//     i = 0;
//     n = 5; // 迭代: 0, 1, 2, 3, 4
//     while (i < n) {
//         sum = sum + (i * 2 + 1); // 稍微不同的循环体
//         i = i + 1;
//     }
//     // 预期: (0*2+1)+(1*2+1)+(2*2+1)+(3*2+1)+(4*2+1) = 1+3+5+7+9 = 25
//     putint(sum);
//     putch(10);

//     // Case 1.3: n = 2.
//     // 如果展开因子 U=3 或 U=4, 所有迭代都在余数部分.
//     sum = 0;
//     i = 0;
//     n = 2; // 迭代: 0, 1
//     while (i < n) {
//         sum = sum + 100;
//         i = i + 1;
//     }
//     putint(sum); // 预期: 100+100 = 200
//     putch(10);

//     // Case 1.4: n = 6.
//     // 如果展开因子 U=3, 主循环迭代2次, 无余数.
//     // 如果展开因子 U=4, 主循环迭代1次, 余数2次.
//     sum = 0;
//     i = 0;
//     n = 6; // 迭代: 0, 1, 2, 3, 4, 5
//     while (i < n) {
//         sum = sum + (5 - i);
//         i = i + 1;
//     }
//     // 预期: (5-0)+(5-1)+(5-2)+(5-3)+(5-4)+(5-5) = 5+4+3+2+1+0 = 15
//     putint(sum);
//     putch(10);

//     return 0;
// }

// // Test Case 2: 数组修改，检查余数处理是否正确访问数组
// int test_array_modification() {
//     int arr[10]; // 为测试提供足够大小的数组
//     int i;
//     int n_arr;
//     int k; // 用于打印

//     putint(102); putch(10); // Test Case ID

//     // Case 2.1: n_arr = 8.
//     // U=3: 主循环2次 (覆盖 arr[0]..arr[5]), 余数2次 (arr[6], arr[7]).
//     // U=4: 主循环2次 (覆盖 arr[0]..arr[7]), 无余数.
//     n_arr = 8;
//     i = 0;
//     while (i < n_arr) {
//         arr[i] = (i + 1) * 10;
//         i = i + 1;
//     }
//     // 打印数组内容以验证
//     k = 0;
//     while (k < n_arr) {
//         putint(arr[k]);
//         if (k < n_arr - 1) {
//             putch(32); // 空格
//         }
//         k = k + 1;
//     }
//     putch(10); // 换行
//     // 预期: 10 20 30 40 50 60 70 80

//     // Case 2.2: n_arr = 5.
//     // U=3: 主循环1次 (arr[0]..arr[2]), 余数2次 (arr[3], arr[4]).
//     // U=4: 主循环1次 (arr[0]..arr[3]), 余数1次 (arr[4]).

//     // (为避免干扰，可以在这里重新初始化数组，但SysY通常不允许在函数中间声明，
//     // 所以我们直接覆盖旧值，并只关注新的n_arr范围)
//     n_arr = 5;
//     i = 0;
//     while (i < n_arr) {
//         arr[i] = (i + 1) * 5;
//         i = i + 1;
//     }
//     k = 0;
//     while (k < n_arr) {
//         putint(arr[k]);
//         if (k < n_arr - 1) {
//             putch(32);
//         }
//         k = k + 1;
//     }
//     putch(10);
//     // 预期: 5 10 15 20 25

//     return 0;
// }

// // Test Case 3: 循环体包含多个不相关的简单语句
// int test_multiple_statements() {
//     int a;
//     int b;
//     int c; // 用于累加a的值
//     int i;
//     int n_multi;

//     putint(103); putch(10); // Test Case ID

//     // Case 3.1: n_multi = 7.
//     // U=3: 主循环2次, 余数1次.
//     a = 10; // 初始值
//     b = 200; // 初始值
//     c = 0;
//     i = 0;
//     n_multi = 7; // 迭代 0..6
//     while (i < n_multi) {
//         a = a + i;      // a 依赖于上一轮的 a 和 i
//         b = b - (i + 1);  // b 依赖于上一轮的 b 和 i
//         c = c + a;      // c 累加当前的 a
//         i = i + 1;
//     }
//     // 手动计算预期值：
//     // i |  i   | old_a | new_a | old_b | new_b | new_c
//     // --|------|-------|-------|-------|-------|-------
//     // 0 |  0   | 10    | 10+0=10| 200  |200-1=199| 0+10=10
//     // 1 |  1   | 10    | 10+1=11| 199  |199-2=197| 10+11=21
//     // 2 |  2   | 11    | 11+2=13| 197  |197-3=194| 21+13=34
//     // 3 |  3   | 13    | 13+3=16| 194  |194-4=190| 34+16=50
//     // 4 |  4   | 16    | 16+4=20| 190  |190-5=185| 50+20=70
//     // 5 |  5   | 20    | 20+5=25| 185  |185-6=179| 70+25=95
//     // 6 |  6   | 25    | 25+6=31| 179  |179-7=172| 95+31=126
//     putint(a); putch(32); // 预期: 31
//     putint(b); putch(32); // 预期: 172
//     putint(c); putch(10); // 预期: 126

//     return 0;
// }

// // Test Case 4: 循环步长大于1 (如果展开遍支持)
// // C++代码中的 `loop.step` 和迭代次数计算表明可能支持非1步长
// int test_larger_step() {
//     int sum_step;
//     int i_step;
//     int n_bound; // 循环变量的上界
//     int step_val;

//     putint(104); putch(10); // Test Case ID

//     // Case 4.1: 迭代 (i_step): 0, 2, 4, 6, 8 (共5次)
//     // n_bound = 10, step_val = 2
//     // U=3: 主循环1次 (0,2,4), 余数2次 (6,8)
//     sum_step = 0;
//     i_step = 0;
//     n_bound = 10;
//     step_val = 2;
//     while (i_step < n_bound) { // 迭代 i_step = 0, 2, 4, 6, 8
//         sum_step = sum_step + i_step + 1;
//         i_step = i_step + step_val;
//     }
//     // 预期: (0+1) + (2+1) + (4+1) + (6+1) + (8+1) = 1+3+5+7+9 = 25
//     putint(sum_step);
//     putch(10);

//     // Case 4.2: 迭代 (i_step): 1, 4, 7, 10 (共4次)
//     // n_bound = 12, step_val = 3
//     // U=3: 主循环1次 (1,4,7), 余数1次 (10)
//     sum_step = 0;
//     i_step = 1;
//     n_bound = 12; // 使得迭代到10为止，13会>=12
//     step_val = 3;
//     while (i_step < n_bound) { // 迭代 i_step = 1, 4, 7, 10
//         sum_step = sum_step + i_step;
//         i_step = i_step + step_val;
//     }
//     // 预期: 1 + 4 + 7 + 10 = 22
//     putint(sum_step);
//     putch(10);

//     return 0;
// }


// int main() {
//     test_simple_summation();
//     test_array_modification();
//     test_multiple_statements();
//     test_larger_step();
//     return 0;
// }

// // Very slowly run ConstantPropagationPass when fully unroll
// // 52_scope
// int a = 7;

// int func() {
//     int b = a;
//     int a = 1;
//     if (a == b) {
//         a = a + 1;
//         return 1;
//     }
//     else
//         return 0;
// }

// int main() {
//     int result = 0;
//     int i = 0;
//     while (i < 100) {
//         if (func() == 1)
//             result = result + 1;
//         i = i + 1;
//     }
//     if (result < 100)
//         putint(1);
//     else
//         putint(0);
//     return 0;
// }
