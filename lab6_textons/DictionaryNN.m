%% Add necessary functions
addpath('lib')
clear all;close all;clc;
addpath(genpath('textures'));
% Create filter bank
[fb] = fbCreate;

% List images in training set
train=dir(fullfile('textures','train','*.jpg'));
%% Dictionary
% Number of textons in dictionary
k = 90;

% Random images to generate textons
imCat=[];
j=randi([1,60],1,2);
i1=imread(fullfile('textures','train',train(j(1)).name));
i2=imread(fullfile('textures','train',train(j(2)).name));

imCat=horzcat(i2,i1);

tic;
[mapCat,textons] = computeTextons(fbRun(fb,imCat),k);
timeTexDict=toc;
status=strcat('Textons dictionary, time:',num2str(timeTexDict))

%% Dictionary per category

% Read images per category
tic;
cont=0;
for i=1:25
    
    p = randperm(30,20);
    
    for index=1:20        
        cont=cont+1;
        n=p(index);
        img=imread(fullfile('textures','train',train(n+(30*(i-1))).name));
        tmap = assignTextons(fbRun(fb,img),textons');
        [histCat,bins]=hist(tmap(:),k);
        histCatCell=histCat/numel(tmap);
        
        % Assign different distributions for each category
        % 1-textons map
        % 2-histogram of category
        % 3-category label
        textonsDic{cont,1}=tmap;
        textonsDic{cont,2}=histCatCell;
        textonsDic{cont,3}=train(n+(30*(i-1))).name(1:end-7);
        
    end
    
    c = clock;
    Start=datestr(c,'HH:MM:SS');
    status=strcat('Textons for training, time:',Start,{' '},'cat',{' '},train(n+(30*(i-1))).name(1:end-7))
end
time=toc;
timePerCategory=time/25;

save('textonsDictionary.mat','textonsDic','textons','k','fb','timeTexDict','time','timePerCategory');
