#!/usr/bin/env zsh

#SBATCH -p instruction

#SBATCH --job-name=Task2Run
#SBATCH --error=Task2Run.err
#SBATCH --output=Task2Run.out
#SBATCH --mem=16G
#SBATCH --time=0-00:01:00
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:1

# just in case, we load the cuda module for compilation
module load nvidia/cuda

# then we compule the .cu file
nvcc task2.cu -Xcompiler -O3 -Xcompiler -Wall -Xptxas -O3 -std=c++17 -o task2

# and then we run the command
./task2
