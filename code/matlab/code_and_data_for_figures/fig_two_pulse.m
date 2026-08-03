gap=[0 10 30];

p =[0.5838  0.0507  1.5796 0.6152...
    34.5542 ...
    0.3576  0.5515 ...
    0.1844  0.3669 ...
    8.1960  50.0000 0.2479 ...
    0.2500  0.9989    0.7532 ...
    0.9259  0.0001    0.1211 ...
    1.0000  0.2029    28.7962 ...
    3.1782  0.5183    0.1042  ...
    0.6428  0.1010];

clear sim_out_pulse

for dur_idx=1:3
    dur=[1 10 30];
    for gap_idx=1:3
        if gap_idx>1
            dur=2*[1 10 30];
        end
        tspan = [0 t_end];
        sim_out_pulse(dur_idx,gap_idx).c_prc = simulate_pow_dur(p,dur(dur_idx),gap(gap_idx));
    end
end

%%
tiledlayout(2,3,'Padding','compact','TileSpacing','compact')
t_end=220;

frames = 0:0.001:t_end;

for gap_idx=2:3
    for dur_idx=1:3
        dur=[1 10 30];
        if gap_idx>1
            dur=2*[1 10 30];
        end

        tspan = [0 t_end];

        nexttile
        hold on


        title(['Dur: ' num2str(dur(dur_idx)), ', Gap: ' num2str(gap(gap_idx))])
        patch([5 5+dur(dur_idx) 5+dur(dur_idx) 5],[0.55 0.55 1.75 1.75],...
            [0.72 0.27 1],'facealpha',0.1,'edgecolor',[0.72 0.27 1]);
        patch((gap(gap_idx)+dur(dur_idx))+[5 5+dur(dur_idx) 5+dur(dur_idx) 5],[0.55 0.55 1.75 1.75],...
            [0.72 0.27 1],'facealpha',0.1,'edgecolor',[0.72 0.27 1],'HandleVisibility','off')


        plot(frames,sim_out_pulse(dur_idx,1).c_prc,...
            'color',[0.25 0.25 0.25],'linewidth',3)
        hold on
        plot(frames,sim_out_pulse(dur_idx,gap_idx).c_prc,...
            'color',[0.72 0.27 1],'linewidth',1.5)

        if dur_idx==1
            ylabel('\Delta F [a.u.]')
        else
            set(gca,'YTickLabel','')
        end

        if gap_idx==3
            xlabel('time [s]')
        else
            set(gca,'XTickLabel','')
        end

        if dur_idx==1 && gap_idx==2
            legend({'UV stimulation','single pulse','2 pulses'})
        end

        xlim([0 200])
        ylim([0.55 1.75])
        set(gca,'TickDir','out')
        grid on
        hold off
    end
end

%%
function out=simulate_pow_dur(p,dur,pow)

t_end=220;

init_val = [1/p(1) 1 ...
    0 ...
    1/p(9) 0 ...
    0 0 ...
    1 0 0 0];


tspan = [0 t_end];
% simulate
options = odeset('Events',@largeEventsFcn,'RelTol',1e-6,'AbsTol',1e-9);
sol = ode45(@(t,y) uv_av_ode_cprc(t,y,[p,dur,pow]), tspan, init_val, options);

% same sampling
frames = 0:0.001:t_end;
y = deval(sol,frames);

out = y(1,:)/y(1,1000);
end

function [position,isterminal,direction] = largeEventsFcn(~,y)
position = sum(abs(y))-1e3; % The value that we want to be zero
isterminal = 1;  % Halt integration
direction = 0;   % The zero can be approached from either direction
end

function F = uv_av_ode_cprc(t,u,p)

t_start_1 = 5;
t_end_1   = 5 + p(end-1);

t_start_2 = 5 + p(end-1) + p(end);
t_end_2   = 5 + p(end-1) + p(end) + p(end-1);

UV = (0.5*(sign(t-t_start_1)-1)-0.5*(sign(t-t_end_1)-1))+...
    (0.5*(sign(t-t_start_2)-1)-0.5*(sign(t-t_end_2)-1));

delta_C = p(1);
delta_2 = p(2);
delta_1 = p(3);
kappa_UV = p(4);
kappa_2 = p(5); % 1

delta_S1 = p(6); % fixed
u2_0 = p(7);

kappa_4 = p(8); % fixed
delta_4 = p(9); % fixed

kappa_5_1 = p(10);
delta_5   = p(11);
kappa_5_2 = p(12);

kappa_6 = p(13); %2
delta_6 = p(14); %3

kappa_7 = p(15); %4
delta_7 = p(16); %5

kappa_8 = p(17); %6
k9_1 = p(18); %7
k9_2 = p(19); %8
delta_9 = p(20); %9

kappa_g1_1 = p(21); %10
kappa_g1_2 = p(22); %11

kappa_10 = p(23); %12
delta_10 = p(24); %13

kappa_11 = p(25); %14
delta_11 = p(26); %15


F = [u(2) + kappa_g1_2 * u(9) + (kappa_UV + kappa_g1_1 * u(7))*UV/(1 + delta_1 * u(3)) - delta_C * u(1);%/(1 + kappa_g1_3 * u(9))
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