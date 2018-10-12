%%
% inter =45;
% phi = 0:pi/inter:(pi*2-pi/inter);
% theta = 0:pi/inter:(pi-pi/inter);
% r = 150;
% X = r*sin(theta')*cos(phi);
% Y = r*sin(theta')*sin(phi);
% Z = r*cos(theta')*ones(1,inter*2);
% X = reshape(X,inter^2*2,1);
% Y = reshape(Y,inter^2*2,1);
% Z = reshape(Z,inter^2*2,1);
% scatter3(X,Y,Z,'r*');
%% the S-PET total area 
% arrange the crystals on the semi-sphere in the order of 1,3,5,...,2n-1.
% all of the crystals are of the same size.
innerR = 10;
outerR = 50;
% area = 4*pi*TotalLevel^2-2*pi*TotalLevel^2*(1-cos(pi/6));
% the area of each piece
areaFactor = 4;
crystA = 2*pi/areaFactor;
TotalLevel = floor(sqrt(innerR^2*2*pi/crystA/areaFactor));
% the number of crystals in each level
nCrysPerLevel =1:2:(2*TotalLevel-1);
CosTheta = zeros(TotalLevel,1);
CosTheta(1) = 1-nCrysPerLevel(1)/TotalLevel^2;
for i =2:1:TotalLevel
    CosTheta(i) = CosTheta(i-1)-nCrysPerLevel(i)/TotalLevel^2;
end
% the last level is the big circle of the sphere, that is , the bottom
% edge.
CosTheta(TotalLevel) = 0;
SinTheta = (1-CosTheta.^2).^(0.5);
%calculate the intervals between two levels. 
Lpolar = zeros(length(CosTheta)-1,1);
for i =1:1:length(Lpolar-1)
    Lpolar(i) = (innerR^2*((CosTheta(i+1)-CosTheta(i))^2+(SinTheta(i+1)-SinTheta(i))^2))^(0.5);
end
plot(SinTheta,CosTheta,'r*');
% calcualte the azimuth angle of each level
Phi = zeros((TotalLevel^2+TotalLevel)*areaFactor,1);

for i=1:1:TotalLevel
    for j= 1:1:(2*i)*areaFactor
        ii = (i^2-i)*areaFactor;
        Phi(ii+j) = j*2*pi/(2*i)/areaFactor;
    end
    
end
SinPhi = sin(Phi);
CosPhi = cos(Phi);

% initialize the array for the vertices of all the peices.
X = zeros(TotalLevel^2*areaFactor,2);
Y = zeros(TotalLevel^2*areaFactor,2);
Z = zeros(TotalLevel^2*areaFactor,2);
Z(1:areaFactor,:) = innerR;
%%%plot the pieces of the semi-sphere
figure;
hold;
for i=2:1:TotalLevel-1
    for j = 1:1:(2*i)*areaFactor
        %the two points of the same azimuth angle on the two edges in a
        %strip
        ii = (i^2-i)*areaFactor;
        X(ii+j,1) = innerR*SinTheta(i)*CosPhi(ii+j);
        X(ii+j,2) = innerR*SinTheta(i+1)*CosPhi(ii+j);
        Y(ii+j,1) = innerR*SinTheta(i)*SinPhi(ii+j);
        Y(ii+j,2) = innerR*SinTheta(i+1)*SinPhi(ii+j);
        Z(ii+j,1) = innerR*CosTheta(i);
        Z(ii+j,2) = innerR*CosTheta(i+1);
        v1 = [X(ii+j,1), Y(ii+j,1),Z(ii+j,1)];
        v2 = [X(ii+j,2), Y(ii+j,2),Z(ii+j,2)];
        % connect the points with same azimuth angle.
        plot3([v1(1),v2(1)],[v1(2),v2(2)],[v1(3),v2(3)],'b','LineWidth',1.5);
        if(j>1) %connect the two neighbor points on one edge 
            v3 = [X(ii+j-1,1), Y(ii+j-1,1),Z(ii+j-1,1)];
            v4 = [X(ii+j-1,2), Y(ii+j-1,2),Z(ii+j-1,2)];
            plot3([v1(1),v3(1)],[v1(2),v3(2)],[v1(3),v3(3)],'r','LineWidth',1.5);
            plot3([v2(1),v4(1)],[v2(2),v4(2)],[v2(3),v4(3)],'r','LineWidth',1.5);
        end
        if(j==(2*i)*areaFactor)% connect the first and last point when it goes a circle.
            v3 = [X(ii+1,1), Y(ii+1,1),Z(ii+1,1)];
            v4 = [X(ii+1,2), Y(ii+1,2),Z(ii+1,2)];
            plot3([v1(1),v3(1)],[v1(2),v3(2)],[v1(3),v3(3)],'r','LineWidth',1.5);
            plot3([v2(1),v4(1)],[v2(2),v4(2)],[v2(3),v4(3)],'r','LineWidth',1.5);
        end
    end
end

% calculate the intervals between two a 
Lazimuth = zeros(length(CosTheta),1);
for i = 2:1:length(Lazimuth)
    ii = (i^2-i)*areaFactor;
    Lazimuth(i) = sqrt((X(ii+1,2)-X(ii+2,2))^2+(Y(ii+1,2)-Y(ii+2,2))^2+(Z(ii+1,2)-Z(ii+2,2))^2);
end
%mark the vertices of the pieces
scatter3(X(:,1),Y(:,1),Z(:,1),'r*');
scatter3(X(:,2),Y(:,2),Z(:,2),'b*');