#include <iostream>

__global__ void task2(int a, int* dA){
    dA[blockIdx.x*blockDim.x + threadIdx.x] = a*threadIdx.x + blockIdx.x;
    // printf("Hello from thread %d on block %d\n", threadIdx.x, blockIdx.x);
}

int main(){ 

    int hA[16], *dA;
    cudaError_t err = cudaMalloc((void**)(&dA), 16*sizeof(int));
    if (err != cudaSuccess)
    {
        std::cout << "Error allocating memory: " << cudaGetErrorString(err) << std::endl;
        return 1;
    }

    // generate random number to pass into as argument a
    std::random_device rd;
    std::mt19937 generator(rd()); // creates a Mersenne Twister random number generator

    std::uniform_int_distribution<int> dist(0, 1000);
    int a = dist(generator);
    
    // call our kernel
    task2<<<2, 8>>>(5, dA);

    // synchronize threads
    cudaDeviceSynchronize();

    // copy computed data from device back to host
    cudaMemcpy(&hA, dA, 16*sizeof(int), cudaMemcpyDefault);

    // print results
    for (int i=0;i<16;i++)
        std::cout << hA[i] << ((i==15)?'\n':' ');
    
    // Free the allocated device memory
    cudaFree(dA);
    
}
