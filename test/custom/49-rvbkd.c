const int global_int = 303;
const float global_float = 3.14;
const int space = 32;
const int maxN=1000;
int sorted_array[maxN];

int main() {
    int i=0;
    while(i<maxN){
      sorted_array[i] = i*10000303%maxN;
      i=i+1;
    }
    putarray(maxN, sorted_array);
    return 0;
}

