% Hw 7
close all; clear all; clc
load('Plutonium.mat');
% Scorelator Problems PART I
% Problem 1: Central diff.
% t=10 -> t(11); Matlab index starts at 1!
dpdt1 = (P(11+1)-P(11-1))/(2*1);
save('A1.dat','dpdt1','-ascii')

%% Problem 2: Forward diff.
dpdt2 = (P(1+1)-P(1))/(1);
save('A2.dat','dpdt2','-ascii')

%% Problem 3: Backward diff.
dpdt3 = (P(41)-P(41-1))/(1);
save('A3.dat','dpdt3','-ascii')

%% Problem 4: Finite diff.s
dpdt4 = zeros(length(t),1);
dpdt4(1) = dpdt2;
for ii = 2:40
    dpdt4(ii) = (P(ii+1)-P(ii-1))/(2*1);
end
dpdt4(length(t)) = dpdt3;
save('A4.dat','dpdt4','-ascii')

%% Problem 5
decayrate = -1./P.*dpdt4;
% lambda
rateavg = sum(decayrate)/length(decayrate);
save('A5.dat','rateavg','-ascii')

%% Problem 6
halflife = log(2)/rateavg;
save('A6.dat','halflife','-ascii')

%% Problem 7
% Writeup Problem PART I
clf
% top axes
subplot(2,1,1)
xt = linspace(0,40,1000);
yt = 1000*exp(-rateavg.*xt);
plot(t,P,'o','MarkerSize',5)
hold on
plot(xt,yt,'Linewidth',1.5)
legend('data','exponential decay','Location','best')
ylabel('Mass of Plutonium')
title('Radioactive Decay of Plutonium')

% bottom axes
subplot(2,1,2)
ytp = 1000*exp(-rateavg.*t);
plot(t,ytp-P,'o')
ylabel('Error')
xlabel('Number of Years')
print(gcf,'-dpng','plutonium_decay.png');

%% Problem 8
% Scorelator Problems PART II
a = 1;
b = 3;
dx = 1;
xs = a:dx:b;
ys = exp(-xs.^2/2);
n = length(xs);
area8_1 = 0;
for ii = 1:n-1
    area8_1 = area8_1 + ys(ii)*dx;
end
save('B1.dat','area8_1','-ascii')

% left rect integration
area8_2s = [];
for ii = 0:16
    dx = 2^(-ii);
    xs = a:dx:b;
    ys = exp(-xs.^2/2);
    n = length(xs);
    area8_2s(ii+1) = 0;
    for jj = 1:n-1
        area8_2s(ii+1) = area8_2s(ii+1) + ys(jj)*dx;
    end
end
area8_2s = area8_2s.';
save('B2.dat','area8_2s','-ascii')

% Right rect integration
area8_3s = [];
for ii = 0:16
    dx = 2^(-ii);
    xs = a:dx:b;
    ys = exp(-xs.^2/2);
    n = length(xs);
    area8_3s(ii+1) = 0;
    for jj = 1:n-1
        area8_3s(ii+1) = area8_3s(ii+1) + ys(jj+1)*dx;
    end
end
area8_3s = area8_3s.';
save('B3.dat','area8_3s','-ascii')

%% Problem 9
% Trapezoid intgration
area8_4s = [];
for ii = 0:16
    dx = 2^(-ii);
    xs = a:dx:b;
    ys = exp(-xs.^2/2);
    n = length(xs);
    area8_4s(ii+1) = trapz(xs,ys);
end
area8_4s = area8_4s.';
save('B4.dat','area8_4s','-ascii')

%% Problem 10
% Simpson's Rule integration "by hand"
area8_5s = [];
for ii = 0:16
    dx = 2^(-ii);
    xs = a:dx:b;
    ys = exp(-xs.^2/2);
    n = length(xs);
    area8_5s(ii+1) = 0;
    for jj = 1:2:n-1                            %f0      %f1      %f2
        area8_5s(ii+1) = area8_5s(ii+1) + dx/3*(ys(jj)+4*ys(jj+1)+ys(jj+2));
    end
end
area8_5s = area8_5s.';
save('B5.dat','area8_5s','-ascii')

%% Problem 11
% Simpson's Rule by Matlab
simpans = integral(@(x) exp(-x.^2/2),a,b);
save('B6.dat','simpans','-ascii')

%% Problem 12
% Writeup Problem PART II
clf
% exact true integral value
syms x
truearea = int(exp(-x^2/2),x,a,b);
stepsize = [];
for ii = 0:16
    stepsize(ii+1) = 2^(-ii);
end
% left
loglog(stepsize,abs(area8_2s-truearea),'r.','MarkerSize',15)
hold on
% right
loglog(stepsize,abs(area8_3s-truearea),'b^','MarkerSize',8)
% trapezoid
loglog(stepsize,abs(area8_4s-truearea),'go')
% Simpson
loglog(stepsize,abs(area8_5s-truearea),'m+')
% left,right error follow O(h)
plot(stepsize,10^(-0.4)*stepsize,'k','Linewidth',2)
% trapezoid error follow O(h^2)
plot(stepsize,10^(-1.5)*stepsize.^2,'k--','Linewidth',2)
% Simpson error follow O(h^4)
plot(stepsize,10^(-4)*stepsize.^3,'k-.','Linewidth',2)
xlabel('Grid spacing')
ylabel('Error')
title('Error of Quadrature Schemes')
legend('Left Rect. Inegration','Right Rect. Inegration','Trapezoid Inegration',"Simpson's Rule",'O(h)','O(h\^2)','O(h\^4)','Location','southeast')
% Machine Precision
% HandleVisibility, off makes plot not show on legend
plot(stepsize,ones(length(stepsize))*10^(-16),'HandleVisibility','off')
print(gcf,'-dpng','quadrature_errors.png');
