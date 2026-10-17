#!/usr/bin/env zsh

#SBATCH -p instruction

#SBATCH --job-name=Task2
#SBATCH --error=Task2.err
#SBATCH --output=Task2.out

#SBATCH --mem=16G
#SBATCH --time=0-00:01:00
#SBATCH --ntasks=1 --cpus-per-task=20

# actual script commands
g++ task2.cpp convolution.cpp -Wall -O3 -std=c++17 -o task2 -fopenmp
./task2 $1 $2
