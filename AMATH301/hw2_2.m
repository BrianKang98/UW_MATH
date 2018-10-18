% Problem 3
clf
xs = linspace(-1.5,1.5);
plot(xs,0*xs,'k-'); % x-axis
hold on
f = @(x) x.^2;
df = @(x) 2.*x;
x = 1; % x_0
for ii = 1:100
    plot(x,0,'rx') % red cross at (x,0)
    plot([x x], [0 f(x)], 'k--') % dashed black line to f(x) from x-axis
    plot(x,f(x),'ro') % red circle at f(x)
    xn = x - f(x) ./ df(x); 
    plot([x xn], [f(x) 0], 'r-') % red line to new x on x-axis
    x = xn;
    if abs(f(x)) < 10^-8
        break;
    end
end
plot(xs,f(xs),'b-');
print(gcf,'-dpng','hw2_prob3_plot.png');

%% Problem 4

clear all; close all; clc; clf;
xs = linspace(0,pi);
plot(xs,0*xs,'k-'); % x-axis
hold on
f = @(x) cos(x) + 0.3.*x;
df = @(x) -sin(x) + 0.3;
x = 1.0; % x_0
for ii = 1:100
    plot(x,0,'rx') % red cross at (x,0)
    plot([x x], [0 f(x)], 'k--') % dashed black line to f(x) from x-axis
    plot(x,f(x),'ro') % red circle at f(x)
    xn = x - f(x) ./ df(x); 
    plot([x xn], [f(x) 0], 'r-') % red line to new x on x-axis
    x = xn;
    if abs(f(x)) < 10^-8
        break;
    end
end
plot(xs,f(xs),'b-');
print(gcf,'-dpng','hw2_prob4_x0_1.0.png');

%%

clear all; close all; clc; clf;
xs = linspace(0,pi);
plot(xs,0*xs,'k-'); % x-axis
hold on
f = @(x) cos(x) + 0.3.*x;
df = @(x) -sin(x) + 0.3;
x = 0.9; % x_0
for ii = 1:100
    plot(x,0,'rx') % red cross at (x,0)
    plot([x x], [0 f(x)], 'k--') % dashed black line to f(x) from x-axis
    plot(x,f(x),'ro') % red circle at f(x)
    xn = x - f(x) ./ df(x); 
    plot([x xn], [f(x) 0], 'r-') % red line to new x on x-axis
    x = xn;
    if abs(f(x)) < 10^-8
        break;
    end
end
plot(xs,f(xs),'b-');
print(gcf,'-dpng','hw2_prob4_x0_0.9.png');

%%

clear all; close all; clc; clf;
xs = linspace(0,1.5*pi);
plot(xs,0*xs,'k-'); % x-axis
hold on
f = @(x) cos(x) + 0.3.*x;
df = @(x) -sin(x) + 0.3;
x = 0.8; % x_0
for ii = 1:100
    plot(x,0,'rx') % red cross at (x,0)
    plot([x x], [0 f(x)], 'k--') % dashed black line to f(x) from x-axis
    plot(x,f(x),'ro') % red circle at f(x)
    xn = x - f(x) ./ df(x); 
    plot([x xn], [f(x) 0], 'r-') % red line to new x on x-axis
    x = xn;
    if abs(f(x)) < 10^-8
        break;
    end
end
plot(xs,f(xs),'b-');
print(gcf,'-dpng','hw2_prob4_x0_0.8.png');

%% Problem 5

clear all; close all; clc; clf;

f = @(x) cos(x) + 0.3*x;
x0s = linspace(-8,8); % default already makes N = 100
M = zeros(100,2);

for ii = 1:100
    M(ii,1) = x0s(ii);
    M(ii,2) = fzero(f, x0s(ii));
end

xs = linspace(-10,10);
clf
plot(xs,0*xs,'k-');
hold on
myroot = M(:,2); % = to all the fzero(s)
for ii = 1:100
    plot([x0s(ii) myroot(ii)], [f(x0s(ii)) 0], 'k-')
end
plot(xs,f(xs));
print(gcf,'-dpng','hw2_prob5_plot.png');
