% Homework 5
% Scorelator Problems
% Problem 1
clc
clear
load('CO2_data.mat');
M_fitlinear = zeros(2);
b_fitlinear = zeros(2,1);
% Set up M
M_fitlinear(1) = sum(t.^2);
M_fitlinear(2) = sum(t);
M_fitlinear(3) = sum(t);
M_fitlinear(4) = n;
% Set up b
b_fitlinear(1) = sum(t.*y);
b_fitlinear(2) = sum(y);
% Solve for x = [A B]
coeffs_fitlinear = M_fitlinear\b_fitlinear;
save("A1.dat","M_fitlinear","-ascii")
save("A2.dat","b_fitlinear","-ascii")
save("A3.dat","coeffs_fitlinear","-ascii")

%% Problem 2
M_fitquadratic = zeros(3);
b_fitquadratic = zeros(3,1);
% Set up M
M_fitquadratic(1) = sum(t.^4);
M_fitquadratic(2) = sum(t.^3);
M_fitquadratic(3) = sum(t.^2);
M_fitquadratic(4) = sum(t.^3);
M_fitquadratic(5) = sum(t.^2);
M_fitquadratic(6) = sum(t);
M_fitquadratic(7) = sum(t.^2);
M_fitquadratic(8) = sum(t);
M_fitquadratic(9) = n;
% Set up b
b_fitquadratic(1) = sum(t.^2.*y);
b_fitquadratic(2) = sum(t.*y);
b_fitquadratic(3) = sum(y);
% Solve for x = [A B C]
coeffs_fitquadratic = M_fitquadratic\b_fitquadratic;
save("B1.dat","M_fitquadratic","-ascii")
save("B2.dat","b_fitquadratic","-ascii")
save("B3.dat","coeffs_fitquadratic","-ascii")

%% Problem 3
M_fitquadsinu = zeros(4);
b_fitquadsinu = zeros(4,1);
% Set up M
M_fitquadsinu(1) = sum(t.^4);
M_fitquadsinu(2) = sum(t.^3);
M_fitquadsinu(3) = sum(t.^2);
M_fitquadsinu(4) = sum(sin(2*pi*t).*t.^2);

M_fitquadsinu(5) = sum(t.^3);
M_fitquadsinu(6) = sum(t.^2);
M_fitquadsinu(7) = sum(t);
M_fitquadsinu(8) = sum(sin(2*pi*t).*t);

M_fitquadsinu(9) = sum(t.^2);
M_fitquadsinu(10) = sum(t);
M_fitquadsinu(11) = n;
M_fitquadsinu(12) = sum(sin(2*pi*t));

M_fitquadsinu(13) = sum(sin(2*pi*t).*t.^2);
M_fitquadsinu(14) = sum(sin(2*pi*t).*t);
M_fitquadsinu(15) = sum(sin(2*pi*t));
M_fitquadsinu(16) = sum(sin(2*pi*t).^2);

% Set up b
b_fitquadsinu(1) = sum(t.^2.*y);
b_fitquadsinu(2) = sum(t.*y);
b_fitquadsinu(3) = sum(y);
b_fitquadsinu(4) = sum(y.*sin(2*pi*t));
% Solve for x = [A B C]
coeffs_fitquadsinu = M_fitquadsinu\b_fitquadsinu;
save("C1.dat","M_fitquadsinu","-ascii")
save("C2.dat","b_fitquadsinu","-ascii")
save("C3.dat","coeffs_fitquadsinu","-ascii")

%% Problem 4
errorfunc = @(A,B,C) sum( (exp(A*(t-B)) + C - y).^2 );
p_guess = [0.03; -100; 300];
p_bestfit = fminsearch(@(p) errorfunc(p(1), p(2), p(3)), p_guess);
save("D1.dat","p_bestfit","-ascii")
ts = [-58; 0; 62];
ys = exp(p_bestfit(1)*(ts-p_bestfit(2)))+p_bestfit(3);
save("D2.dat","ys","-ascii")

%% Problem 5
errorfunc2 = @(A,B,C,D,E,F) sum( (exp(A*(t-B)) + C + D*sin(E*(t-F)) - y).^2 );
p_guess2 = [0.03; -100; 300; 3; 2*pi; 0];
options = optimset('MaxFunEvals',1e10, 'MaxIter',1e10);
p_bestfit2 = fminsearch(@(p2) errorfunc2(p2(1), p2(2), p2(3), p2(4), p2(5), p2(6)), p_guess2, options);
save("E1.dat","p_bestfit2","-ascii")
ts2 = 2020-1958 + (0:11).'/12;
ys2 = exp(p_bestfit2(1)*(ts2-p_bestfit2(2))) + p_bestfit2(3) + p_bestfit2(4)*sin(p_bestfit2(5)*(ts2-p_bestfit2(6)));
save("E2.dat","ys2","-ascii")

%% Problem 6
% Writeup Problems
clf
A = coeffs_fitlinear(1);
B = coeffs_fitlinear(2);
ts = linspace(0,65,1000);
fit_linear = @(t) A*t + B;
ys = fit_linear(ts);
plot(t,y,'k.-')
hold on
plot(ts,ys,'r', 'Linewidth',2)
axis([0 65 300 420])
title('Atmosphereic CO_2')
xlabel('Year Since 1958')
ylabel('Atmosphereic CO_2')
legend('Data','Best Fit: y=At+B', 'Location', 'northwest')
print(gcf,'-dpng','co2_fit_linear.png');

%% Problem 7
clf
A = coeffs_fitquadratic(1);
B = coeffs_fitquadratic(2);
C = coeffs_fitquadratic(3);
ts = linspace(0,65,1000);
fit_quadratic = @(t) A*t.^2 + B*t + C;
ys = fit_quadratic(t);
ys2 = fit_quadratic(ts);
subplot(2,1,1)
plot(t,y,'k.-') % plot the data
hold on
plot(ts,ys2,'g', 'Linewidth',2) % plot fitted line
axis([0 65 300 420])
title('Atmosphereic CO_2')
xlabel('Year Since 1958')
ylabel('Atmosphereic CO_2')
legend('Data','Best Fit: y=At^2+Bt+C', 'Location', 'northwest')

subplot(2,1,2)
plot(t,zeros(size(t)),'g', 'Linewidth',2)
hold on
plot(t, y-ys, 'k.-')
axis([0 20 -5 5])
title('Seasonal Variation')
xlabel('Year Since 1958')
ylabel('Variation Around Mean')
print(gcf,'-dpng','co2_fit_quad.png');

%% Problem 8
clf
A = coeffs_fitquadsinu(1);
B = coeffs_fitquadsinu(2);
C = coeffs_fitquadsinu(3);
D = coeffs_fitquadsinu(4);
ts = linspace(0,65,1000);
fit_quadsinu = @(t) A*t.^2 + B*t + C + D*sin(2*pi*t);
ys = fit_quadsinu(t);
ys2 = fit_quadsinu(ts);
subplot(2,1,1)
plot(t,y,'k.-') % plot the data
hold on
plot(ts,ys2,'g', 'Linewidth',2) % plot fitted line
axis([0 65 300 420])
title('Atmosphereic CO_2')
xlabel('Year Since 1958')
ylabel('Atmosphereic CO_2')
legend('Data','Best Fit: y=At^2+Bt+C+Dsin(2\pit)', 'Location', 'northwest')

subplot(2,1,2)
plot(t,zeros(size(t)),'g', 'Linewidth',2)
hold
plot(t, y-ys, 'k.-')
axis([0 20 -4 4])
title('Error in Data Fit')
xlabel('Year Since 1958')
ylabel('Fit Error')
print(gcf,'-dpng','co2_fit_quadsinu.png');

%% Problem 8
clf
A = p_bestfit(1);
B = p_bestfit(2);
C = p_bestfit(3);
ts = linspace(0,65,1000);
fit_expo = @(t) exp(A*(t-B)) + C;
ys = fit_expo(t);
ys2 = fit_expo(ts);
subplot(2,1,1)
plot(t,y,'k.-') % plot the data
hold on
plot(ts,ys2,'c', 'Linewidth',2) % plot fitted line
axis([0 65 300 420])
title('Atmosphereic CO_2')
xlabel('Year Since 1958')
ylabel('Atmosphereic CO_2')
legend('Data','Best Fit: y=e^{A(t-B)}+C', 'Location', 'northwest')

subplot(2,1,2)
plot(t,zeros(size(t)),'c', 'Linewidth',2)
hold
plot(t, y-ys, 'k.-')
axis([0 20 -5 5])
title('Seasonal Variation')
xlabel('Year Since 1958')
ylabel('Variation Around Mean')
print(gcf,'-dpng','co2_fit_exp.png');

%% (One more) Problem 8
clf
A = p_bestfit2(1);
B = p_bestfit2(2);
C = p_bestfit2(3);
D = p_bestfit2(4);
E = p_bestfit2(5);
F = p_bestfit2(6);
ts = linspace(0,65,1000);
fit_expsinu = @(t) exp(A*(t-B)) + C +D*sin(E*(t-F));
ys = fit_expsinu(t);
ys2 = fit_expsinu(ts);
subplot(2,1,1)
plot(t,y,'k.-') % plot the data
hold on
plot(ts,ys2,'c', 'Linewidth',2) % plot fitted line
axis([0 65 300 420])
title('Atmosphereic CO_2')
xlabel('Year Since 1958')
ylabel('Atmosphereic CO_2')
legend('Data','Best Fit: y=e^{A(t-B)}+C+Dsin(E(t-f))', 'Location', 'northwest')

subplot(2,1,2)
plot(t,zeros(size(t)),'c', 'Linewidth',2)
hold
plot(t, y-ys, 'k.-')
axis([0 10 -3 3])
title('Error in Data Fit')
xlabel('Year Since 1958')
ylabel('Fit Error')
print(gcf,'-dpng','co2_fit_expsinu.png');

%% Problem 9
for ii = 1:6
    subplot(6,1,ii)
    plot(t, y-ys, 'k.-')
    axis([10*(ii-1) 10*ii -3 3])
    yticks([-3,0,3])
    grid on
end
a = axes;
t = title('Error in Exponential + Sinusoidal Data Fit');
xl = xlabel('Year Since 1958');
a.LabelFontSizeMultiplier = 1.5;
yl = ylabel('Fit Error');
a.Visible = 'off';
t.Visible = 'on';
xl.Visible = 'on';
yl.Visible = 'on';
print(gcf,'-dpng','co2_fiterror_expsinu.png');


