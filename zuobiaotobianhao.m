% clc;
% clear;
% close all;
% IV=textread('F:\shiermianti\yuanpan24z.txt');
number_block=72;%棱数
number_binX=8; %每条棱上晶体数
number_binY=24;%轴向层数
R=188;L=120;%半径和轴向长度mm
% R_FOV=442;%FOV半径mm
nDetectors=number_block*number_binX;%单环上晶体个数
M=nDetectors/2;N=nDetectors/2;
layer=number_binY;
SINO=zeros(M+2,N+2,layer*layer);
crystal1=int32(zeros(size(IV,1)/2,1));
crystal2=int32(zeros(size(IV,1)/2,1));
ring1IDD=int32(zeros(size(IV,1)/2,1));
ring2IDD=int32(zeros(size(IV,1)/2,1));
for i=1:2:size(IV,1)
    theta1=acosd(dot([IV(i,1),IV(i,2)],[1,0])/(norm([IV(i,1),IV(i,2)])));
    if IV(i,2)<0
        theta1=360-theta1;
    end
    theta1=theta1+360/576*4;
    if theta1>=360
        theta1=theta1-360;
    end
    
    theta2=acosd(dot([IV(i+1,1),IV(i+1,2)],[1,0])/(norm([IV(i+1,1),IV(i+1,2)])));
    if IV(i+1,2)<0
        theta2=360-theta2;
    end
    theta2=theta2+360/576*4;
    if theta2>=360
        theta2=theta2-360;
    end
    
    crystal1((i+1)/2)=floor(theta1/360*nDetectors)-4;
    crystal2((i+1)/2)=floor(theta2/360*nDetectors)-4;
    ring1IDD((i+1)/2)=floor((IV(i,3)+L/2)/L*layer);
    ring2IDD((i+1)/2)=floor((IV(i+1,3)+L/2)/L*layer);
end
