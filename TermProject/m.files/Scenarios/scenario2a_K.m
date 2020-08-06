clc
clear all
close all

%This file shows how an increase or decrease in head would affect the
%concetration profile of chlorine.

%Soil Parameters
ro = 1.53;    %avg. dry density of the soil (g/cm3)
n = 0.43;   %avg. porosity of soil (-)
cKh = 2e-10; %hydaulic conductivity (m/s)
gKh = 1.1e-11;  %geomembrane hydaulic conductivity (m/s)
cL = 2.9;   %clay thickness in m.
compKh = sqrt(cKh*gKh);

%Chemical Parameters
D = 7e-10;  %diffusion coefficient (m2/s)
Kd = 0.7; %linear partitioning coefficient (mL/g)
Cb = 0.3*39; %soil's background chlorine concentration (mg/L)
R = 1+((ro*Kd)/n);  %retardation coefficient(-)

z = 0:0.1:cL;

L = max(z)-z;

lhvals = [1 3 6 20];
for i = 1:length(lhvals)
    
    lh = lhvals(i);
    %Calculation of seepage velocity
    delH = 3+cL+lh; %head difference (m)
    delz = 3+cL;   %distance (m)
    q = cKh*(delH/delz); %darcyflux (m/s)
    vC = q/n;    %seepage velocity (m/s)
    compq = compKh*(delH/delz);
    compv = compq/n;    %composite liner velocity using geometric mean
    
    t = [14 9.5 4.4];
    C0 = [78 252 156*0.8];
    C_ng(i,:) = cfun(t,z,C0,Cb,R,D,vC);
    C_nf(i,:) = cfun(t,z,C0,Cb,R,D,compv);

    t = [14 10 9.5 4.4];
    C0 = [78 252 252 156*0.8];
    C_f(i,:)= cfun(t(1),z,C0(1),Cb,R,D,compv);
    C_f(i,:)= cfun(t(2:end),z,C0(2:end),C_f(i,:),R,D,vC);

end
subplot(1,3,1)
plot(C_ng,L)
xlabel('Conc. (mg/L)')
ylabel('Liner Height (m)')
title('No Geomembrane')

subplot(1,3,2)
plot(C_f,L)
xlabel('Conc. (mg/L)')
ylabel('Liner Height (m)')
title('Fails after 4 yrs')

subplot(1,3,3)
plot(C_nf,L)
xlabel('Conc. (mg/L)')
ylabel('Liner Height (m)')
title('Never fails')
legend('1 m','3 m','6 m','20 m','location','southeast')

