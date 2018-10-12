clc;close all;
fid=fopen('G:\recon\jaszczak3-3-5\ls_TOF_100ps\jaszczak3-3-5.re.iter030','r');
data=fread(fid,'float');
fclose(fid);
data=reshape(data,80,80,79);
data1=squeeze(data(:,:,40))+squeeze(data(:,:,41))+squeeze(data(:,:,39));
data1=data1/3;
imshow(data1);

diameter=[20 26 35 44 56 73]/2.65;
diameter=fliplr(diameter);
for k=1:6
hold on;
alpha=0:pi/20:2*pi;
x=100+64*sin(60*(k+0.5)/180*pi)+diameter(k)*cos(alpha);
y=100+64*cos(60*(k+0.5)/180*pi)+diameter(k)*sin(alpha);
plot(x,y,'.');
end
hold on
x=100+30*cos(alpha);
y=100+30*sin(alpha);
plot(x,y,'.');
hold off

phantom=zeros(200,200);
radius=60;
diameter=[20 26 35 44 56 73]/2.65;
diameter=fliplr(diameter);
for k=1:6
        tempX=100+64*cos(60*(k+0.5)/180*pi);
        tempY=100+64*sin(60*(k+0.5)/180*pi);
for i=1:200
    for j=1:200
        tempL=(i-tempX)^2+(j-tempY)^2;
        if(tempL<diameter(k)^2)
            phantom(i,j)=7-k;
        end        
    end
end
end

for i=1:200
    for j=1:200
        tempX=100;
        tempY=100;
        tempL=(i-tempX)^2+(j-tempY)^2;
        if(tempL<30^2)
            phantom(i,j)=7;
        end
    end
end
figure
imshow(phantom,[]);
avg=zeros(6,1);
ind=find(phantom==7);
stand_devi=std(data1(ind));
avg_bg=sum(data1(ind))/size(ind,1);
contrast=avg;
for i=1:6
ind=find(phantom==i);
avgT=sum(data1(ind))/size(ind,1)
avg(i)=(avgT-avg_bg)/stand_devi;
contrast(i)=avgT/avg_bg;
end
contrast
