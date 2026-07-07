%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% level of activation (low and intermediate)
pCa = [6.0, 5.8];
k = length(pCa);
% u2 and z2
m = 100;
n = 100;
u2 = linspace(1,24,m);
z2 = linspace(1,8,n);
% Create a grid of x and y values
[U2,Z2] = meshgrid(u2,z2);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Extract the fitted parameters for mouse LV data
murine_ctrl = load('fitted_murine_ctrl_8.mat');
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Extract the fitted parameters for porcine LV data
murine_NEM = load('fitted_murine_NEM_8.mat');
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Parameter set for murine control and murine NEM
param_murine_ctrl = murine_ctrl.relktr;
param_murine_NEM = murine_NEM.relktr;
% remove u2 and z2
param_murine_ctrl([16 18]) = [];
param_murine_NEM([16 18]) = [];
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% preallocate ktr
ktr_ctrl = zeros(m,n,k);
ktr_NEM = zeros(m,n,k);
% Compute ktr for pCa = 6.0 and pCa = 5.8
for i = 1:k
    ktr_ctrl(:,:,i) = rate_force_redev_NEM_1(param_murine_ctrl,u2,z2,pCa(i));
    ktr_NEM(:,:,i) = rate_force_redev_NEM_1(param_murine_NEM,u2,z2,pCa(i));
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Plot the heatmap
h1 = subplot(2,2,1); % plot ktr murine ctrl at pCa=6.0
ax = gca;
contourf(U2,Z2,ktr_ctrl(:,:,1),'LineStyle','none');
c1 = colorbar;
colorTitleHandle = get(c1,'Title');
title_string = 'ktr';
set(colorTitleHandle,'String',title_string);
ax.FontSize = 16;
xlabel('u_2','FontSize',18)
ax.XAxis.LineWidth = 1.5;
ylabel('z_2','FontSize',18)
ax.YAxis.LineWidth = 1.5;
ax.TitleHorizontalAlignment = 'left';
title(['(A) Murine control, pCa = ',num2str(pCa(1))],'FontSize',18)
%%%%%%%%%%%%
h2 = subplot(2,2,2); % plot ktr murine NEM at pCa=6.0
ax = gca;
contourf(U2,Z2,ktr_NEM(:,:,1),'LineStyle','none');
c2 = colorbar;
colorTitleHandle = get(c2,'Title');
title_string = 'ktr';
set(colorTitleHandle,'String',title_string);
ax.FontSize = 16;
xlabel('u_2','FontSize',18)
ax.XAxis.LineWidth = 1.5;
ylabel('z_2','FontSize',18)
ax.YAxis.LineWidth = 1.5;
ax.TitleHorizontalAlignment = 'left';
title(['(B) Murine NEM-S1, pCa = ',num2str(pCa(1))],'FontSize',18)
%%%%%%%%%%%%
h3 = subplot(2,2,3); % plot ktr murine ctrl at pCa=5.8
ax = gca;
contourf(U2,Z2,ktr_ctrl(:,:,2),'LineStyle','none');
c3 = colorbar;
colorTitleHandle = get(c3,'Title');
title_string = 'ktr';
set(colorTitleHandle,'String',title_string);
ax.FontSize = 16;
xlabel('u_2','FontSize',18)
ax.XAxis.LineWidth = 1.5;
ylabel('z_2','FontSize',18)
ax.YAxis.LineWidth = 1.5;
ax.TitleHorizontalAlignment = 'left';
title(['(C) Murine control, pCa = ',num2str(pCa(2))],'FontSize',18)
%%%%%%%%%%%%
h4 = subplot(2,2,4); % plot ktr murine NEM at pCa = 5.8
ax = gca;
contourf(U2,Z2,ktr_NEM(:,:,2),'LineStyle','none');
c4 = colorbar;
colorTitleHandle = get(c4,'Title');
title_string = 'ktr';
set(colorTitleHandle,'String',title_string);
ax.FontSize = 16;
xlabel('u_2','FontSize',18)
ax.XAxis.LineWidth = 1.5;
ylabel('z_2','FontSize',18)
ax.YAxis.LineWidth = 1.5;
ax.TitleHorizontalAlignment = 'left';
title(['(D) Murine NEM-S1, pCa = ',num2str(pCa(2))],'FontSize',18)
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% set(0,'Units','normalized')
% set(h4,'position',[.56 .07 .38 .38])
% set(h3,'position',[.06 .07 .38 .38])
% set(h2,'position',[.56 .56 .38 .38])
% set(h1,'position',[.06 .56 .38 .38])
% set(gcf, 'PaperSize', [12 12], 'PaperPosition', [0 0 12 12])
% print('Figure7','-dpdf')
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%