load wt_ko_mo_data

%% fit to average
npars_est = 2;
to_fit = mean([ko_INNOS.data wt_INNOS.data],2);
% where the data will be saved
file_prefix = 'wt_ko_innos_11032026';

init_par   =[];
fixed_p    =[0.3576];
idx_fixed_p=[1];

fit_mobj(to_fit,init_par,npars_est,file_prefix,fixed_p,idx_fixed_p,'avg');

best_pars_Ca_INNOS_fit_to_mean(idx_fixed_p)=fixed_p;

mean_pareto=importdata([file_prefix '.mat']);
obj_val=mean_pareto.fval;
[~,idx_min_euc]=min(sqrt(sum(obj_val.^2,2)));

best_pars_Ca_INNOS_fit_to_mean(2:3)=mean_pareto.x(idx_min_euc,:);
%%
data=[ko_INNOS.data wt_INNOS.data];
for k=1:48
    npars_est = 3;
    to_fit = data(:,k);
    init_par   =[];
    fixed_p    =[];
    idx_fixed_p=[];

    file_prefix = ['wt_ko_innos_06032026_' num2str(k)];

    fit_mobj(to_fit,init_par,npars_est,file_prefix,fixed_p,idx_fixed_p,'ind');

    t_end=79.5;
    frames = 0:0.5:t_end;

    mean_pareto=importdata([file_prefix '.mat']);
    obj_val=mean_pareto.fval;
    [~,idx_min_euc]=min(sqrt(sum(obj_val.^2,2)));
    mean_par=mean_pareto.x(idx_min_euc,:);
    [obj_val_out,C_PRC,y]=uv_av_mobj(mean_par,to_fit,fixed_p,idx_fixed_p);

    figure(k+10)
    plot(frames,to_fit(41:200),'linewidth',5)
    hold on
    plot(frames,C_PRC,'linewidth',2)

end

%%
best_pars_INNOS=[];
data=[ko_INNOS.data wt_INNOS.data];

for k=48:-1:1
    file_prefix = ['wt_ko_innos_06032026_' num2str(k)];
    mean_pareto=importdata([file_prefix '.mat']);
    obj_val=mean_pareto.fval;
    [~,idx_min_euc]=min(sqrt(sum(obj_val.^2,2)));
    mean_par=mean_pareto.x(idx_min_euc,:);
    best_pars_INNOS(k,:)=mean_par;
end

%%%%%%% functions
%%%%%%% fitting
function fit_mobj(to_fit1,init_par,npars_est,file_prefix,fixed_p_values,fixed_p_index,swt)

npop = 2000;
paramstoest = 1:npars_est;

obj_fun = @(x) uv_av_mobj(x,to_fit1,fixed_p_values,fixed_p_index);

if strcmp(swt,'ind')
    lb(1)=0.2;
    ub(1)=0.6258;
    base = [0.1844 0.3669];
    lb(2:3) = 0.25*base;
    ub(2:3) = 1.75*base;
elseif strcmp(swt,'avg')
    lb = zeros(1,npars_est);
    ub = 2*ones(1,npars_est);
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
function [obj_val,C_INNOS,y]=uv_av_mobj(p_to_fit,to_fit,fixed_p_values,fixed_p_index)

t_end=79.5;
% find steady state
nb_p=numel(p_to_fit)+numel(fixed_p_values);

p=zeros(1,nb_p);

p(fixed_p_index)=fixed_p_values;

idx_p_to_fit=setdiff(1:nb_p,fixed_p_index);
p(idx_p_to_fit)=p_to_fit;

init_val = [0 1/p(3)];

% simulate
tspan = [0 t_end];

% same sampling
frames = 0:0.5:t_end;

options = odeset('Events',@largeEventsFcn,'RelTol',1e-6,'AbsTol',1e-9);
sol = ode45(@(t,y) uv_av_ode_innos(t,y,p), tspan, init_val, options);


if ~isempty(sol.xe)
    C_INNOS= 20*ones(numel(frames),1);
else
    y = deval(sol,frames);
    % normalise
    C_INNOS = (y(2,:))/(y(2,10));

    if max(y(2,:))-min(y(2,:))<1e-3
        C_INNOS=ones(numel(C_INNOS),1);
    end
end


to_fit=to_fit(41:200);
C_INNOS=C_INNOS(:);

obj_val1=sqrt(sum((to_fit(11:51)-C_INNOS(11:51)).^2));
obj_val2=sqrt(sum((to_fit(52:end)-C_INNOS(52:end)).^2));

obj_val=[obj_val1,obj_val2];
end

%%%%%%% ode45 options
function [position,isterminal,direction] = largeEventsFcn(~,y)
position = sum(abs(y))-1e3; % The value that we want to be zero
isterminal = 1;  % Halt integration
direction = 0;   % The zero can be approached from either direction
end

%%%%%%% model
function F = uv_av_ode_innos(t,u,p)

t_end=20+5;

UV = 0.5*(sign(t-5)-1)-0.5*(sign(t-t_end)-1);

delta_G = p(1); %1
kappa_C_innos = p(2); %2
delta_C_innos = p(3); %3

F = [UV - delta_G * u(1);
     1 + kappa_C_innos * u(1) - delta_C_innos * u(2)];%
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