%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%qw_runTracker相关跟踪初始函数
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    close all;clear all;clc;
% RUN_TRACKER  is the external function of the tracker - does initialization and calls trackerMain
    sequence = 'D:\ImageData\David_qw\';%设置路径名称
    [params,im] = qw_LoadImage(sequence);%读取图片
    [params, bg_area, fg_area, area_resize_factor] = initializeAllAreas(im, params);
% 	if params.visualization%为1时画图，0时不画图
% 		params.videoPlayer = vision.VideoPlayer('Position', [100 100 [size(im,2), size(im,1)]+30]);
% 	end
    % if fout<0 we do not output anything
	params.fout = -1;
	% start the actual tracking
% 	trackerMain(params, im, bg_area, fg_area, area_resize_factor);
    result = qw_trackerMain(params, im, bg_area, area_resize_factor);
    fclose('all');
    show_precision(result.pos, params.bb_VOT, sequence);%计算误差值（groundtruth完备情况下）
    disp('程序已正常结束');