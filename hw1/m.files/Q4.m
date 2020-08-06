% This function takes 2 values as input, first is the intial value of head
% and second is the final head value. It returns a graph showing the soil
% saturation for that interval.

function[sat]=Q4(h0,hF) 

head = [h0:1:hF]; % h head values with 1 unit increments

for i=1:length(head) %calculates saturation for each head value in the interval.
    
if head(1,i)<10 
    sat(i)=1
elseif head(1,i)>=10 & head(1,i)<100
    sat(i)=1+0.01*(10 - head(1,i))
elseif head(1,i)>=100
    sat(i)=0.1
end

end

plot(head,sat,'--r')
xlabel('Head (cm)');
ylabel('Soil saturation')

end
