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
MDL_CFG=base
CKPT_PATH="/run/determined/workdir/zxy/mamba/models/gen1_base.ckpt"
GPU_ID=0

python RVT/validation.py dataset=gen1 dataset.path=${DATA_DIR} checkpoint=${CKPT_PATH} \
use_test_set=1 hardware.gpus=${GPU_ID} +experiment/gen1="${MDL_CFG}.yaml" \
batch_size.eval=8 model.postprocess.confidence_threshold=0.001