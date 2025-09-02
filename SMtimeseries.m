clc
clear 
close all
data=xlsread('E:\降水-土壤水分和地形推求地灾发生概率\灾害的P和SSM\chineseHWSD10-100\中国土壤类型\chinesediffsoilhazards.xlsx',...
    'diffSM','A3658:j5118');
data=data./10;

mean20=nanmean(data(:,1));cvmean20=nanstd(data(:,1))./mean20;
mean40=nanmean(data(:,2));cvmean40=nanstd(data(:,2))./mean40;
mean80=nanmean(data(:,3));cvmean80=nanstd(data(:,3))./mean80;
mean100=nanmean(data(:,4));cvmean100=nanstd(data(:,4))./mean100;

subplot(2,1,1)

x1=1:length(data(:,1));
plot(x1,data(:,1), '-','LineWidth',1.5,'Color',[66,122,178]./255)
hold on
plot(x1,data(:,2), '-','LineWidth',1.5,'Color',[240,145,72]./255)
hold on
plot(x1,data(:,3), '-','LineWidth',1.5, 'Color',[219, 219, 141] ./ 255)
hold on
plot(x1,data(:,4), '-','LineWidth',1.5,'Color',[72,192,170]./255)

hold off; % 取消保持图形
ax = gca;
%xlabel('Year', 'FontSize', 20, 'FontName', 'Times New Roman');
ylabel('Soil moisture (%)', 'FontSize', 20, 'FontName', 'Times New Roman');
set(gca, 'FontSize', 20, 'FontName', 'Times New Roman');
h = legend('-20cm: mean=41.05  CV=0.09',  '-40cm: mean=40.43  CV=0.06','-80cm: mean=40.56  CV=0.05', '-100cm: mean=42.24 CV=0.07', 'FontSize', 18, 'FontName', 'Times New Roman');
%axis([0,1440,0,12])  %确定x轴与y轴框图大小
set(h, 'FontSize', 18, 'FontName', 'Times New Roman', 'Orientation', 'horizontal');
ylim([30, 50]);

set(gca,'XTick',[1:365:length(data(:,1))],'fontname','Times New Roman','FontWeight','bold','FontSize',16) %x轴范围1-6，间隔1
%set(gca,'YTick',[0:2:12],'fontname','Times New Roman','FontWeight','bold','FontSize',16) %y轴范围0-700，间隔100
%set(gca,'XTickLabel',{'2007';'2008';'2009';'2010';'2011';'2012';'2013';'2014';'2015';'2016';'2017';'2018';'2019';'2020'},'fontname','Times New Roman','FontWeight','bold','FontSize',16);
set(gca,'LineWidth',1.5); 
set(gca, 'XTickLabel', []); % 去除x轴的所有刻度标记但保留刻度线
text(500, 45, '(a)', 'FontSize', 24, 'FontName', 'Times New Roman', 'FontWeight', 'bold');
% 设置图例位置
legend('Location', 'Best');
set(h, 'Box', 'off');
% 去掉右和上边框
box off;
% 设置标注朝外
set(gca, 'TickDir', 'out');

mean20=nanmean(data(:,7));cvmean20=nanstd(data(:,7))./mean20;
mean40=nanmean(data(:,8));cvmean40=nanstd(data(:,8))./mean40;
mean80=nanmean(data(:,9));cvmean80=nanstd(data(:,9))./mean80;
mean100=nanmean(data(:,10));cvmean100=nanstd(data(:,10))./mean100;

subplot(2,1,2)
x1=1:length(data(:,1));
plot(x1,data(:,7), '-','LineWidth',1.5,'Color',[66,122,178]./255)
hold on
plot(x1,data(:,8), '-','LineWidth',1.5,'Color',[240,145,72]./255)
hold on
plot(x1,data(:,9), '-','LineWidth',1.5, 'Color',[219, 219, 141] ./ 255)
hold on
plot(x1,data(:,10), '-','LineWidth',1.5,'Color',[72,192,170]./255)

hold off; % 取消保持图形
ax = gca;
xlabel('Year', 'FontSize', 20, 'FontName', 'Times New Roman');
ylabel('Soil moisture (%)', 'FontSize', 20, 'FontName', 'Times New Roman');
set(gca, 'FontSize', 20, 'FontName', 'Times New Roman');
h = legend('-20cm: mean=31.12  CV=0.18', '-40cm: mean=32.61  CV=0.13','-80cm: mean=33.75  CV=0.14', '-100cm: mean=35.61 CV=0.11', 'FontSize', 18, 'FontName', 'Times New Roman');
%axis([0,1440,0,12])  %确定x轴与y轴框图大小
set(gca,'XTick',[1:365:length(data(:,1))],'fontname','Times New Roman','FontWeight','bold','FontSize',16) %x轴范围1-6，间隔1
%set(gca,'YTick',[0:2:12],'fontname','Times New Roman','FontWeight','bold','FontSize',16) %y轴范围0-700，间隔100
%set(gca,'XTickLabel',{'2007';'2008';'2009';'2010';'2011';'2012';'2013';'2014';'2015';'2016';'2017';'2018';'2019';'2020'},'fontname','Times New Roman','FontWeight','bold','FontSize',16);

set(gca,'XTickLabel',{'2017';'2018';'2019';'2020';'2021'},'fontname','Times New Roman','FontWeight','bold','FontSize',16);
set(gca,'LineWidth',1.5); 
ylim([18, 50]);
set(h, 'FontSize', 18, 'FontName', 'Times New Roman', 'Orientation', 'horizontal');
text(500, 45, '(b)', 'FontSize', 24, 'FontName', 'Times New Roman', 'FontWeight', 'bold');
% 设置图例位置
legend('Location', 'Best');
set(h, 'Box', 'off');
% 去掉右和上边框
box off;
% 设置标注朝外
set(gca, 'TickDir', 'out');


