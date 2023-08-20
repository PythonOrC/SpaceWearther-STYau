ACE = readtable("20031029_ace_mag_1m.csv");
SYM_H = readtable("20031029_sym_h_1m.csv");

ACE.Bx(ACE.Bx == -999.9) = NaN;
ACE.By(ACE.By == -999.9) = NaN;
ACE.Bz(ACE.Bz == -999.9) = NaN;

figure;
tbl=table([0:1439]', ACE.Bx, ACE.By, ACE.Bz, SYM_H.SYM_H,'VariableNames',{'Time','Bx','By','Bz','SYM_H'});

plt = stackedplot(tbl, "Xvariable","Time", "Title", "IMF Data on October 29, 2003","DisplayLabels",["Bx (nT)","By (nT)","Bz (nT)","SYM_H (nT)"]);
ax = findobj(plt.NodeChildren, 'Type','Axes');
plt.XLimits = [0 1440];
plt.XLabel = "Time (hour)";
set(ax,'XTick',[0 120 240 360 480 600 720 840 960 1080 1200 1320 1440],'XTickLabel',{0,2,4,6,8,10,12,14,16,18,20,22,24})
plt.LineProperties(1).Color = [0 0.4470 0.7410];
plt.LineProperties(2).Color = [0.8500 0.3250 0.0980];
plt.LineProperties(3).Color = [0.9290 0.6940 0.1250];
plt.LineProperties(4).Color = [0.4940 0.1840 0.5560];
plt.FontName = "Arial";
plt.FontSize = 9;


x0=10;
y0=10;
width=900;
height=600;
set(gcf,'position',[x0,y0,width,height]);