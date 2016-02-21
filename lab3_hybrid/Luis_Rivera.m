%This code creates Hybrid Images
%Preparation code
clc;clear all;close all;

%Loading the images
im1=imread('einstein.bmp');%Image with higher importance[eye]
im2=imread('marilyn.bmp');%Image to be in the front side [flower]

%Using the function that will work for any pair of images, the 3 and for
%parameter represent the cut of each filter.
total=Hybrid(im1,im2,7,4);

%Will dispaly the image result as a pyramyd
piramide=vis_hybrid_image(total);
imshow(piramide);