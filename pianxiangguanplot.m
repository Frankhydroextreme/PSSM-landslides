

clear all
clc
close all
data =xlsread('E:/降水-土壤水分和地形推求地灾发生概率/灾害的P和SSM/codes/重要性/Importantdata.xlsx', '不透水面系数随着时间的变化','B2:O6726');
nanRows = any(isnan(data), 2); % 找出包含NaN的行
negativeRows = any(data < 0, 2); % 找出包含小于0的值的行
% 组合这两个条件，找出需要删除的行
rowsToRemove = nanRows |negativeRows;
data = data(~rowsToRemove, :);

corr=[];
pval=[];
for year=2007:2019

    for mon=1:12
    onesRows = find(data(:,1) ==year&data(:,2) ==mon&data(:,6) >0);
    
    if isempty(onesRows)
    R = NaN;
    P = NaN;
else
    % 
   YEARdata=data(onesRows,:);
    X = YEARdata(:,5); % 
    Y = YEARdata(:,6);
    other = YEARdata(:,7:14);
    [R, P] = partialcorr(X, Y, other);
    end

    corr=[corr;R];
    pval=[pval;P];
    end
end

corr(isnan(corr))=[];
corr=abs(corr)*100;
x=1:1:length(corr);

plot (corr-detrend(corr),'linewidth',1.5,'Color',[71 131 159]./255,'linestyle','--')
hold on
y = corr;
x11=linspace(min(x),max(x));
y11=interp1(x,y,x11,'cubic');

a=1.96*std(y)/length(y)^0.5;
xconf = [x x(end:-1:1)] ;%构造正反向的x值，作为置信区间的横坐标值
yc = [y+a y(end:-1:1)-a];%构造y方向的上下范围，作为置信区间的纵坐标值
yconf=[yc(:,1)',yc(:,2)'];
xconf1= spcrv([xconf(1) xconf xconf(end)],2);
yconf1=spcrv([yconf(1) yconf yconf(end)],2);

 p = fill(xconf1,yconf1,'b','FaceAlpha',0.2);%定义填充区间
 p.FaceColor = [110 199 169]./255;%定义区间的填充颜色      
 p.EdgeColor = 'none';%定义区间边界的填充颜色，此处不设置
 hold on
plot(x11,y11,'k-o','MarkerSize',5, 'linewidth',1.5,'Color',[102 199 169]./255)
set(gca,'XTick',[0:10:60],'XTickLabel',{'200701','200901','201101','201301','201501','201701','201901'}) 

[r,p,rlo,rup] =corrcoef(x,corr);
p1=p(1,2)
r1=r(1,2)
pcorr = polyfit(x, corr, 1);

legend('y=0.42x+25.15 p<0.01','Box','off','FontSize',20);
%strings={'R=0.29' ' P=0.03 ' };
%annotation('textbox',[0.3 0.7 0.3 0.2],'LineStyle','none','LineWidth',0.5,'String',strings,'FontSize',8)
%text(10,800,'R=0.29 P=0.03','FontSize',11)
%text(2,840,'(a)','FontSize',11)
% 去掉右和上边框
box off;
set(gca, 'FontName','times new roman', 'FontSize', 22)
%text(0.55,350,'(a)','FontSize',24,'fontname','Times New Roman','FontWeight','bold')
set(gca,'LineWidth',1.5); 
ylim([0, 120]);
xlabel('Month')
ylabel('Contribution (%)')
hold off

