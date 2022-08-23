# Copyright (c) Facebook, Inc. and its affiliates.
# 
# This source code is licensed under the MIT license found in the
# LICENSE file in the root directory of this source tree.


#!/bin/bash

MODEL=MinkUNet

python3 ddp_train.py \
    net.model=$MODEL \
    net.conv1_kernel_size=4 \
    net.model_n_out=96 \
    opt.lr=0.1 \
    opt.max_iter=100000 \
    data.dataset=ScanNetMatchPairDataset \
    data.voxel_size=0.05\
    data.voxelize=True \
    data.scannet_match_dir=$DATASET \
    data.world_space=True \
    trainer.trainer=PartitionPointNCELossTrainer \
    trainer.batch_size=2 \
    trainer.stat_freq=5 \
    trainer.checkpoint_freq=1000 \
    trainer.lr_update_freq=1000 \
    shape_context.r1=2.0 \
    shape_context.r2=20.0 \
    shape_context.nbins_xy=2 \
    shape_context.nbins_zy=2 \
    shape_context.weight_inner=False \
    shape_context.fast_partition=True \
    misc.num_gpus=1 \
    misc.train_num_thread=0 \
    misc.npos=4096 \
    misc.nceT=0.4 \
    misc.out_dir=${OUT_DIR} \
    hydra.launcher.partition=priority \
    hydra.launcher.timeout_min=3600 \
    hydra.launcher.max_num_timeout=5 \
    hydra.launcher.comment=criticalExp \
