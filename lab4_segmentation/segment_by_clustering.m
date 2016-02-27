function my_segmentation = segment_by_clustering(rgb_image,feature_space,clustering_method,number_of_clusters)

    narginchk(3,4);

    if(nargin==3)
        number_of_clusters=1;
    end

    image=rgb_image;
    c=false;

    if(strcmpi('rgb',feature_space)==1)
        c=true;
        new_img=change_feature(image,feature_space)
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

    img_clus=cluster_m(new_img,clustering_method,number_of_clusters);
    my_segmentation=img_clus;

end


function nueva=change_feature(img,space)
  k=1;
  tamanio=size(img);
      if(strcmpi(space,'lab')==1)
      colorTransform = makecform('srgb2lab');
      aux = applycform(img, colorTransform);
      for i=1:tamanio(1)
          for j=1:tamanio(2)
            new(k,1) = aux(i,j,1);
            new(k,2) = aux(i,j,2);
            new(k,3) = aux(i,j,3);
            k=k+1;
          end

      end
    elseif(strcmpi(space,'rgb')==1)
       aux=img;
       for i=1:tamanio(1)
           for j=1:tamanio(2)
             new(k,1) = aux(i,j,1);
             new(k,2) = aux(i,j,2);
             new(k,3) = aux(i,j,3);
             k=k+1;
           end

       end
    elseif(strcmpi(space,'hsv')==1)
       aux=rgb2hsv(img);
       for i=1:tamanio(1)
           for j=1:tamanio(2)
             new(k,1) = aux(i,j,1);
             new(k,2) = aux(i,j,2);
             new(k,3) = aux(i,j,3);
             k=k+1;
           end

       end
    elseif(strcmpi(space,'rgb+xy')==1)
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
        nueva=new;
end

function clus=cluster_m(img,method,num)

  if(strcmpi(method,'k-means')==1)
    clus=kmeans(img,num);
  elseif(strcmpi(method,'gmm')==1)
    clus=NULL;
  elseif(strcmpi(method,'watershed')==1)
    clus=watershed(img);
  end


end
