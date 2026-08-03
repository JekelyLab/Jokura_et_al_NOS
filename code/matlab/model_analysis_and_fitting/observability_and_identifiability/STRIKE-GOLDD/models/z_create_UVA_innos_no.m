clear;

% 6 states
syms u3 u4 u5
x = [u3; u4; u5];

% 2 outputs
h = [u4, u5];

% 1 known input
syms UV;
u = UV;

% 0 unknown inputs
w = [];

% 6 unknown parameters 
syms delta_S1 kappa_4 delta_4 kappa_5_1 kappa_5_2 delta_5

p =[delta_S1; kappa_4; delta_4; kappa_5_1; kappa_5_2; delta_5];

% dynamic equations
f = [UV - delta_S1 * u3;
     1 + kappa_4 * u3 - delta_4 * u4;
     (kappa_5_1 * (u4 - 1/delta_4))/(kappa_5_2 + (u4 - 1/delta_4)) - delta_5 * u5;];

% initial conditions
ics  = []; 
known_ics = [0, 1/delta_4 0];

save('UVA_innos_no','x','p','h','f','u','w','ics','known_ics');

