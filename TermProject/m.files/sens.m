clc
clear all
close all

%This the file for sensitivity analysis. We have changed the parameters by
%a certian degree and compared their effect on the concentration profile of
%Sodium. To calcluate the concentration profiles the cfun.m file was used.

%Soil Parameters
ro = 1.53;    %avg. dry density of the soil (g/cm3)
n = 0.43;   %avg. porosity of soil (-)
Cb = 3; %background concentration (mmol/L)
Kh = 2e-10; %hydaulic conductivity (m/s)

%Calculation of seepage velocity
delH = 3+3+2.9; %head difference (m)
delz = 3+2.9;   %distance (m)
q = Kh*(delH/delz); %darcy flux (m/s)
v = q/n;    %seepage velocity (m/s)

%Chemical Parameters
D = 4e-10;  %diffusion coefficient (m2/s)
Kd = 0.2; %linear partitioning coefficient (mL/g)

R = 1+((ro*Kd)/n);  %retardation coefficient(-)

t = [14 9.5 4.5] ; %time (years)
z = 0:0.1:2.9;

C0 = [1425 3454 1640*0.8];    %leachate concentrations (mg/L)
C0 = C0/23;	%(mmol/L)

%Sensitivity Analysis
del = 0.2;  %20% change is parameter
fprintf("----- Sensitivity Analysis -----\n")
fprintf("The following parameters were increased by %d%%\n\n",del*100)

%Calculating sensitivity

%for soil parameters
fprintf("----- Soil Parameters -----\n")
sR = 1+(((ro*(1+del))*Kd)/n);
sensro = abs(((cfun(t,z,C0,Cb,sR,D,v)-cfun(t,z,C0,Cb,R,D,v))/...
    (cfun(t,z,C0,Cb,R,D,v))))*abs(ro/(del*ro));  %for dry density
fprintf("Sensitivity of dry density of soil: %8.2f%%\n",sensro*100)

sR = 1+(ro*Kd)/(n*(1+del));
sv = q/(n*(1+del));
sensn = abs(((cfun(t,z,C0,Cb,sR,D,sv)-cfun(t,z,C0,Cb,R,D,v))/...
    (cfun(t,z,C0,Cb,R,D,v))))*abs(ro/(del*ro));  %for porosity   
fprintf("Sensitivity of porosity of soil: %8.2f%%\n",sensn*100)

sq = (Kh*(1+del))*(delH/delz);
sv = q/n;
sensKh = abs(((cfun(t,z,C0,Cb,R,D,sv)-cfun(t,z,C0,Cb,R,D,v))/...
    (cfun(t,z,C0,Cb,R,D,v))))*abs(Kh/(del*Kh));  %for conductivity
fprintf("Sensitivity of hydraulic conductivity of soil: %8.2f%%\n\n",...
    sensKh*100)
    
%for chemical parameters
fprintf("----- Chemical Parameters -----\n")
sensD = abs(((cfun(t,z,C0,Cb,R,D*(1+del),v)-cfun(t,z,C0,Cb,R,D,v))/...
    (cfun(t,z,C0,Cb,R,D,v))))*abs(D/(del*D));    %for diffusion coefficient
fprintf("Sensitivity of diffusion coefficient of soil: %8.2f%%\n",...
sensD*100)

sR = 1+(ro*(Kd*(1+0.2)))/n;
sensKd = abs(((cfun(t,z,C0,Cb,sR,D,v)-cfun(t,z,C0,Cb,R,D,v))/...
    (cfun(t,z,C0,Cb,R,D,v))))*abs(Kd/(del*Kd));    %for distribution coefficient
fprintf("Sensitivity of partitioning coefficient of soil: %8.2f%%\n\n",...
    sensKd*100)


