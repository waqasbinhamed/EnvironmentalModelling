clc 
clear all
close all

D = 4500;    %dispersion coefficient in m^2/hr
v = 75; %velocity in m/hr
Cin = 85;   %inflow concentration in mol/L
k = 1.5;    %reaction rate in hr^-1
L = 120;    %length of reactor in m

%Solving the BVP using bvp4c----------------------------------------------

solinit=bvpinit(0:120,[0 0]);
sol=bvp4c(@bvp,@bc,solinit);

%Solving the BVP using Shooting Method------------------------------------

err = [100 100]; %intial value for error
iv1(1) = 0;    %intial value for C at x=0
g = 2;

while err(g-1) > 5  %tolerance is 5%
    
    if g < 4
        iv1(g) = input('Guess C at x=0:');
    else
        iv1(g) = iv1(g-1)+(-1*err(g-1))*((iv1(g-1)-iv1(g-2))/(err(g-1)...
            -err(g-2)));    %next value is predicted using linear extrapolation
    end
    
    iv2 = (v/D)*(iv1(g)-Cin); %calculating dC/dt using boundary condition at x=0
    [x,shC] = ode45(@bvp,[0:120],[iv1(g) iv2]);
    err(g) = abs((shC(120,2)-0)*100);   %calculates error
    
    if err(g) > 5
        if g < 4
            fprintf('The error for your guess is %8.4f%%\n', err(g))
        else
            fprintf('Guess using linear extrapolation: %8.4f\n', iv1(g))
            fprintf('Error for this guess: %8.4f%%\n', err(g))
        end
    end
    
    g = g+1;
end

%Solving the BVP using Finite Difference Method---------------------------

delx = 20; %distance between nodes in m

a1 = D/(delx^2)+v/delx;
a2 = -2*D/(delx^2)-v/delx-k;
a3 = D/(delx^2);

b1 = v+D/delx;
b2 = -D/delx;

b = zeros(7,1);
b(1) = v*Cin;
A = diag(ones(length(b),1)*a2)+diag(ones(length(b)-1,1)*a3,1)+diag...
    (ones(length(b)-1,1)*a1,-1);
A(1,:)=[b1; b2; 0; 0; 0; 0; 0];
A(length(b),:)=[0; 0; 0; 0; 0; -1; 1];
finC = A\b;


%Analytical Solution------------------------------------------------------

l1 = (v/(2*D))*(1-sqrt(1+(4*k*D)/(v^2)));
l2 = (v/(2*D))*(1+sqrt(1+(4*k*D)/(v^2)));

C = ((v*Cin)/((v-D*l1)*l2*exp(l2*L)-(v-D*l2)*l1*exp(l1*L)))*(l2*exp...
    (l2*L)*exp(l1*x)-l1*exp(l1*L)*exp(l2*x));

%Plotting the graphs------------------------------------------------------

subplot(3,1,1)
plot(x,C,'.')
hold on
plot(x,sol.y(1,:)')
title(sprintf('Using BVP4C'))
xlabel('Distance (m)')
ylabel('Concentration (mol/L)')
legend('Analytical','Using bvp4c','location','east')

subplot(3,1,2)
plot(x,C,'.')
hold on
plot(x,shC(:,1))
title(sprintf('Shooting Method'))
xlabel('Distance (m)')
ylabel('Concentration (mol/L)')
legend('Analytical','Using Shooting Method','location','east')

subplot(3,1,3)
plot(x,C,'.')
hold on
xT = 0:20:120;
plot(xT,finC)
title(sprintf('Finite Difference Method'))
xlabel('Distance (m)')
ylabel('Concentration (mol/L)')
legend('Analytical','Using Finite Difference','location','east')
