clear all
close all
clc

syms Q_2     %Flowrates
syms Q_out

syms V_1     %Volumes
syms V_2

syms C_1     %Concentrations
syms C_2

syms W      %Mass

syms k      %decay constant
syms D      %diffusive flow rate (L^3/T)


%Mass Balances
MB_2=W-Q_2*C_2-D*(C_2-C_1)-k*C_2*V_2;
fprintf('Tank 2 Mass Balance: \ndC_2/dt= %s\n',char(MB_2));
MB_1=Q_2*C_2+D*(C_2-C_1)-k*C_1*V_1-Q_out*C_1;
fprintf('\nTank 1 Mass Balance: \ndC_1/dt= %s\n',char(MB_1));
