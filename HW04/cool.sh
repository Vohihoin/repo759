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

for s in static "guided,4" "guided,8"; do
    export OMP_SCHEDULE=$s
    echo $s
    ./task3 1000 100 8 # need to run two times to get accurate measurement, jitt
    ./task3 1000 100 8
done