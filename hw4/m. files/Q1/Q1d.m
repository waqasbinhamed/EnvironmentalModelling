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

%Using the generalized least square method for Pe estimates
Z = [ones(size(Pe)) log(wd)];
E = (Z'*Z)\(Z'*log(wd));
PeE = E(2)*log(wd) + E(1);

%Using the 2nd order polynomial for Pe estimates
pPoly=polyfit(wd,Pe,2);
PeE1 = pPoly(1).*(wd.^2)+pPoly(2).*wd+pPoly(3);

%Using the power function for Pe estimates
pPow=polyfit(log(wd),log(Pe),1);
PeE2 = exp(pPow(2)).*((wd).^pPow(1));

%Using the exponential for Pe estimates
pExp=polyfit(wd,log(Pe),1);
PeE3 = exp(pExp(2)).*exp(pExp(1).*wd);

subplot(2,2,1)
plot(wd,PeE,'-',wd,Pe,'o'); %plotting for generalized least square method
title('Generalized Least Square')
xlabel('wd')
ylabel('Pe')
subplot(2,2,2)
plot(wd,PeE1,'-',wd,Pe,'o');    %plotting for 2nd order polynomial
title('2nd Order Polynomial')
xlabel('wd')
ylabel('Pe')
subplot(2,2,3)
plot(wd,PeE2,'-',wd,Pe,'o');    %plotting for power function
title('Power Function')
xlabel('wd')
ylabel('Pe')
subplot(2,2,4)
plot(wd,PeE3,'-',wd,Pe,'o');    %plotting for exponential function
title('Exponential Function')
xlabel('wd')
ylabel('Pe')