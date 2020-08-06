close all
clc

syms time

H=[22,147,1/6,13,1.2];  %chemical half-life values

%loop that takes the half-life value and calculates the reaction rate for
%each chemical.

for i=1:5      
    
    time=H(1,i);
    k(i)=-log(0.5)/time;       %reaction rate formula

end

Table = table(k(:,1),k(:,2),k(:,3),k(:,4),k(:,5),'VariableNames',{'Nonylphenol', '4-Choloroaniline', 'Diphenil ether', 'Fenpropimorph', 'Ethalfluralin'}); %creating table
disp(Table) %displaying chemical names with their reaction rates.
