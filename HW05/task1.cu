#include <cstdio>

__global__ void task1(){
    int n = threadIdx.x; // thread id within the block, since we're assuming block is 1 dimensional
                         // and number we're computing the factorial of.
    printf("Hello from thread %d\n", n);
    int factorial = 1;
    for (int i = 2; i <= n; i++) {
        factorial *= i;
    }

    printf("%d!=%d\n", n, factorial);
}

int main(){
    const int numElems = 8;
    std::printf("Hello world\n");
    task1<<<1, numElems>>>();
}
