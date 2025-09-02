clear all
clc
traindata=xlsread('E:\降水-土壤水分和地形推求地灾发生概率\灾害的P和SSM\NEW\阈值.xlsx',...
 '全区域1','B3639:C4653');

testdata=xlsread('E:\降水-土壤水分和地形推求地灾发生概率\灾害的P和SSM\NEW\阈值.xlsx',...
 '全区域1','B4656:C6625');
obs=xlsread('E:\降水-土壤水分和地形推求地灾发生概率\灾害的P和SSM\NEW\阈值.xlsx',...
 '全区域1','D4656:D6625');

subplot(2,3,1)
% CFF = colorplus([53,69,84,72]);
PRE=traindata(:,1);
PRE(PRE==0)=[];
SM=traindata(:,2);
SM(isnan(SM))=[];
p=[1 2 3 4 5 6 7 8 9 10 15 20 25 30 35 40 45 50 55 60 65 70];
pre=prctile(PRE,p);
sm=prctile(SM,p);
pre1=testdata(:,1);
preemindex=pre1~=0;
pre1=pre1(preemindex);
preobs=obs(preemindex);
sm1=testdata(:,2);

RE=[];
for i=1:length(pre)
LAND=[];
    for j=1:length(pre1)
        if pre1(j)>pre(i)
            land=1;
        else
            land=0;
        end
        LAND=[LAND;land];
    end
   RE=[RE,LAND]; 
end

HRRE=[];
FARRE=[];

for m=1:min(size(RE))
    mod=RE(:,m);
    TP=sum(preobs==1&mod==1);
    FP=sum(preobs==0&mod==1);
    FN=sum(preobs==1&mod==0);
    TN=sum(preobs==0&mod==0);
    HR=TP/(TP+FN);
    FAR=FP/(FP+TN);
HRRE=[HRRE;HR];
FARRE=[FARRE;FAR];
end

d=((FARRE-0).^2+(HRRE-1).^2).^0.5;
figure(1)
yyaxis left  % 切换到主坐标轴
plot(p,d ,'-o','LineWidth',2);
ylabel('Euclidean distance','FontSize',18,'fontname','Times New Roman');  % 添加左边 y 轴标签
ylim([0.50, 1.00]);
set(gca,'YTick',[0.50:0.1:1.0],'FontSize',18,'fontname','Times New Roman');
hold on
yyaxis right
plot(p,pre,'-o','LineWidth',2);
%ylabel('Precipitation thresholds (mm)','fontname','Times New Roman','FontSize',15);  % 添加右边 y 轴标签
% 添加图例
%xlabel('Exceedance probabilities (%)','fontname','Times New Roman','FontSize',15);  % 添加 x 轴标签
%h=legend('d', 'pre','FontSize',16,'location','best');
%set(h,'Box','off');
yyaxis left  % 切换回主坐标轴，以确保标签添加到主坐标轴
set(gca,'LineWidth',1.5); 
text(55,0.96,'(a)','FontSize',20,'fontname','Times New Roman')

urbantrain=xlsread('E:\降水-土壤水分和地形推求地灾发生概率\灾害的P和SSM\NEW\阈值.xlsx',...
 '城市区域1','D403:E602');
urbantest=xlsread('E:\降水-土壤水分和地形推求地灾发生概率\灾害的P和SSM\NEW\阈值.xlsx',...
 '城市区域1','D605:E756');
urobs=xlsread('E:\降水-土壤水分和地形推求地灾发生概率\灾害的P和SSM\NEW\阈值.xlsx',...
 '城市区域1','F605:F756');

subplot(2,3,2)
PRE=urbantrain(:,1);
PRE(PRE==0)=[];
SM=urbantrain(:,2);
SM(isnan(SM))=[];
p=[1 2 3 4 5 6 7 8 9 10 15 20 25 30 35 40 45 50 55 60 65 70];
pre=prctile(PRE,p);
sm=prctile(SM,p);
pre1=urbantest(:,1);
sm1=urbantest(:,2);

preemindex=pre1~=0;
pre1=pre1(preemindex);
urbanobs=urobs(preemindex);

RE=[];
for i=1:length(pre)
LAND=[];
    for j=1:length(pre1)
        if pre1(j)>pre(i)
            land=1;
        else
            land=0;
        end
        LAND=[LAND;land];
    end
   RE=[RE,LAND]; 
end

HRRE=[];
FARRE=[];

for m=1:min(size(RE))
    mod=RE(:,m);
    TP=sum(urbanobs==1&mod==1);
    FP=sum(urbanobs==0&mod==1);
    FN=sum(urbanobs==1&mod==0);
    TN=sum(urbanobs==0&mod==0);
    HR=TP/(TP+FN);
    FAR=FP/(FP+TN);
HRRE=[HRRE;HR];
FARRE=[FARRE;FAR];
end

d=((FARRE-0).^2+(HRRE-1).^2).^0.5;
figure(1)
yyaxis left  % 切换到主坐标轴
plot(p,d ,'-o');

yyaxis left  % 切换到主坐标轴
plot(p,d ,'-o','LineWidth',2);
%ylabel('d','FontSize',15);  % 添加左边 y 轴标签
ylim([0.50, 1.00]);
set(gca,'YTick',[0.50:0.1:1.0],'FontSize',18,'fontname','Times New Roman');
hold on
yyaxis right
plot(p,pre,'-o','LineWidth',2);
%ylabel('Precipitation thresholds (mm)','fontname','Times New Roman','FontSize',15);  % 添加右边 y 轴标签
% 添加图例
%xlabel('Exceedance probabilities (%)','fontname','Times New Roman','FontSize',15);  % 添加 x 轴标签
%h=legend('d', 'pre','FontSize',16,'location','best');
%set(h,'Box','off');
yyaxis left  % 切换回主坐标轴，以确保标签添加到主坐标轴
set(gca,'LineWidth',1.5); 
text(55,0.96,'(b)','FontSize',20,'fontname','Times New Roman')

nonurbantrain=xlsread('E:\降水-土壤水分和地形推求地灾发生概率\灾害的P和SSM\NEW\阈值.xlsx',...
 '非城市区域1','D402:E602');
nonurbantest=xlsread('E:\降水-土壤水分和地形推求地灾发生概率\灾害的P和SSM\NEW\阈值.xlsx',...
 '非城市区域1','D605:E755');
nonurobs=xlsread('E:\降水-土壤水分和地形推求地灾发生概率\灾害的P和SSM\NEW\阈值.xlsx',...
 '非城市区域1','F605:F755');

subplot(2,3,3)
PRE=nonurbantrain(:,1);
PRE(PRE==0)=[];
SM=nonurbantrain(:,2);
SM(isnan(SM))=[];
p=[1 2 3 4 5 6 7 8 9 10 15 20 25 30 35 40 45 50 55 60 65 70];
pre=prctile(PRE,p);
sm=prctile(SM,p);
pre1=nonurbantest(:,1);
sm1=nonurbantest(:,2);

preemindex=pre1~=0;
pre1=pre1(preemindex);
nonurbanobs=nonurobs(preemindex);

RE=[];
for i=1:length(pre)
LAND=[];
    for j=1:length(pre1)
        if pre1(j)>pre(i)
            land=1;
        else
            land=0;
        end
        LAND=[LAND;land];
    end
   RE=[RE,LAND]; 
end

HRRE=[];
FARRE=[];

for m=1:min(size(RE))
    mod=RE(:,m);
    TP=sum(nonurbanobs==1&mod==1);
    FP=sum(nonurbanobs==0&mod==1);
    FN=sum(nonurbanobs==1&mod==0);
    TN=sum(nonurbanobs==0&mod==0);
    HR=TP/(TP+FN);
    FAR=FP/(FP+TN);
HRRE=[HRRE;HR];
FARRE=[FARRE;FAR];
end

d=((FARRE-0).^2+(HRRE-1).^2).^0.5;
figure(1)
yyaxis left  % 切换到主坐标轴
plot(p,d ,'-o','LineWidth',2);
%ylabel('d','FontSize',15);  % 添加左边 y 轴标签
ylim([0.50, 1.00]);
set(gca,'YTick',[0.50:0.1:1.0],'FontSize',18,'fontname','Times New Roman');
hold on
yyaxis right
plot(p,pre,'-o','LineWidth',2);
ylabel('Precipitation thresholds (mm)','fontname','Times New Roman','FontSize',18);  % 添加右边 y 轴标签
% 添加图例
%xlabel('Exceedance probabilities (%)','fontname','Times New Roman','FontSize',15);  % 添加 x 轴标签
h=legend('d', 'Precipitation thresholds','FontSize',18,'location','best');
set(h,'Box','off');
yyaxis left  % 切换回主坐标轴，以确保标签添加到主坐标轴
set(gca,'LineWidth',1.5); 
text(55,0.96,'(c)','FontSize',20,'fontname','Times New Roman')

subplot(2,3,4)
SM=traindata(:,2)./10;
SM(isnan(SM))=[];
p=[1 2 3 4 5 6 7 8 9 10 15 20 25 30 35 40 45 50 55 60 65 70];
sm=prctile(SM,p);
sm1=testdata(:,2)./10;
index=~isnan(sm1);
sm1=sm1(index);
preobs=obs(index);

RE=[];
for i=1:length(sm)
LAND=[];
    for j=1:length(sm1)
        if sm1(j)>sm(i)
            land=1;
        else
            land=0;
        end
        LAND=[LAND;land];
    end
   RE=[RE,LAND]; 
end

HRRE=[];
FARRE=[];

for m=1:min(size(RE))
    mod=RE(:,m);
    TP=sum(preobs==1&mod==1);
    FP=sum(preobs==0&mod==1);
    FN=sum(preobs==1&mod==0);
    TN=sum(preobs==0&mod==0);
    HR=TP/(TP+FN);
    FAR=FP/(FP+TN);
HRRE=[HRRE;HR];
FARRE=[FARRE;FAR];
end

d=((FARRE-0).^2+(HRRE-1).^2).^0.5;
figure(1)
yyaxis left  % 切换到主坐标轴
plot(p,d ,'-o','LineWidth',2);
ylabel('Euclidean distance','FontSize',18,'fontname','Times New Roman');  % 添加左边 y 轴标签
ylim([0.50, 1.00]);
set(gca,'YTick',[0.50:0.1:1.0],'FontSize',18,'fontname','Times New Roman');

hold on
yyaxis right
plot(p,sm,'-o','LineWidth',2);
%ylabel('Soil moisture thresholds (m^3/m^3)','fontname','Times New Roman','FontSize',15);  % 添加右边 y 轴标签
% 添加图例
xlabel('Exceedance probabilities (%)','fontname','Times New Roman','FontSize',18); 
h=legend('d', 'Soil moisture','FontSize',18,'location','best');
set(h,'Box','off');
yyaxis left  % 切换回主坐标轴，以确保标签添加到主坐标轴
set(gca,'LineWidth',1.5); 
text(78,0.96,'(d)','FontSize',20,'fontname','Times New Roman')



subplot(2,3,5)
SM=urbantrain(:,2)./10;
SM(isnan(SM))=[];
p=[1 2 3 4 5 6 7 8 9 10 15 20 25 30 35 40 45 50 55 60 65 70];
sm=prctile(SM,p);
sm1=urbantest(:,2)./10;
index=~isnan(sm1);
sm1=sm1(index);
urbanobs=urobs(index);

RE=[];
for i=1:length(sm)
LAND=[];
    for j=1:length(sm1)
        if sm1(j)>sm(i)
            land=1;
        else
            land=0;
        end
        LAND=[LAND;land];
    end
   RE=[RE,LAND]; 
end

HRRE=[];
FARRE=[];

for m=1:min(size(RE))
    mod=RE(:,m);
    TP=sum(urbanobs==1&mod==1);
    FP=sum(urbanobs==0&mod==1);
    FN=sum(urbanobs==1&mod==0);
    TN=sum(urbanobs==0&mod==0);
    HR=TP/(TP+FN);
    FAR=FP/(FP+TN);
HRRE=[HRRE;HR];
FARRE=[FARRE;FAR];
end

d=((FARRE-0).^2+(HRRE-1).^2).^0.5;
figure(1)
yyaxis left  % 切换到主坐标轴
plot(p,d ,'-o','LineWidth',2);
%ylabel('d','FontSize',15,'fontname','Times New Roman');  % 添加左边 y 轴标签
ylim([0.50, 1.00]);
set(gca,'YTick',[0.50:0.1:1.0],'FontSize',18,'fontname','Times New Roman');

hold on
yyaxis right
plot(p,sm,'-o','LineWidth',2);
%ylabel('Soil moisture thresholds (m^3/m^3)','fontname','Times New Roman','FontSize',15);  % 添加右边 y 轴标签
ylim([20, 45]);
% 添加图例
xlabel('Exceedance probabilities (%)','fontname','Times New Roman','FontSize',18);  % 添加 x 轴标签
set(gca,'LineWidth',1.5); 
%h=legend('d', 'SM','FontSize',16,'location','best');
%set(h,'Box','off');
yyaxis left  % 切换回主坐标轴，以确保标签添加到主坐标轴
text(78,0.96,'(e)','FontSize',20,'fontname','Times New Roman')


subplot(2,3,6)
SM=nonurbantrain(:,2)./10;
SM(isnan(SM))=[];
p=[1 2 3 4 5 6 7 8 9 10 15 20 25 30 35 40 45 50 55 60 65 70];
sm=prctile(SM,p);
sm1=nonurbantest(:,2)./10;
index=~isnan(sm1);
sm1=sm1(index);
urbanobs=nonurobs(index);

RE=[];
for i=1:length(sm)
LAND=[];
    for j=1:length(sm1)
        if sm1(j)>sm(i)
            land=1;
        else
            land=0;
        end
        LAND=[LAND;land];
    end
   RE=[RE,LAND]; 
end

HRRE=[];
FARRE=[];

for m=1:min(size(RE))
    mod=RE(:,m);
    TP=sum(urbanobs==1&mod==1);
    FP=sum(urbanobs==0&mod==1);
    FN=sum(urbanobs==1&mod==0);
    TN=sum(urbanobs==0&mod==0);
    HR=TP/(TP+FN);
    FAR=FP/(FP+TN);
HRRE=[HRRE;HR];
FARRE=[FARRE;FAR];
end

d=((FARRE-0).^2+(HRRE-1).^2).^0.5;
figure(1)
yyaxis left  % 切换到主坐标轴
plot(p,d ,'-o','LineWidth',2);
%ylabel('d','FontSize',15,'fontname','Times New Roman');  % 添加左边 y 轴标签
ylim([0.50, 1.00]);
set(gca,'YTick',[0.50:0.1:1.0],'FontSize',18,'fontname','Times New Roman');

hold on
yyaxis right
plot(p,sm,'-o','LineWidth',2);
ylabel('Soil moisture thresholds (m^3/m^3)','fontname','Times New Roman','FontSize',18);  % 添加右边 y 轴标签
ylim([20, 45]);
% 添加图例
xlabel('Exceedance probabilities (%)','fontname','Times New Roman','FontSize',18);  % 添加 x 轴标签
set(gca,'LineWidth',1.5); 
%h=legend('d', 'SM','FontSize',16,'location','best');
%set(h,'Box','off');

yyaxis left  % 切换回主坐标轴，以确保标签添加到主坐标轴
text(78,0.96,'(f)','FontSize',20,'fontname','Times New Roman')

disp('OK')
    
