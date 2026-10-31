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


N=200 # number of particles
T=100 # simulation time

for s in static "dynamic,8" "guided,8"; do
    echo $s
    export OMP_SCHEDULE=$s
    
    for t in {1..8}; do
        
        echo "t: $t"
        echo "warm-up run"
        ./task3 $N $T 8 # warm-up run
        echo "actual run"
        ./task3 $N $T $t
        echo "--------------------"

    done

done
