# sEMG
CNN applied to feature engineered sEMG signal for hand motion clasification.

This repository contains MATLAB scripts and direction to preprocess sEMG data to run on Resnet50 (weights=None) using MATLAB's deep learning tool. Some data are provided including processed data from NinaPro DB4/5 (http://ninaweb.hevs.ch/) and partial data collected from the experiments conducted in the Measurement and Control Engineering Research Center facility at the Idaho State University.

Script files:

preprocess.m : Collects the raw sEMG data from a given path. Extract spatiotemporal features with/without irregular polygon followed by generating a contour map with given axis limit.

normalizeInfo.m : sEMG data from all channels are normalized using the normal distribution.

process2D.m : Same as the preprocess.m without the contour map generation.

meandata.m : Extract the moving average from the given window length.

stddata.m : Extract the moving standard deviation from the given window length.

labeled.m : Apply process2D.m on the sEMG data followed by a contour map with normalized color axis and cropping to an image. The image is stored in a given path corresponding to the desired label.

record_.m : Collect sEMG raw signal from the participant for a single motion.

read_.m : Preprocess the data from record_.m to generate spatiotemporal features as an image and stored them in a given directory.

test_.m : record_.m and read_.m run in sequence to prepare the data for inference followed by prediction using a trained network (the network is built using MATLAB’s Deep Learning application).

timeplay.m : Near real-time experiment using 10 motions selected randomly in sequence from the pool of four hand motions. Each motion is recorded and inferred using the corresponding trained network.

Init.m : Initialize MyoMex armband for MATLAB’s use.

emgNinawork.m : Data formatting compatible with resnet50 for Ninapro data.

**If you need to follow setting up MyoMex armband for the MATLAB please visit: https://github.com/mark-toma/MyoMex


Data files:

train#SF**

Spatiotemporal feature from a single subject applying the internal angle of the irregular polygon to construct an image per motion per experiment. 20 experiments were conducted for each of the four motions. Hence 80 images from a single subject.

train#** 

Moving average-based spatiotemporal feature extracted from a single subject for the four motions. 20 experiments were conducted for each of the four motions. Hence 80 images from a single subject.

data**

Raw MyoMex data for 20 experiments of each of the motions from different subjects.

ImageIMU** (https://drive.google.com/drive/folders/1WriIza_WKlYcw2AlbKXyg3H1dStRqImX?usp=sharing)
Ninapro spatiotemporal feature from ten subjects applying the internal angle of the irregular polygon to construct an image per motion per experiment. Six experiments for each of the 40 motions with IMU data included.

Image** (https://drive.google.com/drive/folders/12YxUa0lrVdOCFBvp85_paylZRSuyP0zu?usp=sharing)
Ninapro spatiotemporal feature from ten subjects applying the internal angle of the irregular polygon to construct an image per motion per experiment. Six experiments for each of the 40 motions with IMU data were excluded.
