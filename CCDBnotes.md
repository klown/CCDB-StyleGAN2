# Using Digital Research Alliance of Canada Computer Cluster (CCDB) with Tensorflow
## Tutorial
The following are summary notes based on the full [CCDB tutorial](https://docs.alliancecan.ca/wiki/Tutoriel_Apprentissage_machine/en).

- [**Avoid Anaconda**](https://docs.alliancecan.ca/wiki/AI_and_Machine_Learning#Avoid_Anaconda)
  - Use `virtualenv` command line command instead, but not before installing the version of python required for the project.  See step 3 below.
  - More information about [why Anaconda is to be avoided](https://docs.alliancecan.ca/wiki/Anaconda/en).
- Step 2 [Archiving a data set](https://docs.alliancecan.ca/wiki/Tutoriel_Apprentissage_machine/en#Step_2:_Archiving_a_data_set)
  - Do not submit the job with a data set of many invidual files.  Instead save those files into one tar archive
    - Example of creating a tar file, `$ tar cf dataset.tar ~/dataset/*`
- Step 3 [Preparing your virtual environment](https://docs.alliancecan.ca/wiki/Tutoriel_Apprentissage_machine/en)
  - [Loading an intperpreter](https://docs.alliancecan.ca/wiki/Python#Loading_an_interpreter), aka Python
     - use the `module` command to find and load the version of python desired.
       - to show all available versions of python:   `$ module avail python`
       - to load a specific version of python: `$ module load python/3.7.9`
       - to remove a module:  `$ module unload python/3.7.9`
       - for more info:  `$ module --help`
       - for even more info, see the [Using Modules](https://docs.alliancecan.ca/wiki/Utiliser_des_modules/en) wiki page.
  - Use the `module` command to load other modules that are needed.
    - E.g., load the entire SciPy package:  `$ module load scipy-pack`
  - After all modules have been loaded, use `virtualenv` to create the virtual environment, instantiate it, and install/upgrade pip:

      ```
      $ virtualenv --no-download ENV
      $ source ENV/bin/activate
      $ pip install --no-index --upgrade pip
      ```
  - Use pip to intall other packages, such a `Numpy`.
     - Note that if `module load scipy-stack` was done above, `Numpy` is already installed.
     - If the `Scipy` stack was not loaded, and `Numpy` is still needed, run `pip install numpy`).
    - Strongly recommend using pip's `--no-index` flag to avoid loading the package from a global repository and to use CCDB's local package repository instead.  See [Available wheels](https://docs.alliancecan.ca/wiki/Python#Available_wheels) for information about packages and libraries that are available from CCDB.
    - Also, it is possible to use `pip` to install packages from inside a batch job script provided that:
      - the job can run on one node, and
      - there is a `requirements.txt` for the pip installed packages
      - Here's how: from the login node in an interactive shell, run the `module load`, `virtual env`, and `pip` installations as above and then create a `requirements.txt` from that.  After the `requirements.txt` is created, remove the temporary environment folder.  For example:

            ```
            $ module load python/3.10
            $ ENVDIR=/tmp/$RANDOM
            $ virtualenv --no-download $ENVDIR
            $ source $ENVDIR/bin/activate
            $ pip install --no-index --upgrade pip
            $ pip install --no-index tensorflow
            $ pip freeze --local > requirements.txt
            $ deactivate
            $ rm -rf $ENVDIR
            ```
      - then use the resulting `requirements.txt` in the SLURM batch script.  The script repeats the `module load` and `virtual env` steps, but then uses `pip install --no-index -r requirements.txt` to install the packages:

    - [Tensorflow](https://docs.alliancecan.ca/wiki/Python#Installing_dependent_packages)
      - [TensorFlow 1.x setup](https://docs.alliancecan.ca/wiki/TensorFlow#Installing_TensorFlow)
        - The setup is interactively loading the tensorflow1.x environment module from `StdEnv/2018` and the python 3 module, and then using pip to install tensorflow_gpu version 1.15.0.  This creates a `tensorflow` virtual environment in the directory `tensorflow`:

          ```
          $ module load StdEnv/2018 python/3
          $ virtualenv --no-download tensorflow
          $ source tensorflow/bin/activate
          $ pip install --no-index --upgrade pip
          $ pip install --no-index tensorflow_gpu==1.15.0
          ```
      - It is possible to reference a `tensorflow` virtual environment built inside a user's login-node from within a batch script by using the `~` (tilde) to reference the user's home directory.  For example:

            ```
            ...
            source ~/BlissStyleGAN/StyleGAN2/tensorflow/bin/activate
            ...
            ```
      - Note: the last line in the batch script is typically a call to `python` to execute some AI-related python script.  However, do not call `python` directly, but use `srun python ...` instead.
      - A full batch script is as follows is available in `tensorFlowTestBatch.sh`. and assumes the `tensorflow` virtuual environment folder has been built as described above and that it is situated in `~/BlissStyleGAN/StyleGAN2/tensorflow/`
      - The output from the batch script is found in a file named something like `tensorflowTest-cdr2678-66275923.out`.  The `cdr-2678` is the node on which the script ran and the `66275923` is the batch job id.  Both change every time the script is run.
- Step 4 [Interactive Job](https://docs.alliancecan.ca/wiki/Tutoriel_Apprentissage_machine/en#Step_4:_Interactive_job_(salloc))
  - Use `salloc` as shown below. Note that `<def-someuser>` is either "def-whkchun" or "cpt-whkchun" for us.  When this is executed, there are a number of message indicating that the job and its resources are being allocate -- it takes a few seconds:

      ```
      salloc --account=<def-someuser> --gres=gpu:1 --cpus-per-task=3 --mem=32000M --time=1:00:00
     ```
  - The `salloc` command takes an optional command to run.  If a command is given, then `salloc` will exit as soon as that command is completed.  Here is an example that prints the path to the SLURM_TMPDIR:

        ```
        salloc ... srun echo "Hi"
        ```
  - With no command given, once the interactive session's resources have been allocated, then anything `srun` at the bash prompt is actually executed in the cluster, and not in the local login-node.  To exit the interactive session, use `scancel <jobId>`
  - More information about `salloc` (and related SLURM commands) can be found in [Sheffield HPC Documentation](https://docs.hpc.shef.ac.uk/en/latest/referenceinfo/scheduler/SLURM/Common-commands/salloc.html).
 