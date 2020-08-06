clc
clear all
close all

%This file is to asses the effect of biannual variation of leachate height
%and concentration based on the precipitation data for site.

%Soil Parameters
ro = 1.53;    %avg. dry density of the soil (g/cm3)
n = 0.38;   %avg. porosity of soil (-)
cKh = 2e-10; %hydaulic conductivity (m/s)
gKh = 1.1e-11;  %geomembrane hydaulic conductivity (m/s)
compKh = sqrt(cKh*gKh);

%Calculation of seepage velocity
delH = 3+3+2.9; %head difference (m)
delz = 3+2.9;   %distance (m)
qC = cKh*(delH/delz); %darcyflux (m/s)
vC = qC/n;    %seepage velocity (m/s)
compq = compKh*(delH/delz);
compv = compq/n;    %composite liner velocity using geometric mean

%Chemical Parameters
D = 7e-10;  %diffusion coefficient (m2/s)
Kd = 0; %linear partitioning coefficient (mL/g)
Cb = 5; %background chlorine concentration (mmol/L)
R = 1+((ro*Kd)/n);  %retardation coefficient(-)
z = 0:0.1:2.9;

t = [14 10];    %time (yrs)
C0 = 608/35.5; %leachate concetration
%creating concentration profile for normal case
Cog = cfun(t(1),z,C0,Cb,R,D,compv);
Cog = cfun(t(2),z,C0,Cog,R,D,vC);

% calculation of concentration profiles considering the biannual variation
t = 0.5:0.5:14;
t = sort(t,'descend');
lh = [4.57 1.43];   %leachate height values
hvals = [lh lh lh lh lh lh lh lh lh lh lh lh lh lh];
lC0 = [289.09 926.91]/35.5; %leachate concentration values
C0vals = [lC0 lC0 lC0 lC0 lC0 lC0 lC0 lC0 lC0 lC0 lC0 lC0 lC0 lC0];

%Calculation of seepage velocity
delH = hvals+3+2.9; %head difference (m)
delz = 3+2.9;   %distance (m)
qC = cKh*(delH/delz); %darcy flux (m/s)
vC = qC/n;    %seepage velocity (m/s)
compq = compKh*(delH/delz);
compv = compq/n;    %composite liner velocity using geometric mean

%creating the concentration profile for the variable case
for i = 1:length(t)
    if t(i) > 10
        Cprec(i,:)= cfun(t(i),z,C0vals(i),Cb,R,D,compv(i));
    else
        Cprec(i,:)= cfun(t(i),z,C0vals(i),Cb,R,D,vC(i));
    end
    Cb = Cprec(i,:);
    
end
Cprec = Cprec(end,:);

L = max(z)-z;
plot(Cprec, L,Cog, L)
title('Chlorine')
ylabel('Liner Height (m)')
xlabel('Concentration (mmol/L)')
legend('Using Biannual Variation','Using Average','location','southeast')

