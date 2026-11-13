#!/usr/bin/env zsh

#SBATCH -p instruction

#SBATCH --job-name=Task3Measure
#SBATCH --error=Task3Measure.err
#SBATCH --output=Task3Measure.out
#SBATCH --mem=16G
#SBATCH --time=0-00:02:00
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:1

# just in case, we load the cuda module for compilation
module load nvidia/cuda

# then we compule the .cu file
nvcc task3.cu vscale.cu -Xcompiler -O3 -Xcompiler -Wall -Xptxas -O3 -std=c++17 -o task3



# clear the previous timing files if they exist
> task3_timing.txt
> task3_timing.csv

# run the program with the argument 2^n iterating n over 10 to 29
# and save these results into two files task3_timing.txt and task3_timing.csv

for n in {10..29}; do
    ms=$(./task3 $((2**n)) | head -n 1)
    echo "2^$n: $ms ms" >> task3_timing.txt
    echo "2^$n, $ms" >> task3_timing.csv
done
