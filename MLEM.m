%% ����sinogram
fid=fopen('F:\����\�Բ�����\evaluation\3-3-20\ring200.s','r');
sino=fread(fid,'float');
[Nx,Ny,Nz]=size(sino);
nx=50;
ny=50;
nz=10;        %����voxel number
p=ones(nx,ny,nz);         %����ͼ��
p1=ones(Nx,Ny,Nz);       %ȫ1���ڷ�ͶӰ
% Tp=zeros(180,185);  %��Ϊ����1��ͶӰ����
fid1=fopen('F:\����\�ؽ�\siddon\matrix.txt','r');
a=fread(fid1);


