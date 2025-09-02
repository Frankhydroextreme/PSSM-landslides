function [res,sum1,P] = AUCROC(testclass,scores,CF)
[m,n] = size(testclass);
tpr = zeros(51,1);
fpr = zeros(51,1);
num = 0;
AUC = 0;
for x = 0:0.02:1
    num=num+1;
    tp = 0;
    fn = 0;
    fp = 0;
    tn = 0;
    for y = 1:m
        if scores(y,1)>= x && testclass(y,1)== 1
            tp=tp+1;
        elseif scores(y,1)>=x && testclass(y,1)==0
            fp=fp+1;
        elseif scores(y,1)<x && testclass(y,1)==0
            tn=tn+1;
        elseif scores(y,1)<x && testclass(y,1)==1
            fn=fn+1;
        end
    end
    plot(tp,fp);
    hold on
    tpr(num,1) = tp/(tp+fn);
    fpr(num,1) = fp/(fp+fn);
    plot(fpr(num,1),tpr(num,1));
    hold on
end
sum = [fpr tpr];
sum1 = sortrows(sum);



for i=1:50
    line([sum1(i,1) sum1(i,1)],[sum1(i,2) sum1(i+1,2)],'linewidth',1.5,'color',CF);
    hold on 
    P=line([sum1(i,1) sum1(i+1,1)],[sum1(i+1,2) sum1(i+1,2)],'linewidth',1.5,'color',CF);
    hold on
    AUC = AUC + 0.02*((sum1(i+1,2)+sum1(i,2)))/2;
end

line([0 1],[0,1],'linewidth',1.5,'color','r');
hold on 

axis([0 1 0 1]);
set(gca,'XTick',0:0.2:1,'FontSize', 15,'FontName','Times New Roman','FontWeight','bold');
set(gca,'YTick',0:0.2:1,'FontSize', 15,'FontName','Times New Roman','FontWeight','bold');
set(gca,'LineWidth',1.5); 
xlabel('False Positive Rate','FontSize', 15,'FontName','Times New Roman','FontWeight','bold');
ylabel('True Positive Rate','FontSize', 15,'FontName','Times New Roman','FontWeight','bold');
%title(['ROC curve of (AUC = ' num2str(AUC) ' )']);
res = AUC;
