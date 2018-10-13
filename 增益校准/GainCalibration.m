function [ single_event_data_new ] = GainCalibration( single_event_data,module,channel )
%% 根据谱峰位置校准模块或者通道级别的增益
%% single_event_data_new为输出，寻校准之后的数据
%% single_event_data为输入，采集事件数据，Nx5 array
%% col1:通道号 col2:能量 col3:时间 col4:模块号 col5:列车号
%% module为输入，分析的模块编号，int
%% channel为输入，分析的通道编号，int

%情况1：根据模块画能谱图，做模块级别的增益校准
%情况2：根据模块及通道画能谱图，做通道级别的增益校准
if nargin == 2
    channel = 101;
    index = single_event_data(:,4) == module;
elseif nargin == 3
    index = single_event_data(:,4 )== module & single_event_data(:,1) == channel;
end
%取进行拟合的数据
data = hist(single_event_data(index,2),0:1:2048);
%高斯拟合
fitresult = GaussFit(data,4);
%寻找谱峰增益
peak = PeakSearch(fitresult);
if peak<300 || peak>800
    peak = 511;
end
%情况1：根据模块画能谱图，做模块级别&通道级别的增益校准
single_event_data(index,2) = single_event_data(index,2)*511/peak;
single_event_data_new = single_event_data;
clear peak data single_event_data index
end

