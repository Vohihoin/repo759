#include "matmul.h"

void mmul(const float* A, const float* B, float* C, const std::size_t n){
    
    
    int F = n*n*n;
    for (int f = 0; f < F; f++){
        int j = f % n;
        int k = (f/n) % n;
        int i = f/(n*n);

        if (k == 0){
            C[(i * n) + j] = 0;
        }

        C[(i * n) + j] += A[(i * n) + k] * B[ (k * n)  + j];

    }

    // #pragma omp parallel for collapse(3) schedule(static, n) // Parallelize the triple nested loop for matrix multiplication using OpenMP
    //                                                          // Note: I am picking n for the static chunk size because for the inner loop,
    //                                                          // n iterations correspond to multiplying through one row of B, and since elements
    //                                                          // stored in row-major order, for cache locality, a given thread working with a
    //                                                          // single row is pretty useful
    // for (int i = 0; i < static_cast<int>(n); i++){
    //     for (int k = 0; k < static_cast<int>(n); k++){
    //         for (int j = 0; j < static_cast<int>(n); j++){
    //             if (k == 0){ // initialize C[i][j] = 0
    //                 C[(i * n) + j] = 0;
    //             }
    //             C[(i * n) + j] += A[(i * n) + k] * B[ (k * n)  + j];
    //         }
    //     }
    // }

}
