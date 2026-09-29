#include "convolution.h"

// Assuming square 2D array of size n
inline float index_row_major_for_convolution(const float* array, int i, int j, std::size_t n){
    if (!(i >= 0 && i < static_cast<int>(n)) || !(j >= 0 && j < static_cast<int>(n))) { // If any of our indices is out of bounds
        if ((i >= 0 && i < static_cast<int>(n)) || (j >= 0 && j < static_cast<int>(n))){ // But the other index is in bound (edge), then we return 1
            return 1;
        }else{ // But if both co-ordinates are out of bounds (corner), we return 0
            return 0;
        }
    } // else, we return the appropriate indexed value
    return array[i*n + j];
}

void convolve(const float *image, float *output, std::size_t n, const float *mask, std::size_t m){
    for (int x = 0; x < static_cast<int>(n); x++){
        for (int y = 0; y < static_cast<int>(n); y++){
            
            // We apply our mask of convolution to each point
            // We're assuming our mask width, m, is odd
            float sum = 0;
            for (int i = 0; i < static_cast<int>(m); i++){
                for (int j = 0; j < static_cast<int>(m); j++){
                    // i and j are the indices of the mask we're going throuhg
                    // k and l are our indices for our image that we're applying our mask to
                    int k = x + i - ((m - 1)/2);
                    int l = y + j - ((m - 1)/2);
                    sum += mask[(i * m) + j] * index_row_major_for_convolution(image, k, l, n);
                }
            }
            
            output[ (x * n) + y] = sum;
        }
    }
}