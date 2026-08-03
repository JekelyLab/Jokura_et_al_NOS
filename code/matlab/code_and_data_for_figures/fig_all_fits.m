load best_pars
load wt_ko_mo_data

clear sim_*

for k=47:-1:1
    sim_wt_cPRC(k,:)=simulate_wt_cPRC(best_pars_WT(k,:));
end

for k=55:-1:1
    sim_ko_cPRC(k,:)=simulate_ko_cPRC(best_pars_KO(k,:));
end

for k=55:-1:1
    sim_mo_cPRC(k,:)=simulate_mo_cPRC(best_pars_KO(k,:));
end

for k=48:-1:1
    sim_INNOS(k,:)=simulate_INNOS(best_pars_INNOS(k,:));
end

%%
t_end=79.5;
frames = 0:0.5:t_end;

tiledlayout(3,2,'TileSpacing','tight','Padding','compact')

colors=[0.5 0.5 0.5; 0.15 0.15 0.15; 0.8 0.5 1; 0.72 0.27 1];

nexttile(1)
plot(frames,wt_cPRC.data(41:200,:),'LineWidth',0.5,'Color',colors(3,:),'HandleVisibility','off')
hold on
plot(frames,sim_wt_cPRC,'LineWidth',0.5,'Color',colors(1,:),'HandleVisibility','off')
plot(frames,mean(wt_cPRC.data(41:200,:),2),'LineWidth',4,'Color',colors(4,:))
plot(frames,mean(sim_wt_cPRC),'LineWidth',2,'Color',colors(2,:))
hold off
box off

set(gca,'TickDir','out','XTickLabel','')
ylim([0.38 2.7])
grid on
hold off
ylabel('\Delta F [a.u]')
ax = gca;
ax.TitleHorizontalAlignment = 'left';
title('A')

nexttile(2)
colors=[0.5 0.5 0.5; 0.15 0.15 0.15; 0.3 0.75 0.93; 0 0.45 0.74];
plot(frames,wt_INNOS.data(41:200,1),'LineWidth',0.5,'Color',colors(3,:))
hold on
plot(frames,wt_INNOS.data(41:200,2:27),'LineWidth',0.5,'Color',colors(3,:),'HandleVisibility','off')
plot(frames,sim_INNOS(22:end,:),'LineWidth',0.5,'Color',colors(1,:),'HandleVisibility','off')
plot(frames,mean(wt_INNOS.data(41:200,:),2),'LineWidth',4,'Color',colors(4,:))
plot(frames,mean(sim_INNOS(22:end,:)),'LineWidth',2,'Color',colors(2,:))
hold off
box off
ylim([0.5 3])
set(gca,'TickDir','out','XTickLabel','')
grid on
hold off
ax = gca;
ax.TitleHorizontalAlignment = 'left';
title('B')

nexttile(3)
colors=[0.5 0.5 0.5; 0.15 0.15 0.15; 0.8 0.5 1; 0.72 0.27 1];

plot(frames,ko_cPRC.data(41:200,:),'LineWidth',0.5,'Color',colors(3,:),'HandleVisibility','off')
hold on
plot(frames,sim_ko_cPRC,'LineWidth',0.5,'Color',colors(1,:),'HandleVisibility','off')
plot(frames,mean(ko_cPRC.data(41:200,:),2),'LineWidth',4,'Color',colors(4,:))
plot(frames,mean(sim_ko_cPRC),'LineWidth',2,'Color',colors(2,:))
hold off
box off
ylim([0.24 1.65])
set(gca,'TickDir','out','XTickLabel','')
grid on
hold off
ylabel('\Delta F [a.u]')
ax = gca;
ax.TitleHorizontalAlignment = 'left';
title('C')

%
nexttile(4)
colors=[0.5 0.5 0.5; 0.15 0.15 0.15; 0.3 0.75 0.93; 0 0.45 0.74];
plot(frames,ko_INNOS.data(41:200,1),'LineWidth',0.5,'Color',colors(3,:))
hold on
plot(frames,ko_INNOS.data(41:200,2:21),'LineWidth',0.5,'Color',colors(3,:),'HandleVisibility','off')
plot(frames,sim_INNOS(1:21,:),'LineWidth',0.5,'Color',colors(1,:),'HandleVisibility','off')
plot(frames,mean(ko_INNOS.data(41:200,:),2),'LineWidth',4,'Color',colors(4,:))
plot(frames,mean(sim_INNOS(1:21,:)),'LineWidth',2,'Color',colors(2,:))
hold off
box off
ylim([0.5 3.2])
set(gca,'TickDir','out','XTickLabel','')
grid on
ax = gca;
ax.TitleHorizontalAlignment = 'left';
title('D')
hold off

nexttile(5)
colors=[0.5 0.5 0.5; 0.15 0.15 0.15; 0.8 0.5 1; 0.72 0.27 1];

plot(frames,mo_cPRC.data(41:200,1),'LineWidth',0.5,'Color',colors(3,:))
hold on
plot(frames,mo_cPRC.data(41:200,2:53),'LineWidth',0.5,'Color',colors(3,:),'HandleVisibility','off')
plot(frames,sim_mo_cPRC(1,:),'LineWidth',0.5,'Color',colors(1,:))
plot(frames,sim_mo_cPRC(2:end,:),'LineWidth',0.5,'Color',colors(1,:),'HandleVisibility','off')
plot(frames,mean(mo_cPRC.data(41:200,:),2),'LineWidth',4,'Color',colors(4,:))
plot(frames,mean(sim_mo_cPRC),'LineWidth',2,'Color',colors(2,:))

hold off
box off

set(gca,'TickDir','out')
grid on
hold off
ylabel('\Delta F [a.u]')
xlabel('time [s]')
ax = gca;
ax.TitleHorizontalAlignment = 'left';
title('E')
legend({'data','fits','mean data','mean fit'},'Box','off')

%
nexttile(6)
colors=[0.5 0.5 0.5; 0.15 0.15 0.15; 0.3 0.75 0.93; 0 0.45 0.74];
plot(frames,mo_INNOS.data(41:200,1),'LineWidth',0.5,'Color',colors(3,:))
hold on
plot(frames,mo_INNOS.data(41:200,2:26),'LineWidth',0.5,'Color',colors(3,:),'HandleVisibility','off')
plot(frames,mean(mo_INNOS.data(41:200,:),2),'LineWidth',4,'Color',colors(4,:))
plot(frames,ones(size(frames)),'LineWidth',2,'Color',colors(2,:))

hold off
box off


set(gca,'TickDir','out')
grid on
hold off
xlabel('time [s]')
ax = gca;
ax.TitleHorizontalAlignment = 'left';
title('F')

%% functions to run simulations
function out=simulate_wt_cPRC(p)

t_end=79.5;

init_val = [1/p(1) 1 ...
    0 ...
    1/p(9) 0 ...
    0 0 ...
    1 0 0 0];

tspan = [0 t_end];
% simulate
options = odeset('Events',@largeEventsFcn,'RelTol',1e-6,'AbsTol',1e-9);
sol = ode45(@(t,y) uv_av_ode_wt_cprc(t,y,p), tspan, init_val, options);

% same sampling
frames = 0:0.5:t_end;
y = deval(sol,frames);

out = y(1,:)/y(1,10);
end

function F = uv_av_ode_wt_cprc(t,u,p)

UV = 0.5*(sign(t-5)-1)-0.5*(sign(t-25)-1);

delta_C = p(1);
delta_2 = p(2);
delta_1 = p(3);
kappa_UV = p(4);
kappa_2 = p(5);

delta_S1 = p(6);
u2_0 = p(7);

kappa_4 = p(8);
delta_4 = p(9);

kappa_5_1 = p(10);
delta_5   = p(11);
kappa_5_2 = p(12);

kappa_6 =p(13);
delta_6 = p(14);

kappa_7 = p(15);
delta_7 = p(16);

kappa_8 = p(17);
k9_1 = p(18);
k9_2 = p(19);
delta_9 = p(20);

kappa_g1_1 = p(21);
kappa_g1_2 = p(22);

kappa_10 = p(23);
delta_10 = p(24);

kappa_11 = p(25);
delta_11 = p(26);

w1 = 1;
w2 = 1;

F = [u(2) + kappa_g1_2 * u(9) + (kappa_UV + kappa_g1_1 * u(7))*UV/(1 + delta_1 * u(3)) - delta_C * u(1);
    - delta_2 * (u(2) - u2_0) * u(3) + kappa_2 * u(9)^2* (1 - u(2));
    w1*UV - delta_S1 * u(3);

    1 + kappa_4 * u(3) - delta_4 * u(4);
    (kappa_5_1 * (u(4) - 1/delta_4))/(kappa_5_2 + (u(4) - 1/delta_4)) - delta_5 * u(5);

    w2*kappa_6 * u(5) - delta_6 * u(6);
    kappa_7 * u(6) - delta_7 * u(7);

    -k9_1 * u(8) * u(10)^2/(1 + k9_2*u(10)^2) + kappa_8 * (1 - u(8));
    k9_1 * u(8) * u(10)^2/(1 + k9_2*u(10)^2) - delta_9 * u(9);

    kappa_10 * u(11) - delta_10 * u(10);
    kappa_11 * u(6) - delta_11 * u(11);];

end

%
function out=simulate_ko_cPRC(p)

t_end=79.5;

init_val = [1/p(1) 1 0];


tspan = [0 t_end];
% simulate
options = odeset('Events',@largeEventsFcn,'RelTol',1e-6,'AbsTol',1e-9);
sol = ode45(@(t,y) uv_av_ode_ko_cprc(t,y,p), tspan, init_val, options);

% same sampling
frames = 0:0.5:t_end;
y = deval(sol,frames);

out = y(1,:)/y(1,10);
end


function F = uv_av_ode_ko_cprc(t,u,p)

UV = 0.5*(sign(t-5)-1)-0.5*(sign(t-25)-1);

delta_C = p(1);
delta_2 = p(2);
delta_1 = p(3);
kappa_UV = p(4);

delta_S = p(5);
u2_0 = p(6);

w1 = 1;

F = [u(2) + kappa_UV * UV/(1 + delta_1 * u(3)) - delta_C * u(1); %
    - delta_2 * (u(2) - u2_0) * u(3);
    w1*UV - delta_S * u(3)];%
end

function out=simulate_mo_cPRC(p)

t_end=79.5;

init_val = [1/p(1) 1 0];


tspan = [0 t_end];
% simulate
options = odeset('Events',@largeEventsFcn,'RelTol',1e-6,'AbsTol',1e-9);
sol = ode45(@(t,y) uv_av_ode_mo_cprc(t,y,p), tspan, init_val, options);

% same sampling
frames = 0:0.5:t_end;
y = deval(sol,frames);

out = y(1,:)/y(1,10);
end


function F = uv_av_ode_mo_cprc(t,u,p)

UV = 0.5*(sign(t-5)-1)-0.5*(sign(t-25)-1);

delta_C = p(1);
delta_2 = p(2);
delta_1 = p(3);
kappa_UV = p(4);

delta_S = p(5);
u2_0 = p(6);

w1 = 0.15;

F = [u(2) + kappa_UV * UV/(1 + delta_1 * u(3)) - delta_C * u(1); %
    - delta_2 * (u(2) - u2_0) * u(3);
    w1*UV - delta_S * u(3)];%
end

function out=simulate_INNOS(p)

t_end=79.5;

init_val = [0 1/p(3)];

tspan = [0 t_end];
% simulate
options = odeset('Events',@largeEventsFcn,'RelTol',1e-6,'AbsTol',1e-9);
sol = ode45(@(t,y) uv_av_ode_innos(t,y,p), tspan, init_val, options);

% same sampling
frames = 0:0.5:t_end;
y = deval(sol,frames);

out = y(2,:)/y(2,10);
end


function F = uv_av_ode_innos(t,u,p)

UV = 0.5*(sign(t-5)-1)-0.5*(sign(t-25)-1);

delta_G = p(1); %1

kappa_C_innos = p(2); %2
delta_C_innos = p(3); %3

F = [UV - delta_G * u(1);
     1 + kappa_C_innos * u(1) - delta_C_innos * u(2)];%

end


function [position,isterminal,direction] = largeEventsFcn(~,y)
position = sum(abs(y))-1e3; % The value that we want to be zero
isterminal = 1;  % Halt integration
direction = 0;   % The zero can be approached from either direction
end
