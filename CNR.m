close all
avg=zeros(6,10);
contrast=zeros(6,10);
% for ii=1:50
%     fileName=strcat('C:\Users\twj2417\Desktop\HRRT\eight\HRRT-eighth_',num2str(ii),'.rec');
%     data=load(fileName,'r');
%     data=reshape(data,[64 64 16]);
%     dataT=squeeze(data(:,:,8));
%     dataT=imresize(dataT,[256 256]);
% %     figure; 
%     imshow(dataT,[0,1000]);
% %     fid=fopen('C:\Users\twj2417\Desktop\a.s','w');
% %     fwrite(fid,dataT,'float');
% %     fclose(fid);
    II=zeros(256,256);
    radius=[10 13 17 22 28 37];
    for i=1:256
        for j=1:256
            temp=(i-128)^2+(j-128)^2;
            if(temp<124^2&&temp>=34^2)
                II(i,j)=1;
                II(i,j,1)=20;
                II(i,j,2)=20;
                II(i,j,3)=200;
            end
            if (temp<34^2)
                II(i,j)=-1;
                II(i,j,3)=255;
            end
        end
    end
    for k=1:6
        center1=80*sin(k*60*pi/180)+256/2;
        center2=80*cos(k*60*pi/180)+256/2;
        for i=1:256
            for j=1:256
                temp=(i-center1)^2+(j-center2)^2;
                if(temp<=radius(k)^2)
                    II(i,j)=k+2;
                    II(i,j,1)=255;
                    II(i,j,2)=255;
                    II(i,j,3)=255;
                end
                if(temp<=radius(k)^2&&temp>=(radius(k)-2)^2)
                    II(i,j,1)=255;
                    II(i,j,2)=0;
                    II(i,j,3)=0;
                end
            end
        end
    end
    figure;imshow(II,[]);
%     fid=fopen('C:\Users\twj2417\Desktop\b.s','w');
%     fwrite(fid,II,'float');
%     fclose(fid);
%     avg(:,ii)=zeros(6,1);
%     ind=find(II==-1);
%     stand_devi=std(dataT(ind));
%     avg_bg=sum(dataT(ind))/size(ind,1);
    % contrast=avg;
%     for i=1:6
%         ind=find(II==i+2);
%         avgT=sum(dataT(ind))/size(ind,1);
% %         avg(i,ii)=(avgT-avg_bg)/stand_devi;
%         stand_devi=std(dataT(ind));
%         avg(i,ii)=(avgT)/stand_devi;
%         contrast(i,ii)=avgT;
%     end
% end
% avg
% % contrast