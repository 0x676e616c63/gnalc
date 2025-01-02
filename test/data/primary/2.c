int f() {
    return 0;
}

int main() {
    int a = 1;
    a = 2;
    int b[1+1] = {1, 2};
    
    while (1) {
        a = (1+1)*a + f() + b[1] + (-1);
        {}
        continue;
        ;
    }

    return 0;
}