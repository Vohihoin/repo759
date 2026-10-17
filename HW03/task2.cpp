#include <cstdlib>
#include <chrono>
#include <iostream>
#include <random>
#include <ratio>
#include <iomanip>
#include "convolution.h"

using std::chrono::high_resolution_clock;
using std::chrono::duration;

int main(int argc, char* argv[]){

    if (argc < 3) {
        std::cerr << "Usage: " << argv[0] << " <size of image> <num of threads>" << std::endl;
        return 1;
    }
    
    int n = atoi(argv[1]);
    int t = atoi(argv[2]);

    int m = 3; // mask is of size 3x3

    // TIMING SETUP
    high_resolution_clock::time_point start;
    high_resolution_clock::time_point end;
    duration<double, std::milli> time_span;

    // OPENMP SETUP TO SETUP THE NUMBER OF THREADS
    omp_set_num_threads(t);

    // ACTUAL PROGRAM

    // generate a 2D n x n image matrix of random floats and a m x m mask of random floats
    float* image = new float[n*n];
    float* convolved_image = new float[n*n];

    float* mask = new float[m*m];

    // create a random number generator
    std::random_device rd;
    std::mt19937 generator(rd()); // creates a Mersenne Twister random number generator

    // create a uniform real distribution between -10.0 and 10.0
    std::uniform_real_distribution<float> image_distribution(-10.0f, 10.0f);

    // Create the random image matrix
    for (int i = 0; i < n*n; i++) {
        image[i] = image_distribution(generator);
    }
    
    // create a uniform real distribution for the mask between -1.0 and 1.0
    std::uniform_real_distribution<float> mask_distribution(-1.0f, 1.0f);

    // Create the random mask matrix
    for (int i = 0; i < m*m; i++) {
        mask[i] = mask_distribution(generator);
    }

    // Perform convolution operation on input array with the mask
    start = high_resolution_clock::now();
    convolve(image, convolved_image, n, mask, m);
    end = high_resolution_clock::now();
    time_span = std::chrono::duration_cast<duration<double, std::milli>>(end - start);

    // Print the first and last elements of the output array
    std::cout << convolved_image[0] << std::endl;
    std::cout << convolved_image[(n*n)-1] << std::endl;

    // Prints out the time taken by the convolution operation in ms
    std::cout << time_span.count() << std::endl;

    delete[] image;
    delete[] convolved_image;
    delete[] mask;

    return 0;
}
