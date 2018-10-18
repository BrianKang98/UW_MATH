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
% modify fit functions for easier graphing (horizontal shift of t by 1958)
fit_expsinu = @(t) exp(A*((t-1958)-B)) + C + D*sin(E*((t-1958)-F));
fit_expsinu_exppart = @(t) exp(A*((t-1958)-B)) + C;

%% Plotting
% NOTE
% IF PLOT SHOWS UP WEIRD, DRAG THE FIGURE WINDOW TO FIT THE PLOT ON HW
% after that, run code again to produce the right PNG file

% remember, t = year since 1958
t = t + 1958;
% not anymore
clf
% Main plot
% patch
patch([1963 1968 1968 1963],[315 315 326 326],'w','facecolor',[0.9 0.9 0.9])
hold on
allplots = [];
ts = linspace(1948,2028,5000);
ys = fit_expsinu(ts);
ys2 = fit_expsinu_exppart(ts);
% Trend's color is Matlab's default color for 2nd plot
allplots(3) = plot(ts,ys2,'Color',[0.8500 0.3250 0.0980],'LineWidth',3);
hold on
% Fit's color is Matlab's default color for 1st plot
allplots(2) = plot(ts,ys,'Color',[0 0.4470 0.7410]);
hold on
% Data is black dot
allplots(1) = plot(t,y,'k.','MarkerSize',4);
set(gca,'Box','On')
axis([1948 2028 300 440])
xticks(1948:10:2028)
title('Atmosphereic CO_2')
xlabel('Year')
ylabel('Parts per million')
legtext = {'Data','Fit','Trend'};
% legend
legend(allplots,legtext,'Location','southeast','FontSize',14)
% text
if B<0
    str = sprintf('y(t) = %.3f^{(t+%.1f)} + %.1f',exp(A),-B,C);
else
    str = sprintf('y(t) = %.3f^{(t-%.1f)} + %.1f',exp(A),B,C);
end
text(1988,315,str,'Color',[0.8500 0.3250 0.0980],'HorizontalAlignment','center','Fontsize',16)

% Inset plot
ax2 = axes('Position',[0.2 0.55 0.35 0.3]);
plot(ts,ys2,'Color',[0.8500 0.3250 0.0980],'LineWidth',4);
hold on
plot(ts,ys,'Color',[0 0.4470 0.7410],'LineWidth',2);
hold on
plot(t,y,'k.','MarkerSize',10);
set(gca,'Color',[0.9 0.9 0.9],'Box','On')
xlim([1963 1968])
ylim([315 326])
set(ax2)
print(gcf,'-dpng','hw5_making_a_figure.png');

% just for personal keep
% print(gcf,'-dpdf','hw5_making_a_figure.pdf');

