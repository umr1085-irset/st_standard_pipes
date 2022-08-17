#!/bin/bash

#SBATCH --job-name="stpipe"
#SBATCH --output=stpipe.out
#SBATCH --mem=50G
#SBATCH --cpus-per-task=16
#SBATCH --partition=sihp # cluster partition to use
#SBATCH --mail-user=<user-email> # user email
#SBATCH --mail-type=ALL # receive emails for all updates
#SBATCH --chdir=<output-dir> # output directory where files will be created

input_dir= # directory with filtered h5 file and spatial directory from 10X Spaceranger output
file_name=.h5 # name of h5 file
output_seurat=.rds # .rds output file. No absolute path required

#--------------------------------------------------------------------------------
# Do not modify below
#--------------------------------------------------------------------------------

# check if script is started via SLURM or bash
# if with SLURM: there variable '$SLURM_JOB_ID' will exist
# `if [ -n $SLURM_JOB_ID ]` checks if $SLURM_JOB_ID is not an empty string
if [ -n $SLURM_JOB_ID ];  then
    # check the original location through scontrol and $SLURM_JOB_ID
    CURRPATH=$(scontrol show job $SLURM_JOBID | awk -F= '/Command=/{print $2}')
else
    # otherwise: started with bash. Get the real location.
    CURRPATH=$(realpath $0)
fi

BASEPATH="${CURRPATH%/*/*}"
SCRIPTPATH="$BASEPATH/SCRIPTS/pipe.R"

. /local/env/envconda.sh # load conda
conda activate /home/genouest/irset/privaud/.conda/envs/seurat4 # activate R environment
Rscript $SCRIPTPATH $input_dir $file_name $output_seurat # launcher pre-pipe script
