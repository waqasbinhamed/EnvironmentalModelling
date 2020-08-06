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

%Chemical Parameters for Chlorine
D = 7e-10;  %diffusion coefficient (m2/s)
Kd = 0; %linear partitioning coefficient (mL/g)
Cb = 5*35.5; %soil's background chlorine concentration (mg/L)
Cl_L = 250; %limit (mg/L)
R = 1+((ro*Kd)/n);  %retardation coefficient(-)

z = 0:0.1:cL; %depth values

L = max(z)-z;

lhvals = [1 3 6 20];    %leachate height values
for i = 1:length(lhvals)    %looping over the leachate height values
    
    lh = lhvals(i);
    %Calculation of seepage velocity
    delH = 3+cL+lh; %head difference (m)
    delz = 3+cL;   %distance (m)
    q = cKh*(delH/delz); %darcyflux (m/s)
    vC = q/n;    %seepage velocity (m/s)
    compq = compKh*(delH/delz);
    compv = compq/n;    %composite liner velocity using geometric mean
    
    t = [14 9.5 4.5];   %time(years)
    C0 = [251 608 510*0.8]; %leachate conc. (mg/L)
    C_ng(i,:) = cfun(t,z,C0,Cb,R,D,vC); %conc. profile for no geomembrane
    C_nf(i,:) = cfun(t,z,C0,Cb,R,D,compv);  %conc. profile for no geomembrane failure

    t = [14 10 9.5 4.5];
    C0 = [251 251 608 510*0.8];
    %conc. profile for failure after 4 years
    C_f(i,:)= cfun(t(1),z,C0(1),Cb,R,D,compv);
    C_f(i,:)= cfun(t(2:end),z,C0(2:end),C_f(i,:),R,D,vC);

end

%plotting the concentration profiles
subplot(1,3,1)
plot(C_ng,L)
hold on
plot(Cl_L*ones(length(z),1)',L,':','LineWidth',1.5)
xlabel('Conc. (mg/L)')
ylabel('Liner Height (m)')
title('No Geomembrane')

subplot(1,3,2)
plot(C_f,L)
hold on
plot(Cl_L*ones(length(z),1)',L,':','LineWidth',1.5)
xlabel('Conc. (mg/L)')
ylabel('Liner Height (m)')
title('Fails after 4 yrs')

subplot(1,3,3)
plot(C_nf,L)
hold on
plot(Cl_L*ones(length(z),1)',L,':','LineWidth',1.5)
xlabel('Conc. (mg/L)')
ylabel('Liner Height (m)')
title('Never fails')
legend('1 m','3 m','6 m','20 m','Limit','location','southeast')

