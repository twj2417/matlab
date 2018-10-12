%% �������ݶ���
clc;
clear;
close all;
fid = fopen('F:\����\С����\16ģ��\flood2_d15\flood_differentdelay.s','r');
data = fread(fid,'float32');
data = reshape(data,7,size(data,1)/7);
data = data(:,1:2000000);
% fid = fopen('C:\Users\twj2417\Desktop\test.s','w');
% fwrite(fid,newdata,'float32');
temp = data(1:6,:);
new = reshape(temp,3,size(temp,2)*2);
IV = new';
%% ����תcrystal���
number_block=16;%����
number_binX=10;%ÿ�����Ͼ�����
number_binY=10;%�������
R_inner=99; %Բ���ڰ뾶
thickness=20;%������
len_block=33.4;%block�߳�
len_crystal=len_block/number_binX;
L=33.4;%���򳤶�mm
nDetectors=number_block*number_binX;%�����Ͼ������
layer=number_binY;
parfor i=1:size(IV,1)
    theta=acosd(dot(IV(i,1:2),[1,0])/(norm(IV(i,1:2))));
    if IV(i,2)<0
        theta=360-theta;
    end
    theta=theta+180/nDetectors*number_binX;
    if theta>=360
        theta=theta-360;
    end
    block=floor(theta/360*number_block);
    center=R_inner*[cos(2*block*pi/number_block),sin(2*block*pi/number_block)];
    vec1=center/R_inner;       %blockƽ��ķ�����
    vec=[-sin(2*block*pi/number_block),cos(2*block*pi/number_block)];  %blockƽ���ڵ�����
    pro_point= dot(center-IV(i,1:2),vec1)*vec1+IV(i,1:2);
    edge_block=center-vec*len_block/2;
    crystal=floor(norm(pro_point-edge_block)/len_crystal);
    num_crystal(i,:)=[block,crystal];    
end
block = num_crystal(:,1)+1;
block = reshape(block,2,size(block,1)/2);
for i=1:16
    index = find(block(1,:)==i);
    sub_block = block(:,index);
    for j=1:16
        index1 = find(sub_block(2,:)==j);
        num_two_block(i,j)=size(index1,2);
    end
end
d15=zeros(16,16);
for i =1:16
    for j=1:16
        d15(i,j)=num_two_block(i,j)+num_two_block(j,i);
        d15(j,i)=num_two_block(i,j)+num_two_block(j,i);
    end
end
% save('F:\����\С����\16ģ��\flood1_d12\num_two_blockd.mat','d12')
% load('F:\����\С����\16ģ��\flood2_d15_10_10\num_two_blockd.mat')
pic = zeros(128,128);
for i=1:16
    for j=1:16
        pic((i-1)*8+1:i*8,(j-1)*8+1:j*8)=d15(i,j);
    end
end
imshow(pic,[])
