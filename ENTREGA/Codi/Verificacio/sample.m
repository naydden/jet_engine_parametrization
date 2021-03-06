clc;
clear all;
close all;
plot1=[0 0
1 -0.00087300001
2 -0.0024590001];

plot100=[0 0
0.2 -0.000239
0.40000001 -0.00080500002
0.60000002 -0.001642
0.80000001 -0.0026809999
1 -0.0038689999
1.2 -0.0051589999
1.4 -0.006513
1.6 -0.0079009999
1.8 -0.0093019996
2 -0.010703];

plot900=[0 0
0.133333 -0.000137
0.26666701 -0.00043700001
0.40000001 -0.00089600001
0.533333 -0.001482
0.66666698 -0.002177
0.80000001 -0.002961
0.93333298 -0.003817
1.0666699 -0.0047280001
1.2 -0.005682
1.33333 -0.0066669998
1.46667 -0.0076720002
1.6 -0.008688
1.73333 -0.0097110001
1.86667 -0.010734
2 -0.011756];

plot4=[0 0
0.1 -9.4000003e-005
0.2 -0.00028099999
0.30000001 -0.00056999997
0.40000001 -0.00094400003
0.5 -0.001392
0.60000002 -0.001907
0.69999999 -0.002478
0.80000001 -0.0030990001
0.89999998 -0.003762
1 -0.0044590002
1.1 -0.0051850001
1.2 -0.0059329998
1.3 -0.006699
1.4 -0.0074780001
1.5 -0.0082660001
1.6 -0.0090589998
1.7 -0.0098559996
1.8 -0.010654
1.9 -0.011451
2 -0.012247];

figure
hold on
plot(plot1(:,1),plot1(:,2),'-.g',...
    'LineWidth',2)
plot(plot100(:,1),plot100(:,2),'--k',...
    'LineWidth',2)
plot(plot900(:,1),plot900(:,2),'-.r',...
    'LineWidth',2)
plot(plot4(:,1),plot4(:,2),'--b',...
    'LineWidth',2)
axis([0 2 -0.02 0.02])
xlabel('BEM x axis',...
'FontSize',12,...
'FontName','Helvetica')

ylabel('nodal y-displacement',...
'FontSize',12,...
'FontName','Helvetica')

legend('MESH1','MESH2','MESH3','MESH4',...
'FontUnits','points',...
'interpreter','normal',...
'FontSize',14,...
'FontName','Helvetica',...
'Location','NorthEast')


hold off
print -depsc2 myplot.eps
% legend('900 elements','100 elements','1 element')