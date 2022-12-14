# Processing Spatial Transcriptomics pipelines

This repository encapsulates a pipeline and its launch script. Please read the section on how to launch the script

## Processing pipeline
* Input: 10X standard output for Spatial Trancriptomics
* Steps:
	* Load input H5 matrix

## Use launch scripts
The launch scripts are to be used with `Slurm's sbatch` command on a server. Each script has Slurm options that can modified:

```
#SBATCH --job-name="pre_pipe"
#SBATCH --output=pre_pipe.out
#SBATCH --mem=500G
#SBATCH --cpus-per-task=16
#SBATCH --partition=sihp
#SBATCH --mail-user=<user-email>
#SBATCH --mail-type=ALL
#SBATCH --chdir=<output-dir>
```
* `job-name`: Name of Slurm job 
* `output`: Name of log file
* `mem`: Assigned memory (nust end with a `G` character)
* `cpus-per-task`: Number of assigned cps
* `partition`: cluster partition
* `mail-user`: user email for notification purposes
* `mail-type`: type of notifications (leave it set to `ALL`)
* `chdir`: Output directory where files will be saved

Users have to reference the pipeline input and output files directly in the launch scripts. The pipeline scripts should NOT be modified in that regard.

To launch a script:
```
sbatch pre_pipe_launcher.sh
```
