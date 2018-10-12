clc;close all;clear;
fid1=fopen('C:\Users\twj2417\Desktop\ring20-6-2_6.v','r');
data1=fread(fid1,'float');
%S1=reshape(data1,80,80,100);
% for i=1:80
%     dataT1(:,:,i)=squeeze(S1(:,i,:));
% end
fid2=fopen('C:\Users\twj2417\Desktop\ring20-6-2_15.v','r');
% fwrite(fid2,dataT1,'float');
data2=fread(fid2,'float');
data=data2./data1;
data=reshape(data,80,80,19);
imshow(data(:,:,10),[]);
fid3=fopen('C:\Users\twj2417\Desktop\ring20-6-21_15.v','w');
fwrite(fid3,data,'float');