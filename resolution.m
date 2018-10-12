close all; clc;clear
fid=fopen('C:\Users\twj2417\Desktop\result_2T_11.rec','r');
data=fread(fid,'float');
fclose(fid);
% data=load('\\192.168.1.114\share\3-3-20\ring3-3-20_30.rec');
pixel=1.5;    %mm
data=reshape(data,80,80,20);
num=size(data,3);
z=0;
n=10;
% slice1=n-1;
slice2=n;
slice3=1+n;
% slice4=2+n;
data1=data(:,:,slice2)+data(:,:,slice3);
data1=data1/2;
% data1=squeeze(data(:,:,slice2));
subplot(2,2,1);
% figure
imshow(data1,[]);
x=0;
y=0;
xx=x*10/pixel;
yy=y*10/pixel;
r=sum(data1(38+xx:42+xx,31+yy:50+yy))/5;   %% vertical
rr=data1(31+xx:50+xx,38+yy)+data1(31+xx:50+xx,39+yy)+data1(31+xx:50+xx,40+yy)+data1(31+xx:50+xx,41+yy)+data1(31+xx:50+xx,42+yy);    %% horizontal 
rr=rr/5;
x=1:20;
%%  fit the curves with the gaussian function
fit_ver = fit(x',r','gauss1');
fit_hor = fit(x',rr,'gauss1');
subplot(2,2,2)
imshow(data1,[]);
hold on
plot(148*ones(256,1),1:256,'-');
hold on
plot(1:256,128*ones(256,1),'-');

subplot(2,2,3);plot(x,r);
grid on;hold on;plot(fit_ver);
xlabel('x coordinate');ylabel('Horizontal profile');

subplot(2,2,4);plot(x,rr);
grid on;hold on;plot(fit_hor);
xlabel('x coordinate');ylabel('Vertical profile');
%% calculate the FWHM of the gaussian function
FWHM_hor = vpa(fit_hor.c1*2*sqrt(log(2))*pixel) %% unit in mm
FWHM_ver = vpa(fit_ver.c1*2*sqrt(log(2))*pixel) %% unit in mm

%% sensitivity
% clc;
% miu=0.86; % 0.86/cm
% d=0:0.1:3;
% eff=(1-exp(-miu*d)).^2;
% plot(d,eff,'*-');
% grid on;xlabel('Thickness of the cyrstal (cm)');
% ylabel('Sensitivity');