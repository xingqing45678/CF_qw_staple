function [params,im] = qw_LoadImage(sequence)
    %% 读取文件 params.txt
        params = readParams('params.txt');%读取文件，初始化参数
        %% 加载视频信息
    	start_frame = 1;%开始帧
        sequence_path = sequence;
        img_path = [sequence_path 'img\'];%设置图像路径
        params.bb_VOT = csvread([sequence_path 'groundtruth_rect.txt']);
        region = params.bb_VOT(start_frame,:);%读取groundtruth的第一行8个数据
        %%%%%%%%%%%%%%%%%%%%%%%%%
        % 读取所有图像帧
        dir_content = dir(img_path);
        % skip '.' and '..' from the count
        n_imgs = length(dir_content) - 2;
        img_files = cell(n_imgs, 1);
        for ii = 1:n_imgs
            img_files{ii} = dir_content(ii+2).name;%imag_files存储所有图像帧文件名
        end
        img_files(1:start_frame-1)=[];
        im = imread([img_path img_files{start_frame}]);%将第一幅图像读入
        % 判断是否灰度图像 ?
        if(size(im,3)==1)
            params.grayscale_sequence = true;
        end
        params.img_files = img_files;%将图像名赋给参数表params
        params.img_path = img_path;%将图像路径赋给参数表params
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        if(numel(region)==8)%返回图像像素或数组元素个数
            % polygon format
            [cx, cy, w, h] = getAxisAlignedBB(region);%从真实数据中提取轴对齐边界框作为旋转图像
        else
            x = region(1);
            y = region(2);
            w = region(3);
            h = region(4);
            cx = x+w/2;
            cy = y+h/2;
        end
        % init_pos 是范围框的中心（is the centre of the initial bounding box）
        params.init_pos = [cy cx];
        params.target_sz = round([h w]);%四舍五入往最近的整数靠拢
    end