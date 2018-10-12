clc;close all;clear;
fid=fopen('F:\shiermianti\yuanpansmall.s','r');
I=fread(fid,'float');
fclose(fid);
row=288;
col=288;
slice=576;
I=reshape(I,row,col,slice);
% II=I(:,:,1:24);
% fid1=fopen('F:\shiermianti\yuanpan2no.s','wb');
% fwrite(fid1,II,'float');
% fclose(fid1);
II=1/4*[1,0,1;0,0,0;1,0,1];
III=I;
for k=1:slice
    for i=1:row-2
        for j=1:col-2
            temp=I(i:i+2,j:j+2,k);
            if III(i+1,j+1,k)==0
                III(i+1,j+1,k)=sum(sum(temp.*II));
            end
        end
    end
end
            
