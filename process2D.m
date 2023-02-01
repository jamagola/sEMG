function[feature]=process2D(data)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Feature Extraction
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%
%test
%%
% fid = fopen('/home/golam/workspace/ninaPro/data/s1/motion1/data_1_1.txt','r');
% temp = textscan(fid, '%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f', 'MultipleDelimsAsOne',true, 'Delimiter',' ');
% fclose(fid);
% data=cell2mat(temp);
% data=normalize(data);
% 
window=20;
stride=5;

% 16 columns as 16 lines connected to corners from center
delt=360/16;
deltr=2*pi/16;
offset=0;
r=offset+[meandata(abs(data(:,1:16)), window, stride), meandata(abs(data(:,1)), window, stride)];
x=[r(:,1)*cosd(0*delt), r(:,9)*cosd(1*delt), r(:,2)*cosd(2*delt), r(:,10)*cosd(3*delt), r(:,3)*cosd(4*delt), r(:,11)*cosd(5*delt), r(:,4)*cosd(6*delt),r(:,12)*cosd(7*delt),r(:,5)*cosd(8*delt), r(:,13)*cosd(9*delt), r(:,6)*cosd(10*delt), r(:,14)*cosd(11*delt), r(:,7)*cosd(12*delt), r(:,15)*cosd(13*delt),r(:,8)*cosd(14*delt), r(:,16)*cosd(15*delt), r(:,1)*cosd(0*delt)];
y=[r(:,1)*sind(0*delt), r(:,9)*sind(1*delt), r(:,2)*sind(2*delt), r(:,10)*sind(3*delt), r(:,3)*sind(4*delt), r(:,11)*sind(5*delt), r(:,4)*sind(6*delt),r(:,12)*sind(7*delt),r(:,5)*sind(8*delt), r(:,13)*sind(9*delt), r(:,6)*sind(10*delt), r(:,14)*sind(11*delt), r(:,7)*sind(12*delt), r(:,15)*sind(13*delt), r(:,8)*sind(14*delt),r(:,16)*sind(15*delt), r(:,1)*sind(0*delt)];
r=[r(:,1),r(:,9),r(:,2),r(:,10),r(:,3),r(:,11),r(:,4),r(:,12),r(:,5),r(:,13),r(:,6),r(:,14),r(:,7),r(:,15),r(:,8),r(:,16),r(:,1)];
% Side lengths
% d12=sqrt(((x(:,1)-x(:,2)).^2)+((y(:,1)-y(:,2)).^2));
% d23=sqrt(((x(:,2)-x(:,3)).^2)+((y(:,2)-y(:,3)).^2));
% d34=sqrt(((x(:,3)-x(:,4)).^2)+((y(:,3)-y(:,4)).^2));
% d45=sqrt(((x(:,4)-x(:,5)).^2)+((y(:,4)-y(:,5)).^2));
% d56=sqrt(((x(:,5)-x(:,6)).^2)+((y(:,5)-y(:,6)).^2));
% d67=sqrt(((x(:,6)-x(:,7)).^2)+((y(:,6)-y(:,7)).^2));
% d78=sqrt(((x(:,7)-x(:,8)).^2)+((y(:,7)-y(:,8)).^2));
% d81=sqrt(((x(:,8)-x(:,1)).^2)+((y(:,8)-y(:,1)).^2));

tempx0=x(:,1:16);
tempx1=x(:,2:17);
tempy0=y(:,1:16);
tempy1=y(:,2:17);
tempr0=r(:,1:16);
tempr1=r(:,2:17);

d=sqrt(((tempx0-tempx1).^2)+((tempy0-tempy1).^2));
oab=180*acos(((d.^2)+(tempr0.^2)-(tempr1.^2))./(2*d.*tempr0))/pi;
oba=180*acos(((d.^2)+(tempr1.^2)-(tempr0.^2))./(2*d.*tempr1))/pi;
oba=[oba(:,16),oba(:,1:15)];

% %test
% polar(pi*[0:360/16:360]/180, r(1,:));
% figure
% plot(x(1,:),y(1,:),'-o');

% o12=180*acos(((d12.^2)+(r(:,1).^2)-(r(:,2).^2))./(2*d12.*r(:,1)))/pi;
% o21=180*acos(((d12.^2)+(r(:,2).^2)-(r(:,1).^2))./(2*d12.*r(:,2)))/pi;
% 
% o23=180*acos(((d23.^2)+(r(:,2).^2)-(r(:,3).^2))./(2*d23.*r(:,2)))/pi;
% o32=180*acos(((d23.^2)+(r(:,3).^2)-(r(:,2).^2))./(2*d23.*r(:,3)))/pi;
% 
% o34=180*acos(((d34.^2)+(r(:,3).^2)-(r(:,4).^2))./(2*d34.*r(:,3)))/pi;
% o43=180*acos(((d34.^2)+(r(:,4).^2)-(r(:,3).^2))./(2*d34.*r(:,4)))/pi;
% 
% o45=180*acos(((d45.^2)+(r(:,4).^2)-(r(:,5).^2))./(2*d45.*r(:,4)))/pi;
% o54=180*acos(((d45.^2)+(r(:,5).^2)-(r(:,4).^2))./(2*d45.*r(:,5)))/pi;
% 
% o56=180*acos(((d56.^2)+(r(:,5).^2)-(r(:,6).^2))./(2*d56.*r(:,5)))/pi;
% o65=180*acos(((d56.^2)+(r(:,6).^2)-(r(:,5).^2))./(2*d56.*r(:,6)))/pi;
% 
% o67=180*acos(((d67.^2)+(r(:,6).^2)-(r(:,7).^2))./(2*d67.*r(:,6)))/pi;
% o76=180*acos(((d67.^2)+(r(:,7).^2)-(r(:,6).^2))./(2*d67.*r(:,7)))/pi;
% 
% o78=180*acos(((d78.^2)+(r(:,7).^2)-(r(:,8).^2))./(2*d78.*r(:,7)))/pi;
% o87=180*acos(((d78.^2)+(r(:,8).^2)-(r(:,7).^2))./(2*d78.*r(:,8)))/pi;
% 
% o81=180*acos(((d81.^2)+(r(:,8).^2)-(r(:,1).^2))./(2*d81.*r(:,8)))/pi;
% o18=180*acos(((d81.^2)+(r(:,1).^2)-(r(:,8).^2))./(2*d81.*r(:,1)))/pi;

% internal angles (degree)
angle=oab+oba;

% a1=o12+o18;
% a2=o23+o21;
% a3=o34+o32;
% a4=o45+o43;
% a5=o56+o54;
% a6=o67+o65;
% a7=o78+o76;
% a8=o81+o87;

%angle=[a1 a2 a3 a4 a5 a6 a7 a8];
win=20;
strd=5;
feature=stddata(angle,win, strd);
%feature=meandata(r(:,1:16),win, strd);
%feature=reshape(feature, 32,32);