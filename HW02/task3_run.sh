#!/usr/bin/env zsh

#SBATCH -p instruction

#SBATCH --job-name=Task3
#SBATCH --error=Task3.err
#SBATCH --output=Task3.out

#SBATCH --time=0-00:01:00
#SBATCH --ntasks=1 --cpus-per-task=2

# actual script commands
g++ matmul.cpp task3.cpp -Wall -O3 -std=c++17 -o task3
./task3