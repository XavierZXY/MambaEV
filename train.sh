#!/bin/bash
# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/home/zxy/miniconda3/bin/conda' 'shell.bash' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/home/zxy/miniconda3/etc/profile.d/conda.sh" ]; then
        . "/home/zxy/miniconda3/etc/profile.d/conda.sh"
    else
        export PATH="/home/zxy/miniconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

# conda activate
conda activate Vit-env

# train config
DATA_DIR="/run/determined/workdir/zxy/mamba/data/gen1"
MDL_CFG=small
GPU_IDS=(0 1)
BATCH_SIZE_PER_GPU=2
TRAIN_WORKERS_PER_GPU=24
EVAL_WORKERS_PER_GPU=24
python RVT/train.py model=rnndet training.max_epochs=100 training.max_steps=1000000 dataset=gen1 dataset.path=${DATA_DIR} wandb.project_name=ssms_event_cameras \
wandb.group_name=gen1 +experiment/gen1="${MDL_CFG}.yaml" hardware.gpus=${GPU_IDS} \
batch_size.train=${BATCH_SIZE_PER_GPU} batch_size.eval=${BATCH_SIZE_PER_GPU} \
hardware.num_workers.train=${TRAIN_WORKERS_PER_GPU} hardware.num_workers.eval=${EVAL_WORKERS_PER_GPU}
