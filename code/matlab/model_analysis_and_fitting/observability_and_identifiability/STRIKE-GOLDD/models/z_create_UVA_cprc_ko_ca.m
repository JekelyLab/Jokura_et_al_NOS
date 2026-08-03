clear;

% 3 states
syms u1 u2 u3
x = [u1; u2; u3];

% 1 output
h = u1;

% 1 known input
syms UV;
u = UV;

% 0 unknown inputs
w = [];

% 6 unknown parameters 
syms delta_C delta_2 delta_1 kappa_UV delta_S1 u2_0

p =[delta_C; delta_2; delta_1; kappa_UV; delta_S1; u2_0];

% dynamic equations
f = [u2 + kappa_UV*UV/(1 + delta_1 * u3) - delta_C * u1;
   - delta_2 * (u2 - u2_0) * u3;
     UV - delta_S1 * u3];

% initial conditions
ics  = []; 
known_ics = [1/delta_C, 1, 0];

save('UVA_cprc_ko_ca','x','p','h','f','u','w','ics','known_ics');

