function mostrahist( imdata, handles, Value )
%MOSTRAHIST Summary of this function goes here
%   Detailed explanation goes here

axes(imdata.SYSTEM.hx4)
histogram(imdata.ParC.LCO,0:1:255);

hold on
plot(imdata.ParC.LCO(1,Value), 0.5,'v','MarkerEdgeColor','k','MarkerFaceColor','b', 'MarkerSize',8)
hold off

end

