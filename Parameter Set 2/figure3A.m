close all
clc
%%%%%%%%%%%%%%%%%%%%%
% range of pCa values
n = 500;
pCa_start = 6.3;
pCa_end = 4.5;
pCa = linspace(pCa_start,pCa_end,n);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Extract the fitted parameters for control murine data
murine_ctrl = load('fitted_murine_ctrl_2.mat');
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Extract the fitted parameters for NEM-S1 treated murine data
murine_NEM = load('fitted_murine_NEM_2.mat');
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Compute ktr using the fitted parameters
fitted_ktr_murine_ctrl = rate_force_redev_NEM(murine_ctrl.ktr,pCa);
fitted_ktr_murine_NEM = rate_force_redev_NEM(murine_NEM.ktr,pCa);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Figure
ax = gca;
%%%%%%%%%
plot(pCa,fitted_ktr_murine_ctrl,'k-',...
     'markersize',10,'LineWidth',4), hold on
errorbar(murine_ctrl.pCa,murine_ctrl.data_ktr(:,1),murine_ctrl.data_ktr(:,2),...
         '.','MarkerSize',40,'MarkerEdgeColor','black',...
             'Color','black','LineWidth',2.5), hold on
%%%%%%%%%
plot(pCa,fitted_ktr_murine_NEM,'r-',...
    'markersize',10,'LineWidth',4), hold on
errorbar(murine_NEM.pCa,murine_NEM.data_ktr(:,1),murine_NEM.data_ktr(:,2),...
         '.','MarkerSize',40,'MarkerEdgeColor','red',...
             'Color','red','LineWidth',2.5); hold on
set(gca, 'XDir','reverse')
%%%%%%%%%
ax.FontSize = 20;
xlabel('pCa','FontName', 'Times','FontSize',24);
ax.XAxis.LineWidth = 1.5;
ylabel('Rate of force redevelopment ($s^{-1}$)','Interpreter','latex','FontName',... 
              'Times','FontSize',24,'FontWeight','bold');
ax.YAxis.LineWidth = 1.5;
legend('Control murine fitted solution','Control murine data',...
       'NEM-S1 murine fitted solution','NEM-S1 murine data',...
       'FontSize', 20,'LineWidth',1.5,'Location','best');
title('Parameter set 2: ktr vs pCa','FontSize',30)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% set(0,'Units','normalized')
% set(gcf, 'PaperSize', [10 8], 'PaperPosition', [0 0 10 8])
% print('Figure4A','-djpeg')