addpath('images');
close all;clear all;clc;
im1=imread('8068.jpg');

segmento=segment_by_clustering(im1,'rgb','k-means',4);


figure(1);subimage(im1);
figure(2);image(segmento);colormap colorcube;

clc;
