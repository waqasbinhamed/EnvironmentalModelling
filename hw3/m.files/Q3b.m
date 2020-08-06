clear all
close all
clc


W=1825*10^9;    %Mass

Q_2=7*10^9;     %Flowrates
Q_out=16*10^9;

V_1=3507*10^9;  %Volumes
V_2=8*10^9;

A_c=1.7*10^5;   %cross-sectional area between tanks
k_L=1.48*10^5;  %diffusion mass-transfer coefficient
D=k_L*A_c;  %diffusive flowrate

k=(0.693/43.8)*365; %decay constant

%concentrations
syms C_1
syms C_2

%mass balances
MB_1=Q_2*C_2+D*(C_2-C_1)-k*C_1*V_1-Q_out*C_1;
MB_2=W-Q_2*C_2-D*(C_2-C_1)-k*C_2*V_2;

[A, b] = equationsToMatrix ([MB_1, MB_2],[C_1, C_2]); 
x = A\b;
C_1 = double(x(1,1));
C_2 = double(x(2,1));

fprintf(['Tank 1 concentration = ' num2str(C_1)]);
fprintf(['\nTank 2 concentration = ' num2str(C_2)]);
fprintf(['\n']);