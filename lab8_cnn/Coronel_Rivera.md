# Final Report laboratory 8: Convolutional Neural Networks

Javier Coronel, Luis Carlos Rivera.

## 1. Architecture

The proposed architecture of our networks is the following presented using the following command:
 ```matlab
   vl_simplenn_display(network)
```
![Architecture](https://raw.githubusercontent.com/luiscarm9/lab_vision/master/lab8_cnn/red.PNG)
### 1.1 Description
For the architecture we designed a 9 layers convolutional neuronal network, the decision of this number of layers was made by try and erro tryen to get the best result by the limit factor of the time (1 hour of running time). Our network like the AlexNet network was a set of leyers were the diferential factor was that after a convolutional layer the next layer must be a poolong one. We tried to put another nonlinearity layer in between of a pooling a convolutional but this affected the general perfomance of the algorithm so we didn't applied but we think that this would could be handly to reduce the variablity in the responses learned from the filters.

All the pooling layers were max pooling ones that because based on the state of art worked the best. Another parameter that is critical in the network is the number of filters and the dimensions of them, for thew initial stage we applied one dimensional filters because the data is not in color, therefore we are intereseted only in one channel, as the network get deeper we tried to generate as different responses as we can by applying the same filter size but different number of responses by convolution.
### 1.2 Advantages of this architecture
This architecture uses the principle of jitter that in general terms generate like a randomization of the data in each of the batches, as we want that the network learns all the cases this results very useful, another good point in this methodology is the number of responses by falter that we are getting we try to generate as much responses by convolution to in general learn how each of the textures behavies in fron of each of the filters.
## 2. Results
We evaluated the trained network using our function _test net.m_ which have the following structure
```matlab
	function label_vector=test_net(Trained Network,Data);
```
Based on the output (label_vector) we constructed the confusion matrix for all the 25 different categories in each of the divisions of the dataset.
### 2.1 Performance in Training
![training](/training.png)

The Accuracy of the network in Training was:
### 2.2 Performance in Testing
![testinng](/testing.png)

The Accuracy of the network in Training was:

## 3. Conclusion

One of the downs in this methodology was the time, because deeper networks lear better, and can be tuuned to generate much better accuracy models. But was interesting to have a limit time to get the best architecture idea that probably copul be imported to bigger ones and coul lead to generate even better results that ones that dont take into consideration time.
