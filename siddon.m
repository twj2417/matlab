clc;clear;close all;
dx=2;
dy=2;
dz=2;   %定义重建体素的尺寸mm
nx=50;
ny=50;
nz=10; %定义重建图像中体素数量?
Nx=nx+1;
Ny=ny+1;
Nz=nz+1;
Xplane1=-nx*dx/2;
Yplane1=-ny*dy/2;
Zplane1=-nz*dz/2;
Xplanen=nx*dx/2;
Yplanen=ny*dy/2;
Zplanen=nz*dz/2;
constant=10^-10;
%% 圆环晶体坐标
R=100;  %环半径(mm)
L=33.6;   %轴向长度(mm)
number_block=16;%棱数
number_binX=10; %每条棱上晶体数
number_binY=10;%轴向层数
nDetectors=number_block*number_binX; %单环上晶体个数
layer=number_binY;  %环数
for i=0:layer-1
    for j=1:nDetectors
        num=i*nDetectors+j;
        jt(num,1)=R*cos((j-1)/nDetectors*2*pi);
        jt(num,2)=R*sin((j-1)/nDetectors*2*pi);
        jt(num,3)=(i+1/2-layer/2)*L/layer;
        jt(num,4)=i*nDetectors+j;
    end
end
count=size(jt,1);    %圆环上各晶体中心位置坐标
% G=zeros(count*count,nx*ny*nz);   %系统矩阵
fid=fopen('F:\资料\重建\siddon\matrix.txt','w');
for i=1:count-1
    for j=i+1:count
%         if (jt(j,1)-jt(i,1))~=0&&(jt(j,2)-jt(i,2))~=0&&(jt(j,3)-jt(i,3))~=0
            alphax1=(Xplane1-jt(i,1))/(jt(j,1)-jt(i,1)+constant);
            alphaxn=(Xplanen-jt(i,1))/(jt(j,1)-jt(i,1)+constant);
            alphay1=(Yplane1-jt(i,2))/(jt(j,2)-jt(i,2)+constant);
            alphayn=(Yplanen-jt(i,2))/(jt(j,2)-jt(i,2)+constant);
            alphaz1=(Zplane1-jt(i,3))/(jt(j,3)-jt(i,3)+constant);
            alphazn=(Zplanen-jt(i,3))/(jt(j,3)-jt(i,3)+constant);
            alphamin=max(max(0,min(alphax1,alphaxn)),max(min(alphay1,alphayn),min(alphaz1,alphazn)));
            alphamax=min(min(1,max(alphax1,alphaxn)),min(max(alphay1,alphayn),max(alphaz1,alphazn)));
            if alphamax>=alphamin
                if jt(j,1)>=jt(i,1)
                    lmin=ceil(Nx-(Xplanen-alphamin*(jt(j,1)-jt(i,1))-jt(i,1))/dx);
                    lmax=floor(1+(jt(i,1)+alphamax*(jt(j,1)-jt(i,1))-Xplane1)/dx);
                    alphax=zeros(1,lmax-lmin+1);
                    for l=1:lmax-lmin+1
                        alphax(l)=(Xplane1+(l+lmin-2)*dx-jt(i,1))/(jt(j,1)-jt(i,1)+constant);
                    end
                else
                    lmin=ceil(Nx-(Xplanen-alphamax*(jt(j,1)-jt(i,1))-jt(i,1))/dx);
                    lmax=floor(1+(jt(i,1)+alphamin*(jt(j,1)-jt(i,1))-Xplane1)/dx);
                    alphax=zeros(1,lmax-lmin+1);
                    for l=lmax-lmin+1:-1:1
                        alphax(lmax-lmin+2-l)=(Xplane1+(l+lmin-2)*dx-jt(i,1))/(jt(j,1)-jt(i,1)+constant);
                    end
                end
                if jt(j,2)>=jt(i,2)
                    mmin=ceil(Ny-(Yplanen-alphamin*(jt(j,2)-jt(i,2))-jt(i,2))/dy);
                    mmax=floor(1+(jt(i,2)+alphamax*(jt(j,2)-jt(i,2))-Yplane1)/dy);
                    alphay=zeros(1,mmax-mmin+1);
                    for m=1:mmax-mmin+1
                        alphay(m)=(Yplane1+(m+mmin-2)*dy-jt(i,2))/(jt(j,2)-jt(i,2)+constant);
                    end
                else
                    mmin=ceil(Ny-(Yplanen-alphamax*(jt(j,2)-jt(i,2))-jt(i,2))/dy);
                    mmax=floor(1+(jt(i,2)+alphamin*(jt(j,2)-jt(i,2))-Yplane1)/dy);
                    alphay=zeros(1,mmax-mmin+1);
                    for m=mmax-mmin+1:-1:1
                        alphay(mmax-mmin+2-m)=(Yplane1+(m+mmin-2)*dy-jt(i,2))/(jt(j,2)-jt(i,2)+constant);
                    end
                end
                if jt(j,3)>=jt(i,3)
                    nmin=ceil(Nz-(Zplanen-alphamin*(jt(j,3)-jt(i,3))-jt(i,3))/dz);
                    nmax=floor(1+(jt(i,3)+alphamax*(jt(j,3)-jt(i,3))-Zplane1)/dz);
                    alphaz=zeros(1,nmax-nmin+1);
                    for n=1:nmax-nmin+1
                        alphaz(n)=(Zplane1+(n+nmin-2)*dz-jt(i,3))/(jt(j,3)-jt(i,3)+constant);
                    end
                else
                    nmin=ceil(Nz-(Zplanen-alphamax*(jt(j,3)-jt(i,3))-jt(i,3))/dz);
                    nmax=floor(1+(jt(i,3)+alphamin*(jt(j,3)-jt(i,3))-Zplane1)/dz);
                    alphaz=zeros(1,nmax-nmin+1);
                    for n=nmax-nmin+1:-1:1
                        alphaz(nmax-nmin+2-n)=(Zplane1+(n+nmin-2)*dz-jt(i,3))/(jt(j,3)-jt(i,3)+constant);
                    end
                end
                a=size(alphax,2)+size(alphay,2)+size(alphaz,2);
                alpha_temp=zeros(1,a);
                alpha_temp=[alphax,alphay,alphaz];
                alpha=sort(alpha_temp);
                d=sqrt((jt(i,1)-jt(j,1))^2+(jt(i,2)-jt(j,2))^2+(jt(i,3)-jt(j,3))^2);
                l1=alpha(1:size(alpha,2)-1);
                l2=alpha(2:size(alpha,2));
                len=d*(l2-l1);
                voxel_i=floor(1+(jt(i,1)+(l1+l2)*(jt(j,1)-jt(i,1))/2-Xplane1)/dx);
                voxel_j=floor(1+(jt(i,2)+(l1+l2)*(jt(j,2)-jt(i,2))/2-Yplane1)/dy);
                voxel_k=floor(1+(jt(i,3)+(l1+l2)*(jt(j,3)-jt(i,3))/2-Zplane1)/dz);
                num_voxel=(voxel_k-1)*nx*ny+(voxel_j-1)*nx+voxel_i;
                %                 G(i,j,1:a)=alpha;
                fprintf(fid,'%d\n',jt(i,4));
                fprintf(fid,'%d\n',jt(j,4));
                for in=1:size(len,2)
                    fprintf(fid,'%d\n',num_voxel(in));
                    fprintf(fid,'%f\n',len(in));
                end
            end           
%         end
    end
end
fclose(fid);
