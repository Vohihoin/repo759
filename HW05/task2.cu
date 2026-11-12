#include <iostream>

__global__ void task2(int a, int* dA){
    printf("Hello World\n");
    // dA[blockIdx.x*blockDim.x + threadIdx.x] = a*threadIdx.x + blockIdx.x;
    // printf("%d\n", threadIdx.x);
}

int main(){

    std::cout << "Starting" << std::endl;

    int hA[16], *dA;
    cudaError_t err = cudaMalloc((void**)(&dA), 16*sizeof(int));
    if(err != cudaSuccess){
        std::cout << "Error allocating memory: " << err << std::endl;
        return 1;
    }
    
    // call our kernel
    task2<<<2, 8>>>(5, dA);

    // synchronize threads
    cudaDeviceSynchronize();

    // copy computed data from device back to host
    cudaMemcpy(&hA, dA, 16*sizeof(int), cudaMemcpyDefault);

    // Free the allocated device memory
    cudaFree(dA);

    // for (int i=0;i<16;i++)
    //     std::cout << hA[i] << ((i==15)?'\n':' ');
    
}