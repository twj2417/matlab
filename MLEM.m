%% 读入sinogram
fid=fopen('F:\资料\脑部环形\evaluation\3-3-20\ring200.s','r');
sino=fread(fid,'float');
[Nx,Ny,Nz]=size(sino);
nx=50;
ny=50;
nz=10;        %迭代voxel number
p=ones(nx,ny,nz);         %迭代图像
p1=ones(Nx,Ny,Nz);       %全1用于反投影
% Tp=zeros(180,185);  %均为常数1的投影数据
fid1=fopen('F:\资料\重建\siddon\matrix.txt','r');
a=fread(fid1);


