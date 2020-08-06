clc
clear all
close all

%This program will ask for the required variables and calculate the
%concentration. The concentration values will be plotted against the depth
%of liner.

%Soil Parameters
ro = 1.53;    %avg. dry density of the soil (g/cm3)
n = 0.43;   %avg. porosity of soil (-)
Cb = 0.3; %background chlorine concentration (mmol/L)
cKh = 2e-10; %hydaulic conductivity (m/s)
gKh = 1.1e-11;  %geomembrane hydaulic conductivity (m/s)

%Calculation of seepage velocity
delH = 3+3+2.9; %head difference (m)
delz =3+2.9;   %distance (m)
qC = cKh*(delH/delz); %darcyflux (m/s)
vC = qC/n;    %seepage velocity (m/s)

compKh = sqrt(cKh*gKh);
compq = compKh*(delH/delz);
compv = compq/n;    %composite liner velocity using geometric mean

%Chemical Parameters
D = 7e-10;  %diffusion coefficient (m2/s)
Kd = 0.7; %linear partitioning coefficient (mL/g)

R = 1+((ro*Kd)/n);  %retardation coefficient(-)

z = [1.95 1.75 1.7 1.6 1.6 1.45 1.4 1.3 1.2 1.2 1.1 0.9 0.85 0.8 0.7 ...
    0.7 0.6 0.5 0.4 0.4 0.4 0.35 0.3 0.25 0.25 0.05 0.05 0.05 0.05 0.05];
CB = [0.2 0.25 0.3 0.2 0.3 0.3 0.3 0.3 0.3 0.3 0.2 0.3 0.3 0.6 0.2 0.4 ...
    0.5 0.7 0.5 0.3 0.5 0.7 0.8 0.3 0.5 1.5 1.1 0.9 1.3 0.9];   %Borehole Values

t = [14 9.5 4.5];   %ex = 0
C0 = [78 252 156*0.8]/39;
C(1,:)= cfun(t,z,C0,Cb,R,D,vC);

t = [14 10 9.5 4.5];   %ex = 4
C0 = [78 78 252 156*0.8]/39;
C(2,:)= cfun(t(1),z,C0(1),Cb,R,D,compv);
C(2,:)= cfun(t(2:end),z,C0(2:end),C(2,:),R,D,vC);

t = [14 9.5 8 4.5];   %ex = 6
C0 = [78 252 252 156*0.8]/39;
C(3,:)= cfun(t(1:2),z,C0(1:2),Cb,R,D,compv);
C(3,:)= cfun(t(3:end),z,C0(3:end),C(3,:),R,D,vC);

for i = 1:length(C(:,1))
    SSE = sum((CB-(C(i,:))).^2);
    SSyy = sum((CB-mean(CB)).^2);
    R2(i) = 1-SSE/SSyy;
end

L = max(z);
plot(C,L-z,CB,L-z,'x')
legend('0','4','6','Borehole Values','location','southeast')    

varNames = {'Inactive after','R2'};
T = table(['0 yrs';'4 yrs';'6 yrs'],R2','VariableNames',varNames);
disp(T)