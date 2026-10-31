#!/usr/bin/env zsh

#SBATCH -p instruction
#SBATCH --job-name=Task3_Measure
#SBATCH --error=Task3_Measure.err
#SBATCH --output=Task3_Measure.out
#SBATCH --mem=16G
#SBATCH --time=0-00:10:00
#SBATCH --ntasks=1 --cpus-per-task=8

g++ task3.cpp -Wall -O3 -std=c++17 -o task3 -fopenmp || exit 1

N=100   # number of particles
T=100    # simulation time

for s in static "dynamic,8" "guided,8"; do

    # e.g. "dynamic,8" -> "dynamic"
    filename="task3_measure_log_${s%%,*}"
    txt_filename="${filename}.txt"
    csv_filename="${filename}.csv"

    export OMP_SCHEDULE="$s"

    # start fresh files
    echo "schedule: $s" > "$txt_filename"
    echo "threads,warmup,run" > "$csv_filename"

    for t in {1..8}; do
        warmup_time=$(./task3 "$N" "$T" "$t" | tail -n 1)
        run_time=$(./task3 "$N" "$T" "$t" | tail -n 1)

        echo "t: $t, warmup: $warmup_time, run: $run_time" >> "$txt_filename"
        echo "$t,$warmup_time,$run_time" >> "$csv_filename"
    done
done
