#!/bin/bash

# Copyright (c) 2023, Inclusive Design Institute
#
# Licensed under the BSD 3-Clause License. You may not use this file except
# in compliance with this License.
#
# You may obtain a copy of the BSD 3-Clause License at
# https://github.com/inclusive-design/baby-bliss-bot/blob/main/LICENSE
#
# For use with StyleGAN2-ADA's training tool, `train.py`.  This
# requires that the StyleGAN2-ADA project has been cloned and the environment
# properly set up.  The guide for StyleGAN2-ADA is located at:
# https://towardsdatascience.com/how-to-train-stylegan2-ada-with-custom-dataset-dc268ff70544
# 
# See step 4, Training StyleGAN2-ADA:
# https://towardsdatascience.com/how-to-train-stylegan2-ada-with-custom-dataset-dc268ff70544#689f
#
# Inputs: preppedBlissSinceCharGrey.tar - a tarfile of .tfrecord` files.  The
#         images with are 256x256
# Ouputs: results - a folder for saving the model and sample results

#SBATCH --job-name=StyleGAN-2Training
#SBATCH --gres=gpu:1        # request GPU "generic resource"
#SBATCH --cpus-per-task=4   # maximum CPU cores per GPU request: 6 on Cedar, 16 on Graham.
#SBATCH --mem=32000M        # memory per node
#SBATCH --time=0-01:00      # time (DD-HH:MM)
#SBATCH --account=def-whkchun
#SBATCH --output=%x-%N-%j.out  # %N for node name, %j for jobID

module load nixpkgs/16.09  intel/2018.3  cuda/10.0.130 cudnn/7.5

# Set the virtual environment
source ~/BlissStyleGAN/StyleGAN2/tensorflow/bin/activate

# Copy the (prepared) data to the SLURM_TMPDIR
echo -n "SLURM temparory directory: "
echo "$SLURM_TMPDIR"
echo
mkdir -p $SLURM_TMPDIR/blissTfRecords
tar xf ~/BlissStyleGAN/StyleGAN2/stylegan2-ada/preppedBlissSingleCharGrey.tar -C $SLURM_TMPDIR/blissTfRecords
ls -R $SLURM_TMPDIR/blissTfRecords

# Create a folder for the prepped data and create it.
OUTPUTDIR=./results
mkdir -p $OUTPUTDIR
INPUTDIR=$SLURM_TMPDIR/blissTfRecords/preppedBlissSingleCharGrey
python train.py --outdir $OUTPUTDIR --snap=10 --data $INPUTDIR --augpipe=bgcfnc --res=256






