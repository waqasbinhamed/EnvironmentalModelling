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

fprintf('The required volumes for 95%% NH3 removal:\n')
for i = 1:length(dia)
    
    A = pi*(dia(i)/2)^2;    %cross sectional area in m^2
    
    %function to solve mass balances
    f = @(x,c) [k1*c(1)*(-A/Q);(k2*c(2)-k1*c(1))*(-A/Q);-k2*c(2)*(-A/Q)];
    [x,c] = ode45(f,xspan,cin);

    %finding required volumes
    for j = 1:length(x)
        if cin(1)*0.05 > c(j,1)
            v(i) = A*x(j);
            break
        end
    end
    
    fprintf('For %d cm diameter: %8.4f m^3\n',dia(i)*100,v(i))
end

%selecting design scenario
for k = 1:length(v)
    if v(k)==min(v)
        fprintf('The design diameter: %d cm\n',dia(k)*100)
        fprintf('The design volume: %8.4f m^3\n',v(k))
    end
end