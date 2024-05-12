#!/bin/bash

#SBATCH --job-name=train-USVTrack-HybridSORT
#SBATCH --partition=gpu3090 # gpu3090 队列
#SBATCH --qos=8gpus
#SBATCH --nodes=1 # 单节点
#SBATCH --gpus=1 # 1 块 GPU
#SBATCH --cpus-per-task=8       # 1:4 GPU:CPU ratio      
#SBATCH --output=hpc/%j.out
#SBATCH --error=hpc/%j.err
#SBATCH --mail-type=all
#SBATCH --mail-user=shanliang.yao19@student.xjtlu.edu.cn

module load anaconda3
source activate hybridsort39

# Train detection model
# python tools/train.py -f exps/example/mot/yolox_m_dancetrack_test_hybrid_sort.py

# Eval
python tools/eval.py -f exps/example/mot/yolox_m_dancetrack_test_hybrid_sort.py -c YOLOX_outputs/yolox_m_dancetrack_test_hybrid_sort/best_ckpt.pth.tar

# Train re-ID model
# python fast_reid/tools/train_net.py --config-file ./fast_reid/configs/DanceTrack/sbs_S50.yml

# Eval tracking
# python tools/run_hybrid_sort_dance.py --test -f exps/example/mot/yolox_m_dancetrack_test_hybrid_sort.py -b 1 -d 1 --fp16 

# Eval tracking with reid
# python tools/run_hybrid_sort_dance.py --test -f exps/example/mot/yolox_m_dancetrack_test_hybrid_sort_reid.py -b 1 -d 1 --fp16 
