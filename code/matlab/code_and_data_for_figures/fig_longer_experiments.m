load longer_experiments_data

% simulate longer durations using parameters fitted to average
dur=[22.4 44.7 67.1 89.5 111.9];
amp=[0.25 0.5 0.75 1.0];


p =[0.5838  0.0507  1.5796 0.6152...
    34.5542 ...
    0.3576  0.5515 ...
    0.1844  0.3669 ...
    8.1960  50.0000 0.2479 ...
    0.2500  0.9989  0.7532 ...
    0.9259  0.0001  0.1211 ...
    1.0000  0.2029  28.7962 ...
    3.1782  0.5183  0.1042  ...
    0.6428  0.1010];

t_end=220;
tspan = [0 t_end];

clear sim_out

for dur_idx=1:5
    for amp_idx=1:4
        sim_out(dur_idx,amp_idx).c_prc = simulate_pow_dur(p,dur(dur_idx),amp(amp_idx));
    end
end
%%
p=[3 6 9 12];
d=[10 20 30 40 50];
dur=[22.4 44.7 67.1 89.5 111.9];

c2=[5 4 3 2 1];
frame_uv_end=[173 215 257 299 341];
time=0:0.53268:298;%0:1/4.2:(133+1/3-1/4.2);
frames = (0:0.05:200)+(time(131)-5);
frames_sim = (0:0.5:220)+(time(131)-5);
tiledlayout(2,3,'TileSpacing','compact','Padding','compact')

t0=64.2484;
clear mean_dt_mat

for idx2=2:4
    nexttile
    cla
    clear dt_mat
    for idx1=1:4
        dt=longer_experiments_data(idx1,idx2).ts;
        dt=dt/dt(129);
        dt_mat(idx1,:)=dt;
        
        if idx1==1
            patch([time(131) time(frame_uv_end(idx2)) time(frame_uv_end(idx2)) time(131)]-t0,[0.25 0.25 2.5 2.5],...
            [0.72 0.27 1],'facealpha',(p(idx1)/12)-0.15,'edgecolor',[0.72 0.27 1]);%,'HandleVisibility','off')
            hold on
        end

        plot(time-t0,dt,'linewidth',4,'Color',[0.8 0.8 0.8]./idx1)
        hold on
        axis([time(131)-5-t0 220-t0 0.25 2.5])
        title(['Duration: ' num2str(dur(idx2),3) '[s]'])
        set(gca,'tickdir','out','XTickLabel','')

        grid on
        if idx2~=2
            set(gca,'YTickLabel','')
        else
            ylabel(['\Delta F [a.u.]'])
        end
 
    end
    mean_dt_mat(idx2,:)=mean(dt_mat(2:4,:));
    se_dt_mat(idx2,:)=std(dt_mat(2:4,:))./sqrt(3);
    
    if idx2==2
        legend({'UV stimulation','data 25%','data 50%','data 75%','data 100%'})
    end
end
pause,
for idx2=2:4
    nexttile
    cla
    for idx1=1:4
        
        if idx1==1
            patch([time(131) time(frame_uv_end(idx2)) time(frame_uv_end(idx2)) time(131)]-t0,[0.25 0.25 2.5 2.5],...
            [0.72 0.27 1],'facealpha',(p(idx1)/12)-0.15,'edgecolor',[0.72 0.27 1],'HandleVisibility','off')
            hold on
        end
        

        plot(frames_sim-t0,sim_out(idx2,idx1).c_prc,'linewidth',4,'Color',[0.8 0.8 0.8]./idx1)

        hold on

        axis([time(131)-5-t0 220-t0 0.25 2.5])
        set(gca,'tickdir','out')

        grid on
        if idx2~=2
            set(gca,'YTickLabel','')
        else
            ylabel(['\Delta F [a.u.]'])
        end

    end
    plot(time-t0,mean_dt_mat(idx2,:),'linewidth',2,'Color',[0.72 0.27 1])
    plot(time-t0,mean_dt_mat(idx2,:)-1.96*se_dt_mat(idx2,:),'linewidth',0.5,'Color',[0.72 0.27 1])
    plot(time-t0,mean_dt_mat(idx2,:)+1.96*se_dt_mat(idx2,:),'linewidth',0.5,'Color',[0.72 0.27 1],'HandleVisibility','off')

    if idx2==2
        legend({'sim 25%','sim 50%','sim 75%','sim 100%','mean of data 50%,75% and 100%','standard error'})
    end
    xlabel(['time [s]'])
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
frames = 0:0.5:t_end;
y = deval(sol,frames);

out = y(1,:)/y(1,10);
end

function [position,isterminal,direction] = largeEventsFcn(~,y)
position = sum(abs(y))-1e3; % The value that we want to be zero
isterminal = 1;  % Halt integration
direction = 0;   % The zero can be approached from either direction
end

function F = uv_av_ode_cprc(t,u,p)

t_end = p(end-1)+5;

UV = p(end)*(0.5*(sign(t-5)-1)-0.5*(sign(t-t_end)-1));

delta_C = p(1); 
delta_2 = p(2);
delta_1 = p(3);
kappa_UV = p(4);
kappa_2 = p(5); % 1

delta_S1 = p(6); 
u2_0 = p(7); 

kappa_4 = p(8); 
delta_4 = p(9); 

kappa_5_1 = p(10);   
delta_5   = p(11);
kappa_5_2 = p(12);

kappa_6 =p(13); %2
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

w1 = 1;
w2 = 1;

F = [u(2) + kappa_g1_2 * u(9) + (kappa_UV + kappa_g1_1 * u(7))*UV/(1 + delta_1 * u(3)) - delta_C * u(1);%/(1 + kappa_g1_3 * u(9))
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