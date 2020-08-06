function res = bc(C0,CL)

D = 4500;    %dispersion coefficient in m^2/hr
v = 75; %velocity in m/hr
Cin = 85;   %inflow concentration in mol/L

res(1) = v*Cin-v*C0(1)+D*C0(2);
res(2) = CL(2);

res = res(:);