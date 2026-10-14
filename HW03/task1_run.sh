#!/usr/bin/env zsh

#SBATCH -p instruction

#SBATCH --job-name=Task1
#SBATCH --error=Task1.err
#SBATCH --output=Task1.out

#SBATCH --mem=8G
#SBATCH --time=0-00:01:00
#SBATCH --ntasks=1 --cpus-per-task=20

# actual script commands
g++ task1.cpp matmul.cpp -Wall -O3 -std=c++17 -o task1 -fopenmp
./task1 $1 $2
