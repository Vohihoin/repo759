#include <iostream>
#include <random>
#include "vscale.cuh"

int main(int argc, char** argv){

    // Error checking for the code
    if (argc < 2){
        std::cout << "Usage: " << argv[0] << " <num_ints> num_ints > 0" << std::endl;
    }

    int n = std::stoi(argv[1]);
    if (n <= 0){
        std::cout << "Usage: " << argv[0] << " <num_ints> num_ints > 0" << std::endl;
    }

    // define grid and block dimensions
    int numThreads = 512;
    dim3 blockDim(numThreads);
    dim3 gridDim((n + numThreads - 1)/numThreads);

    // Declaring the arrays, and allocating memory for the device side arrays
    float A[n], B[n], *dA, *dB;

    cudaError_t err = cudaMalloc((void**)&dA, n*sizeof(float));
    if (err != cudaSuccess)
    {
        std::cout << "Error allocating memory: " << cudaGetErrorString(err) << std::endl;
        return 1;
    }

    err = cudaMalloc((void**)&dB, n*sizeof(float));
    if (err != cudaSuccess)
    {
        std::cout << "Error allocating memory: " << cudaGetErrorString(err) << std::endl;
        return 1;
    }


    // Generate random numbers in the arrays a and b
    std::random_device rd;
    std::mt19937 generator(rd());

    std::uniform_real_distribution<float> dist_a(-10.0f, 10.0f);
    std::uniform_real_distribution<float> dist_b(0.0f, 1.0f);
    
    for (int i = 0; i < n; i++){
        A[i] = dist_a(generator);
        B[i] = dist_b(generator);
    }

    // for (int i = 0; i < n; i++){
    //     A[i] = i;
    //     B[i] = (i*1.0f)/n;
    // }

    cudaMemcpy(dA, &A, n*sizeof(float), cudaMemcpyHostToDevice);
    cudaMemcpy(dB, &B, n*sizeof(float), cudaMemcpyHostToDevice);

    // Launch the kernel
    vscale<<<gridDim, blockDim>>>(dA, dB, n);

    // Wait for the kernel to synchronize
    cudaDeviceSynchronize();

    // Bring results from array dB back into B
    cudaMemcpy(&B, dB, n*sizeof(float), cudaMemcpyDeviceToHost);

    // Print out the first and last values
    std::cout << B[0] << std::endl;
    std::cout << B[n-1] << std::endl;
}
