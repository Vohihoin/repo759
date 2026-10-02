#!/usr/bin/env zsh

#SBATCH -p instruction

#SBATCH --job-name=Scaling_Analysis
#SBATCH --error=Scaling_Analysis.err
#SBATCH --output=Scaling_Analysis.out

#SBATCH --time=0-00:01:00
#SBATCH --mem=8G
#SBATCH --ntasks=1 --cpus-per-task=1

# actual script commands
g++ scan.cpp task1.cpp -Wall -O3 -std=c++17 -o task1

# loop through 2^10 to 2^30 and run task1 with each value as input
# then extract the first line of output as the time in milliseconds and log it
> timing_log.txt
> timing_log.csv
for i in {10..30}
do
    time_ms=$(./task1 $((2**i)) | head -n 1)
    echo "2^$i: $time_ms ms" >> timing_log.txt
    echo "2^$i, $time_ms" >> timing_log.csv
done

echo "Measurement complete."
