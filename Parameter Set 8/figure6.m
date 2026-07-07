close all
clc
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% range of pCa values
n = 500;
pCa_start = 6.2;
pCa_end = 4.5;
pCa = linspace(pCa_start,pCa_end,n);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Extract the fitted parameters of murine LV control data
murine_ctrl = load('fitted_murine_ctrl_8.mat');
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Extract the data of murine LV control
murine_NEM = load('fitted_murine_NEM_8.mat');
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Compute rel ktr and P/P_0 using fitted parameters with different u2
param_relktr_ctrl_u2 = murine_ctrl.relktr;
param_relktr_NEM_u2 = murine_NEM.relktr;
u2_ctrl = [murine_ctrl.relktr(16); 2; 5; 8; 12];
u2_NEM = [murine_NEM.relktr(16); 21; 17; 14; 12];
m1 = length(u2_ctrl);
m2 = length(u2_NEM);
fitted_relktr_ctrl_u2 = zeros(n,m1);
fitted_relktr_NEM_u2 = zeros(n,m2);
%%%%%%%%%%%%
for i = 1:m1
    param_relktr_ctrl_u2(16) = u2_ctrl(i);
    fitted_relktr_ctrl_u2(:,i) = rel_rate_force_redev_NEM(param_relktr_ctrl_u2,pCa);    
end
%%%%%%%%%%%%
for i = 1:m2
    param_relktr_NEM_u2(16) = u2_NEM(i);
    fitted_relktr_NEM_u2(:,i) = rel_rate_force_redev_NEM(param_relktr_NEM_u2,pCa);
end
%%%%%%%%%%%%
fitted_relf_ctrl = rel_force_NEM(murine_ctrl.relf,pCa);
fitted_relf_NEM = rel_force_NEM(murine_NEM.relf,pCa);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Compute rel ktr
param_relktr_ctrl_z2 = murine_ctrl.relktr;
param_relktr_NEM_z2 = murine_NEM.relktr;
z2_ctrl = [murine_ctrl.relktr(18); 6; 5; 3; 1];
z2_NEM = [3;2.5;murine_NEM.relktr(18); 2; 1];
m3 = length(z2_ctrl);
m4 = length(z2_NEM);
fitted_relktr_ctrl_z2 = zeros(n,m3);
fitted_relktr_NEM_z2 = zeros(n,m4);
%%%%%%%%%%%%
for i = 1:m3
    param_relktr_ctrl_z2(18) = z2_ctrl(i);
    fitted_relktr_ctrl_z2(:,i) = rel_rate_force_redev_NEM(param_relktr_ctrl_z2,pCa);    
end
%%%%%%%%%%%%
for i = 1:m4
    param_relktr_NEM_z2(18) = z2_NEM(i);
    fitted_relktr_NEM_z2(:,i) = rel_rate_force_redev_NEM(param_relktr_NEM_z2,pCa);
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Figures
colors = [1,0,0
0,1,0
0,0,1
0,1,1
1,0,1
1,1,0
0,0,0];
% colororder(colors);
set(gcf,'DefaultAxesColorOrder',colors)
%%%%%%%%%%%%%%%%%%%%
h1 = subplot(2,2,1);
ax = gca;
L1 = cell(m1+1,1);
for i = 1:m1
    plot(fitted_relf_ctrl,fitted_relktr_ctrl_u2(:,i),...
                   'markersize',10,'LineWidth',2), hold on
    if i == 1
        L1{i} = strcat('fitted solution - u_2 = ', num2str(u2_ctrl(i)));
    else
        L1{i} = strcat('solution - u_2 = ', num2str(u2_ctrl(i)));
    end
end
errorbar(murine_ctrl.data_relf(:,1),murine_ctrl.data_relktr(:,1),...
         murine_ctrl.data_relktr(:,2),murine_ctrl.data_relktr(:,2),...
         murine_ctrl.data_relf(:,2),murine_ctrl.data_relf(:,2),...
         '.','MarkerSize',25,'MarkerEdgeColor','black',...
                'Color','black','LineWidth',1), hold on
L1{m1+1} = strcat('Murine LV control data');
ax.FontSize = 12;  
xlabel('Relative force','FontName', 'Times','FontSize',18);
ax.XAxis.LineWidth = 1.5;
ylabel('Relative $ktr$','Interpreter','latex','FontName', 'Times',...
                                   'FontSize',18,'FontWeight','bold');
ax.YAxis.LineWidth = 1.5;
legend(L1,'Location','northwest')
ax.TitleHorizontalAlignment = 'left';
title('A','FontSize',18)
axis([0 1 0 1.05])
% set(gca, 'XDir','reverse')
%%%%%%%%%%%%%%%%%%%%%
h2 = subplot(2,2,2);
ax = gca;
L2 = cell(m2+1,1);
for i = 1:m2
   plot(fitted_relf_NEM,fitted_relktr_NEM_u2(:,i),...
                   'markersize',10,'LineWidth',2), hold on
   if i == 1
       L2{i} = strcat('fitted solution - u_2 = ', num2str(u2_NEM(i)));
   else
       L2{i} = strcat('solution - u_2 = ', num2str(u2_NEM(i)));
   end
end
errorbar(murine_NEM.data_relf(:,1),murine_NEM.data_relktr(:,1),...
         murine_NEM.data_relktr(:,2),murine_NEM.data_relktr(:,2),...
         murine_NEM.data_relf(:,2),murine_NEM.data_relf(:,2),...
         '.','MarkerSize',25,'MarkerEdgeColor','black',...
                'Color','black','LineWidth',1), hold on
L2{m2+1} = strcat('Murine LV NEM-S1 data');
ax.FontSize = 12;
xlabel('Relative force','FontName', 'Times','FontSize',18);
ax.XAxis.LineWidth = 1.5;
ylabel('Relative $ktr$','Interpreter','latex','FontName', 'Times',...
                                   'FontSize',18,'FontWeight','bold');
ax.YAxis.LineWidth = 1.5;
legend(L2,'Location','best')
ax.TitleHorizontalAlignment = 'left';
title('B','FontSize',18)
axis([0 1 0 1.05])
% set(gca, 'XDir','reverse')
%%%%%%%%%%%%%%%%%%%%
h3 = subplot(2,2,3);
ax = gca;
L3 = cell(m3+1,1);
for i = 1:m3
    plot(fitted_relf_ctrl,fitted_relktr_ctrl_z2(:,i),...
                           'markersize',10,'LineWidth',2), hold on
    if i == 1
        L3{i} = strcat('fitted solution - z_2 = ', num2str(z2_ctrl(i)));
    else
        L3{i} = strcat('solution - z_2 = ', num2str(z2_ctrl(i)));
    end
end
errorbar(murine_ctrl.data_relf(:,1),murine_ctrl.data_relktr(:,1),...
         murine_ctrl.data_relktr(:,2),murine_ctrl.data_relktr(:,2),...
         murine_ctrl.data_relf(:,2),murine_ctrl.data_relf(:,2),...
         '.','MarkerSize',25,'MarkerEdgeColor','black',...
                'Color','black','LineWidth',1), hold on
L3{m3+1} = strcat('Murine LV control data');
ax.FontSize = 12;
xlabel('Relative force','FontName', 'Times','FontSize',18);
ax.XAxis.LineWidth = 1.5;
ylabel('Relative $ktr$','Interpreter','latex','FontName', 'Times',...
                                       'FontSize',18,'FontWeight','bold');
ax.YAxis.LineWidth = 1.5;
legend(L3,'Location','west')
ax.TitleHorizontalAlignment = 'left';
title('C','FontSize',18)
axis([0 1 0 1.05])
% set(gca, 'XDir','reverse')
%%%%%%%%%%%%%%%%%%%%
h4 = subplot(2,2,4);
ax = gca;
L4 = cell(m4+1,1);
for i = 1:m4
    plot(fitted_relf_NEM,fitted_relktr_NEM_z2(:,i),...
                               'markersize',10,'LineWidth',2), hold on
    if i == 3
        L4{i} = strcat('fitted solution - z_2 = ', num2str(z2_NEM(i)));
    else
        L4{i} = strcat('solution - z_2 = ', num2str(z2_NEM(i)));
    end
end
errorbar(murine_NEM.data_relf(:,1),murine_NEM.data_relktr(:,1),...
         murine_NEM.data_relktr(:,2),murine_NEM.data_relktr(:,2),...
         murine_NEM.data_relf(:,2),murine_NEM.data_relf(:,2),...
         '.','MarkerSize',25,'MarkerEdgeColor','black',...
                'Color','black','LineWidth',1), hold on
L4{m4+1} = strcat('Murine LV NEM-S1 data');
ax.FontSize = 12;
xlabel('Relative force','FontName', 'Times','FontSize',18);
ax.XAxis.LineWidth = 1.5;
ylabel('Relative $ktr$','Interpreter','latex','FontName', 'Times',...
                                   'FontSize',18,'FontWeight','bold');
ax.YAxis.LineWidth = 1.5;
legend(L4,'Location','southeast')
ax.TitleHorizontalAlignment = 'left';
title('D','FontSize',18)
axis([0 1 0 1.05])
% set(gca, 'XDir','reverse')
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% set(0,'Units','normalized')
% set(h4,'position',[.57 .08 .38 .38])
% set(h3,'position',[.09 .08 .38 .38])
% set(h2,'position',[.57 .56 .38 .38])
% set(h1,'position',[.09 .56 .38 .38])
% set(gcf, 'PaperSize', [12 12], 'PaperPosition', [0 0 12 12])
% print('figure6','-dpdf')
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%