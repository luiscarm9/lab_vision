function res=train_net(net,test_data)


  test_data = im2single(test_data) ;
  %resultados = cell(1,size(test_data,3)) ;
  %scores = cell(1,size(test_data,3)) ;


  %best = zeros(1,size(test_data,3)) ;
  %bestS = zeros(1,size(test_data,3)) ;

  for i=1:size(test_data,3)

  resultados = vl_simplenn(net, test_data(:,:,i)) ;
  scores = squeeze(gather(resultados(end).x)) ;
  %Obtain the best label based on the highest score
  scores=scores(:);
  [bestS(i),best(i)] = max(scores) ;
  clc;
  end

  

end
