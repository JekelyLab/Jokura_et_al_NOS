function F = uv_av_ode_pred(t,u,p,p1,p2,n)


if n==1
    UV = p2*(0.5*(sign(t-5)-1)-0.5*(sign(t-(5+p1))-1));
else
    UV=0;
    for n_pls=1:n
        pUV=(0.5*(sign(t-(5+(n_pls-1)*p1+(n_pls-1)*p2))-1)...
            -0.5*(sign(t-(5+    n_pls*p1+(n_pls-1)*p2))-1));
        UV=UV+pUV;
    end
end

k_UV = p(1);
k_cGMP= p(2);
delta_PRC = p(3);

k_UV_OPS = p(4); 
k_NO_GC1 = p(5);
delta_G = p(6);

tau_S = p(7);

k_S_CN = p(8);
delta_CN = p(9);

k_NO = p(10);
delta_NO = p(11);

k_UV_PRD = p(12);
delta_CO = p(13);

F = [(1 + k_UV * UV * u(6) + k_cGMP * u(2) - delta_PRC * u(1)); %c_PRC
     (1 + k_UV_OPS * (1-UV) * u(2) + k_NO_GC1 * u(5)  - delta_G * u(2)); %cGMP
     (UV - u(3)/tau_S); %c_S   
     (1 + k_S_CN * u(3) - delta_CN * u(4)); %c_NOS
     (1 + k_NO * u(4) - delta_NO * u(5)); %NO
     (1 - UV * k_UV_PRD * u(6) - delta_CO * u(6))]; %c_O 

end