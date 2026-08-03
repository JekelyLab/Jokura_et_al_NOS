function out=uv_av_ko_gsat(pars,to_fit)

[obj_val]=uv_av_mobj(pars,to_fit);
out = obj_val(1)+obj_val(2);

end

function [obj_val,C_PRC,y]=uv_av_mobj(p,to_fit)

t_end=79.5;
% find steady state
init_val = [1/p(1) 1 0];

% simulate
tspan = [0 t_end];

% same sampling
frames = 0:0.5:t_end;

options = odeset('Events',@largeEventsFcn,'RelTol',1e-6,'AbsTol',1e-9);
sol = ode45(@(t,y) uv_av_ode(t,y,p), tspan, init_val, options);


if ~isempty(sol.xe)
    C_PRC= 20*ones(numel(frames),1);
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
obj_val2=abs(min(to_fit(52:end-10))-min(C_PRC(52:end-10)));%

obj_val=[obj_val1,obj_val2];
end

function [position,isterminal,direction] = largeEventsFcn(~,y)
    position = sum(abs(y))-1e4; % The value that we want to be zero
    isterminal = 1;  % Halt integration
    direction = 0;   % The zero can be approached from either direction
end

function F = uv_av_ode(t,u,p)

t_end=20+5;

UV = 0.5*(sign(t-5)-1)-0.5*(sign(t-t_end)-1);

delta_C = p(1); 
delta_2 = p(2);
delta_1 = p(3);
kappa_UV = p(4);

delta_S = p(5);
u2_0 = p(6);

F = [u(2) + kappa_UV * UV/(1 + delta_1 * u(3)) - delta_C * u(1); %
   - delta_2 * (u(2) - u2_0) * u(3);
     UV - delta_S * u(3)];%
end

% order of parameters in the paper [1 4 3 2 6 5]


