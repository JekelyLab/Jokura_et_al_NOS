load wt_ko_mo_data

%% fit to average
npars_est = 6;
to_fit = mean(ko_cPRC.data(:,1:55),2);
file_prefix = 'ko_cprc_11032026';

init_par   = [];
fixed_p    = [];
idx_fixed_p= [];

fit_mobj(to_fit,init_par,npars_est,file_prefix,fixed_p,idx_fixed_p,'avg');

mean_pareto=importdata([file_prefix '.mat']);
obj_val=mean_pareto.fval;
[~,idx_min_euc]=min(sqrt(sum(obj_val.^2,2)));

best_pars_KO_fit_to_mean=mean_pareto.x(idx_min_euc,:);
%%
for k=1:55
    npars_est = 6;
    to_fit = ko_cPRC.data(:,k);

    fixed_p    = [];
    idx_fixed_p= [];

    file_prefix = ['ko_cprc_05032026_' num2str(k)];

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

end
%%
clear best_pars_KO
for k=55:-1:1
    file_prefix = ['ko_cprc_05032026_' num2str(k)];
    mean_pareto=importdata([file_prefix '.mat']);
    obj_val=mean_pareto.fval;
    [~,idx_min_euc]=min(sqrt(sum(obj_val.^2,2)));
    mean_par=mean_pareto.x(idx_min_euc,:);
    best_pars_KO(k,:)=mean_par;
end

%%%%%%% functions
%%%%%%% fitting
function fit_mobj(to_fit1,init_par,npars_est,file_prefix,fixed_p_values,fixed_p_index,swt)

npop = 2000;
paramstoest = 1:npars_est;

obj_fun = @(x) uv_av_mobj(x,to_fit1,fixed_p_values,fixed_p_index);

if strcmp(swt,'ind')
    base = [0.5838    0.0507    1.5796    0.6152    0.3576    0.5515];
    lb = 0.25*base;
    ub = 1.75*base;
elseif strcmp(swt,'avg')
    lb = zeros(1,npars_est);
    ub = 2*ones(1,npars_est);
end
lb(5) = 0.2;

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
options2.MaxTime = 7200; % maximum GA time
options2.Display = 'none';
options2.InitialPopulationMatrix=pop;
options2.InitialScoresMatrix=first_scores;
options2.MaxStallGenerations = 400;
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
 
ga_out.x=x;
ga_out.fval=fval;
ga_out.scores=scores;

save([file_prefix '.mat'],'ga_out')
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

init_val = [1/p(1) 1 0];

% simulate
tspan = [0 t_end];

% same sampling
frames = 0:0.5:t_end;

options = odeset('Events',@largeEventsFcn,'RelTol',1e-6,'AbsTol',1e-9);
sol = ode45(@(t,y) uv_av_ode_ko(t,y,p), tspan, init_val, options);


if ~isempty(sol.xe)
    C_PRC= 20*ones(numel(frames),1);
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
obj_val2=sqrt(sum((to_fit((end-20):end)-C_PRC((end-20):end)).^2));

obj_val=[obj_val1,obj_val2];
end

%%%%%%% ode45 option
function [position,isterminal,direction] = largeEventsFcn(~,y)
position = sum(abs(y))-1e3; % The value that we want to be zero
isterminal = 1;  % Halt integration
direction = 0;   % The zero can be approached from either direction
end

%%%%%%% model
function F = uv_av_ode_ko(t,u,p)

t_end=20+5;

UV = 0.5*(sign(t-5)-1)-0.5*(sign(t-t_end)-1);

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