#!/usr/bin/env zsh

#SBATCH -p instruction

#SBATCH --job-name=Task3_Measure_1
#SBATCH --error=Task3_Measure_1.err
#SBATCH --output=Task3_Measure_1.out

#SBATCH --mem=16G
#SBATCH --time=0-00:01:00
#SBATCH --ntasks=1 --cpus-per-task=20

# actual script commands
g++ task3.cpp msort.cpp -Wall -O3 -std=c++17 -o task3 -fopenmp

> task3_timing_log_ts.txt
> task3_timing_log_ts.csv

# Run task3 for an n = 10^6, a thread count of 8, and over different threshold values
for ts in {1..10}
do
    time_ms=$(./task3 $((10**6)) 8 $((2**ts)) | tail -n 1)
    echo "2^$ts threashold: $time_ms ms" >> task3_timing_log_ts.txt
    echo "2^$ts, $time_ms" >> task3_timing_log_ts.csv
done
