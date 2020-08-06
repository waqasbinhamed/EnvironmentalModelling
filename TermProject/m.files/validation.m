clc
clear all
close all

%This the file for validation.
%Compares our calibrated model with the predicted concentration profile 
%in the article values to their predicted values. The Kd value for
%Potassium has been calibrated to make our model fit their values. To 
%calcluate the concentration profiles the cfun.m file was used.

%Soil Parameters
ro = 1.53;    %avg. dry density of the soil (g/cm3)
n = 0.43;   %avg. porosity of soil (-)
Kh = 2e-10; %hydaulic conductivity (m/s)
cL = 2.9;   %clay thickness (m)

%Calculation of seepage velocity
dH = 3+cL+3; %head difference (m)
dz =3+cL;   %distance (m)
q = Kh*(dH/dz); %darcyflux (m/s)
v = q/n;    %seepage velocity (m/s)

t = [14 9.5 4.5] ; %time (years)
z = [2.5 2.25 2 1.75 1.5 1.25 1 0.75 0.5 0.25 0];   %clay depth values


%Chemical Parameters for Chlorine
Cb = 5; %background concentration (mmol/L)
D = 7e-10;  %diffusion coefficient (m2/s)
Kd = 0; %linear partitioning coefficient (mL/g)
C0 = [251 608 510*0.8]/35.5;    %leachate concentrations(mmol/L)
R = 1+((ro*Kd)/n);  %retardation coefficient(-)

C_Cl = cfun(t,z,C0,Cb,R,D,v);   %calculating the sodium concentration profile

%Chemical Parameters for Sodium
Cb = 3; %background concentration (mmol/L)
D = 4e-10;  %diffusion coefficient (m2/s)
Kd = 0.2; %linear partitioning coefficient (mL/g)
C0 = [1425 3454 1640*0.8]/23;   %leachate concentrations(mmol/L)
R = 1+((ro*Kd)/n);  %retardation coefficient(-)

C_Na = cfun(t,z,C0,Cb,R,D,v); %calculating the sodium concentration profile

%Chemical Parameters for Potassium
Cb = 0.3; %background concentration (mmol/L)
D = 7e-10;  %diffusion coefficient (m2/s)
C0 = [78 252 156*0.8]/39;   %leachate concentrations(mmol/L)
Kd = 0.7;  %calibrated value (mL/g)
R = 1+((ro*Kd)/n);

C_K = cfun(t,z,C0,Cb,R,D,v); %calculating the sodium concentration profile

%The article's values for each chemical
CP_Cl = [5 5 5 5.5 6 8 9 11 12 13 12];
CP_Na = [2 2 2 2 3 6 13 31 62 80 60];
CP_K = [0.3 0.3 0.3 0.3 0.3 0.3 0.3 0.3 0.3 1.9 3.1];

%Creating plots
L = max(z)-z;
subplot(1,3,1)
plot(C_Cl,L,CP_Cl,L)
title('Chlorine')
ylabel('height (m)')
xlabel('concentration (mmol/L)')

subplot(1,3,2)
plot(C_Na,L,CP_Na,L)
title('Sodium')
ylabel('height (m)')
xlabel('concentration (mmol/L)')

subplot(1,3,3)
plot(C_K,L,CP_K,L)
title('Potassium')
ylabel('height (m)')
xlabel('concentration (mmol/L)')
legend('Simulated','Article''s data','location','southeast')

%Calculating and reporting the error
RMSE_Cl = sqrt(mean((CP_Cl-C_Cl).^2))/(max(CP_Cl)-min(CP_Cl));
RMSE_Na = sqrt(mean((CP_Na-C_Na).^2))/(max(CP_Na)-min(CP_Na));
RMSE_K = sqrt(mean((CP_K-C_K(1,:)).^2))/(max(CP_K)-min(CP_K));

fprintf('The Chlorine concentration error:%8.2f%%\n', RMSE_Cl*100)
fprintf('The Sodium concentration error:%8.2f%%\n', RMSE_Na*100)
fprintf('The Potassium concentration error:%8.2f%%\n'...
    , RMSE_K*100)
