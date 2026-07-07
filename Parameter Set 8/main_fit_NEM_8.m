%% Options of execution - paramter set 8
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Fit_ktr_murine_ctrl = 0; 
Fit_ktr_murine_NEM = 0;
%
Fit_rel_SSF_murine_ctrl = 0; 
Fit_rel_SSF_murine_NEM = 0;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Fit NEM model to ktr vs pCa data in control and NEM murine
if Fit_ktr_murine_ctrl
    
    close all
    clc
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % Mechanical data from control murine
    pCa_ctrl = [6.0; 5.9; 5.8; 5.7; 5.6; 5.5; 4.5];
    ktr_mean_ctrl = [3.9; 3.6; 6.4; 9.0; 15.3; 21.3; 29.8];
    ktr_SEM_ctrl = [0.7; 0.7; 0.9; 1.3; 1.6; 1.8; 2.1];
    %%%%%%%%%%%%
    % Error function - the norm of the difference between actual observations
    % (data) and predicted observations (the solution of the model)
    ftns_1 = @(para_fit) norm(ktr_mean_ctrl - rate_force_redev_NEM(para_fit,pCa_ctrl));
    Parms_1 = 21; % the number of fitting parameters
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % initial values of the parameters to be fitted
    pCa_50 = 5.61;
    k0_BC = 0.0851;
    kCa_BC = 1.3687;
    k0_CB = 0.3645;
    kCa_CB = 0.9914;
    f0_CM1 = 25.4031;
    f0_M1C = 41.5592;
    k_M1M2 = 74.6448;
    k_M2M1 = 82.0666;
    k_M2C = 67.2292;
    alpha = 0.8293;
    alpha_bar = 0.8389;
    beta = 1;
    beta_bar = 0.9;
    u1 = 1.0121;
    u2 = 1.2420;
    z1 = 1;
    z2 = 6.7913;
    v = 5.4474;
    w = 1.0043;
    NEM = 0;

    % Initial fitting parameter vector
    para_fit_1 = [pCa_50;
                  k0_BC;
                  kCa_BC;
                  k0_CB;
                  kCa_CB;
                  f0_CM1;
                  f0_M1C;
                  k_M1M2;
                  k_M2M1;
                  k_M2C;
                  alpha;
                  alpha_bar;
                  beta;
                  beta_bar;
                  u1;
                  u2;
                  z1;
                  z2;
                  v;
                  w;
                  NEM];

    lower_bound_1 = [5.61;  % pCa_50
                     0;     % k0_BC
                     0;     % kCa_BC
                     0;     % k0_CB
                     0;     % kCa_CB
                     0;     % f0_CM1 
                     0;     % f0_M1C
                     0;     % k_M1M2  
                     0;     % k_M2M1
                     0;     % k_M2C
                     0;     % alpha
                     0;     % alpha_bar
                     0;     % beta
                     0;     % beta_bar
                     1;     % u1
                     1;     % u2
                     1;     % z1
                     1;     % z2
                     1;     % v
                     1;     % w
                     0      % NEM
                     ];
    
    upper_bound_1 = [5.61;  % pCa_50
                     Inf;     % k0_BC
                     Inf;     % kCa_BC
                     Inf;     % k0_CB
                     Inf;     % kCa_CB
                     Inf;     % f0_CM1 
                     Inf;     % f0_M1C
                     Inf;     % k_M1M2  
                     Inf;     % k_M2M1
                     Inf;     % k_M2C
                     1;     % alpha
                     1;     % alpha_bar
                     1;     % beta
                     1;     % beta_bar
                     Inf;     % u1
                     Inf;     % u2
                     Inf;     % z1
                     Inf;     % z2
                     Inf;     % v
                     Inf;     % w
                     0      % NEM
                     ];
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % optimization options for pattern search
    opts = optimoptions('patternsearch', ...
    'Display', 'iter', ...
    'Cache', 'on', ...                    % Enable caching for repeated evaluations
    'UseCompletePoll', true, ...          % Use complete polling for better exploration
    'UseParallel', false, ...              % Enable parallel evaluation
    'CompletePoll', 'on', ...             % Complete polling at each iteration
    'InitialMeshSize', 0.1, ...           % Initial mesh size
    'MaxIterations', 1, ...             % Maximum iterations
    'MaxFunctionEvaluations', 1e5, ...    % Maximum function evaluations
    'ScaleMesh', 'off', ...               % Mesh scaling
    'MeshTolerance', 1e-10, ...           % Mesh tolerance
    'FunctionTolerance', 1e-12, ...       % Function tolerance for accuracy
    'StepTolerance', 1e-12, ...           % Step tolerance
    'PlotFcn', @psplotbestf, ...          % Plot function
    'PollMethod', 'MADSPositiveBasis2N', ... % More efficient polling method
    'SearchFcn', @searchlhs, ...          % Latin Hypercube search
    'MeshExpansionFactor', 2.0, ...       % Mesh expansion factor
    'MeshContractionFactor', 0.5, ...     % Mesh contraction factor
    'AccelerateMesh', true);           % Enable mesh acceleration

    % pattern-search algorithm
    [fitted_para_1,fval_1,exitflag_1,output_1]=patternsearch(ftns_1,para_fit_1,...
                                    [],[],[],[],lower_bound_1,upper_bound_1,[],opts);
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % Print out values of the new fitted parameters
    fprintf('fitted parameters for control murine data:\n')
    fprintf('pCa50 = %f \n',fitted_para_1(1))
    fprintf('k0_BC = %f, kCa_BC = %f, k0_CB = %f, kCa_CB = %f \n', fitted_para_1(2:5))
    fprintf('f0_CM1 = %f, f0_M1C = %f \n', fitted_para_1(6:7))
    fprintf('k_M1M2 = %f, k_M2M1 = %f, k_M2C = %f \n', fitted_para_1(8:10))
    fprintf('alpha = %f, alpha_bar = %f, beta = %f, beta_bar = %f \n', fitted_para_1(11:14))
    fprintf('u1 = %f, u2 = %f \n', fitted_para_1(15:16))
    fprintf('z1 = %f, z2 = %f \n', fitted_para_1(17:18))
    fprintf('v = %f, w = %f \n', fitted_para_1(19:20))
    fprintf('NEM = %f \n', fitted_para_1(21))
    fprintf('RMSE = %f', fval_1)
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % Compute the fitted rate of force redevelopment
    n = 500;
    pCa_start = 6.3;
    pCa_end = 4.5;
    p_Ca = linspace(pCa_start,pCa_end,n);
    fitted_ktr_1 = rate_force_redev_NEM(fitted_para_1,p_Ca);
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % Plot the mechanical data and the fitted solution in the same graph
    clf
    h = axes('Position',[0 0 1 1],'Visible','off');
    axes('Position',[.1 .1 .62 .8]);
    ax = gca;
    errorbar(pCa_ctrl,ktr_mean_ctrl,ktr_SEM_ctrl,'.','MarkerSize',25,...
             'MarkerEdgeColor','blue','Color','blue','LineWidth',1); hold on
    plot(p_Ca,fitted_ktr_1,'k-','LineWidth',2);
    set(gca, 'XDir','reverse');
    ax.FontSize = 16
    xlabel('pCa','FontSize',16);
    ax.XAxis.LineWidth = 1.5;
    ylabel('Rate of force redevelopment ($ktr$)','Interpreter','latex','FontSize',16);
    ax.YAxis.LineWidth = 1.5;
    legend('Control murine data','fitted solution','Location','best');
    
    title('Fitting control murine data: ktr vs pCa using parameter set 8', 'FontSize',20)
    ax.TitleHorizontalAlignment = 'left';
    str(1) = {'Fitted parameter set:'};
    str(2) = {[' $pCa_{50}$ = ', num2str(fitted_para_1(1))]};
    str(3) = {[' $k^0_{BC}$ = ', num2str(fitted_para_1(2))]};
    str(4) = {[' $k^{Ca}_{BC}$ = ', num2str(fitted_para_1(3))]};
    str(5) = {[' $k^0_{CB}$ = ', num2str(fitted_para_1(4))]};
    str(6) = {[' $k^{Ca}_{CB}$ = ', num2str(fitted_para_1(5))]};
    str(7) = {[' $f^0_{CM_1}$ = ', num2str(fitted_para_1(6))]};
    str(8) = {[' $f^0_{M_1C}$ = ', num2str(fitted_para_1(7))]};
    str(9) = {[' $k_{M_1M_2}$ = ', num2str(fitted_para_1(8))]};
    str(10) = {[' $k_{M_2M_1}$ = ', num2str(fitted_para_1(9))]};
    str(11) = {[' $k_{M_2C}$ = ', num2str(fitted_para_1(10))]};
    str(12) = {[' $\alpha$ = ', num2str(fitted_para_1(11))]};
    str(13) = {[' $\bar{\alpha}$ = ', num2str(fitted_para_1(12))]};
    str(14) = {[' $\beta$ = ', num2str(fitted_para_1(13))]};
    str(15) = {[' $\bar{\beta}$ = ', num2str(fitted_para_1(14))]};
    str(16) = {[' $u_1$ = ', num2str(fitted_para_1(15))]};
    str(17) = {[' $u_2$ = ', num2str(fitted_para_1(16))]};
    str(18) = {[' $z_1$ = ', num2str(fitted_para_1(17))]};
    str(19) = {[' $z_2$ = ', num2str(fitted_para_1(18))]};
    str(20) = {[' $v$ = ', num2str(fitted_para_1(19))]};
    str(21) = {[' $w$ = ', num2str(fitted_para_1(20))]};
    str(22) = {[' NEM = ', num2str(fitted_para_1(21))]};
    str(23) = {[' RMSE = ', num2str(fval_1)]};
    set(gcf,'CurrentAxes',h)
    text(.77,.5,str,'Interpreter','latex','FontSize',16)
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Fit NEM model to ktr vs pCa data in NEM murine
if Fit_ktr_murine_NEM
    
    close all
    clc
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % Mechanical data from NEM treated murine
    pCa_NEM = [6.1; 6.0; 5.9; 5.8; 5.7; 5.6; 5.5; 4.5];
    ktr_mean_NEM = [26.5; 22.4; 17.1; 14.7; 17.7; 21.8; 23.8; 28.2];
    ktr_SEM_NEM = [2.2; 2.1; 1.5; 1.6; 1.6; 1.7; 1.8; 2.1];
    %%%%%%%%%%%%
    % Error function - the norm of the difference between actual observations
    % (data) and predicted observations (the solution of the model)
    ftns_2 = @(para_fit) norm(ktr_mean_NEM - rate_force_redev_NEM(para_fit,pCa_NEM));
    Parms_2 = 21; % the number of fitting parameters
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % initial values of the parameters to be fitted
    pCa_50 = 5.29;
    k0_BC = 0.0645;
    kCa_BC = 2940.7666;
    k0_CB = 4261.0715;
    kCa_CB = 0.0891;
    f0_CM1 = 68.4571;
    f0_M1C = 1704.2601;
    k_M1M2 = 30.7552;
    k_M2M1 = 11.3271;
    k_M2C = 23.3146;
    alpha = 1;
    alpha_bar = 1;
    beta = 0.7978;
    beta_bar = 0.9701;
    u1 = 1.7320;
    u2 = 22.1711;
    z1 = 1;
    z2 = 2.3513;
    v = 2.1529;
    w = 1;
    NEM = 0.05;
    
    % Initial fitting parameter vector
    para_fit_2 = [pCa_50;
                  k0_BC;
                  kCa_BC;
                  k0_CB;
                  kCa_CB;
                  f0_CM1;
                  f0_M1C;
                  k_M1M2;
                  k_M2M1;
                  k_M2C;
                  alpha;
                  alpha_bar;
                  beta;
                  beta_bar;
                  u1;
                  u2;
                  z1;
                  z2;
                  v;
                  w;
                  NEM];

    lower_bound_2 = [5.29;  % pCa_50
                     0;     % k0_BC
                     0;     % kCa_BC
                     0;     % k0_CB
                     0;     % kCa_CB
                     0;     % f0_CM1 
                     0;     % f0_M1C
                     0;     % k_M1M2  
                     0;     % k_M2M1
                     0;     % k_M2C
                     0;     % alpha
                     0;     % alpha_bar
                     0;     % beta
                     0;     % beta_bar
                     1;     % u1
                     1;     % u2
                     1;     % z1
                     1;     % z2
                     1;     % v
                     1;     % w
                     0.005      % NEM
                     ];
    
    upper_bound_2 = [5.29;  % pCa_50
                     Inf;     % k0_BC
                     Inf;     % kCa_BC
                     Inf;     % k0_CB
                     Inf;     % kCa_CB
                     Inf;     % f0_CM1 
                     Inf;     % f0_M1C
                     Inf;     % k_M1M2  
                     Inf;     % k_M2M1
                     Inf;     % k_M2C
                     1;     % alpha
                     1;     % alpha_bar
                     1;     % beta
                     1;     % beta_bar
                     Inf;     % u1
                     Inf;     % u2
                     Inf;     % z1
                     Inf;     % z2
                     Inf;     % v
                     Inf;     % w
                     0.5      % NEM
                     ];
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % optimization options for pattern search
    opts = optimoptions('patternsearch', ...
    'Display', 'iter', ...
    'Cache', 'on', ...                    % Enable caching for repeated evaluations
    'UseCompletePoll', true, ...          % Use complete polling for better exploration
    'UseParallel', false, ...              % Enable parallel evaluation
    'CompletePoll', 'on', ...             % Complete polling at each iteration
    'InitialMeshSize', 0.1, ...           % Initial mesh size
    'MaxIterations', 1, ...             % Maximum iterations
    'MaxFunctionEvaluations', 1e5, ...    % Maximum function evaluations
    'ScaleMesh', 'off', ...               % Mesh scaling
    'MeshTolerance', 1e-10, ...           % Mesh tolerance
    'FunctionTolerance', 1e-12, ...       % Function tolerance for accuracy
    'StepTolerance', 1e-12, ...           % Step tolerance
    'PlotFcn', @psplotbestf, ...          % Plot function
    'PollMethod', 'MADSPositiveBasis2N', ... % More efficient polling method
    'SearchFcn', @searchlhs, ...          % Latin Hypercube search
    'MeshExpansionFactor', 2.0, ...       % Mesh expansion factor
    'MeshContractionFactor', 0.5, ...     % Mesh contraction factor
    'AccelerateMesh', true);           % Enable mesh acceleration
    % pattern-search algorithm
    [fitted_para_2,fval_2,exitflag_2,output_2]=patternsearch(ftns_2,para_fit_2,...
                                    [],[],[],[],lower_bound_2,upper_bound_2,[],opts);
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % Print out values of the new fitted parameters
    fprintf('fitted parameters for NEM murine data:\n')
    fprintf('pCa50 = %f \n',fitted_para_2(1))
    fprintf('k0_BC = %f, kCa_BC = %f, k0_CB = %f, kCa_CB = %f \n', fitted_para_2(2:5))
    fprintf('f0_CM1 = %f, f0_M1C = %f \n', fitted_para_2(6:7))
    fprintf('k_M1M2 = %f, k_M2M1 = %f, k_M2C = %f \n', fitted_para_2(8:10))
    fprintf('alpha = %f, alpha_bar = %f, beta = %f, beta_bar = %f \n', fitted_para_2(11:14))
    fprintf('u1 = %f, u2 = %f \n', fitted_para_2(15:16))
    fprintf('z1 = %f, z2 = %f \n', fitted_para_2(17:18))
    fprintf('v = %f, w = %f \n', fitted_para_2(19:20))
    fprintf('NEM = %f', fitted_para_2(21))
    fprintf('RMSE = %f', fval_2)
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % Compute the fitted rate of force redevelopment
    n = 500;
    pCa_start = 6.3;
    pCa_end = 4.5;
    p_Ca = linspace(pCa_start,pCa_end,n);
    fitted_ktr_2 = rate_force_redev_NEM(fitted_para_2,p_Ca);
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % Plot the mechanical data and the fitted solution in the same graph
    clf
    h = axes('Position',[0 0 1 1],'Visible','off');
    axes('Position',[.1 .1 .62 .8]);
    ax = gca;
    errorbar(pCa_NEM,ktr_mean_NEM,ktr_SEM_NEM,'.','MarkerSize',25,...
             'MarkerEdgeColor','blue','Color','blue','LineWidth',1); hold on
    plot(p_Ca,fitted_ktr_2,'k-','LineWidth',2);
    set(gca, 'XDir','reverse');
    ax.FontSize = 16;
    xlabel('pCa','FontSize',16);
    ax.XAxis.LineWidth = 1.5;
    ylabel('Rate of force redevelopment ($ktr$)','Interpreter','latex','FontSize',16);
    ax.YAxis.LineWidth = 1.5;
    legend('NEM-S1 treated murine data','fitted solution','Location','best');
    
    title('Fitting NEM-S1 treated murine data: ktr vs pCa using parameter set 8', 'FontSize',20)
    ax.TitleHorizontalAlignment = 'left';
    str(1) = {'Fitted parameter set:'};
    str(2) = {[' $pCa_{50}$ = ', num2str(fitted_para_2(1))]};
    str(3) = {[' $k^0_{BC}$ = ', num2str(fitted_para_2(2))]};
    str(4) = {[' $k^{Ca}_{BC}$ = ', num2str(fitted_para_2(3))]};
    str(5) = {[' $k^0_{CB}$ = ', num2str(fitted_para_2(4))]};
    str(6) = {[' $k^{Ca}_{CB}$ = ', num2str(fitted_para_2(5))]};
    str(7) = {[' $f^0_{CM_1}$ = ', num2str(fitted_para_2(6))]};
    str(8) = {[' $f^0_{M_1C}$ = ', num2str(fitted_para_2(7))]};
    str(9) = {[' $k_{M_1M_2}$ = ', num2str(fitted_para_2(8))]};
    str(10) = {[' $k_{M_2M_1}$ = ', num2str(fitted_para_2(9))]};
    str(11) = {[' $k_{M_2C}$ = ', num2str(fitted_para_2(10))]};
    str(12) = {[' $\alpha$ = ', num2str(fitted_para_2(11))]};
    str(13) = {[' $\bar{\alpha}$ = ', num2str(fitted_para_2(12))]};
    str(14) = {[' $\beta$ = ', num2str(fitted_para_2(13))]};
    str(15) = {[' $\bar{\beta}$ = ', num2str(fitted_para_2(14))]};
    str(16) = {[' $u_1$ = ', num2str(fitted_para_2(15))]};
    str(17) = {[' $u_2$ = ', num2str(fitted_para_2(16))]};
    str(18) = {[' $z_1$ = ', num2str(fitted_para_2(17))]};
    str(19) = {[' $z_2$ = ', num2str(fitted_para_2(18))]};
    str(20) = {[' $v$ = ', num2str(fitted_para_2(19))]};
    str(21) = {[' $w$ = ', num2str(fitted_para_2(20))]};
    str(22) = {[' NEM = ', num2str(fitted_para_2(21))]};
    str(23) = {[' RMSE = ', num2str(fval_2)]};
    set(gcf,'CurrentAxes',h)
    text(.77,.5,str,'Interpreter','latex','FontSize',16)
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Fit NEM model to rel force vs pCa data in control murine

if Fit_rel_SSF_murine_ctrl
    
    close all
    clc
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % relative force in control murine
    pCa_ctrl = [6.0; 5.9; 5.8; 5.7; 5.6; 5.5; 4.5];
    rel_SSF_mean_ctrl = [0.125; 0.234; 0.468; 0.692; 0.825; 0.928; 1];
    rel_SSF_SEM_ctrl = [0.008; 0.013; 0.014; 0.017; 0.019; 0.025; 0];
    %%%%%%%%%%%%
    % Error function - the norm of the difference between actual observations
    % (data) and predicted observations (the solution of the model)
    ftns_3 = @(para_fit) norm(rel_SSF_mean_ctrl - rel_force_NEM(para_fit,pCa_ctrl));
    Parms_3 = 21; % the number of fitting parameters
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % initial values of the parameters to be fitted
    pCa_50 = 5.78;
    k0_BC = 3.3708;
    kCa_BC = 2.1585;
    k0_CB = 41.833;
    kCa_CB = 24.737;
    f0_CM1 = 2.0032;
    f0_M1C = 19.077;
    k_M1M2 = 26.116;
    k_M2M1 = 40.344;
    k_M2C = 17.964;
    alpha = 1;
    alpha_bar = 1;
    beta = 0.9999;
    beta_bar = 1;
    u1 = 1;
    u2 = 31.815;
    z1 = 1;
    z2 = 3.6979;
    v = 4.8784;
    w = 1;
    NEM = 0;
    % Initial fitting parameter vector
    para_fit_3 = [pCa_50;
                  k0_BC;
                  kCa_BC;
                  k0_CB;
                  kCa_CB;
                  f0_CM1;
                  f0_M1C;
                  k_M1M2;
                  k_M2M1;
                  k_M2C;
                  alpha;
                  alpha_bar;
                  beta;
                  beta_bar;
                  u1;
                  u2;
                  z1;
                  z2;
                  v;
                  w;
                  NEM];

    lower_bound_3 = [5.78;  % pCa_50
                     0;     % k0_BC
                     0;     % kCa_BC
                     0;     % k0_CB
                     0;     % kCa_CB
                     0;     % f0_CM1 
                     0;     % f0_M1C
                     0;     % k_M1M2  
                     0;     % k_M2M1
                     0;     % k_M2C
                     0;     % alpha
                     0;     % alpha_bar
                     0;     % beta
                     0;     % beta_bar
                     1;     % u1
                     1;     % u2
                     1;     % z1
                     1;     % z2
                     1;     % v
                     1;     % w
                     0      % NEM
                     ];
    
    upper_bound_3 = [5.78;  % pCa_50
                     Inf;     % k0_BC
                     Inf;     % kCa_BC
                     Inf;     % k0_CB
                     Inf;     % kCa_CB
                     Inf;     % f0_CM1 
                     Inf;     % f0_M1C
                     Inf;     % k_M1M2  
                     Inf;     % k_M2M1
                     Inf;     % k_M2C
                     1;     % alpha
                     1;     % alpha_bar
                     1;     % beta
                     1;     % beta_bar
                     Inf;     % u1
                     Inf;     % u2
                     Inf;     % z1
                     Inf;     % z2
                     Inf;     % v
                     Inf;     % w
                     0      % NEM
                     ];
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % optimization options for pattern search
    opts = optimoptions('patternsearch', ...
    'Display', 'iter', ...
    'Cache', 'on', ...                    % Enable caching for repeated evaluations
    'UseCompletePoll', true, ...          % Use complete polling for better exploration
    'UseParallel', false, ...              % Enable parallel evaluation
    'CompletePoll', 'on', ...             % Complete polling at each iteration
    'InitialMeshSize', 0.1, ...           % Initial mesh size
    'MaxIterations', 1, ...             % Maximum iterations
    'MaxFunctionEvaluations', 1e5, ...    % Maximum function evaluations
    'ScaleMesh', 'off', ...               % Mesh scaling
    'MeshTolerance', 1e-10, ...           % Mesh tolerance
    'FunctionTolerance', 1e-12, ...       % Function tolerance for accuracy
    'StepTolerance', 1e-12, ...           % Step tolerance
    'PlotFcn', @psplotbestf, ...          % Plot function
    'PollMethod', 'MADSPositiveBasis2N', ... % More efficient polling method
    'SearchFcn', @searchlhs, ...          % Latin Hypercube search
    'MeshExpansionFactor', 2.0, ...       % Mesh expansion factor
    'MeshContractionFactor', 0.5, ...     % Mesh contraction factor
    'AccelerateMesh', true);           % Enable mesh acceleration

    % pattern-search algorithm
    [fitted_para_3,fval_3,exitflag_3,output_3]=patternsearch(ftns_3,para_fit_3,...
                                    [],[],[],[],lower_bound_3,upper_bound_3,[],opts);
   
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % Print out values of the new fitted parameters
    fprintf('fitted parameters for control murine data:\n')
    fprintf('pCa50 = %f \n',fitted_para_3(1))
    fprintf('k0_BC = %f, kCa_BC = %f, k0_CB = %f, kCa_CB = %f \n', fitted_para_3(2:5))
    fprintf('f0_CM1 = %f, f0_M1C = %f \n', fitted_para_3(6:7))
    fprintf('k_M1M2 = %f, k_M2M1 = %f, k_M2C = %f \n', fitted_para_3(8:10))
    fprintf('alpha = %f, alpha_bar = %f, beta = %f, beta_bar = %f \n', fitted_para_3(11:14))
    fprintf('u1 = %f, u2 = %f \n', fitted_para_3(15:16))
    fprintf('z1 = %f, z2 = %f \n', fitted_para_3(17:18))
    fprintf('v = %f, w = %f \n', fitted_para_3(19:20))
    fprintf('NEM = %f', fitted_para_3(21))
    fprintf('RMSE = %f', fval_3)
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % Compute the fitted relative force
    n = 500;
    pCa_start = 6.3;
    pCa_end = 4.5;
    p_Ca = linspace(pCa_start,pCa_end,n);
    fitted_relf_3 = rel_force_NEM(fitted_para_3,p_Ca);
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
     % Plot the mechanical data and the fitted solution in the same graph
    clf
    h = axes('Position',[0 0 1 1],'Visible','off');
    axes('Position',[.1 .1 .62 .8]);
    ax = gca;
    errorbar(pCa_ctrl,rel_SSF_mean_ctrl,rel_SSF_SEM_ctrl,'.','MarkerSize',25,...
             'MarkerEdgeColor','blue','Color','blue','LineWidth',1); hold on
    plot(p_Ca,fitted_relf_3,'k-','LineWidth',2);
    set(gca, 'XDir','reverse');
    ax.FontSize = 16;
    xlabel('pCa','FontSize',16);
    ax.XAxis.LineWidth = 1.5;
    ylabel('Relative force','Interpreter','latex','FontSize',16);
    ax.YAxis.LineWidth = 1.5;
    legend('Control murine data','fitted solution','Location','best');
    
    title('Fitting control murine data: P/P0 vs pCa using parameter set 8', 'FontSize',20)
    ax.TitleHorizontalAlignment = 'left';
    str(1) = {'Fitted parameter set:'};
    str(2) = {[' $pCa_{50}$ = ', num2str(fitted_para_3(1))]};
    str(3) = {[' $k^0_{BC}$ = ', num2str(fitted_para_3(2))]};
    str(4) = {[' $k^{Ca}_{BC}$ = ', num2str(fitted_para_3(3))]};
    str(5) = {[' $k^0_{CB}$ = ', num2str(fitted_para_3(4))]};
    str(6) = {[' $k^{Ca}_{CB}$ = ', num2str(fitted_para_3(5))]};
    str(7) = {[' $f^0_{CM_1}$ = ', num2str(fitted_para_3(6))]};
    str(8) = {[' $f^0_{M_1C}$ = ', num2str(fitted_para_3(7))]};
    str(9) = {[' $k_{M_1M_2}$ = ', num2str(fitted_para_3(8))]};
    str(10) = {[' $k_{M_2M_1}$ = ', num2str(fitted_para_3(9))]};
    str(11) = {[' $k_{M_2C}$ = ', num2str(fitted_para_3(10))]};
    str(12) = {[' $\alpha$ = ', num2str(fitted_para_3(11))]};
    str(13) = {[' $\bar{\alpha}$ = ', num2str(fitted_para_3(12))]};
    str(14) = {[' $\beta$ = ', num2str(fitted_para_3(13))]};
    str(15) = {[' $\bar{\beta}$ = ', num2str(fitted_para_3(14))]};
    str(16) = {[' $u_1$ = ', num2str(fitted_para_3(15))]};
    str(17) = {[' $u_2$ = ', num2str(fitted_para_3(16))]};
    str(18) = {[' $z_1$ = ', num2str(fitted_para_3(17))]};
    str(19) = {[' $z_2$ = ', num2str(fitted_para_3(18))]};
    str(20) = {[' $v$ = ', num2str(fitted_para_3(19))]};
    str(21) = {[' $w$ = ', num2str(fitted_para_3(20))]};
    str(22) = {[' NEM = ', num2str(fitted_para_3(21))]};
    str(23) = {[' RMSE = ', num2str(fval_3)]};
    set(gcf,'CurrentAxes',h)
    text(.77,.5,str,'Interpreter','latex','FontSize',16)
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Fit NEM model to rel force vs pCa data in NEM-treated murine

if Fit_rel_SSF_murine_NEM
    
    close all
    clc
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % Mechanical data from mouse LV
    pCa_NEM = [6.1; 6.0; 5.9; 5.8; 5.7; 5.6; 5.5; 4.5];
    rel_SSF_mean_NEM = [0.118; 0.206; 0.317; 0.519; 0.741; 0.888; 0.946; 1];
    rel_SSF_SEM_NEM = [0.008; 0.013; 0.014; 0.019; 0.022; 0.027; 0.029; 0];
    %%%%%%%%%%%%
    % Error function - the norm of the difference between actual observations
    % (data) and predicted observations (the solution of the model)
    ftns_4 = @(para_fit) norm(rel_SSF_mean_NEM - rel_force_NEM(para_fit,pCa_NEM));
    Parms_4 = 21; % the number of fitting parameters
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % initial values of the parameters to be fitted
    pCa_50 = 5.82;
    k0_BC = 0;
    kCa_BC = 0.1977;
    k0_CB = 1.4957;
    kCa_CB = 0;
    f0_CM1 = 76.2981;
    f0_M1C = 104.91;
    k_M1M2 = 656.12;
    k_M2M1 = 914.73;
    k_M2C = 47.658;
    alpha = 0.9;
    alpha_bar = 0.0125;
    beta = 0.9998;
    beta_bar = 0.125;
    u1 = 1.1120;
    u2 = 5.6420;
    z1 = 1.0473;
    z2 = 1.9916;
    v = 1;
    w = 3;
    NEM = 0.01;
    % Initial fitting parameter vector
    para_fit_4 = [pCa_50;
                  k0_BC;
                  kCa_BC;
                  k0_CB;
                  kCa_CB;
                  f0_CM1;
                  f0_M1C;
                  k_M1M2;
                  k_M2M1;
                  k_M2C;
                  alpha;
                  alpha_bar;
                  beta;
                  beta_bar;
                  u1;
                  u2;
                  z1;
                  z2;
                  v;
                  w;
                  NEM];

    lower_bound_4 = [5.82;  % pCa_50
                     0;     % k0_BC
                     0;     % kCa_BC
                     0;     % k0_CB
                     0;     % kCa_CB
                     0;     % f0_CM1 
                     0;     % f0_M1C
                     0;     % k_M1M2  
                     0;     % k_M2M1
                     0;     % k_M2C
                     0;     % alpha
                     0;     % alpha_bar
                     0;     % beta
                     0;     % beta_bar
                     1;     % u1
                     1;     % u2
                     1;     % z1
                     1;     % z2
                     1;     % v
                     1;     % w
                     0.001      % NEM
                     ];
    
    upper_bound_4 = [5.82;  % pCa_50
                     Inf;     % k0_BC
                     Inf;     % kCa_BC
                     Inf;     % k0_CB
                     Inf;     % kCa_CB
                     Inf;     % f0_CM1 
                     Inf;     % f0_M1C
                     Inf;     % k_M1M2  
                     Inf;     % k_M2M1
                     Inf;     % k_M2C
                     1;     % alpha
                     1;     % alpha_bar
                     1;     % beta
                     1;     % beta_bar
                     Inf;     % u1
                     Inf;     % u2
                     Inf;     % z1
                     Inf;     % z2
                     Inf;     % v
                     Inf;     % w
                     0.1      % NEM
                     ];
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % optimization options for pattern search
    opts = optimoptions('patternsearch', ...
    'Display', 'iter', ...
    'Cache', 'on', ...                    % Enable caching for repeated evaluations
    'UseCompletePoll', true, ...          % Use complete polling for better exploration
    'UseParallel', false, ...              % Enable parallel evaluation
    'CompletePoll', 'on', ...             % Complete polling at each iteration
    'InitialMeshSize', 0.1, ...           % Initial mesh size
    'MaxIterations', 1, ...             % Maximum iterations
    'MaxFunctionEvaluations', 1e5, ...    % Maximum function evaluations
    'ScaleMesh', 'off', ...               % Mesh scaling
    'MeshTolerance', 1e-10, ...           % Mesh tolerance
    'FunctionTolerance', 1e-12, ...       % Function tolerance for accuracy
    'StepTolerance', 1e-12, ...           % Step tolerance
    'PlotFcn', @psplotbestf, ...          % Plot function
    'PollMethod', 'MADSPositiveBasis2N', ... % More efficient polling method
    'SearchFcn', @searchlhs, ...          % Latin Hypercube search
    'MeshExpansionFactor', 2.0, ...       % Mesh expansion factor
    'MeshContractionFactor', 0.5, ...     % Mesh contraction factor
    'AccelerateMesh', true);           % Enable mesh acceleration

    % pattern-search algorithm
    [fitted_para_4,fval_4,exitflag_4,output_4]=patternsearch(ftns_4,para_fit_4,...
                                    [],[],[],[],lower_bound_4,upper_bound_4,[],opts);
   
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % Print out values of the new fitted parameters
    fprintf('fitted parameters for NEM-S1 treated murine data:\n')
    fprintf('pCa50 = %f \n',fitted_para_4(1))
    fprintf('k0_BC = %f, kCa_BC = %f, k0_CB = %f, kCa_CB = %f \n', fitted_para_4(2:5))
    fprintf('f0_CM1 = %f, f0_M1C = %f \n', fitted_para_4(6:7))
    fprintf('k_M1M2 = %f, k_M2M1 = %f, k_M2C = %f \n', fitted_para_4(8:10))
    fprintf('alpha = %f, alpha_bar = %f, beta = %f, beta_bar = %f \n', fitted_para_4(11:14))
    fprintf('u1 = %f, u2 = %f \n', fitted_para_4(15:16))
    fprintf('z1 = %f, z2 = %f \n', fitted_para_4(17:18))
    fprintf('v = %f, w = %f \n', fitted_para_4(19:20))
    fprintf('NEM = %f', fitted_para_4(21))
    fprintf('RMSE = %f', fval_4)
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % Compute the fitted relative force
    n = 500;
    pCa_start = 6.3;
    pCa_end = 4.5;
    p_Ca = linspace(pCa_start,pCa_end,n);
    fitted_relf_4 = rel_force_NEM(fitted_para_4,p_Ca);
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
     % Plot the mechanical data and the fitted solution in the same graph
    clf
    h = axes('Position',[0 0 1 1],'Visible','off');
    axes('Position',[.1 .1 .62 .8]);
    ax = gca;
    errorbar(pCa_NEM,rel_SSF_mean_NEM,rel_SSF_SEM_NEM,'.','MarkerSize',25,...
             'MarkerEdgeColor','blue','Color','blue','LineWidth',1); hold on
    plot(p_Ca,fitted_relf_4,'k-','LineWidth',2);
    set(gca, 'XDir','reverse');
    ax.FontSize = 16;
    xlabel('pCa','FontSize',16);
    ax.XAxis.LineWidth = 1.5;
    ylabel('Relative force','Interpreter','latex','FontSize',16);
    ax.YAxis.LineWidth = 1.5;
    legend('NEM-S1 murine data','fitted solution','Location','best');
    
    title('Fitting NEM-S1 treated murine data: P/P0 vs pCa using parameter 8', 'FontSize',20)
    ax.TitleHorizontalAlignment = 'left';
    str(1) = {'Fitted parameter set:'};
    str(2) = {[' $pCa_{50}$ = ', num2str(fitted_para_4(1))]};
    str(3) = {[' $k^0_{BC}$ = ', num2str(fitted_para_4(2))]};
    str(4) = {[' $k^{Ca}_{BC}$ = ', num2str(fitted_para_4(3))]};
    str(5) = {[' $k^0_{CB}$ = ', num2str(fitted_para_4(4))]};
    str(6) = {[' $k^{Ca}_{CB}$ = ', num2str(fitted_para_4(5))]};
    str(7) = {[' $f^0_{CM_1}$ = ', num2str(fitted_para_4(6))]};
    str(8) = {[' $f^0_{M_1C}$ = ', num2str(fitted_para_4(7))]};
    str(9) = {[' $k_{M_1M_2}$ = ', num2str(fitted_para_4(8))]};
    str(10) = {[' $k_{M_2M_1}$ = ', num2str(fitted_para_4(9))]};
    str(11) = {[' $k_{M_2C}$ = ', num2str(fitted_para_4(10))]};
    str(12) = {[' $\alpha$ = ', num2str(fitted_para_4(11))]};
    str(13) = {[' $\bar{\alpha}$ = ', num2str(fitted_para_4(12))]};
    str(14) = {[' $\beta$ = ', num2str(fitted_para_4(13))]};
    str(15) = {[' $\bar{\beta}$ = ', num2str(fitted_para_4(14))]};
    str(16) = {[' $u_1$ = ', num2str(fitted_para_4(15))]};
    str(17) = {[' $u_2$ = ', num2str(fitted_para_4(16))]};
    str(18) = {[' $z_1$ = ', num2str(fitted_para_4(17))]};
    str(19) = {[' $z_2$ = ', num2str(fitted_para_4(18))]};
    str(20) = {[' $v$ = ', num2str(fitted_para_4(19))]};
    str(21) = {[' $w$ = ', num2str(fitted_para_4(20))]};
    str(22) = {[' NEM = ', num2str(fitted_para_4(21))]};
    str(23) = {[' RMSE = ', num2str(fval_4)]};
    set(gcf,'CurrentAxes',h)
    text(.77,.5,str,'Interpreter','latex','FontSize',16)
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
end