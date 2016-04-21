imdb = load('textonsdb.mat') ;
imdb.images.data = im2single(imdb.images.data) ;
train_index = find(mod(0:length(imdb.images.id)-1,2) < 1) ;
val_index = setdiff(1:length(imdb.images.id),train_index) ;
imdb.images.set(1,val_index)=2;

net=load('textures_jitter.mat');


results_train = train_net(net,imdb.images.data(:,:,train_index)) ;
results_train_anot = imdb.images.label(train_index) ;

results_test = train_net(net,imdb.images.data(:,:,val_index)) ;
results_test_anot = imdb.images.label(val_index) ;

save('results_train_anot');
save('results_train');
save('results_test_anot');
save('results_test');


