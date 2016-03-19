addpath('lib')
clear all;close all;clc;
addpath(genpath('textures'));
% create filter bank
[fb] = fbCreate;
im=[];

directorio=dir(fullfile('textures','train'));
%Construccion de las 50 imagenes  
for i=1:25
    n=randi([1,30],1,2);
    c=int2str(i);
    
    if(i<10)
    categoria=strcat('T0',c,'_');
    else
    categoria=strcat('T',c,'_');
    end
    
    if(n(1)<10)
     m=int2str(n(1));
     m=strcat('0',m);
    else
     m=int2str(n(1));
    end
    if(n(2)<10)
    p=int2str(n(2));
    p=strcat('0',p);
    else
    p=int2str(n(2));
    end
    
    i1=imread(strcat(categoria,m,'.jpg'));
    i2=imread(strcat(categoria,p,'.jpg'));
    
    im=horzcat(im,i1,i2);
end

% numero de textones en diccionario
k = 50;

% diccionario de textones
%figure;imshow(map,[]);colormap(jet);
[map,textons] = computeTextons(fbRun(fb,im),k);


