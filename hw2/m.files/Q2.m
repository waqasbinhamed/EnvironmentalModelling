clear all
close all 
clc

CT=10.15*60;    %cycle time(in minutes) 
C0i=133.26;     %Initial concentration of NH3-N
k1b=0.00381;	%base rate constant
k2b=0.00249;	%base rate constant

delta=(0.8:0.05:1.2);
k1vals=delta*k1b;   %k1 values
k2vals=delta*k2b;   %k2 values

C1b=C0i*k1b*((exp(-k1b*CT)/(k2b-k1b))+((exp(-k2b*CT)/(k1b-k2b))));  %base
%concentration for NO2_N

for i=1:length(delta)
    
    C1i_k1(i)=C0i*k1vals(i)*((exp(-k1vals(i)*CT)/(k2b-k1vals(i)))+((exp(-k2b*CT)/(k1vals(i)-k2b))));
    %concentration for new k1 value
    changeC1_k1(i)=(C1i_k1(i)-C1b)/(C1b)*100;   %percent change in NO2 
    %values for each k1 value
    Sens_k1(i)=(abs(C1b-C1i_k1(i))/C1b)*(k1b/abs(k1b-k1vals(i)));   %sensit
    %ivity for each k1 value
   
    C1i_k2(i)=C0i*k1b*((exp(-k1b*CT)/(k2vals(i)-k1b))+((exp(-k2vals(i)*CT)/(k1b-k2vals(i)))));
    %concentration for new k1 value
    changeC1_k2(i)=(C1i_k2(i)-C1b)/(C1b)*100;	%percent change in NO2 
    %values for each k2 value
    Sens_k2(i)=(abs(C1b-C1i_k2(i))/C1b)*(k2b/abs(k2b-k2vals(i)));   %sensit
    %ivity for each k2 value
    
    if Sens_k1(i)>Sens_k2(i)
        fprintf('K1(%.4f) is more sensitive.\n',k1vals(i))
    elseif Sens_k1(i)<Sens_k2(i)
        fprintf('K2(%.4f) is more sensitive.\n', k2vals(i))
    else 
        fprintf('Error, this is the base case.\n')
    end

end

hold off
plot(Sens_k1)
hold on
plot(Sens_k2)
legend('Sensitivity for k_1','Sensitivity for k_2')
fprintf('\n')
disp('Percent change in NO2 values for each k_1 value')
fprintf('\n')
VarNames1 = {'0.8k1', '0.85k1', '0.9k1', '0.95k1', 'k1', '1.05k1','1.1k1','1.15k1','1.2k1'};
T1 = array2table(changeC1_k1,'VariableNames',VarNames1); %creating table for k1 values
disp(T1)
fprintf('\n')
disp('Percent change in NO2 values for each k_2 value')
fprintf('\n')
VarNames2 = {'0.8k2', '0.85k2', '0.9k2', '0.95k2', 'k2', '1.05k2','1.1k2','1.15k2','1.2k2'};
T2 = array2table(changeC1_k2,'VariableNames',VarNames2); %creating table for k2 values
disp(T2)
