int transpose(int n, int matrix[], int rowsize){
    int colsize = n / rowsize;
    int i = 0;
    int j = 0;
    while (i < colsize){
        j = 0;
        while (j < rowsize){
            if (i < j){
                j = j + 1;
                continue;
            }
            int curr = matrix[i * rowsize + j];
            matrix[j * colsize + i] = matrix[i * rowsize + j];
            matrix[i * rowsize + j] = curr;
            j = j + 1;
        }
        i = i + 1;
    }
    return -1;
}
