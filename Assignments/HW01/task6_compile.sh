#!/usr/bin/env zsh

#SBATCH -p instruction

#SBATCH --job-name=Task6
#SBATCH --error=Task6.err
#SBATCH --output=Task6.out

#SBATCH --time=0-00:01:00
#SBATCH --ntasks=1 --cpus-per-task=1

# actual script commands
g++ task6.cpp -Wall -O3 -std=c++17 -o task6
./task6 $1
./task6 6
rm ./task6
