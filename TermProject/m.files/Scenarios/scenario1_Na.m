clc
clear all
close all

%This file shows how a variable head would effect the sodium 
%%concentration profile.

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
D = 4e-10;  %diffusion coefficient (m2/s)
Kd = 0.2; %linear partitioning coefficient (mL/g)
Cb = 3; %background concentration (mmol/L)
R = 1+((ro*Kd)/n);  %retardation coefficient(-)
z = 0:0.1:2.9;

t = [14 10];
C0 = 3454/23;
Cog = cfun(t(1),z,C0,Cb,R,D,compv);
Cog = cfun(t(2),z,C0,Cog,R,D,vC);


t = 0.5:0.5:14;
t = sort(t,'descend');
lh = [4.57 1.43];
hvals = [lh lh lh lh lh lh lh lh lh lh lh lh lh lh];
lC0 = [1642.31 5265.69]/23;
C0vals = [lC0 lC0 lC0 lC0 lC0 lC0 lC0 lC0 lC0 lC0 lC0 lC0 lC0 lC0];

%Calculation of seepage velocity
delH = hvals+3+2.9; %head difference (m)
delz = 3+2.9;   %distance (m)
qC = cKh*(delH/delz); %darcy flux (m/s)
vC = qC/n;    %seepage velocity (m/s)
compq = compKh*(delH/delz);
compv = compq/n;    %composite liner velocity using geometric mean

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
title('Sodium')
ylabel('Liner Height (m)')
xlabel('Concentration (mmol/L)')
legend('Using Biannual Variation','Using Average','location','southeast')