%test
% After init is ran, network is loaded and also run the terminate at the end.

record_
read_

x=imread('C:\Users\jamagola\Documents\github_repo\Experiment\real_time\data_0_0.png');
[value,index]=max(predict(trainedNetwork_1,x))