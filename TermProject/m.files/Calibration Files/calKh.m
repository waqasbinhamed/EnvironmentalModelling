clc
clear all
close all

%Calibration of Kh using their Chlorine predicted value for no geomembrane.

%Soil Parameters
ro = 1.53;    %avg. dry density of the soil (g/cm3)
n = 0.43;   %avg. porosity of soil (-)
Cb = 5; %background chlorine concentration (mmol/L)
Kh0 = 2e-10; %hydaulic conductivity (m/s)

%Calculation of seepage velocity
delH = 3+3+2.9; %head difference (m)
delz =3+2.9;   %distance (m)

%Chemical Parameters
D = 7e-10;  %diffusion coefficient (m2/s)
Kd = 0; %linear partitioning coefficient (mL/g)

R = 1+((ro*Kd)/n);  %retardation coefficient(-)

t = [14 9.5 4.5] ; %time (years)

C0 = [251 608 510*0.8];    %leachate concentrations(mg/L)
C0 = C0/35.5;	%(mmol/L)

z = [2.5 2.25 2 1.75 1.5 1.25 1 0.75 0.5 0.25 0];   
Cm = [5 5 5 5.5 6 8 9 11 12 13 12]; %their predicted values

cali = 0.5:0.1:1.5; %changing the value of Kh by these ratios
Kh = Kh0*cali;  %creating a row of Kh values

for i = 1:length(cali)  %loop for different Kh values
    
    q = Kh(i)*(delH/delz); %darcy flux (m/s)
    v = q/n;    %seepage velocity (m/s)

    C = cfun(t,z,C0,Cb,R,D,v);
    
    RMSE(i) = sqrt(mean((Cm-C).^2));
    deltaC = max(Cm)-min(Cm);
    CE(i) = RMSE(i)/deltaC*100; %calculating the error
    SSE = sum((Cm-C).^2);
    SSyy = sum((Cm-mean(Cm)).^2);
    R2(i) = 1-SSE/SSyy; %calculating the coeffecient of determination
end

varNames = {'Kh/Kh0','Kh','CE(%)','R2'};
T = table(cali',Kh',CE',R2','VariableNames',varNames);
disp(T)

    