#!/usr/bin/env zsh

#SBATCH -p instruction

#SBATCH --job-name=Task3_Measure_2
#SBATCH --error=Task3_Measure_2.err
#SBATCH --output=Task3_Measure_2.out

#SBATCH --mem=16G
#SBATCH --time=0-00:01:15
#SBATCH --ntasks=1 --cpus-per-task=20

# actual script commands
g++ task3.cpp msort.cpp -Wall -O3 -std=c++17 -o task3 -fopenmp

> task3_timing_log_t.txt
> task3_timing_log_t.csv

# Run task3 for an n = 10^6, over different thread counts, a recursive threshold of 2  
# (since we found that it had the best performance from measuring over ts), 
for t in {1..20}
do
    time_ms=$(./task3 $((10**6)) $t 2 | tail -n 1)
    echo "$t threads: $time_ms ms" >> task3_timing_log_t.txt
    echo "$t, $time_ms" >> task3_timing_log_t.csv
done
