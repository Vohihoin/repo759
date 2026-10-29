#!/usr/bin/env zsh

#SBATCH -p instruction

#SBATCH --job-name=Task3
#SBATCH --error=Task3.err
#SBATCH --output=Task3.out

#SBATCH --mem=16G
#SBATCH --time=0-00:04:00
#SBATCH --ntasks=1 --cpus-per-task=8

# actual script commands
g++ task3.cpp -Wall -O3 -std=c++17 -o task3 -fopenmp
./task3 100 5 8
