function my_segmentation = segment_by_clustering(rgb_image,feature_space,clustering_method,number_of_clusters)
  % % % % % % % %
  % This function returns a segmented image based on several parameters
  %
  % Example
  %
  % seg=segment_by_clustering(rgb_image,feature_space,clustering_method,number_of_clusters);
  %
  % Where:
  %
  %     rgb_image: Is the input image in RGB
  %
  %     feature_space: The user decide which feaure space to use (RGB,Lab, HSV, RGB+xy,HSV+xy,Lab+xy)
  %
  %     clustering_method: The user select which method of clustering will be used for the segmentation,
  %                        (K-means, Hierarchical, GMM, Watershed)
  %
  %     number_of_clusters: Optional parameter; by default will be one
  %
  %
  % % % % % % % %
    narginchk(3,4);
%verification of number of inputs if k its not given by defaukt wll be one
    if(nargin==3)
        number_of_clusters=1;
    end

    image=rgb_image;
    tam_original=size(image);
%First segment verification of feature space if exists then change feature
    if(strcmpi(clustering_method,'hierarchical')==0)
      c=false;
      tami=size(image);
      if(strcmpi('rgb',feature_space)==1)
          c=true;
          new_img=change_feature(image,feature_space);
      elseif(strcmpi('lab',feature_space)==1)
          c=true;
          new_img=change_feature(image,feature_space);
      elseif(strcmpi('hsv',feature_space)==1)
          c=true;
          new_img=change_feature(image,feature_space);
      elseif(strcmpi('rgb+xy',feature_space)==1)
          c=true;
          new_img=change_feature(image,feature_space);
      elseif(strcmpi('lab+xy',feature_space)==1)
          c=true;
          new_img=change_feature(image,feature_space);
      elseif(strcmpi('hsv+xy',feature_space)==1)
          c=true;
          new_img=change_feature(image,feature_space);
      end

      if(c == false)
          exp=MException('MyComponent:noSuchVariable','No correct feature space');
          throw(exp);
      end
      img_clus=cluster_m(new_img,clustering_method,number_of_clusters,tami);

    else
      c=false;
      tami=size(image);
      if(strcmpi('rgb',feature_space)==1)
          c=true;
          new_img=change_feature2(image,feature_space);
      elseif(strcmpi('lab',feature_space)==1)
          c=true;
          new_img=change_feature2(image,feature_space);
      elseif(strcmpi('hsv',feature_space)==1)
          c=true;
          new_img=change_feature2(image,feature_space);
      elseif(strcmpi('rgb+xy',feature_space)==1)
          c=true;
          new_img=change_feature2(image,feature_space);
      elseif(strcmpi('lab+xy',feature_space)==1)
          c=true;
          new_img=change_feature2(image,feature_space);
      elseif(strcmpi('hsv+xy',feature_space)==1)
          c=true;
          new_img=change_feature2(image,feature_space);
      end

      if(c == false)
          exp=MException('MyComponent:noSuchVariable','No correct feature space');
          throw(exp);
      end
      img_clus=cluster_m(new_img,clustering_method,number_of_clusters,tami);

    end

    img_clus=imresize(img_clus,[tam_original(1),tam_original(2)]);
    my_segmentation=img_clus;

end
%function that given a feature space changes from rgb to feature_space
function nueva=change_feature(img,space)
  k=1;
  tamanio=size(img);
     if(strcmpi(space,'lab')==1)
       img=imresize(img,[300,300])
       tamanio=size(img);
      colorTransform = makecform('srgb2lab');
      aux = applycform(img, colorTransform);
      new=aux;
    elseif(strcmpi(space,'rgb')==1)
      img=imresize(img,[300,300])
      tamanio=size(img);
       aux=img;
       new=aux;
    elseif(strcmpi(space,'hsv')==1)
      img=imresize(img,[300,300])
      tamanio=size(img);
       aux=rgb2hsv(img);
       new=aux;
    elseif(strcmpi(space,'rgb+xy')==1)
      img=imresize(img,[300,300])
      tamanio=size(img);
        aux=img;
        new = zeros(tamanio(1)*tamanio(2),5);
        for i=1:tamanio(1)
            for j=1:tamanio(2)
              new(k,1) = aux(i,j,1);
              new(k,2) = aux(i,j,2);
              new(k,3) = aux(i,j,3);
              new(k,4) = i;
              new(k,5) = j;
              k=k+1;
            end
        end

    elseif(strcmpi(space,'lab+xy')==1)
      img=imresize(img,[300,300])
      tamanio=size(img);
      colorTransform = makecform('srgb2lab');
      aux = applycform(img, colorTransform);
      new = zeros(tamanio(1)*tamanio(2),5);
      for i=1:tamanio(1)
            for j=1:tamanio(2)
              new(k,1) = aux(i,j,1);
              new(k,2) = aux(i,j,2);
              new(k,3) = aux(i,j,3);
              new(k,4) = i;
              new(k,5) = j;
              k=k+1;
            end
        end

    elseif(strcmpi(space,'hsv+xy')==1)
      img=imresize(img,[300,300])
      tamanio=size(img);
      aux=rgb2hsv(img);
      new = zeros(tamanio(1)*tamanio(2),5);
      for i=1:tamanio(1)
          for j=1:tamanio(2)
            new(k,1) = aux(i,j,1);
            new(k,2) = aux(i,j,2);
            new(k,3) = aux(i,j,3);
            new(k,4) = i;
            new(k,5) = j;
            k=k+1;
          end
      end
    end
    tam=size(new);
    if(tam(2)>3)
      new(:,1)=new(:,1)*0.8
      new(:,2)=new(:,1)*0.8
      new(:,3)=new(:,1)*0.8
      new(:,4)=new(:,1)*1
      new(:,5)=new(:,1)*1
    end
  nueva=new;
end
%function that given a feature space changes from rgb to feature_space this
%speacilly created for hierarchical due to the memory needed it reshape the image to a special value [100,100]
function nueva=change_feature2(img,space)
  k=1;
  tamanio=size(img);
     if(strcmpi(space,'lab')==1)
       img=imresize(img,[100,100])
       tamanio=size(img);
      colorTransform = makecform('srgb2lab');
      aux = applycform(img, colorTransform);
      new=aux;
    elseif(strcmpi(space,'rgb')==1)
      img=imresize(img,[100,100])
      tamanio=size(img);
       aux=img;
       new=aux;
    elseif(strcmpi(space,'hsv')==1)
      img=imresize(img,[100,100])
      tamanio=size(img);
       aux=rgb2hsv(img);
       new=aux;
    elseif(strcmpi(space,'rgb+xy')==1)
      img=imresize(img,[100,100])
      tamanio=size(img);
        aux=img;
        new = zeros(tamanio(1)*tamanio(2),5);
        for i=1:tamanio(1)
            for j=1:tamanio(2)
              new(k,1) = aux(i,j,1);
              new(k,2) = aux(i,j,2);
              new(k,3) = aux(i,j,3);
              new(k,4) = i;
              new(k,5) = j;
              k=k+1;
            end
        end

    elseif(strcmpi(space,'lab+xy')==1)
      img=imresize(img,[100,100])
      tamanio=size(img);
      colorTransform = makecform('srgb2lab');
      aux = applycform(img, colorTransform);
      new = zeros(tamanio(1)*tamanio(2),5);
      for i=1:tamanio(1)
            for j=1:tamanio(2)
              new(k,1) = aux(i,j,1);
              new(k,2) = aux(i,j,2);
              new(k,3) = aux(i,j,3);
              new(k,4) = i;
              new(k,5) = j;
              k=k+1;
            end
        end

    elseif(strcmpi(space,'hsv+xy')==1)
      img=imresize(img,[100,100])
      tamanio=size(img);
      aux=rgb2hsv(img);
      new = zeros(tamanio(1)*tamanio(2),5);
      for i=1:tamanio(1)
          for j=1:tamanio(2)
            new(k,1) = aux(i,j,1);
            new(k,2) = aux(i,j,2);
            new(k,3) = aux(i,j,3);
            new(k,4) = i;
            new(k,5) = j;
            k=k+1;
          end
      end
    end
    tam=size(new);
    if(tam(2)>3)
      new(:,1)=new(:,1)*0.8
      new(:,2)=new(:,1)*0.8
      new(:,3)=new(:,1)*0.8
      new(:,4)=new(:,1)*1
      new(:,5)=new(:,1)*1
    end
  nueva=new;
end

%function that is used to cluster by an input cluster_method an image in any feature_space 
function clus=cluster_m(img,method,num,tam)

  if(strcmpi(method,'k-means')==1)
    tami=size(img);
    if numel(tami)>2
      im=double(img(:,:,2:3));
      nfila=size(im,1);
      ncol=size(im,2);
      im=reshape(im,nfila*ncol,2);

      [clustes_ix,cluster_center]=kmeans(im,num,'distance','sqEuclidean')

      clus=reshape(clustes_ix,nfila,ncol);
    else
      im=double(img(:,:,:));
      [clustes_ix,cluster_center]=kmeans(im,num,'distance','sqEuclidean')
      clus=reshape(clustes_ix,tam(2),tam(1));
      clus=flip(clus);
      clus=rot90(clus,-1);
    end


  elseif(strcmpi(method,'gmm')==1)

    tami=size(img);
    if numel(tami)>2
      img1=matriz(img);
      aux=fitgmdist(img1,num,'CovType','diagonal');
      c=cluster(aux,img1);
      clus=reshape(c,[size(img,1),size(img,2)]);
      clus=flip(clus);
      clus=rot90(clus,-1);
    else
      img1=img;
      aux=fitgmdist(img1,num,'CovType','diagonal');
      c=cluster(aux,img1);
      clus=reshape(c,300,300);
      clus=flip(clus);
      clus=rot90(clus,-1);

    end


  elseif(strcmpi(method,'watershed')==1)

    I=rgb2gray(img);
    [Gmag,Gdir] = imgradient(I);    %Image gradient
    marker = imextendedmin(I, number_of_clusters);
    new_grad = imimposemin(Gmag, marker);   %Impose mins to the gradient
    clus=watershed(new_grad)+1;     %watershed segmentation with the h-mnima imposed

  elseif(strcmpi(method,'hierarchical')==1)

    tam=size(img);
    if numel(tam)>2
      img1=matriz(img);
      distancia = pdist(img1,'cityblock');
      union = linkage(distancia,'average');
      c = cluster(union,'maxclust',num);
      clus = reshape(c, [size(img,1),size(img,2)]);
      clus=flip(clus);
      clus=rot90(clus,-1);
    else
      img1=img;
      distancia = pdist(img1,'cityblock');
      union = linkage(distancia,'average');
      c = cluster(union,'maxclust',num);
      clus = reshape(c, [100,100]);
      clus=flip(clus);
      clus=rot90(clus,-1);
    end


  end
end


function mati=matriz(img)
  k=1;
  tamanio=size(img);
  aux=img;
  new = zeros(tamanio(1)*tamanio(2),3);
   for i=1:tamanio(1)
       for j=1:tamanio(2)
         new(k,1) = aux(i,j,1);
         new(k,2) = aux(i,j,2);
         new(k,3) = aux(i,j,3);
         k=k+1;
       end
   end
   mati=new;
end
