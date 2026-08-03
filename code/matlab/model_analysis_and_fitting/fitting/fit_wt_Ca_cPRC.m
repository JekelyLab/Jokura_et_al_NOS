load wt_ko_mo_data

%% fit to average
npars_est = 15;
to_fit = mean(wt_cPRC.data(:,1:47),2);

% where the data will be saved
file_prefix = 'wt_cprc_11032026';

init_par = [];

fixed_p    =[0.5838 0.0507 1.5796 0.6152 0.3576 0.5515 ... % from KO
             0.1844 0.3669 ... % from Ca INNOS
             8.1960 50.0000 0.2479]; % from NO INNOS

idx_fixed_p=[1:4 6:12];

fit_mobj(to_fit,init_par,npars_est,file_prefix,fixed_p,idx_fixed_p,'avg');

best_pars_WT_fit_to_mean(idx_fixed_p)=fixed_p;

mean_pareto=importdata([file_prefix '.mat']);
obj_val=mean_pareto.fval;
[~,idx_min_euc]=min(sqrt(sum(obj_val.^2,2)));

best_pars_WT_fit_to_mean([5 13:26])=mean_pareto.x(idx_min_euc,:);
% for plotting see next section or fig_all_fits.m

%%  fit to individual datasets
for k=1:47
    tic,
    npars_est = 26;
    to_fit = wt_cPRC.data(:,k);

    fixed_p    = [];
    idx_fixed_p= [];
    init_par   = [];

    file_prefix = ['wt_cprc_06032026_' num2str(k)];

    fit_mobj(to_fit,init_par,npars_est,file_prefix,fixed_p,idx_fixed_p,'ind');

    t_end=79.5;
    frames = 0:0.5:t_end;

    mean_pareto=importdata([file_prefix '.mat']);
    obj_val=mean_pareto.fval;
    [~,idx_min_euc]=min(sqrt(sum(obj_val.^2,2)));
    mean_par=mean_pareto.x(idx_min_euc,:);
    [obj_val_out,C_PRC,y]=uv_av_mobj(mean_par,to_fit,fixed_p,idx_fixed_p);

    figure(k+10)
    % clf
    plot(frames,to_fit(41:200),'linewidth',5)
    hold on
    plot(frames,C_PRC,'linewidth',2)
    toc,
end

%% extract best fitted parameters from individual recordings

clear best_pars_WT
for k=47:-1:1
    file_prefix = ['wt_cprc_06032026_' num2str(k)];

    mean_pareto=importdata([file_prefix '.mat']);
    obj_val=mean_pareto.fval;
    [~,idx_min_euc]=min(sqrt(sum(obj_val.^2,2)));

    mean_par=mean_pareto.x(idx_min_euc,:);
    best_pars_WT(k,:)=mean_par;
end

%%%%%%% functions
%%%%%%% fitting
function fit_mobj(to_fit,init_par,npars_est,file_prefix,fixed_p_values,fixed_p_index,swt)

npop = 2000;
paramstoest = 1:npars_est;

obj_fun = @(x) uv_av_mobj(x,to_fit,fixed_p_values,fixed_p_index);

% parameter bounds
if strcmp(swt,'ind') % based on fitting other data
    lb([1:4 6:7])=[0.1460    0.0127    0.3949    0.1538    0.2000    0.1657];
    ub([1:4 6:7])=[1.0216    0.0887    2.7643    1.0766    0.6258    0.9651];

    lb(8:12)=[0.0461 0.0917 3.2634  13.0155 0.0620];
    ub(8:12)=[0.3227 0.6421 13.9547 87.4424 0.4338];

    base = [34.5542 ...
        0.2500    0.9989    0.7532 ...
        0.9259    0.0001    0.1211 ...
        1.0000    0.2029    28.7962 ...
        3.1782    0.5183    0.1042  ...
        0.6428    0.1010];

    lb([5 13:26])=0.75*base;
    ub([5 13:26])=1.75*base;
    ub([5 21 22]) = 35;
    lb([14 16 24 26]) = 0.1;
    lb(26) = 0.05;
    ub(17) = 0.0001;
    lb(20) = 0.2;

elseif strcmp(swt,'avg') % set
    lb = zeros(1,npars_est);
    ub = 2*ones(1,npars_est);
    ub([1 10 11]) = 35;

    lb([3 5 13 15]) = 0.1;

    ub(6) = 0.0001;
    lb(9) = 0.2;
end

first_pop = scaled_sobol(npop, npars_est, [lb(paramstoest);ub(paramstoest)]);
pop=first_pop;

if ~isempty(init_par)
    pop(1:size(init_par,1),:)=init_par;
end

first_scores = NaN(npop,2);

% Calculate scores for each initial population
tic
parfor fs_idx=1:npop
    first_scores(fs_idx,:) = obj_fun(pop(fs_idx,:));
end
toc
min(first_scores(:,1))
min(first_scores(:,2))

disp('1st scores done')

options1 = optimoptions('gamultiobj','UseParallel', true, ...
    'PopulationSize', npop,'PlotFcn',@gaplotpareto);

options2 = options1;
options2.MaxTime = 7200;
options2.Display = 'none';
options2.InitialPopulationMatrix=pop;
options2.InitialScoresMatrix=first_scores;
options2.MaxStallGenerations = 200;
options2.MaxGenerations = 2000;
options2.CrossoverFcn={'crossoverscattered'};


tic
[x,fval,exitflag,output,population,scores] = gamultiobj(obj_fun, npars_est, [],[],[],[], lb(paramstoest),ub(paramstoest),[], options2);
toc
[~,idx_min_euc]=min(sqrt(sum(fval.^2,2)));
fval(idx_min_euc,:)
[~,idx_min_euc]=min(fval(:,1));
fval(idx_min_euc,:)
[~,idx_min_euc]=min(fval(:,2));
fval(idx_min_euc,:)

disp('1st done')

out_ga.x=x;
out_ga.fval=fval;
out_ga.score=fval;

save([file_prefix '.mat'],'out_ga')
end

%%%%%%% objectives
function [obj_val,C_PRC,y]=uv_av_mobj(p_to_fit,to_fit,fixed_p_values,fixed_p_index)

t_end=79.5;

% find steady state
nb_p=numel(p_to_fit)+numel(fixed_p_values);

p=zeros(1,nb_p);

p(fixed_p_index)=fixed_p_values;

idx_p_to_fit=setdiff(1:nb_p,fixed_p_index);
p(idx_p_to_fit)=p_to_fit;

%steady state before
init_val = [1/p(1) 1 ...
    0 ...
    1/p(9) 0 ...
    0 0 ...
    1 0 0 0];

% simulate
tspan = [0 t_end];

% same sampling as data
frames = 0:0.5:t_end;

options = odeset('Events',@largeEventsFcn,'RelTol',1e-6,'AbsTol',1e-9);
sol = ode45(@(t,y) uv_av_dde_wt(t,y,p), tspan, init_val, options);


if ~isempty(sol.xe)
    C_PRC= 44*ones(numel(frames),1);
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
obj_val2=sqrt(sum((to_fit(52:end)-C_PRC(52:end)).^2));

obj_val=[obj_val1,obj_val2];
end

%%%%%%% ode45 option
function [position,isterminal,direction] = largeEventsFcn(~,y)
position = sum(abs(y))-1e3; % The value that we want to be zero
isterminal = 1;  % Halt integration
direction = 0;   % The zero can be approached from either direction
end

%%%%%%% model
function F = uv_av_dde_wt(t,u,p)

t_end = 20+5;

UV = 0.5*(sign(t-5)-1)-0.5*(sign(t-t_end)-1);

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

%%%%%%% initial parameters
function out=scaled_sobol(npop, npars_est, bounds)
% bounds 2xn matrix with first row lower bounds and second row upper bound.

sobol_set=sobolset(npars_est,'Skip',2e3);
sobol_set=scramble(sobol_set,'MatousekAffineOwen');

ps=net(sobol_set,npop);

for j=npars_est:-1:1
    a=bounds(1,j);
    b=bounds(2,j);

    out(:,j)=a+(b-a)*ps(:,j);
end
end
