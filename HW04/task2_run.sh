#!/usr/bin/env zsh

#SBATCH -p instruction

#SBATCH --job-name=Task2
#SBATCH --error=Task2.err
#SBATCH --output=Task2.out

#SBATCH --mem=16G
#SBATCH --time=0-00:03:00
#SBATCH --ntasks=1 --cpus-per-task=8

# actual script commands
g++ task2.cpp -Wall -O3 -std=c++17 -o task2
./task2 100 5
