function [params,im] = qw_LoadImage(sequence)
    %% ��ȡ�ļ� params.txt
        params = readParams('params.txt');%��ȡ�ļ�����ʼ������
        %% ������Ƶ��Ϣ
    	start_frame = 1;%��ʼ֡
        sequence_path = sequence;
        img_path = [sequence_path 'img\'];%����ͼ��·��
        params.bb_VOT = csvread([sequence_path 'groundtruth_rect.txt']);
        region = params.bb_VOT(start_frame,:);%��ȡgroundtruth�ĵ�һ��8������
        %%%%%%%%%%%%%%%%%%%%%%%%%
        % ��ȡ����ͼ��֡
        dir_content = dir(img_path);
        % skip '.' and '..' from the count
        n_imgs = length(dir_content) - 2;
        img_files = cell(n_imgs, 1);
        for ii = 1:n_imgs
            img_files{ii} = dir_content(ii+2).name;%imag_files�洢����ͼ��֡�ļ���
        end
        img_files(1:start_frame-1)=[];
        im = imread([img_path img_files{start_frame}]);%����һ��ͼ�����
        % �ж��Ƿ�Ҷ�ͼ�� ?
        if(size(im,3)==1)
            params.grayscale_sequence = true;
        end
        params.img_files = img_files;%��ͼ��������������params
        params.img_path = img_path;%��ͼ��·������������params
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        if(numel(region)==8)%����ͼ�����ػ�����Ԫ�ظ���
            % polygon format
            [cx, cy, w, h] = getAxisAlignedBB(region);%����ʵ��������ȡ�����߽����Ϊ��תͼ��
        else
            x = region(1);
            y = region(2);
            w = region(3);
            h = region(4);
            cx = x+w/2;
            cy = y+h/2;
        end
        % init_pos �Ƿ�Χ������ģ�is the centre of the initial bounding box��
        params.init_pos = [cy cx];
        params.target_sz = round([h w]);%���������������������£
    end