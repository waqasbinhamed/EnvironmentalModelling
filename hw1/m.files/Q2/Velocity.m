%function for calculating velocity in channel using Manning's formula

function [v] = Velocity(n,S,B,H)
v=(sqrt(S)/n)*(B/(B+2*H))^(2/3);


