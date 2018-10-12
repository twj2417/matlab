ellip=zeros(100,100,25);
for i=1:100
    for j=1:100
        if (i-50)^2+(j-50)^2<=2500
            ellip(i,j,1)=1;
            ellip(i,j,25)=1;
            ellip(i,j,5)=1;
            ellip(i,j,21)=1;
            ellip(i,j,9)=1;
            ellip(i,j,17)=1;
            ellip(i,j,13)=1;
        end
    end
end
fid=fopen('F:\shiermianti\defrise.s','wb');
fwrite(fid,ellip,'float');
fclose(fid);

