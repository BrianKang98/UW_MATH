clear all; close all; clc

x = -10:0.1:10;
y = exp(x) - tan(x);
plot(x,y)
axis([-4 -2 -1 1]) % first 2 nums for x axis, next 2 nums for y axis
hold on

xr = -2.5;
xl = -4;

for j = 1:1000
    xc = (xl+xr)/2; %midpoint
    fc = exp(xc) - tan(xc);
    plot(xc,fc,'ro', 'Linewidth',2)
    % pause(1)
    drawnow
    
    if fc > 0
        x1 = xc; % move left boundary
    else
        xr = xc; % move right boundary
    end
    
    if abs(fc) < 10^(-5)
        break
    end
end

fc;
xc;
j;
