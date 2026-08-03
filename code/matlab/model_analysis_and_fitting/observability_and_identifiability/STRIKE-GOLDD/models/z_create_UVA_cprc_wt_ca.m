clear;

% 11 states
syms u1 u2 u3 u4 u5 u6 u7 u8 u9 u10 u11
x = [u1; u2; u3; u4; u5; u6; u7; u8; u9; u10; u11];

% 3 output
h = [u1; u4; u5]; % Ca cPRC, Ca INNOS, Ca NO

% 1 known input
syms UV;
u = UV;

% 0 unknown inputs
w = [];

% 26 unknown parameters 
syms delta_C delta_2 delta_1 kappa_UV kappa_2 delta_S1 u2_0 ...
     kappa_4 delta_4 kappa_5_1 delta_5 kappa_5_2 ...
     kappa_6 delta_6 kappa_7 delta_7 kappa_8 k9_1 k9_2 delta_9 ...
     kappa_g1_1 kappa_g1_2 kappa_10 delta_10 kappa_11 delta_11 

p =[delta_C; delta_2; delta_1; kappa_UV; kappa_2; delta_S1; u2_0; ...
    kappa_4; delta_4; kappa_5_1; delta_5; kappa_5_2; ...
    kappa_6; delta_6; kappa_7; delta_7; kappa_8; k9_1; k9_2; delta_9; ...
    kappa_g1_1; kappa_g1_2; kappa_10; delta_10; kappa_11; delta_11];

% dynamic equations
f = [u2 + kappa_g1_2 * u9 + (kappa_UV + kappa_g1_1 * u7)*UV/(1 + delta_1 * u3) - delta_C * u1;
   - delta_2 * (u2 - u2_0) * u3 + kappa_2 * u9^2* (1 - u2);
     UV - delta_S1 * u3;
     1 + kappa_4 * u3 - delta_4 * u4;
     (kappa_5_1 * (u4 - 1/delta_4))/(kappa_5_2 + (u4 - 1/delta_4)) - delta_5 * u5;
     kappa_6 * u5 - delta_6 * u6;     
     kappa_7 * u6 - delta_7 * u7;  
    -k9_1 * u8 * u10^2/(1 + k9_2*u10^2) + kappa_8 * (1 - u8);
     k9_1 * u8 * u10^2/(1 + k9_2*u10^2) - delta_9 * u9;
     kappa_10 * u11 - delta_10 * u10;
     kappa_11 * u6 - delta_11 * u11;];

% initial conditions
ics  = []; 
known_ics = [1/delta_C, 1, 0, 1/delta_4, 0, 0, 0, 1, 0, 0, 0];

save('UVA_cprc_wt_ca','x','p','h','f','u','w','ics','known_ics');

