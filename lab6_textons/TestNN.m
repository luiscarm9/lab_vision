clear all;clc;
addpath('lib');
c = clock;
Start=datestr(c,'HH:MM:SS')

%% Load dictionary of categories and textons
load('textonsDictionary.mat');
testfolder='test'; %testing folder name

test=dir(fullfile('textures',testfolder,'*.jpg')); % Testing folder

label=[];
tic;
for i=1:numel(test)
    
    newIm=(imread(fullfile('textures',testfolder,test(i).name)));
    tmap = assignTextons(fbRun(fb,newIm),textons');
    
    % Asign distribution of textons for image
    [newHist,bins]=hist(tmap(:),k);
    newHist=newHist/numel(tmap);

    [a,b]=size(textonsDic);
    distChi2=zeros(a,1);
    distHI=zeros(a,1);
    
    % Assign distance of distribution for each category
    for j=1:a
        
        distChi2(j)=chi_square_statistics(newHist,textonsDic{j,2});
        distHI(j)=histogram_intersection(newHist,textonsDic{j,2});
    end
    
    % Find minimun difference between income histogram and histogram
    % dictionary
    posChi=find(distChi2==min(distChi2));
    posHI=find(distHI==min(distHI));
    
    % Assign label to the minimum position
    label{i,2}=textonsDic{posChi,3};
    label{i,3}=textonsDic{posHI,3};
    label{i,1}=test(i).name;
    
    ground{i}=test(i).name(1:end-7);
    resultChi2{i}=textonsDic{posChi,3};
    resultHI{i}=textonsDic{posHI,3};    

    strcat(test(i).name,{' '},'corresponds to',{' '}, label{i,2},{' '},'category')
end
time=toc
timePerImage=time/numel(test)

%% Confusion matrix
chi2ConfMat = confusionmat(ground,resultChi2);
ACA_chi = trace(chi2ConfMat);
ACA_chi=ACA_chi/numel(test)

HIConfMat=confusionmat(ground,resultHI);
ACA_HI=trace(HIConfMat);
ACA_HI=ACA_HI/numel(test)

save('testPredictions.mat','label','ground','resultChi2','resultHI',...
    'time','timePerImage','chi2ConfMat','HIConfMat','ACA_chi','ACA_HI');