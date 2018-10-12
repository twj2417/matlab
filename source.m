clear
txt=textread('C:\Users\jwd\Desktop\sensitivity100.txt');
m=size(txt,1);
% img=zeros(512,512);
num=0;
num1=0;
for i=1:m-1
    if txt(i+1,1)==txt(i,1)&&abs(txt(i+1,2)-txt(i,2))<=8*10^-9
%         if (txt(i,5)+txt(i+1,5))==12&&abs(txt(i,5)-txt(i+1,5))==2
%             row=floor(txt(i,2)/0.23)+256;
%             col=floor(txt(i,3)/0.23)+256;
%             img(row,col)=img(row,col)+1;
             num=num+1;
             if txt(i+1,4)==0&&txt(i,4)==0
                 num1=num1+1;
%                 II(2*num1-1:2*num1,:)=txt(i:i+1,4:6);
             end
%          end
    end
end
% [m,n]=size(img);
% imshow(img,[]);colormap('Copper');colorbar
% hold on
% x=1:512;
% yy=225*ones(512,1);
% plot(x,yy,'-');
% line=img(256,:);
% figure;plot(x,line);
% fid=fopen('C:\Users\twj2417\Desktop\source1.s','w');
% fwrite(fid,img,'float');
% fclose(fid);