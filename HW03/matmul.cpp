#include "matmul.h"

void mmul_flattened(const float* A, const float* B, float* C, const std::size_t n){
    
    
    // Manual flattening of the matrix multiplication loop
    std::size_t F = n*n*n; // F has to be size_t, else for relatively small values of n like 2000, n^3 will overflow and become negative

    #pragma omp parallel 
    {

        // Initialize the output matrix C to zero
        #pragma omp for schedule(static)
        for (std::size_t l = 0; l < n*n; l++){
            C[l] = 0; // Doesn't need atomic for two reasons:
                        // 1) Each element is written to by exactly one thread
                        // 2) Monotonic change, so even if multiple threads write
                        //    the final value will still be correct
        }

        // Then perform the matrix multiplication using the flattened loop
        #pragma omp for schedule(static, n)
        for (std::size_t f = 0; f < F; f++){
	        std::size_t j = f % n;
            std::size_t k = (f/n) % n;
	        std::size_t i = f/(n*n);

            // Want each update to C[(i * n) + j] to be atomic, so that
            // the increments made by different threads do not conflict
            #pragma omp atomic 
            C[(i * n) + j] += A[(i * n) + k] * B[ (k * n)  + j];
        }
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

void mmul(const float* A, const float* B, float* C, const std::size_t n){
    
    #pragma omp parallel for schedule(static)
    for (int i = 0; i < static_cast<int>(n); i++){
        for (int k = 0; k < static_cast<int>(n); k++){
            for (int j = 0; j < static_cast<int>(n); j++){
                if (k == 0){ // initialize C[i][j] = 0
                    C[(i * n) + j] = 0;
                }
                C[(i * n) + j] += A[(i * n) + k] * B[ (k * n)  + j];
            }
        }
    }
}
