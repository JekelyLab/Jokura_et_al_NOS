% data that will be fitted, run load_data.m 
% (in this case it will be mean of ko INNOS recordings)
to_fit = mean(wt_cPRC.data,2); 
% to_fit = wt_cPRC.data(:,2); 

% number of new parameters to estimate
% 13 for wt 
% 7 for NOS ko 
% 4 for mo
npars_est = 13; 

% number of equations
% 6 for wt
% 3 for NOS ko
% 2 for mo

n_var = 6; 

% where the data will be saved
file_prefix = 'wt_mean';

% typically empty, but can be taken from some earlier fitting
init_par = [];
fit_uv_av_cprc(to_fit,init_par,npars_est,n_var,file_prefix); 

%% get fitted parameters

wt_mean_pareto=importdata([file_prefix '_CPRC.mat']);
obj_val=wt_mean_pareto.fval;
[~,idx_min_euc]=min(sqrt(sum(obj_val.^2,2)));
wt_mean_par=wt_mean_pareto.x(idx_min_euc,:);

%% plot fit and data
to_fit = mean(wt_cPRC.data,2); 

t_end=79.5;
frames = 0:0.5:t_end;

% when using the objective for simulations to_fit doesn't affect results
[~,C_PRC]=uv_av_mobj_cprc(wt_mean_innos_par,n_var,to_fit);

plot(frames,to_fit(41:200))
hold on
plot(frames,C_PRC)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% ko example %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%
% data that will be fitted, run load_data.m 
% (in this case it will be mean of ko INNOS recordings)
to_fit = mean(ko_cPRC.data,2); 
% to_fit = wt_cPRC.data(:,2); 

% number of new parameters to estimate
% 13 for wt 
% 7 for NOS ko 
% 4 for mo
npars_est = 7; 

% number of equations
% 6 for wt
% 3 for NOS ko
% 2 for mo

n_var = 3; 

% where the data will be saved
file_prefix = 'ko_mean';

% typically empty, but can be taken from some earlier fitting
init_par = [];
fit_uv_av_cprc(to_fit,init_par,npars_est,n_var,file_prefix); 

%% get fitted parameters

ko_mean_pareto=importdata([file_prefix '_CPRC.mat']);
obj_val=ko_mean_pareto.fval;
[~,idx_min_euc]=min(sqrt(sum(obj_val.^2,2)));
ko_mean_par=ko_mean_pareto.x(idx_min_euc,:);

%% plot fit and data
t_end=79.5;
frames = 0:0.5:t_end;

% when using the objective for simulations to_fit doesn't affect results
[~,C_PRC]=uv_av_mobj_cprc(ko_mean_par,n_var,to_fit);

plot(frames,to_fit(41:200))
hold on
plot(frames,C_PRC)



