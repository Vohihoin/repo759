#include <cstdlib>
#include <chrono>
#include <iostream>
#include <random>
#include <ratio>
#include <iomanip>
#include "matmul.h"

using std::chrono::high_resolution_clock;
using std::chrono::duration;

//#define BASE_TEST

int main(int argc, char* argv[]){

    if (argc < 3){
        std::cerr << "Usage: " << argv[0] << " <matrix_size> <num_of_threads>" << std::endl;
        return 1;
    }

    int n = std::atoi(argv[1]);
    int t = std::atoi(argv[2]);

    if (n <= 0 || t <= 0){
        std::cerr << "Matrix size and number of threads must be positive integers." << std::endl;
        return 1;
    }

    #ifdef BASE_TEST
    // Override the matrix size for testing purposes
    n = 3;
    #endif

    // OPENMP SETUP
    omp_set_num_threads(t);

    // TIMING SETUP
    high_resolution_clock::time_point start;
    high_resolution_clock::time_point end;
    duration<double, std::milli> time_span;

    //ACTUAL PROGRAM

    // generate 3 n x n random matrices to perform C=AB 
    float* A = new float[n*n];
    float* B = new float[n*n];
    float* C = new float[n*n];

    // create a random number generator
    std::random_device rd;
    std::mt19937 generator(rd()); // creates a Mersenne Twister random number generator

    // create a uniform real distribution between -2.0 and 2.0 for the 
    // matrix multiplication
    std::uniform_real_distribution<float> distribution(-2.0f, 2.0f);

    for (int i = 0; i < n*n; i++) {
        A[i] = distribution(generator);
    }

    for (int i = 0; i < n*n; i++) {
        B[i] = distribution(generator);
    }

    #ifdef BASE_TEST
    float* A = new float[n*n]{
        1, 2, 3,
        4, 5, 6,
        7, 8, 9,
    };

    float* B = new float[n*n]{
        1, 2, 3,
        4, 5, 6,
        7, 8, 9,
    };

    float* C = new float[n*n];
    #endif

    // Perform and time matrix multiplication using mmul
    start = high_resolution_clock::now();
    mmul(A, B, C, n);
    end = high_resolution_clock::now();

    time_span = std::chrono::duration_cast<duration<double, std::milli>>(end - start);
    

    // Print the first element of array C
    std::cout << C[0] << std::endl;

    // Print the last element of array C
    std::cout << C[n*n - 1] << std::endl;

    // Print the time taken for mmul1 and last element of array C
    std::cout << time_span.count() << std::endl;

    // // Print out the entire array C
    // for (int i = 0; i < n*n; i++) {
    //     std::cout << std::setprecision(3) << C[i] << " ";
    //     if ((i + 1) % n == 0) {
    //         std::cout << std::endl;
    //     }
    // }
    
    delete[] A;
    delete[] B;
    delete[] C;

    return 0;
}
