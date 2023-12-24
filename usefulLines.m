% Useful lines
%net=resnet50('Weights', 'none');
%imdsTrain = imageDatastore("C:\Users\Golam Jaman\Desktop\train0","IncludeSubfolders",true,"LabelSource","foldernames");


% [imdsTrain, imdsValidation] = splitEachLabel(imdsTrain,0.8,"randomized");
% 
% % Resize the images to match the network input layer.
% augimdsTrain = augmentedImageDatastore([300 300 3],imdsTrain);
% augimdsValidation = augmentedImageDatastore([300 300 3],imdsValidation);

% YPredicted = classify(trainedNetwork_1,augimdsTrain);
% Ytest=imdsTrain.Labels;

% plotconfusion(Ytest,YPredicted)