int pow(int a, int b){
    int res = 1;
    int i = b;
    while (i > 0){
        res = res * a;
        i = i - 1;
    }
    return res;
}
int main(){
    return pow(2, 3);
}
