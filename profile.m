clc;close all;clear;
pixel=300;   %�ؽ�ͼ������
slice=63;    %�ؽ�ͼ����
x1=150;   %profile������
y1=150;   %profile������
% %[x1 y1]=find(S1(:,:,32)==max(max(S1(:,:,32))));  %��ͼ�������ĵ�
fid1=fopen('F:\result\ecatbigpans-4_8.v','r');
data1=fread(fid1,'float');
S1=reshape(data1,pixel,pixel,slice);
fid2=fopen('F:\result\ecatbigpans-2_8.v','r');
data2=fread(fid2,'float');
S2=reshape(data2,pixel,pixel,slice);
% fid3=fopen('F:\result\ecatbigpans-4_14.v','r');
% data3=fread(fid3,'float');
% S3=reshape(data3,pixel,pixel,slice);
% fid4=fopen('F:\result\ecatbigpans-4_14.v','r');
% data4=fread(fid4,'float');
% S4=reshape(data4,pixel,pixel,slice);
S4=zeros(300,300,63);
for i=1:300
    for j=1:300
        for k=30:34
            if (i-150.5)^2+(j-150.5)^2<120^2
                S4(i,j,k)=1;
            end
        end
    end
end
% VI=[zeros(512,63),S3,zeros(512,63)];
% VII=[zeros(63,638);VI;zeros(63,638)];
% M_img3=imresize(VII,150/512*94/117);
% figure;imshow(M_img3,[]);
% S1=I./II(51:250,51:250,:);
% S2=I;
dataT1=squeeze(S1(:,y1,:));
dataT2=squeeze(S2(:,y1,:));
%dataT3=squeeze(S3(:,y1,:));
dataT4=squeeze(S4(:,y1,:));
%�жԱ�
M_img1=S1(:,:,32);
figure;imshow(M_img1,[0,0.009]);
colorbar;
title('576 bins');
text(120,280,'d=50cm','color','w');
M_img2=S2(:,:,32); 
figure;imshow(M_img2,[0,0.009]);colorbar;
title('288 bins');
text(120,280,'d=50cm','color','w');
% M_img3=S3(:,:,32);
% figure;imshow(M_img3,[0,0.009]);colorbar;
% title('14 iterations');
% text(120,280,'d=50cm','color','w');
%  v1=var(reshape(M_img1,pixel*pixel,1))
%  v2=var(reshape(M_img2,pixel*pixel,1))
%  v3=var(reshape(M_img3,pixel*pixel,1))
mx=(S1(x1,:,32))/(max(S1(x1,:,32)));%ȡĳ�лҶ�ֵ
nx=(S2(x1,:,32))/(max(S1(x1,:,32)));%ȡĳ�лҶ�ֵ
%lx=(S3(x1,:,32))/(max(S3(x1,:,32)));
px=S4(x1,:,32);
figure;plot(mx,'b','linewidth',2,'linestyle','--');
%axis([0,pixel,0,1.2]);
grid on;  % ���Ʒָ���
hold on   % ʹͼ����һ�������ϻ�
plot(nx,'r','linewidth',2,'linestyle',':');
% hold on   
% plot(lx,'g','linewidth',2,'linestyle','-.');
hold on
plot(px,'y','linewidth',2,'linestyle','-.');
xlabel('�е�����','fontsize',10);
%ylabel('�Ҷ�ֵ','fontsize',10);
title('�ؽ�ͼ�жԱ�');
legend('576 bins','288 bins','source');
%�жԱ�
my=S1(:,y1,32)/(max(S2(:,y1,32)));%ȡĳ�лҶ�ֵ
ny=S2(:,y1,32)/(max(S2(:,y1,32)));%ȡĳ�лҶ�ֵ
%ly=S3(:,y1,32)/(max(S3(:,y1,32)));
py=S4(:,y1,32);
figure;plot(my,'b','linewidth',2,'linestyle','--');
%axis([0,pixel,0,1.2]);
grid on;  % ���Ʒָ���
hold on   % ʹͼ����һ�������ϻ�
plot(ny,'r','linewidth',2,'linestyle',':');
% hold on   
% plot(ly,'g','linewidth',2,'linestyle','-.');
hold on
plot(py,'y','linewidth',2,'linestyle','-.');
xlabel('�е�����','fontsize',10);
%ylabel('�Ҷ�ֵ','fontsize',10);
title('�ؽ�ͼ�жԱ�');
legend('576 bins','288 bins','source'),
%z��Ա�
mz=dataT1(x1,:)/max(dataT2(x1,:));
nz=dataT2(x1,:)/max(dataT2(x1,:));
%lz=dataT3(x1,:)/max(dataT2(x1,:));
pz=dataT4(x1,:);
figure;plot(mz,'b','linewidth',2,'linestyle','--');
%axis([0,slice,0,1]);
grid on;
hold on
plot(nz,'r','linewidth',2,'linestyle',':');
%  hold on   
%  plot(lz,'g','linewidth',2,'linestyle','-.');
 hold on
plot(pz,'y','linewidth',2,'linestyle','-.');
xlabel('z�������','fontsize',10);
%ylabel('�Ҷ�ֵ','fontsize',10);
title('�ؽ�ͼ����Ա�');
hold on
legend('576 bins','288 bins','source');
% A=max(M_img1(x1,:));
% B=max(M_img2(x1,:));
% C=max(M_img3(x1,:));