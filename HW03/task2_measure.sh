#!/usr/bin/env zsh

#SBATCH -p instruction

#SBATCH --job-name=Task2_Measure
#SBATCH --error=Task2_Measure.err
#SBATCH --output=Task2_Measure.out

#SBATCH --mem=16G
#SBATCH --time=0-00:01:00
#SBATCH --ntasks=1 --cpus-per-task=20

# actual script commands
g++ task2.cpp convolution.cpp -Wall -O3 -std=c++17 -o task2 -fopenmp

# Run task2 for an n = 1024, over different thread counts
for t in {1..20}
do
    time_ms=$(./task2 1024 $t | tail -n 1)
    echo "$i threads: $time_ms ms" >> task2_timing_log.txt
    echo "$i, $time_ms" >> task2_timing_log.csv
done
