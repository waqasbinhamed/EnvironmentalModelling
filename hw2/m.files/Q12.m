clear all
close all
clc

W = 246;    % mass discharge rate into the surface water(in kg/day)
k_1 = 0.25; % first order decay coefficient(in day^-1)
Q = 3.13;	% river flow rate(in m^3/s)
A = 72600;	% cross sectional area of river(in m^2)
D = 40*24:240:100*24; % range of dispersion coefficient
C_m = [1.63 3.5 9.13 29.6 70.4 40.7 12.1 7.26 2.12];    %measured concentr
%-ation values
x = -320:80:320;    % distances

v = Q/A;    % flow velocity

for j = 1:length(D) % loop for the range of D values
    
    m = sqrt(1+((4*k_1*D(j))/(v^2)));
    C_0 = W/(m*Q);	% concentration at x=0(in g/L)
    r_1 = v*(1+m)./(2*D(j));
    r_2 = v*(1-m)./(2*D(j));
    
    for i = 1:length(x)
    
        if x(i) <= 0
            C_x(j,i) = C_0*exp(r_1*x(i)); %calculation of C_x if x<=0
        elseif x(i) >= 0
            C_x(j,i) = C_0*exp(r_2*x(i)); %calculation of C_x if x>0
        end

        C_x(j,i) = C_x(j,i)*10.^6;   %convertion from g/L to micrograms/L
    
    end

    RMSE(j) = sqrt(mean((C_x(j,:) - C_m).^2)); %RMSE calculation formula 
    deltaC=max(C_m)-min(C_m); %difference between max and min measured conc.
    CE=RMSE/deltaC*100;
    SSE=sum((C_m-C_x).^2); %SSE calculation
    SSyy=sum((C_m-mean(C_m)).^2); %SSY calculation
    R2=1-SSE/SSyy; %calculation of R^2
    disp(['If D= ' num2str(D(j)/24)])
    disp(['RMSE= ' num2str(RMSE(j))])
    disp(['CE= ' num2str(CE(j))])
    fprintf('\n')

end

disp(['Min CE= ' num2str(min(CE))])
disp(['Max CE= ' num2str(max(CE))])
plot (x,C_m,'o')
hold all
plot (x,C_m,'-or','markeredgecolor','red')
plot(x,C_x(6,:),'-^m','markeredgecolor','blue')
plot(x,C_x(1,:),'-xm','markeredgecolor','magenta')
hold all
xlabel('x, m');
ylabel('C, micrograms/l');
legend('C_m','C Best','C Worst')
