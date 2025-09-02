clear all
clc
close;
data=xlsread('E:\降水-土壤水分和地形推求地灾发生概率\灾害的P和SSM\NEW\四种降水产品的比较.xlsx',...
    '四种降水产品','A2:H1490');


% 删除含有空值和0的行
zeroRows = any(data==0, 2);
alldata = data(~zeroRows, :);
nanRows = any(isnan(alldata), 2);
alldata = alldata(~nanRows, :);
% Filter rows where the value in the fifth column is equal to 8
urbandata = alldata(alldata(:, 8) == 8, :);
nonurbandata=alldata(alldata(:, 8) ~= 8, :);
alldata=alldata(:,1:8);

urban=urbandata(:,1:7);
urbandata=urbandata(:,1:7);
nonurban=nonurbandata(:,1:7);

% Initialize arrays to store results
spadis = [];
timedis = [];

% Loop through each urban data point
for i = 1:max(size(urban))
    urda = urban(i, 1);
    urlon = urban(i, 2);
    urlat = urban(i, 3);

    % Initialize variables to track the minimum timestamp difference and indices
    minTimestampDistance = Inf;
    minTimestampIndices = [];
    minDistance = Inf;
    minIndex = 0;

    % Loop through each non-urban data point
    for j = 1:max(size(nonurban))
        nonurda = nonurban(j, 1);
        nonurlon = nonurban(j, 2);
        nonurlat = nonurban(j, 3);

        % Calculate the absolute timestamp difference
        dis2 = abs(urda - nonurda);

        % Check if this timestamp difference is smaller than the current minimum
        if dis2 < minTimestampDistance
            minTimestampDistance = dis2;
            minTimestampIndices = [j];  % Reset the indices for the new minimum timestamp difference
            minDistance = Inf;  % Reset the minimum distance for this group
        elseif dis2 == minTimestampDistance
            minTimestampIndices = [minTimestampIndices, j];  % Add index to the list for equal timestamp differences
        end

        % Calculate the geographic distance (Euclidean distance)
        dis1 = sqrt((urlon - nonurlon)^2 + (urlat - nonurlat)^2);

%         % If this non-urban point has the closest timestamp, update the geographic distance
% 
%         if j == minTimestampIndices(1)
%             minDistance = dis1;
%             minIndex = j;
        if ismember(j, minTimestampIndices)
            if dis1 < minDistance
                minDistance = dis1;
                minIndex = j;
     end
    end
    end
    % Store the minimum geographic distance and its corresponding non-urban point
    spadis = [spadis; minDistance];
    timedis = [timedis; minIndex];
end

nonurbandata=nonurban(timedis,1:7);

% CF = colorplus([84,237,201,68]);
% C1=CF(1,:);
% C2=CF(2,:);
% C3=CF(3,:);
% C4=CF(4,:);
%  CF = colorplus([83,151,66,67]);
%  C1=CF(1,:);
%  C2=CF(2,:);
%  C3=CF(3,:);
%  C4=CF(4,:);

 C1=[1,86,153]./255;
 C2=[250,192,15]./255;
 C3=[243,118,74]./255;
 C4=[95,198,201]./252;
 CF = [C1;C2;C3;C4];

Timeserisdata = urbandata(105:150, 4:7);%2012-2014年

x=1:1:46;

h1=subplot(2,2,1);
plot(x,Timeserisdata(:,1),'-o','color',C4,...
    'LineWidth',2,...
    'MarkerSize',5,...
    'MarkerEdgeColor',C4);
 hold on;
plot(x,Timeserisdata(:,2),'-o','color',C3,...
    'LineWidth',2,...
    'MarkerSize',5,...
    'MarkerEdgeColor',C3);

 hold on;
 plot(x,Timeserisdata(:,3),'-o','color',C2,...
    'LineWidth',2,...
    'MarkerSize',5,...
    'MarkerEdgeColor',C2);

 hold on;
plot(x,Timeserisdata(:,4),'-o','color',C1,...
    'LineWidth',1.5,...
    'MarkerSize',5,...
    'MarkerEdgeColor',C1);

ylim([0 600]);
%set(gca,'YTick',[0:0.2:1]);
set(gca,'FontName','Times New Roman')
%set([hYLabel], 'FontName','Times New Roman')
set(gca, 'FontSize', 24)
xlabel('Landslide events','FontName','Times New Roman', 'FontSize', 24);
ylabel('Antecedent precipitation (mm)','FontName','Times New Roman', 'FontSize', 24);
set(gcf,'Color',[1 1 1])
set(gca,'LineWidth',1.5); 
h=legend({'HRLT','MSWEP','GPM','CHIRPS'},'FontSize',18,'location','best');   
set(h,'Box','off','Orientation','vertical');

text(1,500,'(a)','FontSize',22,'fontname','Times New Roman','FontWeight','bold','FontWeight','bold')


alldata=alldata(:,4:7);
% 设置图的大小一致

h2=subplot(2,2,2)
hb = boxplot(alldata,...              
                    'Color','k',...                                   %箱体边框及异常点颜色
                    'symbol','.',...                                  %异常点形状
                    'Notch','on',...                                  %异常点形状
                    'OutlierSize',4,...                               %是否是凹口的形式展现箱线图，默认非凹口
                    'labels',{'HRLT','MSWEP','GPM','CHIRPS'});
set(hb,'LineWidth',1.5)                                               %箱型图线宽


h = findobj(gca,'Tag','Box');
for j = 1:min(size(alldata))
    patch(get(h(j),'XData'),get(h(j),'YData'),CF(j,:),'FaceAlpha',.5);%赋颜色填充箱型图内部
end
% 坐标轴美化
set(gca, 'Box', 'on', ...                                        % 边框
         'LineWidth', 1,...                                      % 线宽
         'XGrid', 'off', 'YGrid', 'off', ...                     % 网格
         'TickDir', 'in', 'TickLength', [.015 .015], ...         % 刻度
         'XMinorTick', 'off', 'YMinorTick', 'off', ...           % 小刻度
         'XColor', [.1 .1 .1],  'YColor', [.1 .1 .1])            % 坐标轴颜色

% 背景颜色
%hYLabel = ylabel('Antecedent precipitation accumulation (mm)','FontName','Times New Roman');
%hXLabel = xlabel('Types of cascading geohazards','FontName','Times New Roman');
ylim([0 600]);
%set(gca,'YTick',[0:0.2:1]);
set(gca,'FontName','Times New Roman')
%set([hYLabel], 'FontName','Times New Roman')
set(gca, 'FontSize', 24)
%set([hYLabel], 'FontSize', 22)
set(gcf,'Color',[1 1 1])
set(gca,'LineWidth',1.5); 
text(1,500,'(b)','FontSize',22,'fontname','Times New Roman','FontWeight','bold')


urbandata=urbandata(:,4:7);

h3=subplot(2,2,3)
hb = boxplot(urbandata,...              
                    'Color','k',...                                   %箱体边框及异常点颜色
                    'symbol','.',...                                  %异常点形状
                    'Notch','on',...                                  %异常点形状
                    'OutlierSize',4,...                               %是否是凹口的形式展现箱线图，默认非凹口
                    'labels',{'HRLT','MSWEP','GPM','CHIRPS'});
set(hb,'LineWidth',1.5)                                               %箱型图线宽

h = findobj(gca,'Tag','Box');
for j = 1:min(size(urbandata))
    patch(get(h(j),'XData'),get(h(j),'YData'),CF(j,:),'FaceAlpha',.5);%赋颜色填充箱型图内部
end
% 坐标轴美化
set(gca, 'Box', 'on', ...                                        % 边框
         'LineWidth', 1,...                                      % 线宽
         'XGrid', 'off', 'YGrid', 'off', ...                     % 网格
         'TickDir', 'in', 'TickLength', [.015 .015], ...         % 刻度
         'XMinorTick', 'off', 'YMinorTick', 'off', ...           % 小刻度
         'XColor', [.1 .1 .1],  'YColor', [.1 .1 .1])            % 坐标轴颜色

% 背景颜色
%hYLabel = ylabel('Antecedent precipitation accumulation (mm)','FontName','Times New Roman');
%hXLabel = xlabel('Types of cascading geohazards','FontName','Times New Roman');
ylim([0 600]);
%set(gca,'YTick',[0:0.2:1]);
set(gca,'FontName','Times New Roman')
%set([hYLabel], 'FontName','Times New Roman')
set(gca, 'FontSize', 24)
%set([hYLabel], 'FontSize', 22)
set(gcf,'Color',[1 1 1])
set(gca,'LineWidth',1.5); 
text(1,500,'(c)','FontSize',22,'fontname','Times New Roman','FontWeight','bold','FontWeight','bold')

nonurbandata=nonurbandata(:,4:7);
h4=subplot(2,2,4)
hb = boxplot(nonurbandata,...              
                    'Color','k',...                                   %箱体边框及异常点颜色
                    'symbol','.',...                                  %异常点形状
                    'Notch','on',...                                  %异常点形状
                    'OutlierSize',4,...                               %是否是凹口的形式展现箱线图，默认非凹口
                    'labels',{'HRLT','MSWEP','GPM','CHIRPS'});
set(hb,'LineWidth',1.5)                                               %箱型图线宽

h = findobj(gca,'Tag','Box');
for j = 1:min(size(nonurbandata))
    patch(get(h(j),'XData'),get(h(j),'YData'),CF(j,:),'FaceAlpha',.5);%赋颜色填充箱型图内部
end
% 坐标轴美化
set(gca, 'Box', 'on', ...                                        % 边框
         'LineWidth', 1,...                                      % 线宽
         'XGrid', 'off', 'YGrid', 'off', ...                     % 网格
         'TickDir', 'in', 'TickLength', [.015 .015], ...         % 刻度
         'XMinorTick', 'off', 'YMinorTick', 'off', ...           % 小刻度
         'XColor', [.1 .1 .1],  'YColor', [.1 .1 .1])            % 坐标轴颜色

% 背景颜色
%hYLabel = ylabel('Antecedent precipitation accumulation (mm)','FontName','Times New Roman');
%hXLabel = xlabel('Types of cascading geohazards','FontName','Times New Roman');
ylim([0 600]);
%set(gca,'YTick',[0:0.2:1]);
set(gca,'FontName','Times New Roman')
%set([hYLabel], 'FontName','Times New Roman')
set(gca, 'FontSize', 24)
%set([hYLabel], 'FontSize', 22)
set(gcf,'Color',[1 1 1])
set(gca,'LineWidth',1.5); 
text(1,500,'(d)','FontSize',22,'fontname','Times New Roman','FontWeight','bold','FontWeight','bold')
% 在完成所有子图后调用

% 设置图的大小一致
%set(gcf, 'Position', [100, 100, 1200, 400]);
meanalldata=mean(alldata)
meanurbandata=mean(urbandata)
meannonurbandata=mean(nonurbandata)
