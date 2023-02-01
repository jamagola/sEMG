%near Real-Time application
clear all; close all; clc;
% Initialize
init();
load trainedNetX.mat
fprintf('Initialization Complete!\n');
% Random motion instruction: 0~3
motion=[0];
fprintf('Apply motion: %d\n', 0);
state=false;
ti=[0];
% Stop watch
tic;
% Record data -> extract feature
record_
read_
%pause(1.0);
% Classification
x=imread('C:\Users\jamagola\Documents\github_repo\Experiment\real_time\data_0_0.png');
[value,index]=max(predict(trainedNetwork_1,x))
predict_class=[index];
%predict_class=[round(3*rand())];
time=toc;
to=[time];
state=~state;
iterations=10;
for i=1:10
    if state
        temp=round(3*rand());
        motion=[motion temp];
        ti=[ti time];
        fprintf('Apply motion: %d\n', temp);
        tic;
    else
        motion=[motion 0];
        ti=[ti time];
        fprintf('Apply motion: %d\n', 0);
        tic;
    end
    
    % Record data and feature extraction
    record_
    read_
    %pause(1.0);
    % Classification
    x=imread('C:\Users\jamagola\Documents\github_repo\Experiment\real_time\data_0_0.png');
    [value,index]=max(predict(trainedNetwork_1,x))
    predict_class=[predict_class index];
    %predict_class=[predict_class round(3*rand())];
    time=time+toc;
    to=[to time];
    state=~state;
end

subplot(2,1,1);
plot(ti,motion+1,'k-o');
xlabel('time (s)');
ylabel('Assigned motion');
title('Motion requested');
grid on;

subplot(2,1,2);
plot(to,predict_class,'r-o');
xlabel('time (s)');
ylabel('Predicted motion');
title('Motion predicted');
grid on;

fprintf('Average process delay including sampling duration: %.2f sec.\n',time/(iterations+1));
match_count=sum((motion+1)==predict_class);
total_motions=length(motion);
accuracy=100*match_count/total_motions;
fprintf('Accuracy: %.2f %%. \n',accuracy);
disp(' >>Done!!<<');

terminate_;