clc
clear
III=textread('F:\shiermianti\points.txt');
m=size(III,1);
for i=1:2:m
    if abs(III(i,3))<30&&abs(III(i+1,3))<10
        plot([III(i,1),III(i+1,1)],[III(i,2),III(i+1,2)]);
        hold on
    end
end
