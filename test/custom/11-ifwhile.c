int get_cond(int t) { return t - 1; }

int main() {
    int a = 0;
    int b = 10;

    while (get_cond(b) && get_cond(a) && get_cond(2)) {
        b = b - 1;
        if (b == 10) {
            int b = 1;
            int c = b;
            break;
        } else
            continue;
    }

    if (a == 0 || b == 0)
        return 1;

    return 0;
}