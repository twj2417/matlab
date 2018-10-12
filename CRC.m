close all;clc;clear
avg=zeros(6,10);
contrast=zeros(6,10);
SNR = zeros(6,1);
stand_devi = zeros(6,1);
% data=load('F:\资料\脑部PET\evaluation\SNR\HRRT_jaszczak-3_20.rec','r');
% data=reshape(data,[256 256 20]);
datatemp = load('C:\Users\twj2417\Desktop\文件中转\recon\1.4m\exp_air_DOI5_psf_MLEM_9_0.mat','data')
% datatemp = load('C:\Users\twj2417\Desktop\文件中转\recon\2m\exp2m_air_psf_MLEM_9_0.mat','data')
data=datatemp.data;
figure;imshow(data(:,:,208),[]);
dataT=data(:,:,208)';
data = dataT(73:122,73:122);
dataT=imresize(data,[256,256]);
figure;imshow(dataT,[]);
hold on
II=zeros(256,256);
radius=[7 9 12 16 21 27];
for i=1:256
    for j=1:256
        temp=(i-129)^2+(j-129)^2;
        if(temp<124^2&&temp>=34^2)
            II(i,j)=1;
%             II(i,j,1)=20;
%             II(i,j,2)=20;
%             II(i,j,3)=200;
        end
        if (temp<54^2)
            II(i,j)=-1;
%             II(i,j,3)=255;
        end
    end
end
alpha = 0:pi/20:2*pi;
for k=1:6
    center1=86*sin((k*60-60)*pi/180)+256/2+1;
    center2=86*cos((k*60-60)*pi/180)+256/2+1;
%     x = center1+radius(k)*sin(alpha);
%     y = center2+radius(k)*cos(alpha);
%     plot(x,y,'.');
    for i=1:256
        for j=1:256
            temp=(i-center1)^2+(j-center2)^2;
            if(temp<=radius(k)^2)
                II(i,j)=k+2;
%                 II(i,j,1)=255;
%                 II(i,j,2)=255;
%                 II(i,j,3)=255;
            end
        end
    end
end
figure;imshow(II,[]);
avg=zeros(6,1);
avgT=zeros(6,1);
ind=find(II==-1);
stand_devi=std(dataT(ind));
avg_bg=sum(dataT(ind))/size(ind,1);
contrast=avg;
for i=1:6
    ind=find(II==i+2);
    avgT(i)=sum(dataT(ind))/size(ind,1);
%     stand_devi(i) = std(dataT(ind));
    contrast(i)=(avgT(i)/avg_bg)/6;
    SNR(i) = (avgT(i))/stand_devi;
end
mean(SNR)
mean(contrast)