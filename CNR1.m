close all;clear
voxel_x=80;
voxel_y=80;
voxel_z=79;    %voxel number of recon image
size_voxel=97*sqrt(2)/80;     %voxel size of recon image
diameter=[20 26 35 44 56 73]/2;   %radius of six rods in the phantom
Distance=73;   %pixel numer--center of rod to center of image in the phantom
Radius=30;    %radius of ROI in background
voxel_num=256;  %voxel number of the phantom
Size_voxel=0.5;  %voxel size of the phantom
ratio=size_voxel/Size_voxel;
fid=fopen('G:\recon\jaszczak3-3-5\ls_TOF_250ps\jaszczak3-3-5.re.iter020','r');   %recon images
data=fread(fid,'float');
fclose(fid);
data=reshape(data,voxel_x,voxel_y,voxel_z);
data1=data(:,:,39)+data(:,:,40)+data(:,:,41);
data1=data1/3;
figure;imshow(data1);
%% processing recon images
radius=fliplr(diameter/ratio);   %¼ÆËã°ë¾¶
for k=1:6
    hold on;
    alpha=0:pi/20:2*pi;
    x=voxel_x/2+Distance/ratio*sin(60*(k+0.5)/180*pi+pi/18)+radius(k)*cos(alpha);
    y=voxel_y/2+Distance/ratio*cos(60*(k+0.5)/180*pi+pi/18)+radius(k)*sin(alpha);
    plot(x,y,'.');
end
hold on
x=voxel_x/2+Radius/ratio*cos(alpha);
y=voxel_x/2+Radius/ratio*sin(alpha);
plot(x,y,'.');
hold off

phantom=zeros(voxel_x,voxel_y);
for k=1:6
    tempX=voxel_x/2+Distance/ratio*cos(60*(k+0.5)/180*pi+pi/18);
    tempY=voxel_y/2+Distance/ratio*sin(60*(k+0.5)/180*pi+pi/18);
    for i=1:voxel_x
        for j=1:voxel_y
            tempL=(i-tempX)^2+(j-tempY)^2;
            if(tempL<radius(k)^2)
                phantom(i,j)=7-k;
            end
        end
    end
end

for i=1:voxel_x
    for j=1:voxel_y
        tempX=voxel_x/2;
        tempY=voxel_y/2;
        tempL=(i-tempX)^2+(j-tempY)^2;
        if(tempL<(Radius/ratio)^2)
            phantom(i,j)=7;
        end
    end
end
figure;imshow(phantom,[]);

avg=zeros(6,1);
ind=find(phantom==7);
stand_devi=std(data1(ind));
avg_bg=sum(data1(ind))/size(ind,1);
contrast=avg;
for i=1:6
    ind=find(phantom==i);
    avgT=sum(data1(ind))/size(ind,1);
    avg(i)=(avgT-avg_bg)/stand_devi;
    contrast(i)=avgT/avg_bg;
end
contrast