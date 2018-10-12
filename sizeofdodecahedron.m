Inradius=15;
l_edge=Inradius*20/sqrt(250+110*sqrt(5));  %正五边形边长
r_circu=l_edge/2/sin(36/180*pi);  %五边形外接圆半径
rec_length=l_edge*sin(54/180*pi)*2;   %长方形的长
rec_width=l_edge*cos(54/180*pi)+l_edge*cos(18/180*pi);  %长方形的宽
theta=54/180*pi;
fi=pi-acos(sqrt(5)/5);
thickness=2;
%% 第一种直角三角形
Tri1_length=l_edge*sin(theta);
Tri1_width=l_edge*cos(theta);
Tril_x_trans=rec_length/2-Tri1_length/4;
Tril_y_trans=rec_width/2-Tri1_width/2;
%% 第二种直角三角形
Tri2_length=l_edge*sin(18/180*pi);
Tri2_width=l_edge*cos(18/180*pi);
Tri2_x_trans=rec_length/2-Tri2_length/4;
Tri2_y_trans=rec_width/2-Tri2_width/2;
%% 第一个面
a11=[-l_edge/2,l_edge/2*tan(theta),-Inradius];
a12=[l_edge/2,l_edge/2*tan(theta),-Inradius];
a13=[0,-l_edge/2/cos(theta),-Inradius];
%定义两个向量
p1_vect1=a11-a12;
p1_vect2=a13-(a11+a12)/2;
rec_center1=((a11+a12)/2+a13)/2;
trans_position1=rec_center1+thickness/2*cross(p1_vect2,p1_vect1)/norm(cross(p1_vect1,p1_vect2));
%% 第二个面
a21=[-l_edge/2,l_edge/2*tan(theta),-Inradius];
a22=[l_edge/2,l_edge/2*tan(theta),-Inradius];
v2=[1,0,0];  %对称轴
t=2*pi-fi;
h=makehgtform('axisrotate',v2,t);
a23=[h(1:3,1:3)*p1_vect2(:)]'+(a21+a22)/2;
p2_vect1=a21-a22;
p2_vect2=a23-(a21+a22)/2;
rec_center2=((a21+a22)/2+a23)/2;
trans_position2=rec_center2+thickness/2*cross(p2_vect1,p2_vect2)/norm(cross(p2_vect1,p2_vect2));
%% 第三个面
a31=[l_edge/2,l_edge/2*tan(theta),-Inradius];
v2=[0,0,1];  
t=108*pi/180;
h=makehgtform('axisrotate',v2,t);
v2=h(1:3,1:3)*p1_vect1(:);
t=2*pi-fi;
h=makehgtform('axisrotate',v2,t);
a32=[h(1:3,1:3)*p1_vect1(:)]'+a31;
a33=[h(1:3,1:3)*p1_vect2(:)]'+(a31+a32)/2;
p3_vect1=a31-a32;
p3_vect2=a33-(a31+a32)/2;
rec_center3=((a31+a32)/2+a33)/2;
trans_position3=rec_center3-thickness/2*cross(p3_vect1,p3_vect2)/norm(cross(p3_vect1,p3_vect2));
%% 第四个面
a43=[0,-l_edge/2/cos(theta),-Inradius];
v2=[0,0,1];  
t=2*108*pi/180;
h=makehgtform('axisrotate',v2,t);
v2=h(1:3,1:3)*p1_vect1(:);
t=fi;
h=makehgtform('axisrotate',v2,t);
mid=a43-[h(1:3,1:3)*p1_vect2(:)]';
a41=mid+[1/2*h(1:3,1:3)*p1_vect1(:)]';
a42=mid-[1/2*h(1:3,1:3)*p1_vect1(:)]';
p4_vect1=a41-a42;
p4_vect2=a43-(a41+a42)/2;
rec_center4=((a41+a42)/2+a43)/2;
trans_position4=rec_center4+thickness/2*cross(p4_vect1,p4_vect2)/norm(cross(p4_vect1,p4_vect2));
%% 第五个面
a51=a41;
a51(1,1)=-a51(1,1);
a52=a42;
a52(1,1)=-a52(1,1);
a53=a43;
a53(1,1)=-a53(1,1);
p5_vect1=a51-a52;
p5_vect2=a53-(a51+a52)/2;
rec_center5=((a51+a52)/2+a53)/2;
trans_position5=rec_center5-thickness/2*cross(p5_vect1,p5_vect2)/norm(cross(p5_vect1,p5_vect2));
%% 第六个面
a61=a31;
a61(1,1)=-a61(1,1);
a62=a32;
a62(1,1)=-a62(1,1);
a63=a33;
a63(1,1)=-a63(1,1);
p6_vect1=a61-a62;
p6_vect2=a63-(a61+a62)/2;
rec_center6=((a61+a62)/2+a63)/2;
trans_position6=rec_center6+thickness/2*cross(p6_vect1,p6_vect2)/norm(cross(p6_vect1,p6_vect2));
%% 第七个面
a71=-a51;
a72=-a52;
a73=-a53;
p7_vect1=a71-a72;
p7_vect2=a73-(a71+a72)/2;
rec_center7=((a71+a72)/2+a73)/2;
trans_position7=rec_center7+thickness/2*cross(p7_vect1,p7_vect2)/norm(cross(p7_vect1,p7_vect2));
%% 第八个面
a81=-a61;
a82=-a62;
a83=-a63;
p8_vect1=a81-a82;
p8_vect2=a83-(a81+a82)/2;
rec_center8=((a81+a82)/2+a83)/2;
trans_position8=rec_center8-thickness/2*cross(p8_vect1,p8_vect2)/norm(cross(p8_vect1,p8_vect2));
%% 第九个面
a91=-a21;
a92=-a22;
a93=-a23;
p9_vect1=a91-a92;
p9_vect2=a93-(a91+a92)/2;
rec_center9=((a91+a92)/2+a93)/2;
trans_position9=rec_center9-thickness/2*cross(p9_vect1,p9_vect2)/norm(cross(p9_vect1,p9_vect2));
%% 第十个面
a101=-a31;
a102=-a32;
a103=-a33;
p10_vect1=a101-a102;
p10_vect2=a103-(a101+a102)/2;
rec_center10=((a101+a102)/2+a103)/2;
trans_position10=rec_center10+thickness/2*cross(p10_vect1,p10_vect2)/norm(cross(p10_vect1,p10_vect2));
%% 第十一个面
a111=-a41;
a112=-a42;
a113=-a43;
p11_vect1=a111-a112;
p11_vect2=a113-(a111+a112)/2;
rec_center11=((a111+a112)/2+a113)/2;
trans_position11=rec_center11-thickness/2*cross(p11_vect1,p11_vect2)/norm(cross(p11_vect1,p11_vect2));