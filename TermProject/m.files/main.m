clc
clear all
close all

%This is the main program file for plotting the concentration profiles of
%the 3 chemical in the compacted clay layer.

%Soil Parameters
ro = 1.53;    %avg. dry density of the soil (g/cm3)
n = 0.43;   %avg. porosity of soil (-)
Kh = 2e-10; %hydaulic conductivity (m/s)
cL = 2.9;   %clay thickness (m)

%Calculation of seepage velocity
dH = 3+cL+3; %head difference (m)
dz =3+cL;   %distance (m)
q = Kh*(dH/dz); %darcy flux (m/s)
v = q/n;    %seepage velocity (m/s)

t = [14 9.5 4.5] ; %time (years)
z = 0:0.1:cL;   %clay depth values (m)
z = sort(z,'descend');

%Chemical Parameters for Chlorine
Cb = 5; %intial soil concentration (mmol/L)
D = 7e-10;  %diffusion coefficient (m2/s)
Kd = 0; %linear partitioning coefficient (mL/g)
C0 = [251 608 510*0.8]/35.5;    %leachate concentrations(mmol/L)
R = 1+((ro*Kd)/n);  %retardation coefficient(-)

C_Cl = cfun(t,z,C0,Cb,R,D,v);   %calculating the chlorine concentration profile

%Chemical Parameters for Sodium
Cb = 3; %intial soil concentration (mmol/L)
D = 4e-10;  %diffusion coefficient (m2/s)
Kd = 0.2; %linear partitioning coefficient (mL/g)
C0 = [1425 3454 1640*0.8]/23;   %leachate concentrations(mmol/L)
R = 1+((ro*Kd)/n);  %retardation coefficient(-)

C_Na = cfun(t,z,C0,Cb,R,D,v);   %calculating the sodium concentration profile

%Chemical Parameters for Potassium
Cb = 0.3;   %intial soil concentration (mmol/L)
D = 7e-10;  %diffusion coefficient (m2/s)
Kd = 7; %linear partitioning coefficient (mL/g)
C0 = [78 252 156*0.8]/39;   %leachate concentrations(mmol/L)
R = 1+((ro*Kd)/n);  %retardation coefficient(-)

C_K = cfun(t,z,C0,Cb,R,D,v);    %calculating the potassium concentration profile

L = cL-z;
subplot(1,3,1)
plot(C_Cl,L)
title('Chlorine')
ylabel('Height (m)')
xlabel('Concentration (mmol/L)')

subplot(1,3,2)
plot(C_Na,L)
title('Sodium')
ylabel('Height (m)')
xlabel('Concentration (mmol/L)')

subplot(1,3,3)
plot(C_K,L)
title('Potassium')
ylabel('Height (m)')
xlabel('Concentration (mmol/L)')