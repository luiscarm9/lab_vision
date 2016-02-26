function my_segmentation = segment_by_clustering(rgb_image,feature_space,clustering_method,number_of_clusters)

    narginchk(3,4);
    
    if(nargin==3)
        number_of_clusters=1;
    end
    
    image=rgb_image;
    c=false;
    
    if(strcmpi('rgb',feature_space)==1)
        c=true;
        new_img=image;
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
    
    my_segmentation=new_img;

end


function new=change_feature(img,space)
   tamanio=size(img); 
    if(strcmpi(space,'lab')==1)
      new=rgb2lab(img);  
    elseif(strcmpi(space,'hsv')==1)
       new=rgb2shv(img);  
    elseif(strcmpi(space,'rgb+xy')==1)
        for i=1:tamanio(1)
            for j=1:tamanio(2)
                new=horzcat(img(i,j,1), img(i,j,2), img(i,j,3),i,j);
            end
        end
    elseif(strcmpi(space,'lab+xy')==1)
        img_lab=rgb2lab(img);
        new=vertcat();
        
    elseif(strcmpi(space,'hsv+xy')==1)
        
    end
    

end