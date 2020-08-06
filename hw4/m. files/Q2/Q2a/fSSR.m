%function for optimizing longitudinal dispersion coefficient
function f = fSSR(D,t,C_50)
v = 0.5;
C_0 = 80;
x = 50;

C = (C_0/2).*(erfc((x-v.*t)./(2*sqrt(D.*t)))+exp((v.*x)/D)*...
    erfc((x+v.*t)./(2*sqrt(D.*t))));
f = sum(sqrt(C_50-C));
end
