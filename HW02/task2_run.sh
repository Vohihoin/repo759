#!/usr/bin/env zsh

#SBATCH -p instruction

#SBATCH --job-name=Task2
#SBATCH --error=Task2.err
#SBATCH --output=Task2.out

#SBATCH --time=0-00:01:30
#SBATCH --ntasks=1 --cpus-per-task=1

# actual script commands
g++ convolution.cpp task2.cpp -Wall -O3 -std=c++17 -o task2
./task2 $1 $2
