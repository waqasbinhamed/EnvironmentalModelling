clear all
close all
clc

v = 0.5;
C_0 = 80;
t = 0:700;
D = 1;  %calculated dispersion coefficient
x = [50 150];


for i = 1:length(x)
    %plotting C values at 50m and 150m
    for j = 1:length(t)
    C(i,j) = (C_0/2).*(erfc((x(i)-v.*t(j))./(2*sqrt(D.*t(j))))+exp((v.*x(i)/D))*...
    erfc((x(i)+v.*t(j))./(2*sqrt(D.*t(j)))));
    end
    plot(t,C(i,:))
    xlabel('time (days)')
    ylabel('Concentration (mg/L)')
    hold on
    
    %estimating time for C to reach 10mg/L at 50m and 150m
    diff = abs(C-10);
    for h = 1:length(t)
        if diff(i,h) == min(diff(i,:))
            %plotting C values closest to 10mg/L
            plot(t(h),C(i,h),'x')
            fprintf('Time for concentration to reach 10mg/L at %dm: %d days\n'...
                ,x(i), t(h))
        end
    end
end

legend('C at 50m','Estimate for C=10mg/L at 50m','C at 150m',...
    'Estimate for C=10mg/L at 150m','Location','southeast')