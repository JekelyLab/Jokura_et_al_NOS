function out=uv_av_wt_gsat(pars,to_fit)

[obj_val]=uv_av_mobj(pars,to_fit);
out = sqrt(obj_val(1)^2+obj_val(2)^2);

end

function [obj_val,C_PRC,y]=uv_av_mobj(p_in,to_fit)
t_end=79.5;

p=[0.5838 0.0507 1.5796 0.6152 p_in(1)...
   0.3576 0.5515 ...
   0.1844 0.3669 ...
   8.1960 50.0000 0.2479 p_in(2:5) 0.0001 p_in(6:14)];


init_val = [1/p(1) 1 ...
            0 ...
            1/p(9) 0 ...
            0 0 ...
            1 0 0 0];

% simulate
tspan = [0 t_end];

% same sampling
frames = 0:0.5:t_end;


options = odeset('Events',@largeEventsFcn,'RelTol',1e-6,'AbsTol',1e-9);
sol = ode45(@(t,y) uv_av_ode(t,y,p), tspan, init_val, options);


if ~isempty(sol.xe)
    C_PRC= 44*ones(numel(frames),1);
else
    y = deval(sol,frames);

    % normalise
    C_PRC = y(1,:)/y(1,10);

    if max(y(1,:))-min(y(1,:))<1e-3
        C_PRC=ones(numel(C_PRC),1);
    end
end


to_fit=to_fit(41:200);
C_PRC=C_PRC(:);

obj_val1=sqrt(sum((to_fit(11:51)-C_PRC(11:51)).^2));
obj_val2=sqrt(sum((to_fit(52:end)-C_PRC(52:end)).^2));

obj_val=[obj_val1,obj_val2];
end

function [position,isterminal,direction] = largeEventsFcn(~,y)
position = sum(abs(y))-1e3; % The value that we want to be zero
isterminal = 1;  % Halt integration
direction = 0;   % The zero can be approached from either direction
end

function F = uv_av_ode(t,u,p)

t_end = 20+5;

UV = 0.5*(sign(t-5)-1)-0.5*(sign(t-t_end)-1);

delta_C = p(1); 
delta_2 = p(2);
delta_1 = p(3);
kappa_UV = p(4);
kappa_2 = p(5); % 1 \kappa_B

delta_S1 = p(6); 
u2_0 = p(7);

kappa_4 = p(8); 
delta_4 = p(9); 

kappa_5_1 = p(10);   
delta_5   = p(11);
kappa_5_2 = p(12);

kappa_6 = p(13); %2 \kappa_SGC1
delta_6 = p(14); %3 \delta_SGC1

kappa_7 = p(15); %4 \kappa_Nin1
delta_7 = p(16); %5 \delta_Nin1

kappa_8 = p(17); %6 \kappa_+,3 excluded
k9_1 = p(18); %7 \kappa_+,1
k9_2 = p(19); %8 \kappa_+,2
delta_9 = p(20); %9 \delta_Nin2

kappa_g1_1 = p(21); %10 \kappa_gc11
kappa_g1_2 = p(22); %11 \kappa_gc12

kappa_10 = p(23); %12 \kappa_S1
delta_10 = p(24); %13 \delta_S1

kappa_11 = p(25); %14 \kappa_S2
delta_11 = p(26); %15 \delta_S2 

F = [u(2) + kappa_g1_2 * u(9) + (kappa_UV + kappa_g1_1 * u(7))*UV/(1 + delta_1 * u(3)) - delta_C * u(1);
   - delta_2 * (u(2) - u2_0) * u(3) + kappa_2 * u(9)^2* (1 - u(2));
     UV - delta_S1 * u(3);
     
     1 + kappa_4 * u(3) - delta_4 * u(4);
     (kappa_5_1 * (u(4) - 1/delta_4))/(kappa_5_2 + (u(4) - 1/delta_4)) - delta_5 * u(5);

     kappa_6 * u(5) - delta_6 * u(6);     
     kappa_7 * u(6) - delta_7 * u(7);  

    -k9_1 * u(8) * u(10)^2/(1 + k9_2*u(10)^2) + kappa_8 * (1 - u(8));
     k9_1 * u(8) * u(10)^2/(1 + k9_2*u(10)^2) - delta_9 * u(9);
    
     kappa_10 * u(11) - delta_10 * u(10);
     kappa_11 * u(6) - delta_11 * u(11);];
end

% order of parameters in the paper [10 11 1 2 3 4 5 12 13 14 15 6 7 8 9]
% but 6 is fixed so excluded and hence [9 10 1 2 3 4 5 11 12 13 14 7 8 9]
