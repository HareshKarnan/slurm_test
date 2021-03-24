#!/bin/bash

#SBATCH --job-name slurmjob                                        # Job name

### Logging
SBATCH --output=/dev/null                    # Name of stdout output file (%j expands to jobId)
SBATCH --error=/dev/null                        # Name of stderr output file (%j expands to jobId)
SBATCH --mail-user=haresh92@cs.utexas.edu  # Email of notification
SBATCH --mail-type=END,FAIL,REQUEUE

### Node info
SBATCH --partition dgx                         # Queue name - current options are titans and dgx
SBATCH --nodes=1                                                            # Always set to 1 when using the cluster
SBATCH --ntasks-per-node=1                                        # Number of tasks per node
#SBATCH --time 1:00:00                                                     # Run time (hh:mm:ss)

SBATCH --gres=gpu:1                                                       # Number of gpus needed
SBATCH --mem=5G                                                         # Memory requirements
SBATCH --cpus-per-task=8                                              # Number of cpus needed per task


# activate the python environment
#source /scratch/cluster/haresh92/gaifo-so/env/bin/activate
source /scratch/cluster/haresh92/venv/bin/activate

rm -rf /u/pstone/agents6/haresh/gaifo_so/condor_log/*


env_names=("Hopper-v2")

# run the script
for env_name in "${env_names[@]}"
do
  python3.6 slurm_test_script.py \
  --env-name $env_name \
  --log-dir /u/pstone/agents6/haresh/ &

  sleep 0.01
done

wait

echo " ~~~ Experiments Submitted :) ~~"