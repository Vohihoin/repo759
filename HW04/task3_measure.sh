#!/usr/bin/env zsh

#SBATCH -p instruction

#SBATCH --job-name=Task3_Measure
#SBATCH --error=Task3_Measure.err
#SBATCH --output=Task3_Measure.out

#SBATCH --mem=16G
#SBATCH --time=0-00:01:00
#SBATCH --ntasks=1 --cpus-per-task=8

# actual script commands
g++ task3.cpp -Wall -O3 -std=c++17 -o task3 -fopenmp


N=1000 # number of particles
T=100 # simulation time

# > task3_measure_log_static.txt
# > task3_measure_log_static.csv
# > task3_measure_log_dynamic.txt
# > task3_measure_log_dynamic.csv
# > task3_measure_log_guided.txt
# > task3_measure_log_guided.csv

filename=""
csv_filename=""
txt_filename=""

for s in static "dynamic,8" "guided,8"; do
    
    # Pick filename based on schedule type

    if [[$s == "static"]]; then
        filename = "task3_measure_log_static"
    elif [[ $s == "dynamic,8" ]]; then
        filename = "task3_measure_log_dynamic"
    elif [[ $s == "guided,8" ]]; then
        filename = "task3_measure_log_guided"
    fi

    # create the file names
    txt_filename="${filename}.txt"
    csv_filename="${filename}.csv"

    # clear the files
    > $txt_filename
    > $csv_filename

    # export the OMP schedule we want for this loop iteration
    export OMP_SCHEDULE=$s

    # write the schedule type to the text file
    echo $s > $txt_filename
    
    for t in {1..8}; do
        
        warmup_time = $(./task3 $N $T $t | tail -n 1)
        run_time = $(./task3 $N $T $t | tail -n 1)
        
        echo "t: $t, warmup: $warmup_time, run: $run_time" >> $txt_filename
        echo "$t,$warmup_time,$run_time" >> $csv_filename

    done

done

cp Task3_Measure.out task3_measurements.txt
