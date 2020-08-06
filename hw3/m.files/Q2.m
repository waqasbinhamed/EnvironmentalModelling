close all
clear all
clc

subC = zeros(1,15);
X_0=0.5;    %g/L
S_0=10; %g/L
Y=0.35;
K_s=2;  %mg/L
K_0=0.25;   %1/hr

for t = 0:15
	
    f = @(S)K_s*log(S/S_0)+S-S_0+(X_0*K_0*t/Y);
	S = fsolve(f,1);
	subC(t+1) = S;
   
end

plot(0:15, subC,'-r o')
xlabel('Time(hr)');
ylabel('Substrate Concentration(g/L)');
subC = [0:15; subC];
fprintf(1, ' Time(hr)\t\t Substrate Concentration(g/L)\n') % Column Titles
fprintf(1, '%2d\t\t         %2d\n', subC) % Write Rows