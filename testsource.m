clear
data=textread('\\192.168.1.114\share\source3-3-10.txt');
% data=textread('G:\source.txt');
data1(:,1)=floor(data(:,1)/0.5)+129;
data1(:,2)=floor(data(:,2)/0.5)+129;
% data1(:,3)=floor((data(:,3)+10)/10)+1;
pic=zeros(256,256);
for i=1:size(data1,1)
        pic(data1(i,1),data1(i,2))=pic(data1(i,1),data1(i,2))+1;
end
fid=fopen('C:\Users\twj2417\Desktop\source.s','w');
fwrite(fid,pic,'float');
fclose(fid);
figure;imshow(pic(:,:)',[])
colormap('copper');colorbar
% figure
% profile=pic(128,:);
% plot(profile);