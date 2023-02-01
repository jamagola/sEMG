% Need cropping and preprocess
% Assumption
clear all;
close all;
clc;
% Assumption
subject=10; 
motions=40;
repeat_=6;

fprintf('\nPreparing files: \n');
wait_=waitbar(0,'Preparing data (- _ -)');
%folder='/home/golam/workspace/ninaPro/data/'; 
folder='/home/golam/workspace/ninaPro/dataIMU/'; % IMU
%location='/home/golam/workspace/ninaPro/Image';
location='/home/golam/workspace/ninaPro/ImageIMU'; % IMU
for s=1:subject
    currentSub=strcat("s",string(s));
    for f=1:motions
        currentMo=strcat("motion",string(f));
        mkdir(strcat(location,"/",currentSub,"/",currentMo));
        waitbar(((s-1)*motions+f)/(subject*motions),wait_,'Preparing data (- _ -)')
        for r=1:repeat_
            currentFile=strcat("data_",string(r),"_",string(f),".txt");
            path=strcat(folder,"/",currentSub,"/",currentMo,"/",currentFile); %%%%%%%%%%%
            fid = fopen(path,'r');
            fprintf('Reading: %s\n', path);
            %temp = textscan(fid, '%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f', 'MultipleDelimsAsOne',true, 'Delimiter',' ');
            % Only if IMU
            temp = textscan(fid, '%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f', 'MultipleDelimsAsOne',true, 'Delimiter',' ');

            fclose(fid);
            data=cell2mat(temp);
            %data=normalize(data); %%%%%%%% IMU COMMENT %%%%%%%
            %data=[normalize(data(:,1:16)), data(:,17:19)]; %IMU + 16 probes
            %feature=process2D(data); %%%%%IF NO IMU%%%%%
            feature=process2DIMU(data); %%%%%%%%%%
            contourf(feature,20);
            caxis([min(min(feature)),max(max(feature))]); % Or constant range
            %caxis([meu-5*sd,meu+5*sd]);
            %caxis([0,1]);
            frame=getframe;
            resz=[300,300];
            temp=imresize(frame.cdata,resz);
            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            file_=strcat("data_",string(r),"_",string(f),".png");
            file_=strcat(location,"/",currentSub,"/",currentMo,"/",file_);
            imwrite(temp, file_);
        end
    end
end
waitbar(1,wait_,'Done (@ _ @)');