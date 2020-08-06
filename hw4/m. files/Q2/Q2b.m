clear all
close all
clc

v = 0.5;
C_0 = 80;
t = 0:700;
D = 1;  %calculated dispersion coefficient
x = [50 150];

%plotting C values at 50m and 150m
for i = 1:length(x)
    for j = 1:length(t)
    C(i,j) = (C_0/2).*(erfc((x(i)-v.*t(j))./(2*sqrt(D.*t(j))))+exp((v.*x(i)/D))*...
    erfc((x(i)+v.*t(j))./(2*sqrt(D.*t(j)))));
    end
    plot(t,C(i,:))
    xlabel('time (days)')
    ylabel('Concentration (mg/L)')
    hold on
end

legend('At 50m','At 150m')