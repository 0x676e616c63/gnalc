const int maxn = 10005;
int n, m, f[maxn][20], dep[maxn];
int to[maxn], next[maxn], head[maxn], cnt = 0;

int LCA(int x, int y){
	if (dep[x] < dep[y]){
		int t = x;
		x = y;
		y = t;
	}
	int i = 19;
	while (dep[x] > dep[y]){
		if (f[x][i] && dep[f[x][i]] >= dep[y])
			x = f[x][i];
		i = i - 1;
	}
	if (x == y) return x;
	i = 19;
	while (i >= 0){
		if (f[x][i] != f[y][i]){
			x = f[x][i];
			y = f[y][i];
		}
		i = i - 1;
	}
	return f[x][0];
}
