load NO_data.mat

%% fit to average
npars_est = 3;
to_fit = mean(NO_data(:,[1 3:11]),2);

% where the data will be saved
file_prefix = 'NO_innos_11032026';

init_par   =[];

fixed_p    =[0.3576 0.1844 0.3669];
idx_fixed_p=[1:3];

fit_sobj(to_fit,init_par,npars_est,file_prefix,fixed_p,idx_fixed_p,'avg');

%%
best_pars_NO_INNOS_fit_to_mean(idx_fixed_p)=fixed_p;

mean_pareto=importdata([file_prefix '.mat']);
obj_val=mean_pareto.fval;
[~,idx_min_euc]=min(obj_val);

best_pars_NO_INNOS_fit_to_mean(4:6)=mean_pareto.x(idx_min_euc,:);
%%
for k=[1 3:11]
    npars_est = 6;
    to_fit = NO_to_fit_mat(:,k);
    
    init_par   =[];
    fixed_p    =[];
    idx_fixed_p=[];

    file_prefix = ['NO_innos_06032026_' num2str(k)];

    fit_sobj(to_fit,init_par,npars_est,file_prefix,fixed_p,idx_fixed_p,'ind');

    t_end=79.5;
    frames = 0:0.5:t_end;

    mean_pareto=importdata([file_prefix '.mat']);
    obj_val=mean_pareto.fval;
    [~,idx_min_euc]=min(sqrt(sum(obj_val.^2,2)));
    mean_par=mean_pareto.x(idx_min_euc,:);
    [obj_val_out,C_PRC,y]=uv_av_sobj(mean_par,to_fit,fixed_p,idx_fixed_p);

    figure(k+10)
    % clf
    plot(frames,to_fit(41:200),'linewidth',5)
    hold on
    plot(frames,C_PRC,'linewidth',2)

end
%%
clear best_pars_NO
p_idx=1;
for k=[1 3:11]
    file_prefix = ['NO_innos_06032026_' num2str(k)];
    mean_pareto=importdata([file_prefix '.mat']);
    obj_val=mean_pareto.fval;
    [~,idx_min_euc]=min(sqrt(sum(obj_val.^2,2)));
    mean_par=mean_pareto.x(idx_min_euc,:);
    best_pars_NO(p_idx,:)=mean_par;
    p_idx=p_idx+1;
end

%%%%%%% functions
%%%%%%% fitting
function fit_sobj(to_fit1,init_par,npars_est,file_prefix,fixed_p_values,fixed_p_index,swt)

npop = 2000;
paramstoest = 1:npars_est;

obj_fun = @(x) uv_av_sobj(x,to_fit1,fixed_p_values,fixed_p_index);

if strcmp(swt,'ind')
    lb(1:3)=[0.2000    0.0461    0.0917];
    ub(1:3)=[0.6258    0.3227    0.6421];
    base = [8.1960   50.0000    0.2479];
    lb(4:6) = 0.25*base;
    ub(4:6) = 1.75*base;
elseif strcmp(swt,'avg')
    lb = zeros(1,npars_est);
    ub = 50*ones(1,npars_est);
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
% 
options1 = optimoptions('ga','UseParallel', true, ...
    'PopulationSize', npop,'PlotFcn',@gaplotbestf);

options2 = options1;
options2.MaxTime = 7200; % maximum GA time
options2.Display = 'none';
options2.InitialPopulationMatrix=pop;
options2.InitialScoresMatrix=first_scores;
options2.MaxStallGenerations = 500;
options2.MaxGenerations = 5000;

options2.CrossoverFcn={'crossoverscattered'};

tic
[x,fval,exitflag,output,population,scores] = ga(obj_fun, npars_est, [],[],[],[], lb(paramstoest),ub(paramstoest),[], options2);
toc

[~,idx_min_euc]=min(fval(:,1));
fval(idx_min_euc,:)
disp('1st done')

ga_out.x=x;
ga_out.fval=fval;
ga_out.scores=scores;

save([file_prefix '.mat'],'ga_out')
end

%%%%%%% objectives
function [obj_val,NO_INNOS,y]=uv_av_sobj(p_to_fit,to_fit,fixed_p_values,fixed_p_index)

t_end=79.5;
% find steady state
nb_p=numel(p_to_fit)+numel(fixed_p_values);

p=zeros(1,nb_p);

p(fixed_p_index)=fixed_p_values;

idx_p_to_fit=setdiff(1:nb_p,fixed_p_index);
p(idx_p_to_fit)=p_to_fit;

init_val = [0 1/p(3) 0];

% simulate
tspan = [0 t_end];

% same sampling
frames = 0:0.5:t_end;

options = odeset('Events',@largeEventsFcn,'RelTol',1e-6,'AbsTol',1e-9);
sol = ode45(@(t,y) uv_av_ode_innos_no(t,y,p), tspan, init_val, options);


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

if ~isreal(obj_val1)
    % idx_rightmost_real
    init_val,
    pause,
end

obj_val=[obj_val1];
end

%%%%%%% ode45 options
function [position,isterminal,direction] = largeEventsFcn(~,y)
position = sum(abs(y))-1e3; % The value that we want to be zero
isterminal = 1;  % Halt integration
direction = 0;   % The zero can be approached from either direction
end

%%%%%%% model
function F = uv_av_ode_innos_no(t,u,p)

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

%%%%%% initial parameters
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