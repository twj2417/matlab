function [ peak ] = PeakSearch( fitresult,Lowcut,Highcut)
%% Ѱ��511��ֵλ��
%% peakΪ�����Ѱ�ҵ��ķ�ֵλ�ã�int
%% fitresultΪ���룬��˹���fit�����
%% LowcutΪ���룬511���������±߽磬int
%% HighcutΪ���룬511���������ϱ߽磬int

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

