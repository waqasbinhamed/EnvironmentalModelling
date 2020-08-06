clc
clear all
close all

%This file to calculate what is the maximum allowable height of leachate
%before concentration would negatively effect the concentration of chlorine 
%in the aquifer.

%The quality standards are the ones mentioned in the article.
cL = 2.9;   %clay thickness in m.
Kh = 2e-10;  %conductivity in m/s.
t = 14; %design period in years.

%Soil Parameters
ro = 1.53;    %avg. dry density of the soil (g/cm3)
n = 0.43;   %avg. porosity of soil (-)
cKh = 2e-10; %hydaulic conductivity (m/s)
gKh = 1.1e-11;  %geomembrane hydaulic conductivity (m/s)
compKh = sqrt(cKh*gKh);

%Chemical Parameters for Chlorine
D = 7e-10;  %diffusion coefficient (m2/s)
Kd = 0; %linear partitioning coefficient (mL/g)
C0 = 608;   %max conc. mentioned in the article (mg/L)
Cb = 5*35.5; %soil's background chlorine concentration (mg/L)
Cl_L = 250; %limit (mg/L)
R = 1+((ro*Kd)/n);  %retardation coefficient(-)

z = 0:0.1:cL;
%intializing concentration profiles
C_f = ones(length(z),1)';
C_ng = ones(length(z),1)';
C_nf = ones(length(z),1)';
lh = 0.1;   %intial leachate height value

i = 1; %values of counters
j = 1;
k = 1;
L = max(z)-z;
while C_f(end) < Cl_L || C_ng(end) < Cl_L || C_nf(end) < Cl_L
    
    %Calculation of seepage velocity
    delH = 3+cL+lh; %head difference (m)
    delz = 3+cL;   %distance (m)
    q = Kh*(delH/delz); %darcyflux (m/s)
    vC = q/n;    %seepage velocity (m/s)
    compq = compKh*(delH/delz);
    compv = compq/n;    %composite liner velocity using geometric mean

    C_ng = cfun(14,z,C0,Cb,R,D,vC);
    if C_ng(end) > Cl_L && i == 1
        l_ng = lh;
        i = i + 1;
        
        subplot(1,3,1)
        plot(C_ng,L,Cl_L*ones(length(z),1)',L,':')
        title('No Geomembrane')  
        xlabel('Conc. (mg/L)')
        ylabel('Liner Height (m)')
    end
    
    C_f = cfun(14,z,C0,Cb,R,D,compv);
    C_f = cfun(10,z,C0,C_f,R,D,vC);
    if C_f(end) > Cl_L && j == 1
        l_f = lh;
        j = j + 1;
        
        subplot(1,3,2)
        plot(C_f,L,Cl_L*ones(length(z),1)',L,':')
        title('Fails at 4 years')  
        xlabel('Conc. (mg/L)')
        ylabel('Liner Height (m)')
    end

    C_nf = cfun(t,z,C0,Cb,R,D,compv);
    if C_nf(end) > Cl_L && k == 1
        l_nf = lh;
        k = k + 1;
        
        subplot(1,3,3)
        plot(C_nf,L,Cl_L*ones(length(z),1)',L,':')
        title('Never fails')  
        xlabel('Conc. (mg/L)')
        ylabel('Liner Height (m)')
    end

    lh = lh + 0.1;
end

fprintf('In case of no geomembrane, the maximum leachate height is%8.2f m.\n',l_ng)
fprintf('In case of the geomembrane failing after 4 years, the maximum leachate height is%8.2f m.\n',l_f)
fprintf('In case of the geomembrane never failing, the maximum leachate height is%8.2f m.\n',l_nf)

