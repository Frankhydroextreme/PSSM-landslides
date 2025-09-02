clear all
close all
% HRIT=[0.785 0.785 	0.784 	0.777 
% 0.781 	0.782 	0.780 	0.774 
% 0.785 	0.785 	0.784 	0.777 
% 0.783 	0.784 	0.782 	0.776 
% ]';
% 
% MSWEP=[0.788 	0.790 	0.792 	0.787 
% 0.787 	0.788 	0.790 	0.785 
% 0.788 	0.791 	0.793 	0.788 
% 0.787 	0.788 	0.790 	0.787  
% ]';
% CHIRPS=[0.781 	0.785 	0.790 	0.797 
% 0.778 	0.782 	0.786 	0.795 
% 0.781 	0.784 	0.789 	0.793 
% 0.780 	0.782 	0.787 	0.790   
% ]';
% GPM=[0.780 	0.777 	0.779 	0.783 
% 0.775 	0.774 	0.776 	0.779 
% 0.779 	0.776 	0.780 	0.780 
% 0.777 	0.775 	0.777 	0.777    
% ]';
% 
% 
% UrbanHRIT=[0.717 	0.678 	0.606 	0.701 
% 0.718 	0.659 	0.621 	0.704 
% 0.666 	0.630 	0.583 	0.645 
% 0.617 	0.561 	0.543 	0.610 
%  ]';
% UrbanMSWEP=[0.579 	0.670 	0.661 	0.664 
% 0.573 	0.677 	0.677 	0.663 
% 0.545 	0.637 	0.632 	0.655 
% 0.483 	0.586 	0.591 	0.612   
% ]';
% UrbanCHIRPS=[0.695 	0.593 	0.556 	0.715 
% 0.704 	0.584 	0.566 	0.727 
% 0.627 	0.552 	0.535 	0.707 
% 0.610 	0.488 	0.458 	0.708    
% ]';
% UrbanGPM=[0.490 	0.701 	0.567 	0.613 
% 0.473 	0.681 	0.550 	0.595 
% 0.439 	0.645 	0.515 	0.598 
% 0.410 	0.577 	0.434 	0.525  
% ]';
% 
% 
% nonurbanHRIT=[0.842 	0.838 	0.837 	0.844 
% 0.839 	0.833 	0.832 	0.838 
% 0.840 	0.836 	0.835 	0.843 
% 0.841 	0.836 	0.835 	0.842 
%  ]';
% nonurbanMSWEP=[0.837 	0.842 	0.842 	0.844 
% 0.833 	0.836 	0.839 	0.838 
% 0.836 	0.839 	0.841 	0.841 
% 0.834 	0.839 	0.839 	0.841    
% ]';
% nonurbanCHIRPS=[0.834 	0.839 	0.838 	0.845 
% 0.829 	0.836 	0.832 	0.838 
% 0.830 	0.836 	0.835 	0.842 
% 0.829 	0.836 	0.834 	0.842    
% ]';
% nonurbanGPM=[0.837 	0.841 	0.841 	0.842 
% 0.832 	0.837 	0.836 	0.839 
% 0.832 	0.836 	0.837 	0.839 
% 0.832 	0.836 	0.837 	0.840 
% ]';
% 
% 

% HRIT=[0.774 	0.773 	0.777 	0.773 
% 0.774 	0.774 	0.776 	0.774 
% 0.784 	0.783 	0.787 	0.780 
% 0.771 	0.769 	0.775 	0.770 
% ]';
% 
% MSWEP=[0.769 	0.769 	0.772 	0.773 
% 0.767 	0.768 	0.773 	0.773 
% 0.779 	0.779 	0.780 	0.782 
% 0.766 	0.766 	0.770 	0.771 
% ]';
% CHIRPS=[0.775 	0.778 	0.775 	0.772 
% 0.775 	0.780 	0.776 	0.772 
% 0.787 	0.790 	0.787 	0.784 
% 0.774 	0.778 	0.774 	0.772 
% ]';
% GPM=[0.768 	0.768 	0.768 	0.762 
% 0.764 	0.767 	0.766 	0.764 
% 0.771 	0.773 	0.775 	0.774 
% 0.762 	0.762 	0.762 	0.763    
% ]';
% 
% 
% UrbanHRIT=[0.651 	0.647 	0.626 	0.596 
% 0.658 	0.648 	0.637 	0.603 
% 0.667 	0.644 	0.634 	0.605 
% 0.675 	0.647 	0.634 	0.598 
% 
%  ]';
% UrbanMSWEP=[0.677 	0.671 	0.672 	0.663 
% 0.687 	0.678 	0.686 	0.685 
% 0.698 	0.686 	0.691 	0.692 
% 0.704 	0.712 	0.706 	0.690  
% ]';
% UrbanCHIRPS=[0.691 	0.698 	0.682 	0.680 
% 0.697 	0.707 	0.694 	0.703 
% 0.703 	0.709 	0.700 	0.697 
% 0.714 	0.721 	0.701 	0.699 
%    
% ]';
% UrbanGPM=[0.674 	0.691 	0.693 	0.687 
% 0.687 	0.702 	0.706 	0.708 
% 0.692 	0.701 	0.700 	0.715 
% 0.690 	0.705 	0.710 	0.714 
% ]';
% 
% 
% nonurbanHRIT=[0.757 	0.753 	0.752 	0.752 
% 0.754 	0.749 	0.748 	0.748 
% 0.751 	0.751 	0.750 	0.750 
% 0.755 	0.756 	0.754 	0.754 ]';
% nonurbanMSWEP=[ 0.755 	0.757 	0.758 	0.761 
% 0.751 	0.754 	0.757 	0.757 
% 0.752 	0.757 	0.758 	0.759 
% 0.757 	0.761 	0.762 	0.763   
% ]';
% nonurbanCHIRPS=[0.753 	0.751 	0.753 	0.756 
% 0.750 	0.747 	0.752 	0.753 
% 0.752 	0.751 	0.754 	0.754 
% 0.753 	0.752 	0.757 	0.757     
% ]';
% nonurbanGPM=[0.757 	0.760 	0.758 	0.757 
% 0.751 	0.755 	0.755 	0.755 
% 0.751 	0.757 	0.757 	0.756 
% 0.756 	0.761 	0.760 	0.759 
% ]';

HRIT=[0.805 	0.791 	0.790 	0.813 
0.836 	0.831 	0.845 	0.862 
0.802 	0.762 	0.774 	0.766 
0.791 	0.791 	0.802 	0.816   
]';

MSWEP=[0.805 	0.817 	0.818 	0.847 
0.832 	0.848 	0.853 	0.880 
0.766 	0.792 	0.796 	0.816 
0.781 	0.827 	0.812 	0.850  
]';

CHIRPS=[0.844 	0.838 	0.853 	0.854 
0.851 	0.866 	0.815 	0.884 
0.828 	0.803 	0.852 	0.854 
0.834 	0.885 	0.843 	0.879 
]';

GPM=[0.801 	0.793 	0.827 	0.857 
0.860 	0.835 	0.859 	0.865 
0.780 	0.774 	0.763 	0.827 
0.792 	0.784 	0.840 	0.847     
]';


UrbanHRIT=[0.713 	0.704 	0.677 	0.674 
0.705 	0.692 	0.679 	0.672 
0.672 	0.671 	0.646 	0.617 
0.667 	0.666 	0.640 	0.635  

 ]';
UrbanMSWEP=[0.677 	0.671 	0.672 	0.663 
0.687 	0.678 	0.686 	0.685 
0.698 	0.686 	0.691 	0.692 
0.704 	0.712 	0.706 	0.690  
]';
UrbanCHIRPS=[0.691 	0.698 	0.682 	0.680 
0.697 	0.707 	0.694 	0.703 
0.703 	0.709 	0.700 	0.697 
0.714 	0.721 	0.701 	0.699    
]';
UrbanGPM=[0.674 	0.691 	0.693 	0.687 
0.687 	0.702 	0.706 	0.708 
0.692 	0.701 	0.700 	0.715 
0.690 	0.705 	0.710 	0.714 
]';


nonurbanHRIT=[0.757 	0.753 	0.752 	0.752 
0.754 	0.749 	0.748 	0.748 
0.751 	0.751 	0.750 	0.750 
0.755 	0.756 	0.754 	0.754 ]';
nonurbanMSWEP=[ 0.755 	0.757 	0.758 	0.761 
0.751 	0.754 	0.757 	0.757 
0.752 	0.757 	0.758 	0.759 
0.757 	0.761 	0.762 	0.763   
]';
nonurbanCHIRPS=[0.753 	0.751 	0.753 	0.756 
0.750 	0.747 	0.752 	0.753 
0.752 	0.751 	0.754 	0.754 
0.753 	0.752 	0.757 	0.757     
]';
nonurbanGPM=[0.757 	0.760 	0.758 	0.757 
0.751 	0.755 	0.755 	0.755 
0.751 	0.757 	0.757 	0.756 
0.756 	0.761 	0.760 	0.759 
]';

 C1=[1,86,153]./255;
 C2=[250,192,15]./255;
 C3=[79,89,109]./255;
 C4=[95,198,201]./252;

subplot(4,3,1);
h = bar(HRIT,0.5);
set(gca, 'XTickLabel', {'HRLT 1d', 'HRLT 2d', 'HRLT 3d','HRLT 7d'},'FontSize',16,'fontname','Times New Roman','FontWeight','bold');
%set(gca, 'XTickLabel', {});
ylabel(' AUC','fontname','Times New Roman','FontSize',15,'FontWeight','bold');
ylim([0.75, 0.9]);
set(gca,'YTick',[0.75:0.05:0.9],'FontSize',16,'fontname','Times New Roman','FontWeight','bold');
set(gca,'LineWidth',1.5); 
%set(h, 'FaceColor', [113 254 210]/255);
  set(h(1), 'FaceColor', C1);
  set(h(2), 'FaceColor', C2);
  set(h(3), 'FaceColor', C3);
  set(h(4), 'FaceColor', C4);
%  set(h(5), 'FaceColor', [197 154 132]/255);
%  set(h(7), 'FaceColor', [197 168 206]/255);
text(1,0.795,'(a)','FontSize',20,'fontname','Times New Roman','FontWeight','bold')
h=legend({'SM 20','SM 40','SM 80','SM 100'},'FontSize',15,'location','best','fontname','Times New Roman'); 
set(h,'Box','off');


subplot(4,3,4);
h = bar(MSWEP,0.5);
set(gca, 'XTickLabel', {'MSWEP 1d', 'MSWEP 2d', 'MSWEP 3d','MSWEP 7d'},'FontSize',16,'fontname','Times New Roman','FontWeight','bold');
ylabel(' AUC','fontname','Times New Roman','FontSize',15,'FontWeight','bold');
%set(gca, 'XTickLabel', {});
set(gca,'LineWidth',1.5); 
ylim([0.75, 0.90]);
set(gca,'YTick',[0.75:0.05:0.90],'FontSize',16,'fontname','Times New Roman','FontWeight','bold');
  set(h(1), 'FaceColor', C1);
  set(h(2), 'FaceColor', C2);
  set(h(3), 'FaceColor', C3);
  set(h(4), 'FaceColor', C4);
%  set(h(5), 'FaceColor', [197 168 206]/255);
%  set(h(6), 'FaceColor', [197 154 132]/255);
%  set(h(7), 'FaceColor', [197 168 206]/255);
text(1,0.795,'(b)','FontSize',20,'fontname','Times New Roman','FontWeight','bold')

subplot(4,3,7);
h = bar(CHIRPS,0.5);
set(gca, 'XTickLabel', {'CHIRPS 1d', 'CHIRPS 2d', 'CHIRPS 3d','CHIRPS 7d'},'FontSize',16,'fontname','Times New Roman','FontWeight','bold');
ylabel(' AUC','fontname','Times New Roman','FontSize',15,'FontWeight','bold');
set(gca,'LineWidth',1.5); 
%set(gca, 'XTickLabel', {});
ylim([0.75, 0.90]);
set(gca,'YTick',[0.75:0.05:0.90],'FontSize',16,'fontname','Times New Roman','FontWeight','bold');
  set(h(1), 'FaceColor', C1);
  set(h(2), 'FaceColor', C2);
  set(h(3), 'FaceColor', C3);
  set(h(4), 'FaceColor', C4);
%  set(h(6), 'FaceColor', [197 154 132]/255);
%  set(h(7), 'FaceColor', [197 168 206]/255);
text(1,0.795,'(c)','FontSize',20,'fontname','Times New Roman','FontWeight','bold')

subplot(4,3,10);
h = bar(GPM,0.5);
%set(gca, 'XTickLabel', {});
set(gca, 'XTickLabel', {'GPM 1d', 'GPM 2d', 'GPM 3d','GPM 7d'},'FontSize',16,'fontname','Times New Roman','FontWeight','bold');
ylabel(' AUC','fontname','Times New Roman','FontSize',15,'FontWeight','bold');
ylim([0.75, 0.90]);
set(gca,'YTick',[0.75:0.05:0.90],'FontSize',16,'fontname','Times New Roman','FontWeight','bold');
set(gca,'LineWidth',1.5); 
%set(h, 'FaceColor', [113 254 210]/255);
  set(h(1), 'FaceColor', C1);
  set(h(2), 'FaceColor', C2);
  set(h(3), 'FaceColor', C3);
  set(h(4), 'FaceColor', C4);
%  set(h(6), 'FaceColor', [197 154 132]/255);
%  set(h(7), 'FaceColor', [197 168 206]/255);
text(1,0.795,'(d)','FontSize',20,'fontname','Times New Roman','FontWeight','bold')
%h=legend({'SM 10','SM 20','SM 30','SM 40'},'FontSize',15,'location','best','fontname','Times New Roman'); 
%set(h,'Box','off');

subplot(4,3,2);
h = bar(UrbanHRIT,0.5);
set(gca, 'XTickLabel', {'HRIT 1d', 'HRIT 2d', 'HRIT 3d','HRIT 7d'},'FontSize',16,'fontname','Times New Roman','FontWeight','bold');
%set(gca, 'XTickLabel', {});
%ylabel(' AUC','fontname','Times New Roman','FontSize',15,'FontWeight','bold');
set(gca,'LineWidth',1.5); 
ylim([0.40, 0.90]);
set(gca,'YTick',[0.40:0.1:0.90],'FontSize',16,'fontname','Times New Roman','FontWeight','bold');
  set(h(1), 'FaceColor', C1);
  set(h(2), 'FaceColor', C2);
  set(h(3), 'FaceColor', C3);
  set(h(4), 'FaceColor', C4);
%  set(h(5), 'FaceColor', [197 168 206]/255);
%  set(h(6), 'FaceColor', [197 154 132]/255);
%  set(h(7), 'FaceColor', [197 168 206]/255);
text(1,0.795,'(e)','FontSize',20,'fontname','Times New Roman','FontWeight','bold')

subplot(4,3,5);
h = bar(UrbanMSWEP,0.5);
set(gca, 'XTickLabel', {'MSWEP 1d', 'MSWEP 2d', 'MSWEP 3d','MSWEP 7d'},'FontSize',16,'fontname','Times New Roman','FontWeight','bold');
%ylabel(' AUC','fontname','Times New Roman','FontSize',15,'FontWeight','bold');
%set(gca, 'XTickLabel', {});
set(gca,'LineWidth',1.5); 
ylim([0.40, 0.90]);
set(gca,'YTick',[0.40:0.1:0.90],'FontSize',16,'fontname','Times New Roman','FontWeight','bold');
  set(h(1), 'FaceColor', C1);
  set(h(2), 'FaceColor', C2);
  set(h(3), 'FaceColor', C3);
  set(h(4), 'FaceColor', C4);
%  set(h(6), 'FaceColor', [197 154 132]/255);
%  set(h(7), 'FaceColor', [197 168 206]/255);
text(1,0.795,'(f)','FontSize',20,'fontname','Times New Roman','FontWeight','bold')


subplot(4,3,8);
h = bar(UrbanCHIRPS,0.5);
set(gca, 'XTickLabel', {'CHIRPS 1d', 'CHIRPS 2d', 'CHIRPS 3d','CHIRPS 7d'},'FontSize',16,'fontname','Times New Roman','FontWeight','bold');
%ylabel(' AUC','fontname','Times New Roman','FontSize',15,'FontWeight','bold');
%set(gca, 'XTickLabel', {});
ylim([0.40, 0.90]);
set(gca,'YTick',[0.40:0.1:0.90],'FontSize',16,'fontname','Times New Roman','FontWeight','bold');
set(gca,'LineWidth',1.5); 
%set(h, 'FaceColor', [113 254 210]/255);
  set(h(1), 'FaceColor', C1);
  set(h(2), 'FaceColor', C2);
  set(h(3), 'FaceColor', C3);
  set(h(4), 'FaceColor', C4);
%  set(h(6), 'FaceColor', [197 154 132]/255);
%  set(h(7), 'FaceColor', [197 168 206]/255);
text(1,0.795,'(g)','FontSize',20,'fontname','Times New Roman','FontWeight','bold')
%h=legend({'SM 10','SM 20','SM 30','SM 40'},'FontSize',15,'location','best','fontname','Times New Roman'); 
%set(h,'Box','off');

subplot(4,3,11);
h = bar(UrbanGPM,0.5);
set(gca, 'XTickLabel', {'GPM 1d', 'GPM 2d', 'GPM 3d','GPM 7d'},'FontSize',16,'fontname','Times New Roman','FontWeight','bold');
%ylabel(' AUC','fontname','Times New Roman','FontSize',15,'FontWeight','bold');
%set(gca, 'XTickLabel', {});
set(gca,'LineWidth',1.5); 
ylim([0.40, 0.90]);
set(gca,'YTick',[0.40:0.1:0.90],'FontSize',16,'fontname','Times New Roman','FontWeight','bold');
  set(h(1), 'FaceColor', C1);
  set(h(2), 'FaceColor', C2);
  set(h(3), 'FaceColor', C3);
  set(h(4), 'FaceColor', C4);
%  set(h(5), 'FaceColor', [197 168 206]/255);
%  set(h(6), 'FaceColor', [197 154 132]/255);
%  set(h(7), 'FaceColor', [197 168 206]/255);
text(1,0.795,'(h)','FontSize',20,'fontname','Times New Roman','FontWeight','bold')

subplot(4,3,3);
h = bar(nonurbanHRIT,0.5);
set(gca, 'XTickLabel', {'HRLT 1d', 'HRLT 2d', 'HRLT 3d','HRLT 7d'},'FontSize',16,'fontname','Times New Roman','FontWeight','bold');
%ylabel(' AUC','fontname','Times New Roman','FontSize',15,'FontWeight','bold');
set(gca,'LineWidth',1.5); 
ylim([0.74, 0.78]);
set(gca,'YTick',[0.74:0.01:0.78],'FontSize',16,'fontname','Times New Roman','FontWeight','bold');
  set(h(1), 'FaceColor', C1);
  set(h(2), 'FaceColor', C2);
  set(h(3), 'FaceColor', C3);
  set(h(4), 'FaceColor', C4);
%  set(h(6), 'FaceColor', [197 154 132]/255);
%  set(h(7), 'FaceColor', [197 168 206]/255);
text(1,0.765,'(i)','FontSize',20,'fontname','Times New Roman','FontWeight','bold')


subplot(4,3,6);
h = bar(nonurbanMSWEP,0.5);
set(gca, 'XTickLabel', {'MSWEP 1d', 'MSWEP 2d', 'MSWEP 3d','MSWEP 7d'},'FontSize',16,'fontname','Times New Roman','FontWeight','bold');
%ylabel(' AUC','fontname','Times New Roman','FontSize',15,'FontWeight','bold');
ylim([0.74, 0.78]);
set(gca,'YTick',[0.74:0.01:0.78],'FontSize',16,'fontname','Times New Roman','FontWeight','bold');
set(gca,'LineWidth',1.5); 
%set(h, 'FaceColor', [113 254 210]/255);
  set(h(1), 'FaceColor', C1);
  set(h(2), 'FaceColor', C2);
  set(h(3), 'FaceColor', C3);
  set(h(4), 'FaceColor', C4);
%  set(h(6), 'FaceColor', [197 154 132]/255);
%  set(h(7), 'FaceColor', [197 168 206]/255);
text(1,0.795,'(j)','FontSize',20,'fontname','Times New Roman','FontWeight','bold')
%h=legend({'SM 10','SM 20','SM 30','SM 40'},'FontSize',15,'location','best','fontname','Times New Roman'); 
%set(h,'Box','off');

subplot(4,3,9);
h = bar(nonurbanCHIRPS,0.5);
set(gca, 'XTickLabel', {'CHIRPS 1d', 'CHIRPS 2d', 'CHIRPS 3d','CHIRPS 7d'},'FontSize',16,'fontname','Times New Roman','FontWeight','bold');
%ylabel(' AUC','fontname','Times New Roman','FontSize',15,'FontWeight','bold');
set(gca,'LineWidth',1.5); 
ylim([0.74, 0.78]);
set(gca,'YTick',[0.74:0.01:0.78],'FontSize',16,'fontname','Times New Roman','FontWeight','bold');
  set(h(1), 'FaceColor', C1);
  set(h(2), 'FaceColor', C2);
  set(h(3), 'FaceColor', C3);
  set(h(4), 'FaceColor', C4);
%  set(h(5), 'FaceColor', [197 168 206]/255);
%  set(h(6), 'FaceColor', [197 154 132]/255);
%  set(h(7), 'FaceColor', [197 168 206]/255);
text(1,0.795,'(k)','FontSize',20,'fontname','Times New Roman','FontWeight','bold')

subplot(4,3,12);
h = bar(nonurbanGPM,0.5);
set(gca, 'XTickLabel', {'GPM 1d', 'GPM 2d', 'GPM 3d','GPM 7d'},'FontSize',16,'fontname','Times New Roman','FontWeight','bold');
%ylabel(' AUC','fontname','Times New Roman','FontSize',15,'FontWeight','bold');
set(gca,'LineWidth',1.5); 
ylim([0.74, 0.78]);
set(gca,'YTick',[0.74:0.01:0.78],'FontSize',16,'fontname','Times New Roman','FontWeight','bold');
  set(h(1), 'FaceColor', C1);
  set(h(2), 'FaceColor', C2);
  set(h(3), 'FaceColor', C3);
  set(h(4), 'FaceColor', C4);
%  set(h(6), 'FaceColor', [197 154 132]/255);
%  set(h(7), 'FaceColor', [197 168 206]/255);
text(1,0.76,'(l)','FontSize',20,'fontname','Times New Roman','FontWeight','bold')










