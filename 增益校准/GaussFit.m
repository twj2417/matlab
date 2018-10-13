function [ fitresult ] = GaussFit(data,gaussOrder)
%% ��˹���
%% fitresultΪ�������˹���fit�����
%% dataΪ���룬��Ҫ��ϵ����ݣ�Nx1 array
%% gaussOrderΪ���룬��˹��ϵĽ����Ƽ�4-6��int

x=0:1:length(data)-1;
[xData, yData] = prepareCurveData( double(x), double(data) );
ft = fittype( ['gauss' int2str(gaussOrder)]);
opts = fitoptions( ft );
opts.Lower = [-Inf -Inf -Inf];
opts.Upper = [Inf Inf Inf];
[fitresult, ~] = fit( xData, yData, ft, opts );
clear xData yData ft opts x
end

