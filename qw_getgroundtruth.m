close all;clear all;clc;
sequence_path = 'D:\ImageData\David_qw\';%����·������
img_path = [sequence_path 'img\'];
intrest_frame = 1;%Ŀ��֡
% ��ȡ����ͼ��֡
dir_content = dir(img_path);
% skip '.' and '..' from the count
n_imgs = length(dir_content) - 2;
img_files = cell(n_imgs, 1);
for ii = 1:n_imgs
    img_files{ii} = dir_content(ii+2).name;%imag_files�洢����ͼ��֡�ļ���
end
img = imread([img_path img_files{intrest_frame}]);%��ȡĿ��֡
[sub_img,target_sz] = imcrop(img);%�ָ�ͼ��
pos = target_sz(1:2)+target_sz(3:4)/2;
%% ��ͼ
figure
imshow(img);
rectangle('Position',target_sz, 'EdgeColor','r');
hold on;
plot(pos(1),pos(2),'r+','MarkerSize',10);
disp([num2str(target_sz(1)),',',num2str(target_sz(2)),',',num2str(target_sz(3)),',',num2str(target_sz(4))]);