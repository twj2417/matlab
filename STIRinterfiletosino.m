clc;clear;close all
fid=fopen('F:\brainhuan\20mm\ring20-6-2newarc.s','r');
pro=fread(fid,'float');
nrow=73;
ncol=80;
nslice=100;
%% interfile to sinogram
pro=reshape(pro,nrow,nslice,ncol);
newpro=zeros(nrow,ncol,nslice);
for i=1:nslice
    newpro(:,:,i)=squeeze(pro(:,i,:));
end
slice=sqrt(nslice);
startpoint2=0;
startpoint1=101;
for j=1-slice:slice-1
    startpoint2=startpoint2+slice-abs(j);
    if j<0
        startpoint1=startpoint1+sign(j)*2*(slice-abs(j));
        outpro(:,:,startpoint1:startpoint1+slice-abs(j)-1)=newpro(:,:,startpoint2-slice+abs(j)+1:startpoint2);
    elseif j==0
        startpoint1=startpoint1-slice;
        outpro(:,:,startpoint1:startpoint1+slice-1)=newpro(:,:,startpoint2-slice+1:startpoint2);
        startpoint1=startpoint1+slice-1;
    else
        startpoint1=startpoint1+sign(j)*2*(slice-abs(j));
        outpro(:,:,startpoint1-slice+abs(j)+1:startpoint1)=newpro(:,:,startpoint2-slice+abs(j)+1:startpoint2);
    end   
end

%%¡¡sinogram to interfile
% outpro=zeros(nrow,ncol,nslice);
% pro=reshape(pro,nrow,ncol,nslice);
% slice=sqrt(nslice);
% startpoint1=1;
% startpoint2=nslice+1;
% for j=1-slice:slice-1
%     if j<0
%         startpoint1=startpoint1+slice-abs(j)-1;
%         startpoint2=startpoint2-2*(slice-abs(j));
%         outpro(:,:,startpoint1:startpoint1+slice-abs(j)-1)=pro(:,:,startpoint2:startpoint2+slice-abs(j)-1);
%     elseif j==0
%         startpoint1=startpoint1+slice-abs(j)-1;
%         startpoint2=startpoint2-slice;
%         outpro(:,:,startpoint1:startpoint1+slice-1)=pro(:,:,startpoint2:startpoint2+slice-1);
%         startpoint2=startpoint2+slice-1;
%     else
%         startpoint1=startpoint1+slice-abs(j)+1;
%         startpoint2=startpoint2+2*(slice-abs(j));
%         outpro(:,:,startpoint1:startpoint1+slice-abs(j)-1)=pro(:,:,startpoint2-slice+abs(j)+1:startpoint2);
%     end   
% end
% newpro=zeros(nrow,nslice,ncol);
% for i=1:nslice
%     newpro(:,i,:)=outpro(:,:,i);
% end

fid1=fopen('F:\brainhuan\20mm\ring20-6-2newarcnew.s','w');
fwrite(fid1,outpro,'float');