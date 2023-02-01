% Mean and STD for global
% Need cropping and preprocess
% Assumption
clear all;
close all;
clc;
% Assumption
T=0.005;            % sample period
Ts=1;               % start time
Te=3;               % end time
ns=(Ts/T)+1;        % Start sample %200
ne=ns+(Te/T);       % end sample   %800
%subject=225;        % Total subject
subject=10;
%folder=["Cylindrical_Grasp", "Fist", "Spherical_Grasp", "Tip_Pinch"];
folder=["motion_1", "motion_2", "motion_3", "motion_4"];
%filename=["Prueba","Prueba","Cilindro","Prueba"];
filename=["attempt_","attempt_","attempt_","attempt_"];
fprintf('\nPreparing files: \n');
wait_=waitbar(0,'Reading data (- _ -)');
state=1
for f=1:length(folder)
    for s=1:subject
        waitbar(((f-1)*subject+s)/(subject*length(folder)),wait_,'Reading data (- _ -)')
        path=strcat(folder(f),"/",filename(f),string(s),".txt");
        fid = fopen(path,'r');
        fprintf('Reading: %s\n', path);
        temp = textscan(fid, '%f%f%f%f%f%f%f%f%f', 'MultipleDelimsAsOne',true, 'Delimiter',' ');
        fclose(fid);
        data=cell2mat(temp);
        data=data(ns:ne,1:end-1);
        if state
            dataset=data;
            state=0;
        else
            dataset=[dataset;data];
        end
    end
end
waitbar(1,wait_,'Done (@ _ @)');
[r,c]=size(dataset);
dataset=reshape(dataset,1,r*c);
meu=mean((dataset));
sd=std((dataset));