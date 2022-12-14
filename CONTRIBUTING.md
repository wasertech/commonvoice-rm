# Dockerfile for producing romansh model

## Licensing:

This model is available under the terms of the MPL 2.0 (see `LICENSE.txt`).

## Prerequistes:

* Ensure you have a running setup of [`Docker` working with GPU support](https://docs.docker.com/config/containers/resource_constraints/#gpu)
* Prepare a host directory with enough space for training / producing intermediate data (>=400GB).
* Ensure it's writable by `trainer` (uid 999 by default) user (defined in the Dockerfile).
* For Common Voice dataset, please make sure you have downloaded the dataset prior to running (behind email)
  Place `cv-corpus-*-rm` inside your host directory, in a `sources/` subdirectory.

## Build the image:

```
$ docker build [--build-arg ARG=val] -f Dockerfile.train -t commonvoice-rm .
```

Several parameters can be customized:
 - `stt_repo` to fetch STT from a different repo than upstream
 - `stt_branch` to checkout a specific branch / commit
 - `stt_sha1` commit to pull from when installing pre-built binaries
 - `kenlm_repo`, `kenlm_branch` for the same parameters for KenLM
 - `english_compatible` set to 1 if you want the importers to be run in
    "English-compatible mode": this will affect behavior such as english
    alphabet file can be re-used, when doing transfer-learning from English
    checkpoints for example.
 - `lm_evaluate_range`, if non empty, this will perform a LM alpha/beta evaluation
    the parameter is expected to be of the form: `lm_alpha_max`,`lm_beta_max`,`n_trials`.
    See upstream `lm_optimizer.py` for details
 - `lm_add_excluded_max_sec` set to 1 adds excluded sentences that were too long to the language model.

Some parameters for the model itself:
 - `train_batch_size` to specify the batch size for training dataset
 - `dev_batch_size` to specify the batch size for dev dataset
 - `test_batch_size` to specify the batch size for test dataset
 - `epoch` to specify the number of epochs to run training for
 - `learning_rate` to define the learning rate of the network
 - `dropout` to define the dropout applied
 - `lm_alpha`, `lm_beta` to control language model alpha and beta parameters
 - `amp` to enable or disable automatic mixed precision
 - `skip_batch_test` to skip or not batch test completely
 - `duplicate_sentence_count` to control if Common Voice dataset might need
    to be regenerated with more duplicated allowed using Corpora Creator
    **USE WITH CAUTION**
 - `enable_augments` to help the model to better genralise on noisy data by augmenting the data in various ways.
 - `cv_personal_first_url` to download only your own voice instead of all Common Voice dataset (first url)
 - `cv_personal_second_url` to download only your own voice instead of all Common Voice dataset (second url)

Language specific things needs to be under a language directory. Have a look at `rm/` for an example:
 - `importers.sh`: script to run all the importers
 - `metadata.sh`: script exporting variables to define model metadata used at export time
 - `params.sh`: script exporting variables to define dataset-level parameters, e.g.,
                Common Voice release filename, sha256 value, Lingua Libre language
		parameters, etc.
 - `prepare_lm.sh`: prepare text content for producing external scorer. This
                    should produce a `sources_lm.txt` file.

Pay attention to automatic mixed precision: it will speed up the training
process (by itself and because it allows to increase batch size). However,
this is only viable when you are experimenting on hyper-parameters. Proper
selection of best evaluating model seems to vary much more when AMP is enabled
than when it is disabled. So use with caution when tuning parameters and
disable it when making a release.

Default values should provide good experience.

The default batch size has been tested with this mix of dataset:
 - Common Voice Romansh, released on jully 2022 (v10.0)


### Transfer learning from pre-trained checkpoints

To perform transfer learning, please download and make a read-to-use directory
containing the checkpoint to use. Ready-to-use means directly re-usable checkpoints
files, with proper `checkpoint` descriptor as TensorFlow produces.

To use an existing checkpoint, just ensure the `docker run` includes a mount such as:
`type=bind,src=PATH/TO/CHECKPOINTS,dst=/transfer-checkpoint`. Upon running, the checkpoints will be automatically used as starting point.

Checkpoints don't typically use automatic mixed precision nor fully-connected layer normalization and mostly use a standard number of hidden layers (2048 unless specified otherwise). So don't change those parameters to fine-tune from them.

## Hardware

Training successfull on:

> - Threadripper 2920X + 96GB RAM
> - 1x GeForce RTX 3060
> - Manjaro (Arch) Linux, kernel 5.18.17-1-MANJARO, driver 515.65.01

With ~1000h of audio, one training epoch takes ~23min (Automatic Mixed Precision enabled)

## Run the image:

The `mount` option is really important: this is where intermediate files, training, checkpoints as
well as final model files will be produced.

```
$ docker run --it --gpus=all --mount type=bind,src=PATH/TO/HOST/DIRECTORY,dst=/mnt --env TRAIN_BATCH_SIZE=64 commonvoice-rm
```

Training parameters can be changed at runtime as well using environment variables.
