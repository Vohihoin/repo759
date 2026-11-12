#include <iostream>

__global__ void task2(int a, int* dA){
    dA[blockIdx.x*blockDim.x + threadIdx.x] = a*threadIdx.x + blockIdx.x;
    printf("Hello from thread %d on block %d\n", threadIdx.x, blockIdx.x);
}

int main(){

    std::cout << "Starting" << std::endl;

    int hA[16], *dA;
    cudaError_t err = cudaMalloc((void**)(&dA), 16*sizeof(int));
    if (err != cudaSuccess)
    {
        std::cout << "Error allocating memory: " << err << std::endl;
        return 1;
    }
    
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