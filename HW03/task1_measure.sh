#!/usr/bin/env zsh

#SBATCH -p instruction

#SBATCH --job-name=Task1Measure
#SBATCH --error=Task1Measure.err
#SBATCH --output=Task1Measure.out

#SBATCH --mem=16G
#SBATCH --time=0-00:01:00
#SBATCH --ntasks=1 --cpus-per-task=20

# actual script commands
g++ task1.cpp matmul.cpp -Wall -O3 -std=c++17 -o task1 -fopenmp

> timing_log.txt
> timing_log.csv

# loop through 1 to 20 threads and run task1 with each value as input
# then collect the time in milliseconds for the thread as the last line 
# of output
> timing_log.txt
> timing_log.csv
for i in {1..20}
do
    time_ms=$(./task1 1024 $i | tail -n 1)
    echo "$i threads: $time_ms ms" >> task1_timing_log.txt
    echo "$i, $time_ms" >> task1_timing_log.csv
done
