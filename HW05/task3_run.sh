#!/usr/bin/env zsh

#SBATCH -p instruction

#SBATCH --job-name=Task3Run
#SBATCH --error=Task3Run.err
#SBATCH --output=Task3Run.out
#SBATCH --mem=16G
#SBATCH --time=0-00:02:00
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:1

# just in case, we load the cuda module for compilation
module load nvidia/cuda

# then we compule the .cu file
nvcc task3.cu vscale.cu -Xcompiler -O3 -Xcompiler -Wall -Xptxas -O3 -std=c++17 -o task3

# and then we run the command
./task3 $1
