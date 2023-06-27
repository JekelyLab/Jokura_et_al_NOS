function F = uv_av_ode_inrgw(t,u,p)

UV = 0.5*(sign(t-5)-1)-0.5*(sign(t-25)-1);

if numel(p)==17
k_UV = p(1);
k_cGMP= p(2);
delta_PRC = p(3);

k_UV_GC2 = p(4); 
k_NO_GC1 = p(5);
delta_G = p(6);

tau_S = p(7);

k_S_CN = p(8);
delta_CN = p(9);

k_NO = p(10);
delta_NO = p(11);

k_UV_PRD = p(12);
delta_CO = p(13);

k_R_S = p(14);
k_R_PRC = p(15);
k_R_CN = p(16);
delta_R = p(17);

F = [(1 + k_UV * UV * u(3) + k_cGMP * u(2) - delta_PRC * u(1)); %c_PRC
     (1 + k_UV_GC2 * (1-UV) * u(2) + k_NO_GC1 * u(6)  - delta_G * u(2)); %cGMP
     (1 - UV * k_UV_PRD * u(3) - delta_CO * u(3)); %c_O
     (UV - u(4)/tau_S); %c_S   
     (1 + k_S_CN * u(4) - delta_CN * u(5)); %c_NOS
     (1 + k_NO * u(5) - delta_NO * u(6)); %NO
     (1 - k_R_S * u(4) + k_R_PRC * u(1) - k_R_CN * u(5) * u(7) - delta_R * u(7))]; %c_RGW 

elseif numel(p)==14 %NO ko
k_UV = p(1);
k_cGMP= p(2);
delta_PRC = p(3);

k_UV_OPS = p(4); 
delta_G = p(5);

k_UV_PRD = p(6);
delta_CO = p(7);

tau_S = p(8);

k_S_CN = p(9);
delta_CN = p(10);

k_R_PRC = p(11);
k_R_CN = p(12);
delta_R = p(13);
k_R_S = p(14);

F = [(1 + k_UV * UV * u(3) + k_cGMP * u(2) - delta_PRC * u(1)); %c_PRC
     (1 + k_UV_OPS * (1-UV) * u(2) - delta_G * u(2)); %cGMP
     (1 - UV * k_UV_PRD * u(3) - delta_CO * u(3)); %c_O  
     (UV - u(3)/tau_S); %c_S   
     (1 + k_S_CN * u(4) - delta_CN * u(5)); %c_NOS
     (1 - k_R_S * u(4) + k_R_PRC * u(1) - k_R_CN * u(5) * u(6) - delta_R * u(6))]; %c_RGW

elseif numel(p)==6 % mo NIT_GC2
k_UV = p(1);
delta_PRC = p(2);

k_UV_PRD = p(3);
delta_CO = p(4);

k_R_PRC = p(5);
delta_R = p(6);

F = [(1 + k_UV * UV * u(2) - delta_PRC * u(1)); %c_PRC
     (1 - UV * k_UV_PRD * u(2) - delta_CO * u(2)); %c_O 
     (1 + k_R_PRC * u(1) - delta_R * u(3))]; %c_RGW
end