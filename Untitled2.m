clc;
clear;
close all;

II=textread('2.txt');
 number_block=72;%棱数
number_binX=8; %每条棱上晶体数
number_binY=32;
ID1=fix(II(:,2)/number_binX)*number_binX*number_block+mod(II(:,2),number_binX)+II(:,1)*number_binX;
ID2=fix(II(:,4)/number_binX)*number_binX*number_block+mod(II(:,4),number_binX)+II(:,3)*number_binX;
data=zeros(number_block*number_binX*number_binY);
for i=1:size(ID1,1)
    if mod(ID1(i),number_block*number_binX)<mod(ID2(i),number_block*number_binX)
        data(ID1(i)+1,ID2(i)+1)=data(ID1(i)+1,ID2(i)+1)+1;
    else
        data(ID2(i)+1,ID1(i)+1)=data(ID2(i)+1,ID1(i)+1)+1;
    end
end
%% LOR排列成两维数据转到四维   
 layer=number_binY;
 nDetectors=number_block*number_binX;
Slayer=layer;    %layer*2-1;
LOR1=data;
SLOR=zeros(nDetectors,nDetectors,layer,layer);
    for i=1:layer
        for j=1:layer
            ia=(i-1)*nDetectors;
            ib=(j-1)*nDetectors;
            SLOR(:,:,i,j)=LOR1(ia+1:ia+nDetectors,ib+1:ib+nDetectors); 
        end
    end
% %  
 SLOR1=zeros(nDetectors,nDetectors,layer*layer);
A=zeros(nDetectors);
MLOR=zeros(nDetectors);
for i=1:layer
    for j=1:layer
        nslice=i-j;
        slice=-layer;
        for k=0:abs(nslice)
            slice=slice+2*(layer-k);
        end
        if nslice==0
           slice=min(i,j);
        else if nslice>0
                slice=slice-2*(layer-nslice)+min(i,j);
            else
                slice=slice-(layer+nslice)+min(i,j);
            end
        end
        SLOR1(:,:,slice)=SLOR(:,:,i,j)+SLOR1(:,:,slice);
    end
end
 M=nDetectors/2;N=nDetectors/2;
 SINO=zeros(M+2,M+2,layer*layer);
for i=1:nDetectors
    for j=1:nDetectors
        theta=mod(i+j-2,nDetectors)*180*(M-1)/nDetectors/179+1;
         if j<=nDetectors/2+1
             d=N/2*abs(cos((j-i-1)/(nDetectors-2)*pi))+N/2+1;
         else if abs(i-nDetectors/4-1)<=abs(j-3*nDetectors/4-1)
                 d=N/2*abs(cos((j-i-1)/(nDetectors-2)*pi))+N/2+1;
             else
                 d=-N/2*abs(cos((j-i-1)/(nDetectors-2)*pi))+N/2+1;
             end
         end
        theta1=floor(theta);
        d1=floor(d);
            SINO(theta1,d1,:)=SINO(theta1,d1,:)+SLOR1(i,j,:)*(theta1+1-theta)*(d1+1-d);
            SINO(theta1+1,d1,:)=SINO(theta1+1,d1,:)+SLOR1(i,j,:)*(theta-theta1)*(d1+1-d);
            SINO(theta1,d1+1,:)=SINO(theta1,d1+1,:)+SLOR1(i,j,:)*(theta1+1-theta)*(d-d1);
            SINO(theta1+1,d1+1,:)=SINO(theta1+1,d1+1,:)+SLOR1(i,j,:)*(theta-theta1)*(d-d1);
    end
end

SINO1=SINO(1:M,1:N,:);
for i=1:layer*layer
    A=flipud(SINO1(:,:,i));
    data1(:,:,i)=A';
end
data2=reshape(data1,[M*N*(layer*layer) 1]);
fid1=fopen('ceshi72first.s','wb');
fwrite(fid1,data2,'float');
