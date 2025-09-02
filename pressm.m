% 创建示例数据
clear all
clc
close all
china=xlsread('E:\降水-土壤水分和地形推求地灾发生概率\灾害的P和SSM\NEW\CHINAlandslidesSM.xlsx', 'ALL','C2:AI6622');
nanRows = any(isnan(china), 2);

% 删除含有空值的行
china = china(~nanRows, :);
x = china(:,29)/10;%表层土壤水
y = china(:,23);%累计2天降水
labels = china(:,32);
% 根据类别创建颜色向量
colorMap = [95 198 201; 250 192 15]/255;  % 自定义颜色映射，示例中使用红色和蓝色
  % 根据标签值选择颜色
figure;
subplot(2,3,1)
colors = colorMap(labels+1, :);
% 绘制散点图
scatter(x, y, 15, colors, 'filled');

% 添加趋势线和公式
hold on;
x1 = x(labels == 1);
y1 = y(labels == 1);
% 找到 y1 中不等于 0 的元素的索引
nonZeroIndices = y1 ~= 0;

% 使用非零索引来过滤 x1 和 y1
x1 = x1(nonZeroIndices);
y1 = y1(nonZeroIndices);


fun = @(coeffs, x) coeffs(1) * exp(coeffs(2) * (x+coeffs(3)));

% 初始参数猜测
guess_coeffs = [1, 1,1];
lb = [0.0001, 0.0001,0.0001]; % 下限
ub = [Inf, Inf, Inf]; % 上限设置为无穷大，表示不设上限
% 使用最小二乘法进行拟合
fit_coeffs = lsqcurvefit(fun, guess_coeffs, x1, y1, lb, ub);
fitfun=@(x)fit_coeffs(1) * exp(fit_coeffs(2) * (x+fit_coeffs(3)));
x_fit = linspace(min(x1), max(x1), 1000);
y_fit = fitfun(x_fit);

plot(x_fit, y_fit, 'Color', [1 86 153] / 255, 'LineWidth', 2);
% 计算置信区间
zValue=1.96;
n=length(y_fit);
fitDelta=std(y_fit)/n^0.5;
upperConfInt = y_fit + zValue .* fitDelta;
lowerConfInt = y_fit - zValue .* fitDelta;
hold on
fill([x_fit, fliplr(x_fit)], [upperConfInt, fliplr(lowerConfInt)], [194 220 236] / 255, 'EdgeColor', 'none', 'FaceAlpha', 0.35);

% 添加公式和R值
%formula = sprintf('y = %.2fexp(%.2f(x + %.2f))', fit_coeffs(1), fit_coeffs(2), fit_coeffs(3));

[r,p,rlo,rup] =corrcoef(x1,y1);
r_squared = r(1, 2);p=p(1, 2);
r_value = sprintf('R= %.2f,p = %.3f', r_squared, p);

smmean=mean(x1);smcv=std2(x1)/smmean;
pmean=mean(y1);pcv=std2(y1)/pmean;

%text(0.15, 500, formula, 'FontSize', 13,'FontName','Times New Roman');
text(0.15, 200, 'SM: mean=38.46% cv=0.14 ','FontSize', 20,'FontName','Times New Roman');
text(0.15, 100, 'Precipitation: mean=83.19 mm cv=0.66', 'FontSize', 20,'FontName','Times New Roman');

%text(0.2, max(y)-100, r_value, 'FontSize', 12);
% 添加数据标签
%text(x, y, string(labels), 'VerticalAlignment','bottom', 'HorizontalAlignment','right');
% 设置图例
%legend('1', '0', 'Location', 'best');
% 添加标题和轴标签
%title('Scatter Plot');
xlabel('SM (m^3/m^3 %)');
ylabel('Cumulative 2-day precipitation (mm)');
% 设置坐标轴范围
xlim([10, 60]);
ylim([0, 500]);
set(gca,'YTick',[0:100:500]);
set(gca, 'FontName','Times New Roman', 'FontSize', 26)
text(0.55,350,'(a)','FontSize',24,'fontname','Times New Roman','FontWeight','bold')
set(gca,'LineWidth',1.5); 

[r, p] = corrcoef(y1, fitfun(x1));
R_ = r(1, 2);
set(gca,'LineWidth',1.5);
disp(['拟合优度（R值）: ', num2str(R_)]);

subplot(2,3,2)
chinaurban=xlsread('E:\降水-土壤水分和地形推求地灾发生概率\灾害的P和SSM\NEW\阈值1.xlsx', '城市区域new','D3:F754');
nanRows = any(isnan(chinaurban), 2);
% 删除含有空值的行
chinaurban = chinaurban(~nanRows, :);

x = chinaurban(:,2)/10;%表层土壤水
y = chinaurban(:,1);%累计三天降水

labels = chinaurban(:,3);

% 绘制散点图
%gscatter(x, y, labels, colors, 'o', 8, 'on','filled');
colors = colorMap(labels+1, :);
scatter(x, y, 15, colors, 'filled');
hold on
% 添加趋势线和公式
x2 = x(labels == 1);
y2 = y(labels == 1);
nonZeroIndices = y2 ~= 0;

% 使用非零索引来过滤 x1 和 y1
x2 = x2(nonZeroIndices);
y2 = y2(nonZeroIndices);

fun = @(coeffs, x) coeffs(1) * exp(coeffs(2) * (x+coeffs(3)));

% 初始参数猜测
guess_coeffs = [1, 1,1];
lb = [0.0001, 0.0001,0.0001]; % 下限
ub = [Inf, Inf, Inf]; % 上限设置为无穷大，表示不设上限
% 使用最小二乘法进行拟合
fit_coeffs = lsqcurvefit(fun, guess_coeffs, x2, y2, lb, ub);
fitfun=@(x)fit_coeffs(1) * exp(fit_coeffs(2) * (x+fit_coeffs(3)));
x_fit = linspace(min(x2), max(x2), 1000);
y_fit = fitfun(x_fit);

plot(x_fit, y_fit, 'Color', [1 86 153] / 255, 'LineWidth', 2);
% 计算置信区间
zValue=1.96;
n=length(y_fit);
fitDelta=std(y_fit)/n^0.5;
upperConfInt = y_fit + zValue .* fitDelta;
lowerConfInt = y_fit - zValue .* fitDelta;
hold on
fill([x_fit, fliplr(x_fit)], [upperConfInt, fliplr(lowerConfInt)], [194 220 236] / 255, 'EdgeColor', 'none', 'FaceAlpha', 0.35);

smmean=mean(x2);smcv=std2(x2)/smmean;
pmean=mean(y2);pcv=std2(y2)/pmean;

% 添加公式和R值
%formula = sprintf('y = %.2fexp(%.2f(x + %.2f))', fit_coeffs(1), fit_coeffs(2), fit_coeffs(3));
text(0.15, 200, 'SM: mean=37.36% cv=0.18 ','FontSize', 20,'FontName','Times New Roman');
text(0.15, 100, 'Precipitation: mean=74.48 mm cv=0.66', 'FontSize', 20,'FontName','Times New Roman');
%text(0.15, 500, formula, 'FontSize', 13,'FontName','Times New Roman');
set(gca,'LineWidth',1.5); 
%text(0.2, max(y)-100, r_value, 'FontSize', 12);
% 添加数据标签
%text(x, y, string(labels), 'VerticalAlignment','bottom', 'HorizontalAlignment','right');
% 设置图例
% 添加标题和轴标签
%title('Scatter Plot');
xlabel('SM (m^3/m^3 %)');
%ylabel('Precipitation (mm)');
% 设置坐标轴范围
xlim([10, 60]);
ylim([0, 500]);
set(gca,'YTick',[0:100:500]);
set(gca, 'FontName','Times New Roman', 'FontSize', 26)
text(0.55,350,'(b)','FontSize',24,'fontname','Times New Roman','FontWeight','bold')
set(gca,'LineWidth',1.5); 
[r, p] = corrcoef(y2, fitfun(x2));
R_ = r(1, 2);

disp(['拟合优度（R值）: ', num2str(R_)]);

subplot(2,3,3)
%chinanonurban=xlsread('E:\降水-土壤水分和地形推求地灾发生概率\灾害的P和SSM\\NEW\CHINANEW.xlsx', '非城市的（1）','C2:AB2000');
chinanonurban=xlsread('E:\降水-土壤水分和地形推求地灾发生概率\灾害的P和SSM\NEW\阈值1.xlsx','城市区域new','K2:M754');
nanRows = any(isnan(chinanonurban), 2);
% 删除含有空值的行
chinanonurban = chinanonurban(~nanRows, :);

x = chinanonurban(:,2)/10;%表层土壤水
y = chinanonurban(:,1);%累计7天降水
labels = chinanonurban(:,3);
% 绘制散点图
% 创建颜色矩阵
colors = colorMap(labels+1, :);
%scatter(x, y, 20, colors, 'filled');
%scatter(x, y, 15, colors, 'filled');
scatter(x(labels == 1), y(labels == 1), 15, colorMap(2,:), 'filled');
hold on;
scatter(x(labels == 0), y(labels == 0), 15, colorMap(1,:), 'filled');

% 添加趋势线和公式
x3 = x(labels == 1);
y3 = y(labels == 1);
nonZeroIndices = y3 ~= 0;

% 使用非零索引来过滤 x1 和 y1
x3 = x3(nonZeroIndices);
y3 = y3(nonZeroIndices);

fun = @(coeffs, x) coeffs(1) * exp(coeffs(2) * (x+coeffs(3)));

% 初始参数猜测
guess_coeffs = [1, 1,1];
lb = [0.0001, 0.0001,0.0001]; % 下限
ub = [Inf, Inf, Inf]; % 上限设置为无穷大，表示不设上限
% 使用最小二乘法进行拟合
fit_coeffs = lsqcurvefit(fun, guess_coeffs, x3, y3, lb, ub);
fitfun=@(x)fit_coeffs(1) * exp(fit_coeffs(2) * (x+fit_coeffs(3)));
x_fit = linspace(min(x3), max(x3), 1000);
y_fit = fitfun(x_fit);
plot(x_fit, y_fit, 'Color', [1 86 153] / 255, 'LineWidth', 2);
% 计算置信区间
zValue=1.96;
n=length(y_fit);
fitDelta=std(y_fit)/n^0.5;
upperConfInt = y_fit + zValue .* fitDelta;
lowerConfInt = y_fit - zValue .* fitDelta;
hold on
fill([x_fit, fliplr(x_fit)], [upperConfInt, fliplr(lowerConfInt)], [194 220 236] / 255, 'EdgeColor', 'none', 'FaceAlpha', 0.35);

% 添加公式和R值
%formula = sprintf('y = %.2fexp(%.2f(x + %.2f))', fit_coeffs(1), fit_coeffs(2), fit_coeffs(3));
%text(0.15, max(y)-300, formula, 'FontSize',13,'FontName','Times New Roman');
% 添加标题和轴标签
xlabel('SM (m^3/m^3 %)','FontName','Times New Roman');
%ylabel('Precipitation (mm)','FontName','Times New Roman');
% 设置坐标轴范围
h=legend({'Landslides','No landslides','Fitted line'},'FontSize',20,'location','best');   %右上角标注
set(h,'Box','off');
xlim([10, 60]);
ylim([0, 500]);
set(gca,'YTick',[0:100:500]);
set(gca, 'FontName','Times New Roman', 'FontSize', 26)
text(0.55,350,'(c)','FontSize',24,'fontname','Times New Roman','FontWeight','bold')
smmean=mean(x3);smcv=std2(x3)/smmean;
pmean=mean(y3);pcv=std2(y3)/pmean;

% 添加公式和R值
text(0.15, 200, 'SM: mean=39.26% cv=0.12 ','FontSize', 20,'FontName','Times New Roman');
text(0.15, 100, 'Precipitation: mean=70.19 mm cv=0.65', 'FontSize', 20,'FontName','Times New Roman');
%text(0.15, 500, formula, 'FontSize', 13,'FontName','Times New Roman');
set(gca,'LineWidth',1.5); 

[r, p] = corrcoef(y3, fitfun(x3));
R_ = r(1, 2);

disp(['拟合优度（R值）: ', num2str(R_)]);
set(gca,'LineWidth',1.5); 

subplot(2,3,4)
density_y = ksdensity(y);
density_y(density_y < 0) = 0;

density_y1 = ksdensity(y1);
density_y1(density_y1 < 0) = 0;

density_y2 = ksdensity(y2);
density_y2(density_y2 < 0) = 0;

density_y3 = ksdensity(y3);
density_y3(density_y3 < 0) = 0;
plot(linspace(min(y1), max(y1), numel(density_y1)), density_y1, 'Color', [134 132 0] / 255,'LineWidth', 2);
hold on
plot(linspace(min(y2), max(y2), numel(density_y2)), density_y2, 'Color', [71 120 185] / 255, 'LineWidth', 2);
plot(linspace(min(y3), max(y3), numel(density_y3)), density_y3,'LineWidth', 2);

xlabel('Cumulative 2-day precipitation (mm)','FontName','Times New Roman', 'FontSize', 20);
ylabel('Probability density','FontName','Times New Roman', 'FontSize', 20);
h=legend({'All areas','Urbanized','Non-urbanized'},'FontSize',20,'FontName','Times New Roman','location','northwest');   %右上角标注
set(h,'Box','off');
set(gca, 'FontName','Times New Roman', 'FontSize', 24)
xlim([0, 500]);
text(600,0.011,'(d)','FontSize',24,'fontname','Times New Roman','FontWeight','bold')
set(gca, 'Box', 'off', 'FontName', 'Times New Roman', 'FontSize', 20);
set(gca,'LineWidth',1.5); 

subplot(2,3,5)

density_x1 = ksdensity(x1);
density_x1(density_x1 < 0) = 0;

density_x2 = ksdensity(x2);
density_x2(density_x2 < 0) = 0;

density_x3 = ksdensity(x3);
density_x3(density_x3 < 0) = 0;
plot(linspace(min(x1), max(x1), numel(density_x1)), density_x1, 'Color', [134 132 0] / 255,'LineWidth', 2);
hold on
plot(linspace(min(x2), max(x2), numel(density_x2)), density_x2, 'Color', [79 89 109] / 255,'LineWidth', 2, 'LineWidth', 2);
plot(linspace(min(x3), max(x3), numel(density_x3)), density_x3, 'LineWidth', 2);

xlabel('SM (m^3/m^3 %)','FontName','Times New Roman');
%ylabel('Probability density','FontName','Times New Roman');
%h=legend({'All areas','urban','non-urban'},'FontSize',13,'FontName','Times New Roman','location','northwest');   %右上角标注
%set(h,'Box','off');
set(gca, 'FontName','Times New Roman', 'FontSize', 26)
xlim([10, 50]);
ylim([0, 0.12]);
text(20,0.01,'(e)','FontSize',24,'fontname','Times New Roman','FontWeight','bold')
set(gca, 'Box', 'off', 'FontName', 'Times New Roman', 'FontSize', 20);
set(gca,'LineWidth',1.5); 

