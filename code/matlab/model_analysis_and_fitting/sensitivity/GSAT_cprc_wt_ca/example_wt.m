% clear
clc

pro = pro_Create();

fixed_p    =[34.5542    0.2500    0.9989    0.7532...
              0.9259    0.1211    1.0000    0.2029    28.7962 ...
              3.1782    0.5183    0.1042    0.6428     0.1010];

fixed_p_min=0.25*fixed_p;
fixed_p_max=1.75*fixed_p;

fixed_p_max([1 9 10])=35;
fixed_p_min([3 5 12 14])=0.1;
fixed_p_min(8)=0.2;

for k=1:numel(fixed_p)
    pro = pro_AddInput(pro, @()pdf_Sobol([fixed_p_min(k) fixed_p_max(k)]), ['param' num2str(k)]);
end

load('../../../code_data_for_figures/wt_ko_mo_data.mat');
data = mean(wt_cPRC.data(:,1:47),2);

tic
pro = pro_SetModel(pro, @(x)uv_av_wt_gsat(x,data), 'model');
toc

%%

clear Stot1k eStot1k Salpha100k eSalpha100k
pro.N = 1000;

pro = GSA_Init(pro);
%
%
parfor k=1:numel(fixed_p)
    disp(k)
    tic,
    [Stot1k(k) eStot1k(k)] = GSA_GetTotalSy(pro, {k}, 1);
    toc,
end
%%
save wt_Sobols Stot1k eStot1k

%%
pro.N = 100000;
tic,
pro = GSA_Init(pro);
toc,
%
parfor k=1:numel(fixed_p)
    disp(k)
    tic,
    [Salpha100k(k), eSalpha100k(k)] = GSA_GetSy(pro, {k}, 1);
    toc,
end
save wt_Sobols Stot1k eStot1k Salpha100k eSalpha100k
