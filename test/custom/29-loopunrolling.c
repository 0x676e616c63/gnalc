// -O1: 65_color
// -std-pipeline with inline: 94_nested_loops

// // 94_nested_loops
// int arr1[10][2][3][4][5][6][2];
// int arr2[10][2][3][2][4][8][7];

// void loop1(int x, int y) {
//   int a, b, c, d, e, f, g;
//   a = 0;
//   while (a < x && a < y) {
//     b = 0;
//     while (b < 2) {
//       c = 0;
//       while (c < 3) {
//         d = 0;
//         while (d < 4) {
//           e = 0;
//           while (e < 5) {
//             f = 0;
//             while (f < 6) {
//               g = 0;
//               while (g < 2) {
//                 arr1[a][b][c][d][e][f][g] = a + b + c + d + e + f + g + x + y;
//                 g = g + 1;
//               }
//               f = f + 1;
//             }
//             e = e + 1;
//           }
//           d = d + 1;
//         }
//         c = c + 1;
//       }
//       b = b + 1;
//     }
//     a = a + 1;
//   }
// }

// void loop2() {
//   int a, b, c, d, e, f, g;
//   a = 0;
//   while (a < 10) {
//     b = 0;
//     while (b < 2) {
//       c = 0;
//       while (c < 3) {
//         d = 0;
//         while (d < 2) {
//           e = 0;
//           while (e < 4) {
//             f = 0;
//             while (f < 8) {
//               g = 0;
//               while (g < 7) {
//                 arr2[a][b][c][d][e][f][g] = a + b + d + g;
//                 g = g + 1;
//               }
//               f = f + 1;
//             }
//             e = e + 1;
//           }
//           d = d + 1;
//         }
//         c = c + 1;
//       }
//       b = b + 1;
//     }
//     a = a + 1;
//   }
// }

// int loop3(int h, int i, int j, int k, int l, int m, int n) {
//   int a, b, c, d, e, f, g;
//   int ans = 0;
//   a = 0;
//   while (a < 10) {
//     b = 0;
//     while (b < 100) {
//       c = 0;
//       while (c < 1000) {
//         d = 0;
//         while (d < 10000) {
//           e = 0;
//           while (e < 100000) {
//             f = 0;
//             while (f < 1000000) {
//               g = 0;
//               while (g < 10000000) {
//                 ans = ans % 817 + arr1[a][b][c][d][e][f][g] + arr2[a][b][c][d][e][f][g];
//                 g = g + 1;
//                 if (g >= n) break;
//               }
//               f = f + 1;
//               if (f >= m) break;
//             }
//             e = e + 1;
//             if (e >= l) break;
//           }
//           d = d + 1;
//           if (d >= k) break;
//         }
//         c = c + 1;
//         if (c >= j) break;
//       }
//       b = b + 1;
//       if (b >= i) break;
//     }
//     a = a + 1;
//     if (a >= h) break;
//   }
//   return ans;
// }

// int main() {
//   int x = getint();
//   int y = getint();
//   int h = getint();
//   int i = getint(), j = getint();
//   int k = getint();
//   int l = getint();
//   int m = getint();
//   int n = getint();
//   loop1(x, y);
//   loop2();
//   return loop3(h, i, j, k, l, m, n);
// }


// // 65_color
// const int maxn = 18;
// const int mod = 1000000007;
// int dp[maxn][maxn][maxn][maxn][maxn][7];
// int list[200];

// int equal(int a, int b) {
//     if (a == b)
//         return 1;
//     return 0;
// }

// int dfs(int a, int b, int c, int d, int e, int last){
//     if(dp[a][b][c][d][e][last] != -1)
//         return dp[a][b][c][d][e][last];
//     if(a + b + c + d + e == 0)
//         return 1;
//     int ans = 0;
//     if (a) ans = (ans + (a - equal(last, 2)) * dfs(a - 1, b, c, d, e, 1)) % mod;
//     if (b) ans = (ans + (b - equal(last, 3)) * dfs(a + 1, b - 1, c, d, e, 2)) % mod;
//     if (c) ans = (ans + (c - equal(last, 4)) * dfs(a, b + 1, c - 1, d, e, 3)) % mod;
//     if (d) ans = (ans + (d - equal(last, 5)) * dfs(a, b, c + 1, d - 1, e, 4)) % mod;
//     if (e) ans = (ans + e * dfs(a, b, c, d + 1, e - 1, 5)) % mod;
//     dp[a][b][c][d][e][last] = ans % mod;
//     return dp[a][b][c][d][e][last];
// }

// int cns[20];
 
// int main(){
//     int n = getint();
//     int i = 0; 
//     while (i < maxn) {
//         int j = 0;
//         while(j < maxn) {
//             int k = 0;
//             while(k < maxn) {
//                 int l = 0;
//                 while (l < maxn) {
//                     int m = 0;
//                     while (m < maxn) {
//                         int h = 0;
//                         while (h < 7) {
//                             dp[i][j][k][l][m][h] = -1;
//                             h = h + 1;
//                         }
//                         m = m + 1;
//                     }
//                     l = l + 1;
//                 }
//                 k = k + 1;
//             }
//             j = j + 1;
//         }
//         i = i + 1;
//     }
    
//     i = 0;
//     while (i < n) {
//         list[i] = getint();
//         cns[list[i]] = cns[list[i]] + 1;
//         i = i + 1;
//     }

//     int ans = dfs(cns[1], cns[2], cns[3], cns[4], cns[5], 0);

//     putint(ans);

//     return ans;
// }