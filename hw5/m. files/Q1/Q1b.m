clc
clear all
close all

tspan = [0:10]; %time span
ci = [0 0 0 0]; %intial concentrations
[t,c] = ode45(@reactions,tspan,ci); %using ode45 to solve

%plotting time vs concentration 
plot(t,c)
xlabel('Time (min)')
ylabel('Concentration (mg/L)')
legend('A1','B1','A2','B2','location','southeast')

%creating table for concentrations in first 10 mins
varN = {'Time (min)','A1 (mg/L)','B1 (mg/L)','A2 (mg/L)','B2 (mg/L)'};
T = table(t,c(:,1),c(:,2),c(:,3),c(:,4),'VariableNames',varN);
disp(T)

fprintf('Concentration of A in Reactor 1: %8.4f mg/L\n', c(end,1))
fprintf('Concentration of B in Reactor 1: %8.4f mg/L\n', c(end,2))
fprintf('Concentration of A in Reactor 2: %8.4f mg/L\n', c(end,3))
fprintf('Concentration of B in Reactor 2: %8.4f mg/L\n', c(end,4))
