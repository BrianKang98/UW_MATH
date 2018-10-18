% Problem 1

f = @(x) x.^2;
% df = @(f) diff(f); %is this right??
df = @(x) 2.*x;
x = 1; % x_0
x_save = [];
for ii = 1:100
    xn = x - f(x) ./ df(x); %not computing
    x = xn;     %evaluates to [] not a num
    x_save = [x_save; x];
    if abs(f(x)) < 10^-8
        break;
    end
end
save("A1.dat", "x_save", "-ascii")

%% Problem 2
clear all; close all; clc

f = @(x) cos(x) + 0.3.*x;
% df = @(f) diff(f); %is this right??
df = @(x) -sin(x) + 0.3;
x = 1.0; % x_0
x_save = [];
for ii = 1:100
    xn = x - f(x) ./ df(x); %not computing
    x = xn;     %evaluates to [] not a num
    x_save = [x_save; x];
    if abs(f(x)) < 10^-8
        break;
    end
end
save("B1.dat", "x_save", "-ascii")

%%
clear all; close all; clc

f = @(x) cos(x) + 0.3.*x;
% df = @(f) diff(f); %is this right??
df = @(x) -sin(x) + 0.3;
x = 0.9; % x_0
x_save = [];
for ii = 1:100
    xn = x - f(x) ./ df(x); %not computing
    x = xn;     %evaluates to [] not a num
    x_save = [x_save; x];
    if abs(f(x)) < 10^-8
        break;
    end
end
save("B2.dat", "x_save", "-ascii")

%%
clear all; close all; clc

f = @(x) cos(x) + 0.3.*x;
% df = @(f) diff(f); %is this right??
df = @(x) -sin(x) + 0.3;
x = 0.8; % x_0
x_save = [];
for ii = 1:100
    xn = x - f(x) ./ df(x); %not computing
    x = xn;     %evaluates to [] not a num
    x_save = [x_save; x];
    if abs(f(x)) < 10^-8
        break;
    end
end
save("B3.dat", "x_save", "-ascii")
