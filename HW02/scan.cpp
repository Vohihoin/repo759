#include "scan.h"

void scan(const float *arr, float *output, std::size_t n){
    float current_scan = 0.0;
    for (int i = 0; i < n; i++){
        // add before we assign because we're doing an inclusive scan
        current_scan += arr[i];
        output[i] = current_scan;
    }
}