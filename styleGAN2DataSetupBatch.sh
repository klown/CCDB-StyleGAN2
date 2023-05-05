#!/bin/bash

#SBATCH --job-name=StyleGAN-2
#SBATCH --gres=gpu:1        # request GPU "generic resource"
#SBATCH --cpus-per-task=1   # maximum CPU cores per GPU request: 6 on Cedar, 16 on Graham.
#SBATCH --mem=32000M        # memory per node
#SBATCH --time=0-03:00      # time (DD-HH:MM)
#SBATCH --account=ctb-whkchun
#SBATCH --output=%x-%N-%j.out  # %N for node name, %j for jobID

module load cuda cudnn 

# Set the virtual environment
source ~/BlissStyleGAN/StyleGAN2/tensorflow/bin/activate
export PROTOCOL_BUFFERS_PYTHON_IMPLEMENTATION=python

# Copy the (prepared) data to the SLURM_TMPDIR
echo -n "SLURM temparory directory: "
echo "$SLURM_TMPDIR"
echo
mkdir $SLURM_TMPDIR/blissSingleCharGrey
tar xf ~/BlissStyleGAN/blissSingleCharsGrey.tar -C $SLURM_TMPDIR/blissSingleCharGrey
ls -R $SLURM_TMPDIR/blissSingleCharGrey

OUTPUTDIR=preppedBlissSingleCharGrey
mkdir $OUTPUTDIR
INPUTDIR=$SLURM_TMPDIR/blissSingleCharGrey/blissSingleCharsInGrayscale
python dataset_tool.py create_from_images $OUTPUTDIR $INPUTDIR






