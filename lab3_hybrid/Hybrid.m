function Hybrid_image=Hybrid(im1,im2,fcl,fch)

%Creating the cut of that enter as a parameter
f_cut_low=fcl;
f_cut_high=fch;

f_1=fspecial('Gaussian',f_cut_high*3+1,f_cut_high);
f_2=fspecial('Gaussian',f_cut_low*3+1,f_cut_low);

primera=imfilter(im1,f_1);
segunda=im2-imfilter(im2,f_2);%This bowth lines apply the formula to each of the images

Hybrid_image=primera+segunda;%Finl step is to add both image results


end