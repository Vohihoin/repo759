#include <cstdlib>
#include <chrono>
#include <iostream>
#include <random>
#include <ratio>
#include "scan.h"

using std::chrono::high_resolution_clock;
using std::chrono::duration;

int main(int argc, char* argv[]){

    if (argc < 2) {
        std::cerr << "Usage: " << argv[0] << " <n>" << std::endl;
        return 1;
    }
    
    int n = atoi(argv[1]);


    // TIMING SETUP
    high_resolution_clock::time_point start;
    high_resolution_clock::time_point end;
    duration<double, std::milli> time_span;

    // ACTUAL PROGRAM

    // generate an array of n random floats
    float* arr = new float[n];
    float* output_arr = new float[n];

    // create a random number generator
    std::random_device rd;
    std::mt19937 generator(rd()); // creates a Mersenne Twister random number generator

    // create a uniform real distribution between -1.0 and 1.0
    std::uniform_real_distribution<float> distribution(-1.0f, 1.0f);

    for (int i = 0; i < n; i++) {
        arr[i] = distribution(generator);
    }

    
    // Perform scan operation on input array
    start = high_resolution_clock::now();
    scan(arr, output_arr, n);
    end = high_resolution_clock::now();
    time_span = std::chrono::duration_cast<duration<double, std::milli>>(end - start);

    std::cout << time_span.count() << std::endl;

    // Print the first and last elements of the output array
    std::cout << output_arr[0] << std::endl;
    std::cout << output_arr[n-1] << std::endl;

    delete[] arr;
    delete[] output_arr;

    return 0;
}