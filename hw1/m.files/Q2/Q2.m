close all
clc

% S : slope;
% n : roughness coefficient;
% B : width (m);
% H : depth (m);
% Manning's velocity formula: v = (sqrt(S)/n)*(B/(B+2*H))^(2/3)

A=[0.030 0.0008 7 1.0; 0.040 0.0005 9 1.5; 0.025 0.0001 12 2.4; 0.014 0.0012 10 2.0]; %table of parameters for all channels
Vcol = [0;0;0;0]; %column for velocity values with intial value set to 0.
for row = 1:4
    n=A(row,1);
    S=A(row,2);
    B=A(row,3);
    H=A(row,4);
    Vcol(row,1) = ((S^0.5)/n)*(B/(B+2*H))^2/3;
end
    
vmatrix = [[1;2;3;4] A Vcol]; %creating matrix that includes channel numbers, parameters and calculated velocities.
vtable = array2table(vmatrix,'VariableNames',{'Channel','n','S','B','H','Velocity'}); %creating table that includes channel numbers, parameters and calculated velocities.
disp(vtable); %displaying created table.