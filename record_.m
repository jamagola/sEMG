% Record

T = 5; % seconds
m1.clearLogs()
m1.startStreaming();
pause(T);
m1.stopStreaming();
fprintf('Logged data for %d seconds,\n\t',T);
fprintf('IMU samples: %10d\tApprox. IMU sample rate: %5.2f\n\t',...
  length(m1.timeIMU_log),length(m1.timeIMU_log)/T);
fprintf('EMG samples: %10d\tApprox. EMG sample rate: %5.2f\n\t',...
  length(m1.timeEMG_log),length(m1.timeEMG_log)/T);

%%
% figure;
% plot(m1.timeEMG_log,m1.emg_log);   
% title('emg');
% %plot each sensor information 
% figure;
% subplot(4,2,1); plot(m1.timeEMG_log,m1.emg_log(:,1));   title('emg');
% subplot(4,2,2); plot(m1.timeEMG_log,m1.emg_log(:,2));   title('emg');
% subplot(4,2,3); plot(m1.timeEMG_log,m1.emg_log(:,3));   title('emg');
% subplot(4,2,4); plot(m1.timeEMG_log,m1.emg_log(:,4));   title('emg');
% subplot(4,2,5); plot(m1.timeEMG_log,m1.emg_log(:,5));   title('emg');
% subplot(4,2,6); plot(m1.timeEMG_log,m1.emg_log(:,6));   title('emg');
% subplot(4,2,7); plot(m1.timeEMG_log,m1.emg_log(:,7));   title('emg');
% subplot(4,2,8); plot(m1.timeEMG_log,m1.emg_log(:,8));   title('emg');
%%

%Create a copy of the variables 
EMG1=m1.emg_log(:,1);
EMG2=m1.emg_log(:,2);
EMG3=m1.emg_log(:,3);
EMG4=m1.emg_log(:,4);
EMG5=m1.emg_log(:,5);
EMG6=m1.emg_log(:,6);
EMG7=m1.emg_log(:,7);
EMG8=m1.emg_log(:,8);

EMGT=[m1.emg_log, m1.timeEMG_log];

% Save as text
folder='C:\Users\jamagola\Documents\github_repo\Experiment\real_time\';
%folder='C:\Users\jamagola\Documents\github_repo\data\subject3\M';
attempt=0;
motion_=0;
filename=strcat('data_',string(attempt),'_',string(motion_),'.txt');
location=strcat(folder,filename);
%location=strcat(folder,string(motion_),'\',filename);

save(location, 'EMGT', '-ascii');