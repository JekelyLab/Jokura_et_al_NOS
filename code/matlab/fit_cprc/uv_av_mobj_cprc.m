function [obj_val,C_PRC,y]=uv_av_mobj_cprc(p,n_var,to_fit)

t_end=79.5;
frames = 0:0.5:t_end;

% find steady state
x0 = zeros(1,n_var);
f_uv_av = @(x) uv_av_ode_cprc(0,x,p);
X_uv_av = fsolve(f_uv_av,x0,optimoptions('fsolve','Display','none','MaxFunctionEvaluations',1e12,'MaxIterations',1e12));

kk=1;
while any(abs(X_uv_av)>1e4)
    x0 = rand(1,n_var);
    X_uv_av = fsolve(f_uv_av,x0,optimoptions('fsolve','Display','none','MaxFunctionEvaluations',1e12,'MaxIterations',1e12));
    kk=kk+1;
    if kk>20
        break
    end
end

if any(abs(X_uv_av)>1e4)
    C_PRC= 10*ones(numel(frames),1);
else

    % simulate
    tspan = [0 t_end];
    init_val = X_uv_av;

    options = odeset('Events',@largeEventsFcn,'RelTol',1e-6,'AbsTol',1e-9);
    sol = ode45(@(t,y) uv_av_ode_cprc(t,y,p), tspan, init_val, options);

    % same sampling
    frames = 0:0.5:t_end;
    if ~isempty(sol.xe)
        C_PRC= 10*ones(numel(frames),1);
    else
        y = deval(sol,frames);

        % normalise
        C_PRC = y(1,:)/y(1,10);

        if max(y(1,:))-min(y(1,:))<1e-3
            C_PRC=ones(numel(C_PRC),1);
        end
    end

end
to_fit=to_fit(41:200);
C_PRC=C_PRC(:);

obj_val1=sqrt(sum((to_fit(11:51)-C_PRC(11:51)).^2));
obj_val2=sqrt(sum((to_fit(52:end)-C_PRC(52:end)).^2));

obj_val=[obj_val1,obj_val2];
end

function [position,isterminal,direction] = largeEventsFcn(~,y)
position = sum(abs(y))-1e4; % The value that we want to be zero
isterminal = 1;  % Halt integration
direction = 0;   % The zero can be approached from either direction
end
