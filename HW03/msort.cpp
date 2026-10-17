#include <algorithm>
#include <cstring>
#include "msort.h"

void msort_rec(int* into, int* from, std::size_t start, std::size_t end, const std::size_t threshold);

void msort(int* arr, const std::size_t n, const std::size_t threshold){
    int* arr_copy = new int[n];
    std::memcpy(arr_copy, arr, n * sizeof(int)); // only using because array is of primitive type
    
    #pragma omp parallel
    {
        #pragma omp single
        {
            msort_rec(arr, arr_copy, 0, n, threshold);
        }
    }
}

/**
 * @brief Recursive Parallel Merge Sort
 * 
 * If the size of the sub-array is below @ref threshold, "into" will be sorted serially. Because our end-goal is always
 * to have into sorted.
 * But, if we can't serially sort into, then we're going to split "from" into halves, sort those halves, and merge the halves
 * from "from" into "into" So the "from" and "into" refer to where we're merging from and into based on the current recursion step.
 * 
 * @param from 
 * @param into
 * @param start Start index of sub-array to copy (inclusive)
 * @param end End index of sub-array to copy (exclusive)
 * @param threshold At what size of array, below which to perform a serial sort
 */
void msort_rec(int* into, int* from, std::size_t start, std::size_t end, const std::size_t threshold){

    std::size_t arr_size = start - end + 1;
    if (arr_size < threshold){ // we can perform a serial sort on our "into" sub-array
                               // when our sub-array size is smaller than the threshold
        std::sort(&(into[start]), &(into[end]));
        return;
    }

    // else, if we're above the threshold, we split our array in two
    // (conceptually doesn't matter if we're splitting an "into" array or a "from" array since at this point, we're assuming both halves
    // are unsorted and so have the exact same values)
    std::size_t middle = (start + end) / 2;

    // Assign a task to sort the first half of the array
    #pragma omp task
    {
        msort_rec(from, into, start, middle, threshold);
    }

    // Sort the second half by ourselves
    msort_rec(from, into, middle, end, threshold);

    // Wait for the other half being run by a task to finish sorting before continuing
    #pragma omp taskwait

    // Once we have the two sorted halves, we merge them from the "from" array into the "into" array
    std::size_t i= start;
    std::size_t j = middle;
    for (std::size_t k = start; k < end; ++k){
        if (i < middle && (j >= end || from[i] <= from[j])){
            into[k] = from[i];
            ++i;
        } else {
            into[k] = from[j];
            ++j;
        }
    }
}