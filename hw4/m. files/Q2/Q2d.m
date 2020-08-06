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
    
    %estimating time for C to reach steadt state at 50m and 150m
    for h = 1:length(t)
        if round(C(i,h),4) == round(max(C(i,:)),4)
            %plotting steady state C values
            plot(t(h),C(i,h),'x')
            fprintf('Time for concentration to reach steady state at %dm: %d days\n'...
                ,x(i), t(h))
            break
        end
    end
end

legend('C at 50m','Estimate for steady state C at 50m','C at 150m',...
    'Estimate for steady state C at 150m','Location','southeast')