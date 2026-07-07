function rel_F = rel_force_NEM(para_fit,pCa)

    pCa_50 = para_fit(1);
    k0_BC = para_fit(2);
    kCa_BC = para_fit(3);
    k0_CB = para_fit(4);
    kCa_CB = para_fit(5); 
    f0_CM1 = para_fit(6);
    f0_M1C = para_fit(7);
    k_M1M2 = para_fit(8);
    k_M2M1 = para_fit(9);
    k_M2C = para_fit(10);
    alpha = para_fit(11);
    alpha_bar = para_fit(12);
    beta = para_fit(13);
    beta_bar = para_fit(14);
    u1 = para_fit(15);
    u2 = para_fit(16);
    z1 = para_fit(17);
    z2 = para_fit(18);
    v = para_fit(19);
    w = para_fit(20);
    NEM = para_fit(21);

    n = length(pCa);
    Ca_Ca50 = 10.^(-pCa + pCa_50);
    initial_value = [0;0;NEM;0];
    tspan = [0,5];
    neighbor_interaction_para = [alpha,alpha_bar,beta,beta_bar,u1,u2,z1,z2,v,w];
    ref_para = [k0_BC,kCa_BC,k0_CB,kCa_CB,f0_CM1,f0_M1C,k_M1M2,k_M2M1,k_M2C];
    F = zeros(n,1);
    % options = odeset('RelTol',1e-8,'AbsTol',1e-5);

    for i = 1:n
        p = [ref_para,Ca_Ca50(i),neighbor_interaction_para,NEM];
        func = @filament_function_NEM_S1;
        [~,y] = ode15s(@(r,y) func(r,y,p),tspan,initial_value);
        F(i) = NEM - y(end,3) + y(end,4);
    end
    rel_F = F/max(F);
    
end