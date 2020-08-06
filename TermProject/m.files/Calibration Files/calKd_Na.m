clc
clear all
close all

%Calibration of Kd for Sodium using their Sodium predicted values for 
%no geomembrane.

%Soil Parameters
ro = 1.53;    %avg. dry density of the soil (g/cm3)
n = 0.43;   %avg. porosity of soil (-)
Cb = 0.3; %background chlorine concentration (mmol/L)
Kh = 2e-10; %hydaulic conductivity (m/s)

%Calculation of seepage velocity
delH = 3+3+2.9; %head difference (m)
delz =3+2.9;   %distance (m)
q = Kh*(delH/delz); %darcy flux (m/s)
v = q/n;    %seepage velocity (m/s)

%Chemical Parameters
D = 4e-10;  %diffusion coefficient (m2/s)
Kd0 = 0.2; %linear partitioning coefficient (mL/g)

t = [14 9.5 4.5] ; %time (years)

C0 = [1425 3454 1640*0.8]/23;   %leachate concentrations(mmol/L)

%the article's predicted values
z = [2.5 2.25 2 1.75 1.5 1.25 1 0.75 0.5 0.25 0]; 
CP_Na = [2 2 2 2 3 6 13 31 62 80 60];


cali = 0.5:0.1:2; %changing the value of Kd by these ratios
Kd = Kd0*cali;  %creating a row of Kd values

for i = 1:length(cali)  %loop for different Kd values
    
    R = 1+((ro*Kd(i))/n);  %retardation coefficient(-)
    C = cfun(t,z,C0,Cb,R,D,v);
    
    RMSE(i) = sqrt(mean((CP_K-C).^2));
    deltaC = max(CP_K)-min(CP_K);
    CE(i) = (RMSE(i)/deltaC)*100;   %calculating the error
    SSE = sum((CP_K-C).^2);
    SSyy = sum((CP_K-mean(CP_K)).^2);
    R2(i) = 1-SSE/SSyy; %calculating the coeffecient of determination
end

% displaying table
fprintf('For Sodium\n\n')
varNames = {'Kd/Kd0','Kd','CE(%)','R2'};
T1 = table(cali',Kd',CE',R2','VariableNames',varNames);
disp(T1)



    