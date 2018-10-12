close all
fid1=fopen('F:\shiermianti\yuanpan2.s','r');
I=fread(fid1,'float');
fclose(fid1);
I=reshape(I,288,288,24*24);
%subplot(1,2,1);
img=I(:,:,12);
imshow(img,[]);
% fid2=fopen('F:\result\newdatabb_8.v','r');
% II=fread(fid2,'float');
% fclose(fid2);
% II=reshape(II,200,200,63);
%subplot(1,3,2);imshow(II(:,:,32),[]);
% fid3=fopen('F:\result\newdatazz_8.v','r');
% III=fread(fid3,'float');
% fclose(fid3);
% III=reshape(III,200,200,63);
% subplot(1,3,3);imshow(III(:,:,32),[]);
% fid3=fopen('F:\result\ecatpantotal_8.v','r');
% III=fread(fid3,'float');
% fclose(fid3);
% III=reshape(III,200,200,63);
% figure;imshow(III(:,:,32),[0 0.0252]);colorbar;
% a=I(:,:,32)./II(:,:,32);
% max(a(:))
% min(a(:))
% subplot(1,2,2);imshow(a,[0,1]);