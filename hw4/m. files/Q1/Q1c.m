clc
clear all
close all
format short g

v = [0.715 0.14 0.372 0.368 0.824  0.309 0.41 0.301 1.01 0.608];
d = [0.335 0.512 0.268 0.130 0.264 0.338 0.268 0.105 0.227 0.123];
w = [13.6 2.23 10.8 1.2 11.1 8.83 10 5 6.8 21.5];
L_y = [605 3.83 379 15.9 575 201 382 191 322 817];
D_x = [29.5 0.0771 9.83 0.652 31.9 4.91 11 3.72 24.6 20.8];

Pe = ((L_y.*v)./D_x)';  %Peclet number calculation
wd = (w./d)';   %mean depth ratio calculation

%Finding coefficients for 2nd order polynomial
pPoly=polyfit(wd,Pe,2);
%calculating MQE for 2nd order polynomial
PeE1 = pPoly(1).*(wd.^2)+pPoly(2).*wd+pPoly(3);
dif1 = Pe - (PeE1);
MQE_Poly = sqrt(sum(dif1.*dif1))/10;
fprintf('MQE for 2nd Order Polynomial:%8.4f\n', MQE_Poly)

%Finding coefficients for power function
pPow=polyfit(log(wd),log(Pe),1);
%calculating MQE for power function
PeE2 = exp(pPow(2)).*((wd).^pPow(1));
dif2 = Pe - (PeE2);
MQE_Pow = sqrt(sum(dif2.*dif2))/10;
fprintf('MQE for Power function:%8.4f\n', MQE_Pow)

%Finding coefficients for exponential function
pExp=polyfit(wd,log(Pe),1);
%calculating MQE for exponential function
PeE3 = exp(pExp(2)).*exp(pExp(1).*wd);
dif3 = Pe - (PeE3);
MQE_Exp = sqrt(sum(dif3.*dif3))/10;
fprintf('MQE for Exponential function:%8.4f\n', MQE_Exp)






