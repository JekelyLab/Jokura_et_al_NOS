function [C_PRC,y]=simulate_prediction(p,n_var,p1,p2,p3,t_end)

% find steady state
x0 = zeros(1,n_var);
f_uv_av = @(x) uv_av_ode_pred(0,x,p,p1,p2,p3);
[X_uv_av,~,exitflag] = fsolve(f_uv_av,x0,optimoptions('fsolve','Display','none','MaxFunctionEvaluations',1e12,'MaxIterations',1e12));

kk=1;
while exitflag~=1
    x0 = rand(1,n_var);
    [X_uv_av,~,exitflag] = fsolve(f_uv_av,x0,optimoptions('fsolve','Display','none','MaxFunctionEvaluations',1e12,'MaxIterations',1e12));
    kk=kk+1;
    if kk>20
	%disp('20')		
        break
    end
end

% simulate
tspan = [0 t_end];
init_val = X_uv_av;
opts = odeset('MaxStep',0.05,'RelTol',1e-6,'AbsTol',1e-9);
sol = ode45(@(t,y) uv_av_ode_pred(t,y,p,p1,p2,p3), tspan, init_val,opts);

% same sampling
frames = 0:0.05:t_end;
y = deval(sol,frames);

% normalise
C_PRC = y(1,:)/y(1,101);

