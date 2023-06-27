% data that will be fitted, run load_data.m 
% (in this case it will be mean of wt INRGW recordings)
to_fit = mean(wt_INRGW.data,2); 

% have to be estimated 1st e.g. using a script in fit_cprc_example.m
fixed_pars = wt_mean_par; 

% number of new parameters to estimate
% 4 for wt and NOS ko
% 2 for mo 
npars_est = 3; 

% number of equations
% 7 for wt
% 6 for NOS ko
% 3 for mo
n_var = 7; 

% where the data will be saved
file_prefix = 'wt_mean';

 % typically empty, but can be taken from some earlier fitting
init_par = [];
fit_uv_av_inrgw(fixed_pars,to_fit,init_par,npars_est,n_var,file_prefix); 

%% get fitted parameters

wt_mean_rgw_pareto=importdata([file_prefix '_RGW.mat']);
obj_val=wt_mean_rgw_pareto.fval;
[~,idx_min_euc]=min(sqrt(sum(obj_val.^2,2)));
wt_mean_rgw_par=wt_mean_rgw_pareto.x(idx_min_euc,:);

%% plot fit and data
t_end=79.5;
frames = 0:0.5:t_end;

% when using the objective for simulations to_fit doesn't affect results
[~,C_RGW]=uv_av_mobj_inrgw(wt_mean_rgw_par,wt_mean_par,n_var,to_fit);

plot(frames,to_fit(41:200))
hold on
plot(frames,C_RGW)
 
