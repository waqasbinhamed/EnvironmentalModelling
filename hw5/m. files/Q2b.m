clc
clear all
close all

k1 = 0.56;  %NH3 to NO2
k2 = 0.28;  %NO2 to NO3

cin = [130 10 5];   %in mg/L

Q = 300;    %flowrate in L/hr
Q = Q*0.001;    %in m^3/hr

dia = [20 30 50]; %diameters in cm
dia = dia*0.01; %in m

xspan = [0:0.5:100];    %length values in m

for i = 1:length(dia)
    
    A = pi*(dia(i)/2)^2;    %cross sectional area in m^2
    
    %function to solve mass balances
    f = @(x,c) [k1*c(1)*(-A/Q);(k2*c(2)-k1*c(1))*(-A/Q);-k2*c(2)*(-A/Q)];
    [x,c] = ode45(f,xspan,cin);
    
    %plotting time vs concentrations
    subplot(3,1,i)
    plot(x,c)
    hold on
    plot(x,ones(length(x))*(c(1)*0.05),'r:','LineWidth',2)
    title(sprintf('Diameter = %d cm',dia(i)*100))
    xlabel('Time (hr)')
    ylabel('Conc. (mg/L)')
    legend('NH_3','NO_2','NO_3','location','east')
end