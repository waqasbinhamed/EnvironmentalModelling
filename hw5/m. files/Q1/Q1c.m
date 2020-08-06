clc
clear all
close all

tspan = [0:0.5:120]; %time span
ci = [0 0 0 0]; %intial concentrations
[t,c] = ode45(@reactions,tspan,ci); %using ode45 to solve

%finding time to reach steady state
c = round(c,3);
for i = 1:length(t)
    if c(i,1)==c(end,1)&&c(i,2)==c(end,2)&&c(i,3)==c(end,3)&&c(i,4)==c(end,4)
        ss = i;
        break
    end
end

plot(t,c)
xlabel('Time (min)')
ylabel('Concentration (mg/L)')
legend('A1','B1','A2','B2','location','southeast')

fprintf('Time until steady state: %8.3f min\n', t(ss))
fprintf('Steady state concentration of A in Reactor 1: %8.3f mg/L\n', c(ss,1))
fprintf('Steady state concentration of B in Reactor 1: %8.3f mg/L\n', c(ss,2))
fprintf('Steady state concentration of A in Reactor 2: %8.3f mg/L\n', c(ss,3))
fprintf('Steady state concentration of B in Reactor 2: %8.3f mg/L\n', c(ss,4))
