clc
clear all
close all

%This program will estimate the geomembrane failure time. This will be done
%by plotting different graphs for different geomembrane failure times and
%then determining the R2 coefficient.

%Soil Parameters
ro = 1.53;    %avg. dry density of the soil (g/cm3)
n = 0.38;   %avg. porosity of soil (-)
Cb = 5; %background chlorine concentration (mmol/L)
cKh = 2e-10; %hydaulic conductivity (m/s)

gKh = 1.1e-11;  %geomembrane hydaulic conductivity (m/s)

%Calculation of seepage velocity
delH = 3+3+2.9; %head difference (m)
delz =3+2.9;   %distance (m)
qC = cKh*(delH/delz); %darcyflux (m/s)
vC = qC/n;    %seepage velocity (m/s)

compKh = sqrt(cKh*gKh); %composite liner's Kh calculated using geometric mean
compq = compKh*(delH/delz);
compv = compq/n;    %composite liner velocity

%Chemical Parameters
D = 7e-10;  %diffusion coefficient (m2/s)
Kd = 0; %linear partitioning coefficient (mL/g)

R = 1+((ro*Kd)/n);  %retardation coefficient(-)

z = [2 1.7 1.7 1.6 1.4 1.25 1.2 1.2 1.1 0.9 0.85 0.85 0.8 0.7 0.65 0.6 ...
    0.45 0.4 0.4 0.3 0.3 0.25 0.05 0.05 0.05 0.05 0.05];    
CB = [5 6.5 5 6 6 5.5 8 5.5 7 9.5 12 8.5 9 11.5 10.5 13 12.5 11.5 12 12 ...
    11 11.5 10 11 10 11.5 10.5];    %Borehole Values

t = [14 9.5 4.5];   %inactive after 0 years
C0 = [251 608 510*0.8]/35.5;    %leachate concs. (mmol/L)
C(1,:)= cfun(t,z,C0,Cb,R,D,vC);

t = [14 10 9.5 4.5];	%inactive after 4 years
C0 = [251 251 608 510*0.8]/35.5;
C(2,:)= cfun(t(1),z,C0(1),Cb,R,D,compv);
C(2,:)= cfun(t(2:end),z,C0(2:end),C(2,:),R,D,vC);

t = [14 9.5 8 4.5]; %inactive after 6 years
C0 = [251 608 608 510*0.8]/35.5;
C(3,:)= cfun(t(1:2),z,C0(1:2),Cb,R,D,compv);
C(3,:)= cfun(t(3:end),z,C0(3:end),C(3,:),R,D,vC);

t = [14 9.5 6 4.5]; %inactive after 8 years
C0 = [251 608 608 510*0.8]/35.5;
C(4,:)= cfun(t(1:2),z,C0(1:2),Cb,R,D,compv);
C(4,:)= cfun(t(3:end),z,C0(3:end),C(4,:),R,D,vC);

%calculation of coefficient of determination
for i = 1:length(C(:,1))
    SSE = sum((CB-(C(i,:))).^2);
    SSyy = sum((CB-mean(CB)).^2);
    R2(i) = 1-SSE/SSyy;
end

%plotting profiles
L = max(z);
plot(C,L-z,CB,L-z,'x')
legend('0','4','6','8','Borehole Values','location','southeast')    

varNames = {'Inactive after','R2'};
T = table(['0 yrs';'4 yrs';'6 yrs';'8 yrs'],R2','VariableNames',varNames);
disp(T)