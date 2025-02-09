int main() {
    int a = 2;
    if(a == 2)
    {
        a = 3;
        if(a == 4) // Miss
           a = 4;
    }
    return a + 1;
}
// Expected 3 BasicBlocks