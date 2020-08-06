clc
clear all
close all

k = 1.5;    %reaction rate in hr^-1
L = 120;    %length of reactor in m
D = 4500;    %dispersion coefficient in m^2/hr
v = 75; %velocity in m/hr
Cin = 85;   %inflow concentration in mol/L

n = 7;   %intial number of nodes
delx = 20;  %intial distance between nodes in m

a1 = D/(delx^2)+v/delx;
a2 = -2*D/(delx^2)-v/delx-k;
a3 = D/(delx^2);

b1 = v+D/delx;
b2 = -D/delx;

err = 100;

while err > 5   %tolerance is 5% for maximum error
    
    delx = L/(n-1); % m

    a1 = D/(delx^2)+v/delx;
    a2 = -2*D/(delx^2)-v/delx-k;
    a3 = D/(delx^2);

    b1 = v+D/delx;
    b2 = -D/delx;
    
    b = zeros(n,1);
    b(1) = v*Cin;
    A = diag(ones(length(b),1)*a2)+diag(ones(length(b)-1,1)*a3,1)+diag...
        (ones(length(b)-1,1)*a1,-1);
    A1b = [b1 b2];
    A(1,:) = [A1b zeros(1,n-2)];
    Al1 = [-1 1];
    A(length(b),:)=[zeros(1,n-2) Al1];
    finC = A\b;
    
    
    l1 = (v/(2*D))*(1-sqrt(1+(4*k*D)/(v^2)));
    l2 = (v/(2*D))*(1+sqrt(1+(4*k*D)/(v^2)));
    
    x = linspace(0,120,n);
    C = ((v*Cin)/((v-D*l1)*l2*exp(l2*L)-(v-D*l2)*l1*exp(l1*L)))*(l2*exp...
    (l2*L)*exp(l1.*x)-l1*exp(l1*L)*exp(l2.*x));
    C = C';
    

    ercol= abs((C-finC)./C)*100;    %error at each node
    err = max(abs(ercol));  %maximum error
    n = n + 1;
    
end

fprintf('For a tolerance of 5%%, %d nodes are required.\n',n-1);

VarNames = {'x','C (mol/L) using Finite Difference','C (mol.L)','Error'};
T = table(x',finC,C,ercol,'VariableNames',VarNames);
disp(T)

plot(x,C,'.')
hold on
plot(x,finC)
title(sprintf('Finite Difference Method'))
xlabel('Distance (m)')
ylabel('Concentration (mol/L)')
legend('Analytical','Using Finite Difference','location','east')