#!/usr/bin/env zsh

#SBATCH –p instruction

#SBATCH --job-name=FirstSlurm
#SBATCH --error=FirstSlurm.err
#SBATCH --output=FirstSlurm.out

#SBATCH --time=0-00:01:00
#SBATCH --ntasks=1 --cpus-per-task=2

# actual script commands
hostname