int func(int num) {
    if (num) {
        num = 1;
    } else if (num == 2) {
        num = 5;
    } else {
        num = 3;
    }
    while (num) {
        num = num - 1;
    }

    return num;
}

int scp(int num, int s) {
    if (s && num) {
        num = 1;
    } else if (num == 1 || s == 2) {
        s = 2;
    }
    while (num && s) {
        num = num - 1;
    }

    return num;
}