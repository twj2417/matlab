close all
data=load('C:\Users\twj2417\Desktop\HRRT\HRRT.map');
% max(data)
% min(data)
% min(data)
% data=load('C:\Users\twj2417\Desktop\derenzo1.5-1.5-5_ABF25.rec');
% data(find(data>250))=0;
data=reshape(data,64,64,16);
for i=1:16
    data(:,:,i)=fliplr(data(:,:,i));
end
% img=data(:,:,5);
% data1=imresize(img,[64,64]);
% fid=fopen('\\192.168.1.114\share\hoffman1.5-1.5-7_20.v','w');
% fwrite(fid,data,'float');
% fclose(fid)
% figure;imshow(data(:,:,5),[]);
% I = data(:,:,5);
% G =fspecial('gaussian', [3 3], 2);
% Ig =imfilter(I,G,'same');imshow(Ig,[0,400]);
figure; img = data(:,:,8);
imshow(img',[]);
colormap('copper');
% colorbar
% imagesc(data(:,:,80),[]);


