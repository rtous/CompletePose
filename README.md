# CompletePose. Human pose completion in partial body camera shots

## 1. Introduction

This repository contains the code related to the paper ["Human pose completion in partial body camera shots"](https://upcommons.upc.edu/bitstream/handle/2117/394207/main.pdf;jsessionid=F7BEA81F9053C26DE28BE39BCAD8FAF5?sequence=1)

## 2. Acknowledgements

If you find this repository useful for your research, please cite the original publication:
```
   @article{Tous28072023},
      author = {Ruben Tous, Jordi Nin and Laura Igual},
      title = {Human pose completion in partial body camera shots},
      journal = {Journal of Experimental \& Theoretical Artificial Intelligence},
      volume = {0},
      number = {0},
      pages = {1--11},
      year = {2023},
      publisher = {Taylor \& Francis},
      doi = {10.1080/0952813X.2023.2241575},
      URL = { https://doi.org/10.1080/0952813X.2023.2241575}
   }
```

## 3. Setup dependencies
```
git clone https://github.com/rtous/partial2D.git
cd partial2D

python3.11 -m venv myvenv
source myvenv/bin/activate

pip install torch==2.3.1 torchvision==0.18.1
pip install matplotlib==3.9.2
pip install opencv-python==3.4.17.61
pip install numpy==1.26.0
pip install tensorboard==2.18.0
pip install cdflib==1.3.2
pip install scipy==1.14.1
```
## 4. Dataset

### 4.1 H36M (training dataset and used for quantitative evaluation)

Download and decompress H36M 2D poses:

   - Request access to https://vision.imar.ro/human3.6m
   - Download by subject (for all of them): Poses_D2_Positions
   - Decompress the files into a data/H36M/2D folder (asuming you're in the repo's root)
```
      mkdir -p data/H36M/2D
      mv $HOME/Downloads/Poses* data/H36M/2D
      tar -xvf data/H36M/2D/Poses_D2_Positions_S1.tgz -C data/H36M/2D
      tar -xvf data/H36M/2D/Poses_D2_Positions_S5.tgz -C data/H36M/2D
      tar -xvf data/H36M/2D/Poses_D2_Positions_S6.tgz -C data/H36M/2D
      tar -xvf data/H36M/2D/Poses_D2_Positions_S7.tgz -C data/H36M/2D
      tar -xvf data/H36M/2D/Poses_D2_Positions_S8.tgz -C data/H36M/2D
      tar -xvf data/H36M/2D/Poses_D2_Positions_S9.tgz -C data/H36M/2D
      tar -xvf data/H36M/2D/Poses_D2_Positions_S11.tgz -C data/H36M/2D
      rm data/H36M/2D/*.tgz
```

### 4.2 CHARADE (test dataset for qualitative evaluation)

```
      mkdir -p data/CHARADE/keypoints
      wget https://github.com/rtous/charade/raw/refs/heads/main/keypointsOpenPose.zip
      unzip keypointsOpenPose.zip -d data/CHARADE/keypoints  
      rm keypointsOpenPose.zip
      mkdir -p data/CHARADE/images
      wget https://github.com/rtous/charade/raw/refs/heads/main/images.zip
      unzip images.zip -d data/CHARADE/images  
      rm images.zip
```

## 5. Test inference

Generate a test dataset:
```
   ./datasetH36M_makelite.sh
```

Test with frozen keypoints (CGAN):

```
   ./inference.sh conf_CGAN.sh confDataset_H36M.sh 0 1
   ./FPD.sh conf_CGAN.sh confDataset_H36M.sh 0
```
NOTE: Visual results can be seen in data/output/CGAN_H36M/CHARADE/images and data/output/CGAN_H36M/TEST/images.

Test with frozen keypoints (DAE):

```
   ./inference.sh conf_DAE.sh confDataset_H36M.sh 0 1
   ./FPD.sh conf_DAE.sh confDataset_H36M.sh 0
```

## 6. Train

Train and eval (CGAN):
```
   ./train.sh conf_CGAN.sh confDataset_H36M.sh 0 
   ./inference.sh conf_CGAN.sh confDataset_H36M.sh 0 0
   ./FPD.sh conf_CGAN.sh confDataset_H36M.sh 0
```
NOTE: Before inference the exact checkpoint need to be specified in conf_CGAN.sh.

NOTE: Visual debug results can be seen during training in data/output/CGAN_H36M (debug_input_cropped.jpg and debug_output.jpg).

Train and eval (DAE):
```
   ./train.sh conf_DAE.sh confDataset_H36M.sh 0 
   ./inference.sh conf_DAE.sh confDataset_H36M.sh 0 0
   ./FPD.sh conf_DAE.sh confDataset_H36M.sh 0
```

With other models can be tested just changing conf_CGAN.sh for the proper script:

- conf_AE.sh (autoencoder)
- conf_VAE.sh (variational autoencoder)
- conf_WGAN.sh (wasserstein GAN)
- conf_CVAE.sh (conditional variational autoencoder)

## 7. Monitoring training

tensorboard --logdir runs

http://localhost:6006/
