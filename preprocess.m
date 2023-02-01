clear all;
close all;
clc;
% Assumption
T=0.005;            % sample period
Ts=1;               % start time
Te=3;               % end time
ns=(Ts/T)+1;        % Start sample %200
ne=ns+(Te/T);       % end sample   %800


folder=["Cylindrical_Grasp", "Fist", "Spherical_Grasp", "Tip_Pinch"];
filename=["Prueba","Prueba","Cilindro","Prueba"];
subject=1;
path=strcat(folder(1),"/",filename(1),string(subject),".txt");

fid = fopen(path,'r');
temp = textscan(fid, '%f%f%f%f%f%f%f%f%f', 'MultipleDelimsAsOne',true, 'Delimiter',' ');
fclose(fid);
data=cell2mat(temp);
data=data(ns:ne,:);
data=normalize(data);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Feature
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
window=10;
stride=5;

% 8 columns as 8 lines connected to corners from center
delt=45;
deltr=2*pi/8;
r=[meandata(abs(data(:,1:8)), window, stride), meandata(abs(data(:,1)), window, stride)];
x=[r(:,1)*cosd(0*delt), r(:,2)*cosd(1*delt), r(:,3)*cosd(2*delt), r(:,4)*cosd(3*delt), r(:,5)*cosd(4*delt), r(:,6)*cosd(5*delt), r(:,7)*cosd(6*delt),r(:,8)*cosd(7*delt), r(:,1)*cosd(0*delt)];
y=[r(:,1)*sind(0*delt), r(:,2)*sind(1*delt), r(:,3)*sind(2*delt), r(:,4)*sind(3*delt), r(:,5)*sind(4*delt), r(:,6)*sind(5*delt), r(:,7)*sind(6*delt),r(:,8)*sind(7*delt),r(:,1)*sind(0*delt)];

theta=[0, deltr, 2*deltr, 3*deltr, 4*deltr, 5*deltr, 6*deltr, 7*deltr, 0];

for i=1:10
    polarplot(theta, r(i,:), 'LineWidth',2)
    grid on;
    hold on;
    rlim([0,1])
    %pause(0.5);
end

figure
for i=1:10
    plot(x(i,:), y(i,:))
    %grid on;
    hold on;
    %pause(0.5);
end 

% Side lengths
d12=sqrt(((x(:,1)-x(:,2)).^2)+((y(:,1)-y(:,2)).^2));
d23=sqrt(((x(:,2)-x(:,3)).^2)+((y(:,2)-y(:,3)).^2));
d34=sqrt(((x(:,3)-x(:,4)).^2)+((y(:,3)-y(:,4)).^2));
d45=sqrt(((x(:,4)-x(:,5)).^2)+((y(:,4)-y(:,5)).^2));
d56=sqrt(((x(:,5)-x(:,6)).^2)+((y(:,5)-y(:,6)).^2));
d67=sqrt(((x(:,6)-x(:,7)).^2)+((y(:,6)-y(:,7)).^2));
d78=sqrt(((x(:,7)-x(:,8)).^2)+((y(:,7)-y(:,8)).^2));
d81=sqrt(((x(:,8)-x(:,1)).^2)+((y(:,8)-y(:,1)).^2));

o12=180*acos(((d12.^2)+(r(:,1).^2)-(r(:,2).^2))./(2*d12.*r(:,1)))/pi;
o21=180*acos(((d12.^2)+(r(:,2).^2)-(r(:,1).^2))./(2*d12.*r(:,2)))/pi;

o23=180*acos(((d23.^2)+(r(:,2).^2)-(r(:,3).^2))./(2*d23.*r(:,2)))/pi;
o32=180*acos(((d23.^2)+(r(:,3).^2)-(r(:,2).^2))./(2*d23.*r(:,3)))/pi;

o34=180*acos(((d34.^2)+(r(:,3).^2)-(r(:,4).^2))./(2*d34.*r(:,3)))/pi;
o43=180*acos(((d34.^2)+(r(:,4).^2)-(r(:,3).^2))./(2*d34.*r(:,4)))/pi;

o45=180*acos(((d45.^2)+(r(:,4).^2)-(r(:,5).^2))./(2*d45.*r(:,4)))/pi;
o54=180*acos(((d45.^2)+(r(:,5).^2)-(r(:,4).^2))./(2*d45.*r(:,5)))/pi;

o56=180*acos(((d56.^2)+(r(:,5).^2)-(r(:,6).^2))./(2*d56.*r(:,5)))/pi;
o65=180*acos(((d56.^2)+(r(:,6).^2)-(r(:,5).^2))./(2*d56.*r(:,6)))/pi;

o67=180*acos(((d67.^2)+(r(:,6).^2)-(r(:,7).^2))./(2*d67.*r(:,6)))/pi;
o76=180*acos(((d67.^2)+(r(:,7).^2)-(r(:,6).^2))./(2*d67.*r(:,7)))/pi;

o78=180*acos(((d78.^2)+(r(:,7).^2)-(r(:,8).^2))./(2*d78.*r(:,7)))/pi;
o87=180*acos(((d78.^2)+(r(:,8).^2)-(r(:,7).^2))./(2*d78.*r(:,8)))/pi;

o81=180*acos(((d81.^2)+(r(:,8).^2)-(r(:,1).^2))./(2*d81.*r(:,8)))/pi;
o18=180*acos(((d81.^2)+(r(:,1).^2)-(r(:,8).^2))./(2*d81.*r(:,1)))/pi;

% internal angles (degree)
a1=o12+o18;
a2=o21+o23;
a3=o32+o34;
a4=o43+o45;
a5=o54+o56;
a6=o65+o67;
a7=o76+o78;
a8=o81+o87;

angle=[a1 a2 a3 a4 a5 a6 a7 a8];
win=10;
strd=5;
feature=stddata(angle,win, strd);
figure
contourf(feature)
caxis([0,50]);