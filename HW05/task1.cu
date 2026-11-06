#include <cstdio>

__global__ void task1(){
    int n = threadIdx.x; // thread id within the block, since we're assuming block is 1 dimensional
                         // and number we're computing the factorial of.
    int factorial = 1;
    for (int i = 2; i <= n; i++) {
        factorial *= i;
    }

    std::printf("%d!=%d", n, factorial);
}

int main(){
    const int numElems = 8;
    task1<<<1, numElems>>>();
}