clear;

% 2 states
syms u3 u4
x = [u3; u4];

% 1 outputs
h = u4;

% 1 known input
syms UV;
u = UV;

% 0 unknown inputs
w = [];

% 3 unknown parameters 
syms delta_S1 kappa_4 delta_4

p =[delta_S1; kappa_4; delta_4];

% dynamic equations
f = [UV - delta_S1 * u3;
     1 + kappa_4 * u3 - delta_4 * u4];

% initial conditions
ics  = []; 
known_ics = [0, 1/delta_4];

save('UVA_innos_ca','x','p','h','f','u','w','ics','known_ics');

