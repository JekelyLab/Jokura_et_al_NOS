function F = uv_av_ode_innos(t,u,p)

UV = 0.5*(sign(t-5)-1)-0.5*(sign(t-25)-1);

tau_S = p(1);

k_S_CN = p(2);
delta_CN = p(3);

F = [(UV - u(1)/tau_S); %c_S   
     (1 + k_S_CN * u(1) - delta_CN * u(2))]; %c_NOS