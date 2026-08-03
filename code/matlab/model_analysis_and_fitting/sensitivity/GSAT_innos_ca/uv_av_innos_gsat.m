function out=uv_av_innos_gsat(pars,to_fit)

[obj_val]=uv_av_mobj(pars,to_fit);
out = obj_val(1)+obj_val(2);

end

function [obj_val,C_INNOS,y]=uv_av_mobj(p,to_fit)

t_end=79.5;
% find steady state

init_val = [0 1/p(3)];

% simulate
tspan = [0 t_end];

% same sampling
frames = 0:0.5:t_end;

options = odeset('Events',@largeEventsFcn,'RelTol',1e-6,'AbsTol',1e-9);
sol = ode45(@(t,y) uv_av_ode(t,y,p), tspan, init_val, options);


if ~isempty(sol.xe)
    C_INNOS= 20*ones(numel(frames),1);
else
    y = deval(sol,frames);

    % normalise
    C_INNOS = (y(2,:))/(y(2,10));

    if max(y(2,:))-min(y(2,:))<1e-3
        C_INNOS=ones(numel(C_INNOS),1);
    end
end


to_fit=to_fit(41:200);
C_INNOS=C_INNOS(:);

obj_val1=sqrt(sum((to_fit(11:51)-C_INNOS(11:51)).^2));
obj_val2=sqrt(sum((to_fit(52:end)-C_INNOS(52:end)).^2));

if ~isreal(obj_val1)
    % idx_rightmost_real
    init_val
    pause,
end

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

delta_G = p(1); %1

kappa_C_innos = p(2); %2
delta_C_innos = p(3); %3

F = [UV - delta_G * u(1);
     1 + kappa_C_innos * u(1) - delta_C_innos * u(2)];%
end


