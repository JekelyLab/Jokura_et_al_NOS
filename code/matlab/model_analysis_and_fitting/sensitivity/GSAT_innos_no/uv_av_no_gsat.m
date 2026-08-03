function out=uv_av_no_gsat(pars,to_fit)

[obj_val]=uv_av_mobj(pars,to_fit);
out = obj_val(1);

end

function obj_val=uv_av_mobj(p,to_fit)

t_end=79.5;
% find steady state

init_val = [0 1/p(3) 0];


% simulate
tspan = [0 t_end];

% same sampling
frames = 0:0.5:t_end;

options = odeset('Events',@largeEventsFcn,'RelTol',1e-6,'AbsTol',1e-9);
sol = ode45(@(t,y) uv_av_ode(t,y,p), tspan, init_val, options);


if ~isempty(sol.xe)
    NO_INNOS= 20*ones(numel(frames),1);
else
    y = deval(sol,frames);
    NO_INNOS = y(3,:);

    if max(y(3,:))-min(y(3,:))<1e-3
        NO_INNOS=ones(numel(NO_INNOS),1);
    end
end


to_fit=to_fit(41:200);
NO_INNOS=NO_INNOS(:);

obj_val1=sqrt(sum((to_fit(11:51)-NO_INNOS(11:51)).^2));
% obj_val2=sqrt(sum((to_fit(52:end)-NO_INNOS(52:end)).^2));

if ~isreal(obj_val1)
    % idx_rightmost_real
    init_val
    pause,
end

obj_val=obj_val1;
end

function [position,isterminal,direction] = largeEventsFcn(~,y)
    position = sum(abs(y))-1e2; % The value that we want to be zero
    isterminal = 1;  % Halt integration
    direction = 0;   % The zero can be approached from either direction
end

function F = uv_av_ode(t,u,p)
t_end=20+5;

UV = 0.5*(sign(t-5)-1)-0.5*(sign(t-t_end)-1);

delta_G = p(1);

kappa_CN = p(2);
delta_CN = p(3);

kappa_N_1 = p(4);
delta_N   = p(5);
kappa_N_2 = p(6);

F = [UV - delta_G * u(1);
     1 + kappa_CN * u(1)  - delta_CN * u(2);
     (kappa_N_1 * (u(2) - 1/delta_CN))/(kappa_N_2 + (u(2) - 1/delta_CN)) - delta_N * u(3)];%

end

% order in paper [1 2 3 4 6 5]
