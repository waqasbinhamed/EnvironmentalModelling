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

%Using the generalized least square method
Z = [ones(size(Pe)) log(wd)];
a = (Z'*Z)\(Z'*log(wd));

fprintf('Alpha:%8.4f\n', a(1))
fprintf('Beta:%8.4f\n', a(2))

PeE = a(1)+a(2)*log(wd);    %Pe estimates  calculation
dif = Pe - PeE; %difference between calculated and estimated Pe values
MQE = sqrt(sum(dif.*dif))/10;   %MQE calculation
fprintf('Mean Quadratic Error:%8.4f\n', MQE)
