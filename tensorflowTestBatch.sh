#!/bin/bash

#SBATCH --job-name=tensorflowTest
#SBATCH --gres=gpu:1        # request GPU "generic resource"
#SBATCH --cpus-per-task=6   # maximum CPU cores per GPU request: 6 on Cedar, 16 on Graham.
#SBATCH --mem=32000M        # memory per node
#SBATCH --time=0-03:00      # time (DD-HH:MM)
#SBATCH --account=ctb-whkchun
#SBATCH --output=%x-%N-%j.out  # %N for node name, %j for jobID

module load cuda cudnn 

echo "Check python version BEFORE activating virtual environment:"
python --version

source ~/BlissStyleGAN/StyleGAN2/tensorflow/bin/activate
echo "Check python version AFTER activating virtual environment:"
python --version

export PROTOCOL_BUFFERS_PYTHON_IMPLEMENTATION=python
srun python ./tensorflowTest.py

