% Reading

% Assumption
T=0.005;            % sample period
Ts=1;               % start time
Te=3;               % end time
ns=(Ts/T)+1;        % Start sample %200
ne=ns+(Te/T);       % end sample   %800

meu=-0.0087;
sd=0.2047;

folder='C:\Users\jamagola\Documents\github_repo\Experiment\real_time\';
%folder='C:\Users\jamagola\Documents\github_repo\data\subject3\M';
attempt=0;
motion_=0;
filename=strcat('data_',string(attempt),'_',string(motion_),'.txt');
path=strcat(folder,filename);
%path=strcat(folder,string(motion_),'\',filename);

fid = fopen(path,'r');
fprintf('Reading: %s\n', path);
temp = textscan(fid, '%f%f%f%f%f%f%f%f%f', 'MultipleDelimsAsOne',true, 'Delimiter',' ');
fclose(fid);
data=cell2mat(temp);
data=data(ns:ne,:);
%data=normalize(data);
%data=(data-meu)/sd;
feature=process2D(data);
contourf(feature,20);
caxis([min(min(feature)),max(max(feature))]); % Or constant range
%caxis([meu-5*sd,meu+5*sd]);
%caxis([0,1]);
frame=getframe;
resz=[300,300];
temp=imresize(frame.cdata,resz);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
folder='C:\Users\jamagola\Documents\github_repo\Experiment\real_time\';
%folder='C:\Users\jamagola\Documents\github_repo\data\subject3\M';
filename=strcat('data_',string(attempt),'_',string(motion_),'.png');
path=strcat(folder,filename);
%path=strcat(folder,string(motion_),'\',filename);
imwrite(temp, path);