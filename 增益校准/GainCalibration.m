function [ single_event_data_new ] = GainCalibration( single_event_data,module,channel )
%% �����׷�λ��У׼ģ�����ͨ�����������
%% single_event_data_newΪ�����ѰУ׼֮�������
%% single_event_dataΪ���룬�ɼ��¼����ݣ�Nx5 array
%% col1:ͨ���� col2:���� col3:ʱ�� col4:ģ��� col5:�г���
%% moduleΪ���룬������ģ���ţ�int
%% channelΪ���룬������ͨ����ţ�int

%���1������ģ�黭����ͼ����ģ�鼶�������У׼
%���2������ģ�鼰ͨ��������ͼ����ͨ�����������У׼
if nargin == 2
    channel = 101;
    index = single_event_data(:,4) == module;
elseif nargin == 3
    index = single_event_data(:,4 )== module & single_event_data(:,1) == channel;
end
%ȡ������ϵ�����
data = hist(single_event_data(index,2),0:1:2048);
%��˹���
fitresult = GaussFit(data,4);
%Ѱ���׷�����
peak = PeakSearch(fitresult);
if peak<300 || peak>800
    peak = 511;
end
%���1������ģ�黭����ͼ����ģ�鼶��&ͨ�����������У׼
single_event_data(index,2) = single_event_data(index,2)*511/peak;
single_event_data_new = single_event_data;
clear peak data single_event_data index
end

