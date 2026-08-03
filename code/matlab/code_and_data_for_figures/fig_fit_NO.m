load best_pars
load NO_data

clear sim_*

for k=10:-1:1
    sim_NO(k,:)=simulate_NO(best_pars_NO(k,:));
end

fit_to_mean=simulate_NO([0.3576 0.1844 0.3669 8.1960 50.0000 0.2479]);
%%
colors=[0.5 0.5 0.5; 0.25 0.25 0.25; [70 152 117]./256];

plot(frames,NO_data(41:200,1),'LineWidth',0.5,'Color',colors(3,:))
hold on
plot(frames,NO_data(41:200,[3:11]),'LineWidth',0.5,'Color',colors(3,:),'HandleVisibility','off')
plot(frames,sim_NO(1,:),'LineWidth',0.5,'Color',colors(1,:))
plot(frames,sim_NO(2:10,:),'LineWidth',0.5,'Color',colors(1,:),'HandleVisibility','off')
plot(frames,mean(NO_data(41:200,[1 3:11]),2),'LineWidth',4,'Color',colors(3,:))
plot(frames,mean(sim_NO),'LineWidth',4,'Color',colors(1,:))
plot(frames,fit_to_mean,'LineWidth',2,'Color','#098500')

% hold off
box off
ylim([-0.1 0.4])
set(gca,'TickDir','out')
ylabel('\Delta F [a.u]')
xlabel('time [s]')
legend({'data','fits','mean data','mean fit','fit to mean'},'Box','off')

grid on
hold off
%%
function out=simulate_NO(p)

t_end=79.5;

init_val = [0 1/p(3) 0];

tspan = [0 t_end];
% simulate
options = odeset('Events',@largeEventsFcn,'RelTol',1e-6,'AbsTol',1e-9);
sol = ode45(@(t,y) uv_av_ode_no(t,y,p), tspan, init_val, options);

% same sampling as data
frames = 0:0.5:t_end;
y = deval(sol,frames);

out = y(3,:);
end

function F = uv_av_ode_no(t,u,p)

UV = 0.5*(sign(t-5)-1)-0.5*(sign(t-25)-1);

delta_G = p(1);

kappa_CN = p(2);
delta_CN = p(3);

kappa_N_1 = p(4);
delta_N   = p(5);
kappa_N_2 = p(6);

F = [UV - delta_G * u(1);
     1 + kappa_CN * u(1)  - delta_CN * u(2);
     (kappa_N_1 * (u(2) - 1/delta_CN))/(kappa_N_2 + (u(2) - 1/delta_CN)) - delta_N * u(3)];
end


function [position,isterminal,direction] = largeEventsFcn(~,y)
position = sum(abs(y))-1e3; % The value that we want to be zero
isterminal = 1;  % Halt integration
direction = 0;   % The zero can be approached from either direction
end