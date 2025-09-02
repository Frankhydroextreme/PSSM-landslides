
clc
clear 
close all


% lon 为原数据的lon
% lat 为原数据的lat
% var 为原始数据（变量）
% shp_file为要裁剪的shp file

% lon=min(R.LongitudeLimits):0.01:max(R.LongitudeLimits);
% lat=min(R.LatitudeLimits):0.01:max(R.LatitudeLimits);
% 
% [xx, yy] = meshgrid(lon, lat);
% xx(:,end)=[];
% xx(end,:)=[];
% yy(:,end)=[];
% yy(end,:)=[];
% 
% kk = 3;
% out = [shpfile(kk).X; shpfile(kk).Y]';
% index = inpolygon(xx, yy, out(:,1), out(:,2));
% 
% index=flipud(index);
% index(index == 0) = nan; % 将非多边形内的值设置为NaN
% geotiffwrite(fullfile(['E:\降水-土壤水分和地形推求地灾发生概率\手稿修改\手稿意见\Figure\New\test.tif']),index,R)
% %end




% shpfile = shaperead('E:\降水-土壤水分和地形推求地灾发生概率\灾害的P和SSM\liuyumergeWGS1984.shp');
% [impervious,R]=geotiffread('E:\降水-土壤水分和地形推求地灾发生概率\灾害的P和SSM\GISDimproviousclip0.01.tif');
% numRegions = length(shpfile);
% summaryStats = zeros(numRegions, 1);  % Modify this line if you need more statistics
% % Loop through each region in the shapefile
% 
% allre=[];
% for k = 1:numRegions
%     all=[];
%        % 获取当前要素的边界框坐标
%     bbox = shpfile(k).BoundingBox;
%     minlon = bbox(1);
%     maxlon = bbox(2);
%     minlat = bbox(3);
%     maxlat = bbox(4);
% % 根据边界框坐标确定栅格中对应区域的像素范围
%   r1=ceil((minlat-min(R.LatitudeLimits))/0.01);
%   c1=ceil((minlon-min(R.LongitudeLimits))/0.01);
%   r2=ceil((maxlat-min(R.LatitudeLimits))/0.01);
%   c2=ceil((maxlon-min(R.LongitudeLimits))/0.01);
% 
%   data=impervious(r1:r2,c1:c2);
%   a=sum(sum(data==1));
%   b=sum(sum(data==2));
%   c=sum(sum(data==3));
%   d=sum(sum(data==4));
%   e=sum(sum(data==5));
%   f=sum(sum(data==6));
%   g=sum(sum(data==7));
%   h=sum(sum(data==8));
% all=[a;b;c;d;e;f;g;h];
% allre=[allre,all];
% end


InPath = 'E:\降水-土壤水分和地形推求地灾发生概率\灾害的P和SSM\subarea\0.01';
directory = dir(InPath); % 获取文件夹中的文件信息
folderName= directory(1).name; % 获取第一个文件夹的名称
dirNamepath = dir(fullfile(InPath, folderName, '*.tif')); % 获取特定扩展名的文件

allre=[];
for j=1:length(dirNamepath)
    all=[];
    filename = fullfile(InPath, dirNamepath(j).name);
    data=imread(filename);
    a=sum(sum(data==1));
    b=sum(sum(data==2));
    c=sum(sum(data==3));
    d=sum(sum(data==4));
    e=sum(sum(data==5));
    f=sum(sum(data==6));
    g=sum(sum(data==7));
    h=sum(sum(data==8));
    all=[a;b;c;d;e;f;g;h];
    allre=[allre,all];

end
%allre=allre.*30*30/1000/1000;
%allre=allre.*(0.00026949459/0.01)^2;
h = bar(allre', 'stacked');
labels = {'HAIRB','HUAIRB','NWRB','PRB', 'SERB','SLRB','SWRB','YLRB','YZRB'};

%labels = {'SLRB','NWRB','HAIRB','YLRB','HUAIRB','YZRB','SWRB','SERB','PRB'}
% 设置每一组堆积柱形图的颜色
h(1).FaceColor = [82 93 169]/256;
h(2).FaceColor = [27 112 176]/256;
h(3).FaceColor = [63 164 201]/256;
h(4).FaceColor = [119 204 197]/256;
h(5).FaceColor = [177 227 190]/256;
h(6).FaceColor = [216 241 214]/256;
h(7).FaceColor = [243 190 116]/256;
h(8).FaceColor = [192 158 159]/256;

% 设置x轴的刻度和标签
set(gca, 'XTick', 1:length(labels));
set(gca, 'XTickLabel', labels);
% 隐藏边框
box off;
set(gca,'FontName','Times New Roman', 'FontSize', 28);

xlabel('River basin area','FontName','Times New Roman', 'FontSize', 28);
ylabel('Urban area (km^2)','FontName','Times New Roman', 'FontSize', 28);
set(gcf,'Color',[1 1 1])
set(gca,'LineWidth',1.5); 
%h=legend({'Before1985', '1985-1990', '1990-1995', '1995-2000', '2000-2005', '2005-2010', '2010-2015', '2015-2020'},'FontSize',18,'location','best');   
%set(h,'Box','off','Orientation','vertical');

%text(1,46000,'(b)','FontSize',22,'fontname','Times New Roman')

% 设置图像保存时的尺寸这里的关键是 PaperUnits, PaperSize, PaperPositionMode, 和 PaperPosition 属性。
% 这些属性确保您在打印或保存图像时可以控制输出的尺寸。
% 在这个示例中，输出图像的大小被设置为 16 英寸宽，8 英寸高。您可以根据需要调整这些值。
set(gcf, 'PaperUnits', 'centimeter');
set(gcf, 'PaperSize', [36 18]);
set(gcf, 'PaperPositionMode', 'manual');
set(gcf, 'PaperPosition', [0 0 36 18]);

print('basinarea','-dtiff','-painters','-r600');

disp('done');




% %读取shp文件
% shape = shaperead('shapefile.shp');
% % 读取 netCDF 文件
% nc = ncinfo('data.nc');
% data = ncread('data.nc', 'data');
% % 确定裁剪区域
% lon = ncread('data.nc', 'lon');
% lat = ncread('data.nc', 'lat');
% lonlim = [min(shape.X) max(shape.X)];
% latlim = [min(shape.Y) max(shape.Y)];
% ilat = find(lat >= latlim(1) & lat <= latlim(2));
% ilon = find(lon >= lonlim(1) & lon <= lonlim(2));
% 
% % 裁剪数据
% data_new = data(ilon, ilat);
% data_new = maskregion(lon,lat,var,shape);
% 
% 
% 
% function varout = maskregion(lon,lat,var,shp_file)
% % lon 为原数据的lon
% % lat 为原数据的lat
% % var 为原始数据（变量）
% % shp_file为要裁剪的shp file
% [xx,yy]=meshgrid(lon,lat);
% index=zeros(size(var,2),size(var,1));
% for kk=1:length(shp_file)
%     out=[W(kk).X ;W(kk).Y]';
%     aa = inpolygon(xx,yy,out(:,1),out(:,2)) +0;
%     try
%         index=index+aa;
%     catch
%         index=index+aa';
%     end
% end
% index(index==0)=nan;
% for kk=1:size(var,3)
%     varout(:,:,kk)=var(:,:,kk).*index';
% end
% end
% 
% 
% 
% % 创建一个新的 netCDF 文件并写入裁剪后的数据
% ncwriteatt('data_cropped.nc', '/', 'Conventions', 'CF-1.6');
% ncwriteatt('data_cropped.nc', '/', 'title', 'Cropped Data');
% ncwriteatt('data_cropped.nc', '/', 'history', ['Created on ' datestr(now)]);
% ncwrite('data_cropped.nc', 'lon', lon(ilon));
% ncwrite('data_cropped.nc', 'lat', lat(ilat));
% ncwrite('data_cropped.nc', 'data_new', data_new);
% 





