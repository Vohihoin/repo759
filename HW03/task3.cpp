#include <cstdlib>
#include <chrono>
#include <random>
#include <ratio>
#include <iomanip>
#include <iostream>
#include <string>
#include "msort.h"

using std::chrono::high_resolution_clock;
using std::chrono::duration;


int main(int argc, char* argv[]) {

    if (argc < 4){
        std::cerr << "Usage: " << argv[0] << " <num of elements> <num of threads> <threshold>" << std::endl;
        return 1;
    }

    int n = std::stoi(argv[1]);
    int t = std::stoi(argv[2]);
    std::size_t ts = std::stoi(argv[3]);

    // Set the number of OpenMP threads based on t
    omp_set_num_threads(t);

    // TIMING SETUP
    high_resolution_clock::time_point start;
    high_resolution_clock::time_point end;
    duration<double, std::milli> time_span;

    // Create a random array of integers
    int* arr = new int[n];
        
    // create a random number generator
    std::random_device rd;
    std::mt19937 generator(rd()); // creates a Mersenne Twister random number generator

    // create a uniform int distribution between -1000 and 1000 for the 
    // matrix multiplication
    std::uniform_int_distribution<int> distribution(-1000, 1000);

    for (int i = 0; i < n; i++){
        arr[i] = distribution(generator);
    }

    // Time the msort operation
    start = high_resolution_clock::now();
    msort(arr, n, ts);
    end = high_resolution_clock::now();
    time_span = std::chrono::duration_cast<duration<double, std::milli>>(end - start);

    std::cout << arr[0] << std::endl;
    std::cout << arr[n-1] << std::endl;
    std::cout << time_span.count() << std::endl;

    delete[] arr;
    
    return 0;
}