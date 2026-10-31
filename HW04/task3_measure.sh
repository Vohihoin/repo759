#!/usr/bin/env zsh

#SBATCH -p instruction

#SBATCH --job-name=Task3_Measure
#SBATCH --error=Task3_Measure.err
#SBATCH --output=Task3_Measure.out

#SBATCH --mem=16G
#SBATCH --time=0-00:30:00
#SBATCH --ntasks=1 --cpus-per-task=8

# actual script commands
g++ task3.cpp -Wall -O3 -std=c++17 -o task3 -fopenmp


N=1000 # number of particles
T=100 # simulation time

for s in static dynamic "guided,8"; do
    export OMP_SCHEDULE=$s
    echo $s
    ./task3 1000 100 8
    ./task3 1000 100 8
done