%% Import data
clc
clear
load('CO2_data.mat');

%% fminsearch on exponential fit + oscillation
clc
Z0 = [0.03; -100; 300; 3; 2*pi; 0];
optims = optimset('maxfunevals',10000,'maxiter',10000);

errorfunc = @(A,B,C,D,E,F) sum( (exp(A*(t-B)) + C + D*sin(E*(t-F)) - y).^2 );

coeffs_fitexpsinu = fminsearch(@(Z) errorfunc(Z(1),Z(2),Z(3),Z(4),Z(5),Z(6)), Z0, optims);
A = coeffs_fitexpsinu(1);
B = coeffs_fitexpsinu(2);
C = coeffs_fitexpsinu(3);
D = coeffs_fitexpsinu(4);
E = coeffs_fitexpsinu(5);
F = coeffs_fitexpsinu(6);
fit_expsinu = @(t) exp(A*(t-B)) + C + D*sin(E*(t-F));
fit_expsinu_exppart = @(t) exp(A*(t-B)) + C;


%% Plotting