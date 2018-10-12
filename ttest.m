% %% single���� һ��singleһ������
% % clear;clc;close all
% % txt=textread('G:\youler\derenzo.txt');
% txt=output;
% % txt=[txt0(:,1),txt0(:,3:5)];
% % txt=txt0;
% n=size(txt,1);
% txt1=txt(1:n-1,1);
% txt2=txt(2:n,1);
% diff=txt2-txt1;
% clear txt1 txt2
% index=find(diff==0);
% index1=index+1;
% m=size(index,1);
% parfor i=1:m
%     II1(i,:)=txt(index(i),2:4);
%     II2(i,:)=txt(index1(i),2:4);
% end
% clear txt
% III=[II1 II2];
% floor(0)
% %% coincidence���� ÿ��eventռ����
% % clc;
% % clear;
% % II=textread('G:\10LYSO_air_8_7.13.txt');
% % m=size(II,1);
% % III=zeros(m/2,6);
% % for j=1:3
% %     I=II(:,j);
% %     I=reshape(I,2,m/2);
% %     III(:,j)=I(1,:)';
% %     III(:,j+3)=I(2,:)';
% % end
% % clear II;
% %% �ӳ�LOR����Բ��
% x1=III(:,1);
% y1=III(:,2);
% z1=III(:,3);
% x2=III(:,4);
% y2=III(:,5);
% z2=III(:,6);
% clear III;
% R=188;%��λ��mm
% L=450;
% slice_l=10;
% parfor i=1:m
%     a=(y2(i)-y1(i))/(x2(i)-x1(i));
%     b=y1(i)-x1(i)/(x2(i)-x1(i))*(y2(i)-y1(i));
%     xo1=(-a*b+sqrt(a^2*R^2+R^2-b^2))/(a^2+1);
%     xo2=(-a*b-sqrt(a^2*R^2+R^2-b^2))/(a^2+1);
%     zo1=(xo1-x1(i))/(x2(i)-x1(i))*(z2(i)-z1(i))+z1(i);
%     zo2=(xo2-x1(i))/(x2(i)-x1(i))*(z2(i)-z1(i))+z1(i);
%     if abs(zo1)<=L/2&&abs(zo2)<=L/2&&isreal(zo1)&&isreal(zo2)       
%         y1(i)=a*xo1+b;
%         y2(i)=a*xo2+b;
%         x1(i)=xo1;x2(i)=xo2;z1(i)=zo1;z2(i)=zo2;
%     else
%         x1(i)=0;
%     end
% end
% index=find(x1~=0);
% temp=zeros(2,size(index,1));
% temp(1,:)=x1(index);
% temp(2,:)=x2(index);
% IV(:,1)=reshape(temp,2*size(temp,2),1);
% temp(1,:)=y1(index);
% temp(2,:)=y2(index);
% IV(:,2)=reshape(temp,2*size(temp,2),1);
% temp(1,:)=z1(index);
% temp(2,:)=z2(index);
% IV(:,3)=reshape(temp,2*size(temp,2),1);
% clear x1
% clear x2
% clear y1
% clear y2
% clear z1
% clear z2
%% �������ݶ���
clc;
clear;
close all;
% IV=textread('C:\Users\twj2417\Desktop\point_air.txt');
fid = fopen('\\192.168.1.114\share\GATE\mydata\ring\wearable\cylinder\air\cylinder_air_total.txt','r');
data = fread(fid,'float');
data = reshape(data,7,size(data,1)/7);
temp = data(1:6,:);
new = reshape(temp,3,size(temp,2)*2);
IV = new';
1
%% ����תcrystal���
number_block=16;%����
number_binX=10;%ÿ�����Ͼ�����
number_binY=10;%�������
R=99;
L=33.4;%�뾶�����򳤶�mm
% R_FOV=442;%FOV�뾶mm
nDetectors=number_block*number_binX;%�����Ͼ������
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
    theta1=theta1+180/nDetectors*number_binX;
    if theta1>=360
        theta1=theta1-360;
    end
    
    theta2=acosd(dot([IV(i+1,1),IV(i+1,2)],[1,0])/(norm([IV(i+1,1),IV(i+1,2)])));
    if IV(i+1,2)<0
        theta2=360-theta2;
    end
    theta2=theta2+180/nDetectors*number_binX;
    if theta2>=360
        theta2=theta2-360;
    end    
    crystal1((i+1)/2)=floor(theta1/360*nDetectors)-floor(number_binX/2);
    crystal2((i+1)/2)=floor(theta2/360*nDetectors)-floor(number_binX/2);
    ring1IDD((i+1)/2)=floor((IV(i,3)+L/2)/L*layer);
    ring2IDD((i+1)/2)=floor((IV(i+1,3)+L/2)/L*layer);
end
clear IV
floor(2)
%% ������תsinogram
% clc;close all; clear;
% data=textread('C:\Users\twj2417\Desktop\8.txt');
% ring1IDD=int32(floor(data(:,1)/number_block)*number_binX+floor(data(:,2)/number_binX));
% ring2IDD=int32(floor(data(:,3)/number_block)*number_binX+floor(data(:,4)/number_binX));
% crystal1=int32(mod(data(:,1),number_block)*number_binX+mod(data(:,2),number_binX))-number_binX/2;
% crystal2=int32(mod(data(:,3),number_block)*number_binX+mod(data(:,4),number_binX))-number_binX/2;

m_ringNb=int32(layer);
m_crystalNb=int32(nDetectors);
m_radialElemNb=int32(nDetectors/2);
m_sinogramNb = int32(layer*layer);

index=find(crystal1<0);
crystal1(index)=crystal1(index)+m_crystalNb;

index=find(crystal2<0);
crystal2(index)=crystal2(index)+m_crystalNb;

crystal1IDD=crystal1+m_crystalNb/4;
crystal2IDD=crystal2+m_crystalNb/4;

index=find(crystal1IDD>=m_crystalNb);
crystal1IDD(index)=crystal1IDD(index)-m_crystalNb;

index=find(crystal2IDD>=m_crystalNb);
crystal2IDD(index)=crystal2IDD(index)-m_crystalNb;

x1=sin((0.5+double(crystal1IDD))*(2*pi)./double(m_crystalNb));
x2=sin((0.5+double(crystal2IDD))*(2*pi)./double(m_crystalNb));
y1=cos((0.5+double(crystal1IDD))*(2*pi)./double(m_crystalNb));
y2=cos((0.5+double(crystal2IDD))*(2*pi)./double(m_crystalNb));

r1=int32(zeros(size(ring1IDD,1),1));
r2=int32(zeros(size(ring2IDD,1),1));
c1=int32(zeros(size(crystal1IDD,1),1));
c2=int32(zeros(size(crystal2IDD,1),1));

index=find(x1>x2);
r1(index)=ring2IDD(index);
r2(index)=ring1IDD(index);
c1(index)=crystal1IDD(index);
c2(index)=crystal2IDD(index);

index=find(x1<x2);
r1(index)=ring1IDD(index);
r2(index)=ring2IDD(index);
c1(index)=crystal2IDD(index);
c2(index)=crystal1IDD(index);

index=find(x1==x2&y1<y2);
if (size(index,1)>=1)
    r1(index)=ring2IDD(index);
    r2(index)=ring1IDD(index);
    c1(index)=crystal1IDD(index);
    c2(index)=crystal2IDD(index);
end

index=find(x1==x2&y1>y2);
if (size(index,1)>=1)
    r1(index)=ring1IDD(index);
    r2(index)=ring2IDD(index);
    c1(index)=crystal2IDD(index);
    c2(index)=crystal1IDD(index);
end

ring1IDD=r1;
ring2IDD=r2;
crystal1IDD=c1;
crystal2IDD=c2;
clear r1
clear r2
clear c1
clear c2
floor(3)
sinoG=int32(zeros(size(ring1IDD,1),3));
for ii=1:size(ring1IDD,1)
    %% Ringbin No.
    ring1ID=int32(ring1IDD(ii));
    ring2ID=int32(ring2IDD(ii));
    crystal1ID=int32(crystal1IDD(ii));
    crystal2ID=int32(crystal2IDD(ii));
    DeltaZ=int32(ring2ID-ring1ID);
    if(DeltaZ<0)
        ADeltaZ=-DeltaZ;
    else
        ADeltaZ=DeltaZ;
    end
    sinoID = (ring1ID+ring2ID-ADeltaZ)/2;
    if(ADeltaZ>0)
        sinoID = sinoID+m_ringNb;
    end
    if (ADeltaZ>1)
        for i=1:ADeltaZ-1
            sinoID=sinoID+2*(m_ringNb-i);
        end
    end
    if(DeltaZ<0)
        sinoID =sinoID+ m_ringNb-ADeltaZ;
    end   
    %%
    itemp = mod(floor(double(crystal1ID + crystal2ID + int32(m_crystalNb/2)+1)/2),m_crystalNb/2);
    binViewID = itemp;
    det1_c = binViewID;
    if(abs(crystal1ID - det1_c) < abs(crystal1ID - (det1_c + int32(m_crystalNb))))
        diff1 = crystal1ID - det1_c;
    else
        diff1 = crystal1ID - (det1_c + m_crystalNb);
    end
    if (abs(crystal2ID - det1_c) < abs(crystal2ID - (det1_c + int32(m_crystalNb))))
        diff2 = crystal2ID - det1_c;
    else
        diff2 = crystal2ID - (det1_c + m_crystalNb);
    end
    if (abs(diff1) < abs(diff2))
        sigma = crystal1ID - crystal2ID;
    else
        sigma = crystal2ID - crystal1ID;
    end
    
    if (sigma < 0)
        sigma =sigma+ m_crystalNb;
    end
    itemp = sigma + (m_radialElemNb)/2 - m_crystalNb/2;
    binElemID = itemp;
    sinoG(ii,1)=sinoID+1;
    sinoG(ii,2)=binElemID+1;
    sinoG(ii,3)=binViewID+1;
end

index=find(sinoG(:,2)>0);
sinoGG=[sinoG(index,1),sinoG(index,2),sinoG(index,3)];
clear sinoG
index=find(sinoGG(:,2)<=m_radialElemNb);
sinoGGG=[sinoGG(index,1),sinoGG(index,2),sinoGG(index,3)];
clear sinoGG

% figure
% index=find(sinoGGG(:,1)==16);
% x=sinoGGG(index,2);
% y=sinoGGG(index,3);
% plot(x,y,'.')
data=zeros(m_radialElemNb,m_radialElemNb,m_sinogramNb);
for j=1:size(sinoGGG(:,1),1)
    data(sinoGGG(j,2),sinoGGG(j,3),sinoGGG(j,1))=data(sinoGGG(j,2),sinoGGG(j,3),sinoGGG(j,1))+1;
end
%figure;
%imshow(squeeze(data(:,:,16)),[]);
floor(4)
fid=fopen('C:\Users\twj2417\Desktop\sinogram1.s','w');
data1=reshape(data,(m_radialElemNb)*(m_radialElemNb)*(m_sinogramNb),1);
fwrite(fid,data1,'float');
fclose(fid);
