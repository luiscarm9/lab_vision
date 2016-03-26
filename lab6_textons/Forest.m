addpath('lib');
clear all;close all;clc;
addpath(genpath('textures'));
% create filter bank
[fb] = fbCreate;
im=[];

directorio=dir(fullfile('textures','train'));
%Construccion de las 50 imagenes
if(exist('textons1.mat')<2 &&exist('map.mat')<2)
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

    i1=imread(strcat(categoria,m,'.jpg'))/255;
    i2=imread(strcat(categoria,p,'.jpg'))/255;

    im=horzcat(im,i1,i2);
end

% numero de textones en diccionario
k = 50;

% diccionario de textones
%figure;imshow(map,[]);colormap(jet);
[map,textons] = computeTextons(fbRun(fb,im),k);
save('map');save('textons');
end

load('textons.mat');
load('map.mat')

directorio=directorio(~ismember({directorio.name},{'.','..'}));
%for i=1:numel(directorio)
if(exist('TData.mat')<2)
TData=[];
mu=ones(1,1);
for i=1:numel(directorio)
  im=double(imread(directorio(i).name))/255;
  t=assignTextons(fbRun(fb,im),textons');
  h=histcounts(t,50);
  a=horzcat(h,mu);
  TData=vertcat(TData,a);

  if(mod(i,30)==0)
    mu=mu+1;
  end

end
save('TData.mat','TData');
end

if(exist('modelo.mat')<2)
load('TData.mat');
features=TData(:,(1:50));
classLabels=TData(:,51);
B = TreeBagger(25,features,classLabels, 'Method', 'classification');
save('modelo.mat','B');
end
%close all;clear all;clc;
load('modelo.mat');load('textons.mat');
directoriot=dir(fullfile('textures','test'));
directoriot=directoriot(~ismember({directoriot.name},{'.','..'}));
pr=[];
%for=1:numel(directorio)
for m=1:numel(directoriot)
  im=double(imread(directoriot(m).name))/255;
  t=assignTextons(fbRun(fb,im),textons');
  t1=histcounts(t,50);
  c=B.predict(t1);

  cate = str2double(c);
  pr(m)=cate;
end

y=ones(10,1);
label=[];
for l=1:25
label=vertcat(label,y);
y=y+1;
end
C_M = confusionmat(label,pr(:));
save('label.mat','label');save('C_Matrix.mat','C_M');
stats=confussionmatStats(label,pr(:));
%credit stats function to http://www.mathworks.com/matlabcentral/fileexchange/46035-confusionmatstats-group-grouphat-/content/confusionmatStats.m
diago=diag(stats.confusionMat);
accuracy=sum(diago)/numel(directoriot);
