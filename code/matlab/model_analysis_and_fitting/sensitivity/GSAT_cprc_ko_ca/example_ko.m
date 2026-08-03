% clear
clc

pro = pro_Create();

fixed_p_min=[0.1460    0.0127    0.3949    0.1538    0.2000    0.1657];
fixed_p_max=[1.0216    0.0887    2.7643    1.0766    0.6258    0.9651];


for k=1:numel(fixed_p_min)
    pro = pro_AddInput(pro, @()pdf_Sobol([fixed_p_min(k) fixed_p_max(k)]), ['param' num2str(k)]);
end

load('../../../code_data_for_figures/wt_ko_mo_data.mat');
data = mean(ko_cPRC.data,2);

tic
pro = pro_SetModel(pro, @(x)uv_av_ko_gsat(x,data), 'model');
toc


pro.N = 200000;
tic,
pro = GSA_Init(pro);
toc,
%
clear Stot200k eStot200k Salpha200k eSalpha200k

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

save ko_Sobols Stot200k eStot200k Salpha200k eSalpha200k
