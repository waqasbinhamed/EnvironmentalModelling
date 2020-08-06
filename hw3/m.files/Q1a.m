clear all
close all
clc
 
Q_w = [60 30 52.08 24]; %incoming flowrates in m^3/day
Q_i = [50 35 53 20];	%outgoing flowrates in m^3/day

Q_12=Q_w(1)-Q_i(1); %other flowrates in m^3/day
Q_23=Q_w(2)+Q_12-Q_i(2);
Q_34=Q_w(3)+Q_23-Q_i(3);
Q_4r=Q_w(4)+Q_34-Q_i(4);

C_w = [15 8 14 12]; %incoming concentrations in mg/L
C_w = C_w.*(10^3);  %in mg/m^3

V = [5.2 4.1 7.3 2.7];
V = V.*(10^6);  %lake volumes in 10^6m^3

k = [0.535 0.467 0.952 0.368];  %decay rate in m^3y^-1kg^-1
k = k.*((10^-6)*(1/365));   %in m^3d^-1mg^-1

syms C_a C_b C_c C_d;

r = [k(1)*(C_a)^2 k(2)*(C_b)^2 k(3)*(C_c)^2 k(4)*(C_d)^2]; %decay rates

%steady-state mass balances for each lake 
MB_a= (Q_w(1)*C_w(1))-(Q_i(1)*C_a)-(Q_12*C_a)-V(1)*r(1);
MB_b=(Q_12*C_a)+(Q_w(2)*C_w(2))-(Q_i(2)*C_b)-(Q_23*C_b)-V(2)*r(2);
MB_c=(Q_23*C_b)+(Q_w(3)*C_w(3))-(Q_i(3)*C_c)-(Q_34*C_c)-V(3)*r(3);
MB_d=(Q_34*C_c)+(Q_w(4)*C_w(4))-(Q_i(4)*C_d)-(Q_4r*C_d)-V(4)*r(4);

[solC_a,solC_b,solC_c,solC_d] = solve([MB_a == 0, MB_b == 0, MB_c == 0, MB_d == 0], [C_a, C_b,...
    C_c, C_d]);

solC_a = double(solC_a);
solC_b = double(solC_b);
solC_c = double(solC_c);
solC_d = double(solC_d);

% choosing only the positive real roots
for i = 1:length(solC_a)
    if  ((solC_a(i) >= 0) && (real(solC_a(i)) == solC_a(i))&&...
            (solC_b(i) >= 0) && (real(solC_b(i)) == solC_b(i))&&...
            (solC_c(i) >= 0) && (real(solC_c(i)) == solC_c(i))&&...
            (solC_d(i) >= 0) && (real(solC_d(i)) == solC_d(i)))
        C_a = solC_a(i);
        C_b = solC_b(i);
        C_c = solC_c(i);
        C_d = solC_d(i);
    end
end

disp(['Lake A concentration (mg/m^3) = ' num2str(C_a)])
disp(['Lake B concentration (mg/m^3) = ' num2str(C_b)])
disp(['Lake C concentration (mg/m^3) = ' num2str(C_c)])
disp(['Lake D concentration (mg/m^3) = ' num2str(C_d)])