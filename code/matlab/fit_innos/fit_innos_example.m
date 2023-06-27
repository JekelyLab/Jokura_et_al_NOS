% data that will be fitted, run load_data.m 
% (in this case it will be mean of ko INNOS recordings)
to_fit = mean(ko_INNOS.data,2); 

% number of new parameters to estimate
npars_est = 3; 

% number of equations
n_var = 2; 

% where the data will be saved
file_prefix = 'ko_mean';

 % typically empty, but can be taken from some earlier fitting
init_par = [];
fit_uv_av_innos(to_fit,init_par,npars_est,n_var,file_prefix); 

%% get fitted parameters

ko_mean_innos_pareto=importdata([file_prefix '_INNOS.mat']);
obj_val=ko_mean_innos_pareto.fval;
[~,idx_min_euc]=min(sqrt(sum(obj_val.^2,2)));
ko_mean_innos_par=ko_mean_innos_pareto.x(idx_min_euc,:);

%% plot fit and data
t_end=79.5;
frames = 0:0.5:t_end;

% when using the objective for simulations to_fit doesn't affect results
[~,C_INNOS]=uv_av_mobj_innos(ko_mean_innos_par,n_var,to_fit);

plot(frames,to_fit(41:200))
hold on
plot(frames,C_INNOS)
