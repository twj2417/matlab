function [ peak ] = PeakSearch( fitresult,Lowcut,Highcut)
%% 寻找511峰值位置
%% peak为输出，寻找到的峰值位置，int
%% fitresult为输入，高斯拟合fit结果，
%% Lowcut为输入，511能量窗的下边界，int
%% Highcut为输入，511能量窗的上边界，int

if nargin==1
    Lowcut=0;
    Highcut=2048;
end
int_index_temp=Lowcut:1:Highcut;
int_value_temp=fitresult(int_index_temp);
[~, pos]=findpeaks(int_value_temp);
peak=max(pos);
clear int_index_temp int_value_temp pos
end

