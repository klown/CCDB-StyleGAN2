# StyleGAN2-ADA Table of Contents

Contents of this directory:

- `pytorch-ada-results`
  - This contains the results of training the GAN, including the model (`.pkl`)
  files, the fake images, and other data about the training runs.  Training was
  not done in one continuous run, but over five separate runs.  The beginning of
  each run was initiated based on the latest model of the previous run.  Thus,
  they are effectively a single run.
  - The results of each run are stored within sub-directories whose name begins
  with a six digit sequence number.  For example, the first run results are in
  `00000-preppedBlissSingleCharGrey-auto1` and the last results in
  `00004-preppedBlissSingleCharGrey-auto1-resumecustom`. Thus, the last model
  from the last run is
  `00004-preppedBlissSingleCharGrey-auto1-resumecustom/network-snapshot-000880.
  pkl`.
  - Note that within each run, a model file was periodically saved &ndash; there
  are a series of models within each subdirectory.
- `preppedBliss4Pytorch.tar`
  - a tar file of the original images of single character Bliss symbols used for
  training.
- `baby-bliss-bot`
 - As of 16-June-2023:  A clone of the `feat/stylegan2-ada` branch of the
 baby-bliss-bot github project containing the shell scripts used for setup,
 image preparation and training.
 [StyleGAN2-ADATraining.md](https://github.com/klown/baby-bliss-bot/blob/feat/stylegan2-ada/docs/StyleGAN2-ADATraining.md) documents this in greater detail.
- `stylegan2-ada-pytorch`
 - A clone of the [StyleGAN2-ADA PyTorch](https://github.com/NVlabs/stylegan2-ada-pytorch) github repository used for data
 preparation and training.
 - Note: one change to the `generate.py` script was needed to handle the grey
 scale images of the Bliss symbols, as noted in the
 [StyleGAN2-ADATraining.md](https://github.com/klown/baby-bliss-bot/blob/feat/stylegan2-ada/docs/StyleGAN2-ADATraining.md#set-up-on-compute-canada-clusters)
 documentation.
- `pytorch-ada-generate`
  - Attempts at using a model to generate new images.  The model used was the
  latest of the third training run: `network-snapshot-001640.pkl` in the
  `00002-preppedBlissSingleCharGrey-auto1-resumecustom` sub-directory.
