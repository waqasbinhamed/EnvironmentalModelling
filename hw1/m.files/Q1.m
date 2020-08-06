close all
clc

M=[9,6,7,2,1]; %M vector
N=[3,8,4,5,2]; %N vector
Ka = M+N
Kb = N-M+8
Kc = N.*M
Kd = M.^N
Ke = 2.^M-(N*4)
Kf = 5*M+M.^N

