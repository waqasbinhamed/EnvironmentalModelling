clear all
close all
clc

v = 0.5;
C_0 = 80;
x = 50;
t = 0:100:700;
C_50 = [0,40,59.6 69 73 76 77.5 78.5];

%using fuction fSSR.m to calculate D
D = fminsearch(@fSSR,1,[],t,C_50);
fprintf('The longitudinal dispersion coefficient(m^2/day): %8.4f\n',D)

%using D value to calculate C values at 50m
C = (C_0/2).*(erfc((x-v.*t)./(2*sqrt(D.*t)))+exp((v.*x)/D)*...
    (erfc((x+v.*t)./(2*sqrt(D.*t)))));
%calculating MQE using given and calculated C values at 50m
dif = C-C_50;
MQE = sqrt(sum(dif.*dif))/length(t);
fprintf('MQE: %8.4f\n',MQE)
