clc

pro = pro_Create();


fixed_p_min=[0.2001    0.0461    0.0917    3.2634   13.0155    0.0620];
fixed_p_max=[0.6258    0.3227    0.6349   13.9547   87.4424    0.4338];


for k=1:numel(fixed_p_min)
    pro = pro_AddInput(pro, @()pdf_Sobol([fixed_p_min(k) fixed_p_max(k)]), ['param' num2str(k)]);
end

load('../../../code_data_for_figures/NO_data.mat');
data = mean(NO_data(:,[1 3:11]),2);

tic
pro = pro_SetModel(pro, @(x)uv_av_no_gsat(x,data), 'model');
toc


pro.N = 200000;
tic,
pro = GSA_Init(pro);
toc,

clear Stot200k eStot200k Salpha200k Salpha200k

parfor k=1:numel(fixed_p_min)
    disp(k)
    tic,
    [Stot200k(k) eStot200k(k)] = GSA_GetTotalSy(pro, {k}, 1);
    toc,
end
%
parfor k=1:numel(fixed_p_min)
    disp(k)
    tic,
    [Salpha200k(k), eSalpha200k(k)] = GSA_GetSy(pro, {k}, 1);
    toc,
end

save no_Sobols Stot200k eStot200k Salpha200k eSalpha200k
