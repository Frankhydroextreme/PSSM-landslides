%如何从一个巨大的矩阵中根据经纬度来提取指定位置为中心的周围100个像元的值
%并且计算这个坐标周围的每年的城市化率

clc
clear 

imagePath = 'F:\BaiduNetdiskDownload\不透水面\GISD30_1985-2020_China.tif';
blockSize = 20;  % 块的大小（像素）
latlon=xlsread('G:\2023codes\PLSSEM\PB.xlsx','非城市滑坡','Aj2:Al753');

LEN=max(size(latlon));
RE=[];

%ration = zeros(1, LEN);

for i=1:LEN

lat = latlon(i,3);  % 指定经度
lon = latlon(i,2); % 指定纬度



% 读取图像
% 读取TIF图像和地理空间信息
%[~, cmap, R] = geotiffread(imagePath);
info = geotiffinfo(imagePath);
xWorldLimits = info.SpatialRef.LatitudeLimits;
yWorldLimits = info.SpatialRef. LongitudeLimits;
% 将经纬度转换为图像坐标
%x = round((lon - xWorldLimits(1)) / info.PixelScale(1)) + 1;
%y = round((yWorldLimits(2)-lat) / info.PixelScale(2)) + 1;

x=ceil((max(xWorldLimits)-lat)/info.PixelScale(2));
y=ceil((lon-min(yWorldLimits))/info.PixelScale(1));
% 计算以指定位置为中心的10x10范围
xStart = max(x - blockSize/2, 1);
xEnd = min(x + blockSize/2, info.Width);
yStart = max(y - blockSize/2, 1);
yEnd = min(y + blockSize/2, info.Height);

% 定义当前块的PixelRegion参数
pixelRegion = {[xStart, xEnd-1],[yStart, yEnd-1]};

% 读取指定区域的图像数据
blockImage = im2double(imread(imagePath, 'PixelRegion', pixelRegion));
subImage=blockImage(:)*255;
RE=[RE,subImage];
area=400;
  % 根据日期条件进行计算增加的比例占区域总面积（400），还是计算占不透水面的比例，看后面的结果
    date = latlon(i, 1);
    if date >= 2005 && date <= 2009
       count = sum(subImage == 6);
       
       % ration(i) = count / sum(subImage>0);
        ration(i) = count / area;
    elseif date >= 2010 && date <= 2014
        count = sum(subImage == 7);
        ration(i) = count / area;
    elseif date >= 2015 && date <= 2020
        count = sum(subImage == 8);
        ration(i) = count / area;
  
    end

end

disp('ok')




% data=xlsread('E:\降水-土壤水分和地形推求地灾发生概率\灾害的P和SSM\CHINA1.xlsx','Sheet1','A28:O6273');
% result=[];
% date=data(:,1);
% data1=data(:,2:15);
% for i=1:14
%   lu=data1(:,i);
% index=find(date==2006+i);
% value=lu(index,:);
% result=[result;value];
%     end

