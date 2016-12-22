%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%qw_runTracker��ظ��ٳ�ʼ����
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    close all;clear all;clc;
% RUN_TRACKER  is the external function of the tracker - does initialization and calls trackerMain
    sequence = 'D:\ImageData\David_qw\';%����·������
    [params,im] = qw_LoadImage(sequence);%��ȡͼƬ
    [params, bg_area, fg_area, area_resize_factor] = initializeAllAreas(im, params);
% 	if params.visualization%Ϊ1ʱ��ͼ��0ʱ����ͼ
% 		params.videoPlayer = vision.VideoPlayer('Position', [100 100 [size(im,2), size(im,1)]+30]);
% 	end
    % if fout<0 we do not output anything
	params.fout = -1;
	% start the actual tracking
% 	trackerMain(params, im, bg_area, fg_area, area_resize_factor);
    result = qw_trackerMain(params, im, bg_area, area_resize_factor);
    fclose('all');
    show_precision(result.pos, params.bb_VOT, sequence);%�������ֵ��groundtruth�걸����£�
    disp('��������������');