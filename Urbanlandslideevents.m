close all
clear all
subareaInPath = 'H:\CMIP6\landcovertypes\histric\landcover1000m\hkl1000\china';
subareadirectory = dir(subareaInPath); % 获取文件夹中的文件信息
subareafolderName= subareadirectory(1).name; % 获取第一个文件夹的名称
subareadirNamepath = dir(fullfile(subareaInPath, subareafolderName, '*.tif')); % 获取特定扩展名的文件

subareadaily=[];
subareayear=[];
urbanareatype=[];
for year=2007:1:2019
subareafilename = fullfile(subareaInPath ,['MODIS_LANDCOVER',num2str(year)]);
[clip,Rclip]=geotiffread(subareafilename);
% 原始和目标分辨率
originalResolution = 0.0089831528;
targetResolution = 0.01;
% 计算调整因子
resizeFactor = originalResolution / targetResolution;
% 调整图像尺寸
landcovertype = imresize(clip, resizeFactor, 'nearest');
urbanarea=sum(sum(landcovertype == 13));
urbanareatype=[urbanareatype;urbanarea];
end

allyeararea=[];
allyearurban=[];
alldailyarea=[];
alldailyurban=[];

InPath = fullfile('E:\LHASADATA\2000-2020 0.01\',num2str(year));
directory = dir(InPath); % 获取文件夹中的文件信息
folderName= directory(1).name; % 获取第一个文件夹的名称
dirNamepath = dir(fullfile(InPath, folderName, '*.tif')); % 获取特定扩展名的文件

dailyarea=[];

    for i=1:length(dirNamepath)
    filename = fullfile(InPath, dirNamepath(i).name);
    %disp(filename)
    [landslide, R_A] = geotiffread(filename);
    landslideclip = geocrop(landslide, R_A,Rclip.LatitudeLimits,Rclip.LongitudeLimits);
    % 原始和目标分辨率
    originalResolution = 0.0083333333;
    targetResolution = 0.01;
    % 计算调整因子
    resizeFactor = originalResolution / targetResolution;
    % 调整图像尺寸
    landslideclipnew = imresize(landslideclip, resizeFactor, 'nearest');
    
    urbanlandslide=(landslideclipnew==2&(landcovertype == 13));%
    urbanlandslidearea=sum(sum(urbanlandslide));%
    urbanarea=sum(sum(landcovertype == 13));

    dailyarea=[dailyarea;urbanlandslidearea];
   
    end
    alldailyarea=[alldailyarea;dailyarea];
    yearurban=nansum(dailyarea);
    allyeararea=[allyeararea;urbanarea];
    allyearurban=[allyearurban; yearurban];
%end

toc
disp('ok')