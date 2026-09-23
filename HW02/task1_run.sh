#!/usr/bin/env zsh

#SBATCH -p instruction

#SBATCH --job-name=Task1
#SBATCH --error=Task1.err
#SBATCH --output=Task1.out

#SBATCH --time=0-00:01:00
#SBATCH --ntasks=1 --cpus-per-task=1

# actual script commands
g++ scan.cpp task1.cpp -Wall -O3 -std=c++17 -o task1
./task1 $1
