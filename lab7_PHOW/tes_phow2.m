function test_phow()

file2 = fopen('test2.txt','w');

run('vlfeat-0.9.20/toolbox/vl_setup');
testDir='/datos1/vision/imagenet_small/test/';
addpath(genpath('/datos1/vision/imagenet_small/'));
categorias=dir(testDir);
categorias=categorias(~ismember({categorias.name},{'.','..'}));
%pre=[];anot=[];
%count=1;
for m=2:10:242
  tic;
count=1;
  mn=strcat('baseline-model',int2str(m),'.mat');
  load(mn);
  for c=1:numel(model.classes)
  %for c=1:1
    ca=categorias(c).name;
    imagenes = dir(fullfile(testDir,ca));
    imagenes=imagenes(~ismember({imagenes.name},{'.','..'}));
    for i=1:numel(imagenes)
    %for i=1:1
      im=imread(imagenes(i).name);
      label=model.classify(model,im);
      label=cellstr(label);
      ca=cellstr(ca);
      pre(count)=label;
      anot(count)=ca;
      count=count+1;
    end
  end
  toc;
estad=confusionmat(pre(:),anot(:));
diago=diag(estad);
accuracy=sum(diago)/numel(pre(:));
fprintf(file2,'%d %.3f %.3f\n',m,accuracy,toc);

end
 mat=estad.confusionMat;
  save('confu','mat');
end
