const int maxn = 18;
const int mod = 1000000007;
int dp[maxn][maxn][maxn][maxn][maxn][7];
int list[200];

int cns[20];
 
int main(){
    int n = getint();
    int i = 0;
    i = 0;
    while (i < n) {
        list[i] = getint();
        cns[list[i]] = cns[list[i]] + 1;
        i = i + 1;
    }
}