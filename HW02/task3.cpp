#include <cstdlib>
#include <chrono>
#include <iostream>
#include <random>
#include <ratio>
#include <iomanip>
#include "matmul.h"

using std::chrono::high_resolution_clock;
using std::chrono::duration;

int main(int argc, char* argv[]){

    int n = 1000;

    // TIMING SETUP
    high_resolution_clock::time_point start;
    high_resolution_clock::time_point end;
    duration<double, std::milli> time_span;

    // ACTUAL PROGRAM

    // generate 3 n x n random matrices to perform C=AB 
    double* arr_A = new double[n*n];
    double* arr_B = new double[n*n];
    double* arr_C = new double[n*n];

    std::vector<double> vec_A = std::vector<double>(n*n);
    std::vector<double> vec_B = std::vector<double>(n*n);

    // create a random number generator
    std::random_device rd;
    std::mt19937 generator(rd()); // creates a Mersenne Twister random number generator

    // create a uniform real distribution between -10.0 and 10.0
    std::uniform_real_distribution<double> image_distribution(-1.0, 1.0);

    for (int i = 0; i < n*n; i++) {
        arr_A[i] = image_distribution(generator);
        vec_A[i] = arr_A[i];
    }

    for (int i = 0; i < n*n; i++) {
        arr_B[i] = image_distribution(generator);
        vec_B[i] = arr_B[i];
    }

    // Print out the number of rows of input matrices
    std::cout << n << std::endl;

    // MMUL1

    // Perform and time matrix multiplication using mmul1
    start = high_resolution_clock::now();
    mmul1(arr_A, arr_B, arr_C, n);
    end = high_resolution_clock::now();
    time_span = std::chrono::duration_cast<duration<double, std::milli>>(end - start);
    
    // Print the time taken for mmul1 and last element of array C
    std::cout << time_span.count() << std::endl;
    std::cout << arr_C[(n*n)-1] << std::endl;

    // MMUL2

    // Perform and time matrix multiplication using mmul2
    start = high_resolution_clock::now();
    mmul2(arr_A, arr_B, arr_C, n);
    end = high_resolution_clock::now();
    time_span = std::chrono::duration_cast<duration<double, std::milli>>(end - start);

    // Print the time taken for mmul2 and last element of array C
    std::cout << time_span.count() << std::endl;
    std::cout << arr_C[(n*n)-1] << std::endl;

    // MMUL3

    // Perform and time matrix multiplication using mmul3
    start = high_resolution_clock::now();
    mmul3(arr_A, arr_B, arr_C, n);
    end = high_resolution_clock::now();
    time_span = std::chrono::duration_cast<duration<double, std::milli>>(end - start);

    // Print the time taken for mmul3 and last element of array C
    std::cout << time_span.count() << std::endl;
    std::cout << arr_C[(n*n)-1] << std::endl;

    // MMUL4

    // Perform and time matrix multiplication using mmul4
    start = high_resolution_clock::now();
    mmul4(vec_A, vec_B, arr_C, n);
    end = high_resolution_clock::now();
    time_span = std::chrono::duration_cast<duration<double, std::milli>>(end - start);

    // Print the time taken for mmul4 and last element of array C
    std::cout << time_span.count() << std::endl;
    std::cout << arr_C[(n*n)-1] << std::endl;

    delete[] arr_A;
    delete[] arr_B;
    delete[] arr_C;

    // No need to delete vectors as they are automatically managed by RAII

    return 0;
}
