close all
clc

time=0:10:150; %time from day 0 to 150 with 10 day steps 
Conc1=15*(exp(-0.031507*time)); %calculates concentration of Nonylphenol
plot(time,Conc1,'-xm','markeredgecolor','blue')
hold on 
xlabel('Time(days)');
ylabel('Concentration(micrograms/L)')

Conc2=15*(exp(-0.053319*time)); %calculates concentration of Fenpropimorph
plot(time,Conc2,'-sr','markeredgecolor','green')
hold off
legend('Nonylphenol','Fenpropimorph')

