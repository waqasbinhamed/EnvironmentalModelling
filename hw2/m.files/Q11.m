close all
clc

W = 246;    % mass discharge rate into the surface water(in kg/day)
k_1 = 0.25;  % first order decay coefficient(in day^-1)
Q = 3.13;	% river flow rate(in m^3/s)
A = 72600;	% cross sectional area of river(in m^2)
D =60*24;  % dispersion coefficient(converted from m^2/h to m^2/day)
x = -320:80:320;	% distances

v = Q/A;	% flow velocity
m = sqrt(1+((4*k_1*D)/(v^2)));	% given in the question statement
C_0 = W/(m*Q);	% concentration at x=0(in g/L)
r_1 = v*(1+m)./(2*D);
r_2 = v*(1-m)./(2*D);

for i = 1:length(x) % loop for the range of distances 

    if x(i) <= 0
        C_x(i) = C_0*exp(r_1*x(i)); %calculation of C_x if x<=0
    elseif x(i) >= 0
        C_x(i) = C_0*exp(r_2*x(i)); %calculation of C_x if x>0
    end
    
    C_x(i) = C_x(i)*10.^6   %convertion from g/L to micrograms/L
    
end

plot (x,C_x,'x')
hold all
plot (x,C_x)
xlabel('x, m');
ylabel('C, micrograms/L');