clear;clc;close all
% P=phantom(124);
crystal_size=1;  %单位mm
nDetectors=380;     %探测器个数
MnDetectors=nDetectors/2;
pixel_num=256;
pixel_size=0.5;  %单位mm
image=zeros(pixel_num, pixel_num);
fid=fopen('\\192.168.1.114\share\jaszczak1.5-1.5-10.s','r');
R1=fread(fid,'float');

% angle=linspace(0,179,MnDetectors);
% R=radon(P,angle);       %180°投影数据
R1=reshape(R1,[MnDetectors MnDetectors 79]);
R=R1(:,:,40);
d=1;
[N,M]=size(R);
R0=zeros(M-N,M);
R1=[R;R0];           %补0
for i=1:2*M-1
    hs(i)=(-2)/(d^2*pi^2*(4*(i-M)^2-1));   %hS-L，滤波器
end
Hs=repmat(hs,M,1);
h=zeros(M,M);
for a=1:M
    for i=1:M
        h(a,i)=Hs(a,i+M-a);   %二维滤波器
    end
end
b=R1'*(h');            %滤波后的投影
% figure; imshow(b,[]);

% C2=zeros(128,128);
for i=1:pixel_num
    for j=1:pixel_num
        for theta=1:M
            d=((i-(pixel_num+1)/2)*sin((theta-1)/M*pi)+(j-(pixel_num+1)/2)*cos((theta-1)/M*pi))*(pixel_size/crystal_size)+M/2;
            if d>=1&&d<M
                d1=floor(d);
                image(i,j)=image(i,j)+(d1+1-d)*b(theta,d1)+(d-d1)*b(theta,d1+1);
            end
        end
    end
end
figure; imshow(image,[]);