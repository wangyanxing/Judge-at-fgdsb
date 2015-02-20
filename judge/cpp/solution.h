int hamming(int a , int b) {
    int res = 0, i, j;
    while (a >0 || b > 0) {
        i = a % 10, j = b % 10;
        if (a == 0 || b == 0 || i != j)
            res++;
        a /= 10, b /= 10;
    }
    return res;
}