function dCdx = bvp(x,C)

D = 4500;    %dispersion coefficient in m^2/hr
v = 75; %velocity in m/hr
k = 1.5;    %reaction rate in hr^-1

%C(1) = C
%C(2) = C'

dCdx(1) = C(2);
dCdx(2) = (v/D)*C(2)+(k/D)*C(1);

dCdx = dCdx(:);