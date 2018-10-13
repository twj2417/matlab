% clear all
% close all
% clc
% for i=1:30
%     filename = ['..\..\..\data_WearableSystem\16module_Source_20180912\16module_pt1_' int2str(i)];
    addpath(genpath('\'));
    load([filename '.mat']);
%     figure;title('energy');
%     for moduleID=0:1:15
%         moduleIndex=find(single_event_data(:,4)==moduleID);
%         subplot(4,4,moduleID+1);hist(single_event_data(moduleIndex,2),0:1:2048);xlim([0 2052]);
%     end
%     figure;title('TDC');
%     for moduleID=0:1:15
%         moduleIndex=find(single_event_data(:,4)==moduleID);
%         subplot(4,4,moduleID+1);plot(single_event_data(moduleIndex,3));xlim([0 20000]);
%     end
% moduleIndex=find(single_event_data(:,4)==14);
% figure;plot(single_event_data(moduleIndex,3));  
% figure;plot(single_event_data(moduleIndex(390000:400000),5));  
% end
    

    for module=0:15
        single_event_data_new=[];
        single_event_data_new=GainCalibration( single_event_data,module);
        single_event_data=single_event_data_new;
    end
    save([filename 'GainCorrectt.mat'],'single_event_data');
%     figure;title('after');
%     for moduleID=0:1:15
%         moduleIndex=find(single_event_data(:,4)==moduleID);
%         subplot(4,4,moduleID+1);hist(single_event_data(moduleIndex,2),0:0.5:2048);xlim([0 2052]);
%     end
    clearvars except i
% end