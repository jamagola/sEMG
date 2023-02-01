% Nina Data work

clc; clear all; close all;

location='/home/golam/workspace/ninaPro/';
subjectList=["s1","s2","s3","s4","s5","s6","s7","s8","s9","s10"];

% Assuming 200 Hz, 3 sec ~ 600 samples
samples=600;
n=[17,23]; % motion from 1-n
r=6; % Repeated times: r
probes=16;
imu=3;
probes=probes+imu; % *****************only if IMU comment otherwise*********************
stim=20; % 17 if not IMU, 20 if it is!
rept=21; % 18 if not IMU, 21 if it is!
TotalSubject=10;
W=waitbar(0, '<<<Generating files: Please wait>>>');
for s=1:TotalSubject
    subject_=subjectList(s);
    filenameB=strcat('/',upper(subject_),'_E3_A1.mat');
    filenameA=strcat('/',upper(subject_),'_E2_A1.mat');

    path=strcat(location,subject_,filenameA);
    load(path);

    %data3=[emg, restimulus, rerepetition]; % stimulus: 17, repetition: 18
    data3=[emg, acc, restimulus, rerepetition]; % IMU included || stimulus: 20, repetition: 21
    data3update=data3(data3(:,stim)~=0, :);

    motion=zeros(sum(n),r,samples,probes);   
    minsz=samples;
    for i=1:n(1)
        for j=1:r
            temp_=data3update(data3update(:,stim)==i & data3update(:,rept)==j,1:probes);
            if size(temp_,1)<samples
                motion(i,j,1:size(temp_,1),:)=temp_(:,:);
                if minsz>size(temp_,1)
                    minsz=size(temp_,1);
                end
            else
                motion(i,j,:,:)=temp_(1:samples,:);
            end
        end
    end


    path=strcat(location,subject_,filenameB);
    load(path);
    restimulus=restimulus+n(1);
    data3=[emg, acc, restimulus, rerepetition];
    data3update=data3(data3(:,stim)~=n(1), :);
    for i=1+n(1):sum(n)
        for j=1:r
            temp_=data3update(data3update(:,stim)==i & data3update(:,rept)==j,1:probes);
            if size(temp_,1)<samples
                motion(i,j,1:size(temp_,1),:)=temp_(:,:);
                if minsz>size(temp_,1)
                    minsz=size(temp_,1);
                end
            else
                motion(i,j,:,:)=temp_(1:samples,:);
            end
        end
    end



    % Save as text
    % If IMU then destination dataIMU
    %folder='/home/golam/workspace/ninaPro/data/';
    folder='/home/golam/workspace/ninaPro/dataIMU/';
    folder=strcat(folder,subject_,'/');
    
    for motion_=1:sum(n)
        folder_=strcat(folder,'motion',string(motion_));
        mkdir(folder_);
        for attempt=1:r
            %attempt=6;
            %motion_=40;
            filename=strcat('data_',string(attempt),'_',string(motion_),'.txt');
            location_=strcat(folder_,'/',filename);
            temp=reshape(motion(motion_,attempt,:,1:probes),samples,probes);

            save(location_, 'temp', '-ascii');

            %plot each sensor information 
            % figure;
            % for k=1:probes
            %     subplot(4,4,k); plot(temp(:,k)); title(strcat('emg: ',string(k)));
            %     grid on;
            %     xlabel('samples');
            %     ylabel('emg');
            % end
            % Ok
        end
    end
    waitbar(s/TotalSubject,W);
end
disp('Done!!')