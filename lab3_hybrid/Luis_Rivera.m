%This code creates Hybrid Images
%Preparation code
clc;clear all;close all;

%Loading the images
im1=imread('einstein.bmp');%Image with higher importance[eye]
im2=imread('marilyn.bmp');%Image to be in the front side [flower]

%Using the function that will work for any pair of images, the 3 and for
%parameter represent the cut of each filter.
f_cut_low=5;
f_cut_high=10;

f_1=fspecial('Gaussian',f_cut_high*3+1,f_cut_high);%Low pass filter
f_2=fspecial('Gaussian',f_cut_low*3+1,f_cut_low);%High pass filter

primera=imfilter(im1,f_1);
segunda=im2-imfilter(im2,f_2);%This bowth lines apply the formula to each of the images

total=primera+segunda;%Finl step is to add both image results

%%Using fft
figure(1);
subplot(2,5,1);imshow(fft2(im1));title('Original_1');
subplot(2,5,2);imshow(fft2(im2));title('Original_2');
subplot(2,5,3);imshow(fft2(f_1));title('Filter');
subplot(2,5,4);imshow(fft2(im1-imfilter(im1,f_1)));title('Filtred_1');
subplot(2,5,5);imshow(fft2(im2-imfilter(im2,f_1)));title('Filtred_2');

%%Using dct2
im11=rgb2gray(im1);im22=rgb2gray(im2);
subplot(2,5,6);imshow(dct2(im11));title('Original_1');
subplot(2,5,7);imshow(dct2(im22));title('Original_2');
subplot(2,5,8);imshow(dct2(f_1));title('Filter');
subplot(2,5,9);imshow(dct2(im11-imfilter(im11,f_1)));title('Filtred_1');
subplot(2,5,10);imshow(dct2(im22-imfilter(im22,f_1)));title('Filtred_2');
clc;
pause;


%Will dispaly the image result as a pyramyd
piramide=vis_hybrid_image(total);
figure(2);
imshow(piramide);
