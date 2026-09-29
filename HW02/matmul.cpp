#include "matmul.h"

void mmul1(const double *A, const double *B, double *C, const unsigned int n){
    for (int i = 0; i < static_cast<int>(n); i++){
        for (int j = 0; j < static_cast<int>(n); j++){
            // initialize C[i][j] = 0
            C[(i * n) + j] = 0;
            for (int k = 0; k < static_cast<int>(n); k++){
                C[(i * n) + j] += A[(i * n) + k] * B[ (k * n)  + j];
            }
        }
    }
}

void mmul2(const double *A, const double *B, double *C, const unsigned int n){
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

void mmul3(const double *A, const double *B, double *C, const unsigned int n){
    for (int j = 0; j < static_cast<int>(n); j++){
        for (int k = 0; k < static_cast<int>(n); k++){
            for (int i = 0; i < static_cast<int>(n); i++){
                if (k == 0){ // initialize C[i][j] = 0
                    C[(i * n) + j] = 0;
                }
                C[(i * n) + j] += A[(i * n) + k] * B[ (k * n)  + j];
            }
        }
    }
}

void mmul4(const std::vector<double>& A, const std::vector<double>& B, double* C, const unsigned int n){
    for (int i = 0; i < static_cast<int>(n); i++){
        for (int j = 0; j < static_cast<int>(n); j++){
            // initialize C[i][j] = 0
            C[(i * n) + j] = 0;
            for (int k = 0; k < static_cast<int>(n); k++){
                C[(i * n) + j] += A.at((i * n) + k) * B.at( (k * n)  + j);
            }
        }
    }
}