% % % % % % % %
% This function cretaes severeal segmentations over one image and save all the results as a cell
%Works over all the Dataset
% % % % % % % %

mkdir('RESULT');
addpath(genpath('BSR'));
folder=fullfile('BSR','BSDS500','data','images','test');
directorio=dir(folder);

for i=3:numel(directorio)-1

    imagen=imread(directorio(i).name);
    pos=1;

%How many segmentations ddue to the number of clusters
    for j=5:1:7
        %The user define which method, feature space
        resul=segment_by_clustering(imagen,'lab','k-means',j);
        resul=uint16(resul);
        segs{pos}=resul;
        pos=pos+1;
        name=strsplit(directorio(i).name,'.');
        save(fullfile('RESULT',name{1}),'segs');

    end



end
