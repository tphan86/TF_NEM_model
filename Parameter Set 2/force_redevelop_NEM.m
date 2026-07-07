function [value, isterminal, direction] = force_redevelop_NEM(t,u,threshold,NEM)
    value = NEM - u(3) + u(4) - threshold;
    isterminal = 1;
    direction = 0;
end