dddclear
%% single数据 一个single一行数据
txt=textread('F:\资料\脑部PET\evaluation\cylinder\cylinder5.txt');  %第一列eventID,第二列blockID，第三至五列光子坐标
0
% txt=output;
% txt=[txt0(:,1),txt0(:,3:5)];
% txt=txt0;
n=size(txt,1);
txt1=txt(1:n-1,1);
txt2=txt(2:n,1);
diff=txt2-txt1;
clear txt1 txt2
index=find(diff==0);
index1=index+1;
m=size(index,1);
num=num2str(m);
fid1=fopen('F:\资料\脑部PET\evaluation\hoffman\hoffman13new.txt.hdr','w');
fprintf(fid1,'%s\n',num);
fclose(fid1);
parfor i=1:m
    II1(i,:)=txt(index(i),3:5);
    II2(i,:)=txt(index1(i),3:5);
    II3(i,:)=txt(index(i),2);
    II4(i,:)=txt(index1(i),2);
end
% clear txt
III=[II1 II2 II3 II4];
1
output=III;
[num_row,num_col]=size(output);
fid=fopen('F:\资料\脑部PET\evaluation\cylinder\cylinder5new.txt','w');
for p=1:num_row
    fprintf(fid,'%g\t%g\t%g\t%g\t%g\t%g\t%g\t%g\n',output(p,1),output(p,2),output(p,3),output(p,4),output(p,5),output(p,6),output(p,7),output(p,8));   
end
fclose(fid);