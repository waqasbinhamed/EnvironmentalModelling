function resC = cfun(t,z,C0,Cb,R,D,v)

%This is the function for simulation of the concentration profile. It
%applies the analytical solution for every z value for each loop and
%replace the intial soil concentration with the calculated value for the
%next loop.

C = zeros(length(t),length(z)); %creation of concentration matrix
C(1,:) = ones(length(z),1)'.*Cb;    %sets the row to the intial conc. entered

for i = 1:length(t) %loops through the duration values
    t(i) = t(i)*(365*24*60*60); %converts from years to sec
    %applies the formula
    a1 = erfc((R*z-v*t(i)/(2*sqrt(D*R*t(i)))));
    a2 = erfc((R*z+v*t(i)/(2*sqrt(D*R*t(i)))));
    C(i+1,:) = C(i,:)+(C0(i)-C(i,:)).*(a1+exp((v*z)/D).*a2)/2;
end

%returns only the last row of the concentration matrix since we only want
%the final concentration values.
resC = C(length(t)+1,:);    



