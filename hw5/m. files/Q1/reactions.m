function csol = reactions(t,c)

td = 7; %residence time
A0 = 50;    %inlet A concentration
k1 = 0.2;   %forward reaction rate coefficient
k2 = 0.1;   %backward reaction rate coefficient

%equations for reactor 1
csol(1) = A0/td-c(1)/td-k1*c(1)+k2*c(2);    %A1
csol(2) = -c(2)/td+k1*c(1)-k2*c(2); %B1
%equations for reactor 2
csol(3) = c(1)/td-c(3)/td-k1*c(3)+k2*c(4);  %A2
csol(4) = c(2)/td-c(4)/td+k1*c(3)-k2*c(4);  %B2

csol =csol(:);
end