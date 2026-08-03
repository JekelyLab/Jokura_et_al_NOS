load wt_ko_mo_data

p_WT =[0.5838 0.0507  1.5796 0.6152...
    34.5542 ...
    0.3576 0.5515 ...
    0.1844 0.3669 ...
    8.1960 50.0000 0.2479 ...
    0.2500    0.9989    0.7532 ...
    0.9259    0.0001    0.1211 ...
    1.0000    0.2029    28.7962 ...
    3.1782    0.5183    0.1042  ...
    0.6428    0.1010 ...
    1 1]; % for WT set 1 & 1

p_KO =[0.5838 0.0507  1.5796 0.6152...
    34.5542 ...
    0.3576 0.5515 ...
    0.1844 0.3669 ...
    8.1960 50.0000 0.2479 ...
    0.2500    0.9989    0.7532 ...
    0.9259    0.0001    0.1211 ...
    1.0000    0.2029    28.7962 ...
    3.1782    0.5183    0.1042  ...
    0.6428    0.1010 ...
    1 0]; % for KO set 1 & 0

p_MO =[0.5838 0.0507  1.5796 0.6152...
    34.5542 ...
    0.3576 0.5515 ...
    0.1844 0.3669 ...
    8.1960 50.0000 0.2479 ...
    0.2500    0.9989    0.7532 ...
    0.9259    0.0001    0.1211 ...
    1.0000    0.2029    28.7962 ...
    3.1782    0.5183    0.1042  ...
    0.6428    0.1010 ...
    0.15 0]; % for KO set 0.15 & 0

mean_wt_fit=simulate_wt_cPRC(p_WT);
mean_ko_fit=simulate_wt_cPRC(p_KO);
mean_mo_fit=simulate_wt_cPRC(p_MO);

for k=1:9
    p_KO(end)=k/10;
    sim_wt_to_ko(k,:)=simulate_wt_cPRC(p_KO);
end

for k=0:9
    p_MO(end-1)=k/10;
    sim_ko_to_mo(k+1,:)=simulate_wt_cPRC(p_MO);
end

%%
t_end=79.5;
frames = 0:0.5:t_end;

tiledlayout(3,1,'TileSpacing','tight','Padding','compact')

colors=[0.93      0.69      0.13;...
        0.1490    0.5490    0.8660;...
        0.9600    0.4660    0.1600];

nexttile(1)
plot(frames,mean(wt_cPRC.data(41:200,:),2),'LineWidth',4,'Color',colors(1,:))
hold on
plot(frames,mean_wt_fit,'LineWidth',2,'Color',[0.15 0.15 0.15],'HandleVisibility','off')
plot(frames,mean(ko_cPRC.data(41:200,:),2),'LineWidth',4,'Color',colors(2,:))
plot(frames,mean_ko_fit,'LineWidth',2,'Color',[0.15 0.15 0.15],'HandleVisibility','off')
plot(frames,mean(mo_cPRC.data(41:200,:),2),'LineWidth',4,'Color',colors(3,:))
plot(frames,mean_mo_fit,'LineWidth',2,'Color',[0.15 0.15 0.15])
hold off
box off
set(gca,'TickDir','out','XTickLabel','')
ylim([0.5 1.5])
grid on
hold off
ylabel('\Delta F [a.u]')
legend({'WT','NOS ko','NIT-GC2 mo','fits'},'Box','off')
ax = gca;
ax.TitleHorizontalAlignment = 'left';
title('A')

nexttile(2)

plot(frames,mean(wt_cPRC.data(41:200,:),2),'LineWidth',4,'Color',colors(1,:),'HandleVisibility','off')
hold on
plot(frames,mean_wt_fit,'LineWidth',2,'Color',[0.15 0.15 0.15],'HandleVisibility','off')
plot(frames,mean(ko_cPRC.data(41:200,:),2),'LineWidth',4,'Color',colors(2,:),'HandleVisibility','off')
plot(frames,mean_ko_fit,'LineWidth',2,'Color',[0.15 0.15 0.15],'HandleVisibility','off')
plot(frames,sim_wt_to_ko(1,:),'Color',[0.5 0.5 0.5],'LineWidth',0.5)
plot(frames,sim_wt_to_ko(2:end,:),'Color',[0.5 0.5 0.5],'LineWidth',0.5,'HandleVisibility','off')
hold off
box off

set(gca,'TickDir','out','XTickLabel','')
ylim([0.5 1.5])
grid on
hold off
ylabel('\Delta F [a.u]')
legend({'interpolated fits'},'Box','off')
ax = gca;
ax.TitleHorizontalAlignment = 'left';
title('B')

nexttile(3)
plot(frames,mean(ko_cPRC.data(41:200,:),2),'LineWidth',4,'Color',colors(2,:))
hold on
plot(frames,mean_ko_fit,'LineWidth',2,'Color',[0.15 0.15 0.15])
plot(frames,mean(mo_cPRC.data(41:200,:),2),'LineWidth',4,'Color',colors(3,:))
plot(frames,mean_mo_fit,'LineWidth',2,'Color',[0.15 0.15 0.15])
plot(frames,sim_ko_to_mo,'Color',[0.5 0.5 0.5],'LineWidth',0.5)
hold off
box off

set(gca,'TickDir','out')
ylim([0.5 2])
grid on
hold off
ylabel('\Delta F [a.u]')
xlabel('time [s]')
ax = gca;
ax.TitleHorizontalAlignment = 'left';
title('C')

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

% same sampling as data
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

w1 = p(27);
w2 = p(28);

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

function [position,isterminal,direction] = largeEventsFcn(~,y)
position = sum(abs(y))-1e3; % The value that we want to be zero
isterminal = 1;  % Halt integration
direction = 0;   % The zero can be approached from either direction
end



