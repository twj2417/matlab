function [ fitresult ] = GaussFit(data,gaussOrder)
%% 高斯拟合
%% fitresult为输出，高斯拟合fit结果，
%% data为输入，需要拟合的数据，Nx1 array
%% gaussOrder为输入，高斯拟合的阶数推荐4-6，int

x=0:1:length(data)-1;
[xData, yData] = prepareCurveData( double(x), double(data) );
ft = fittype( ['gauss' int2str(gaussOrder)]);
opts = fitoptions( ft );
opts.Lower = [-Inf -Inf -Inf];
opts.Upper = [Inf Inf Inf];
[fitresult, ~] = fit( xData, yData, ft, opts );
clear xData yData ft opts x
end

