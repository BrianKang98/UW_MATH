% Homework 6
% Scorlator Problems
close all; clear all; clc
% Problem 1
a = 2; b = 10;
% initial guess
x1 = [1,10];
% banana function
fun = @(x) (a-x(1))^2 + b*(x(2)-x(1)^2)^2;
res = fun(x1);
save('A1.dat','res','-ascii')

%% Problem 2
iguess = [1,10];
imin = (fminsearch(fun,iguess)).';
save('A2.dat','imin','-ascii')

%% Problem 3
gradx = @(x) 2*(a-x(1))*(-1) + 2*b*(x(2)-x(1)^2)*(-2*x(1));
grady = @(x) 2*b*(x(2)-x(1)^2);
% gradient of f at (1,10)
gradf = [gradx(iguess), grady(iguess)].';
save('A3.dat','gradf','-ascii')
nrm_gradf = norm(gradf, Inf);
save('A4.dat','nrm_gradf','-ascii')

%% Problem 4
% phi(t)
phifun = @(t) [1;10]-t*gradf;
phi = phifun(0.1);
save('A5.dat','phi','-ascii')
% banana function(phi(t)) = ??
phires = fun(phi);
save('A6.dat','phires','-ascii')

%% Problem 5
temp = @(t) fun(phifun(t));
% how insert function handle???
tstar = fminbnd(temp, 0, 0.1);
save('A7.dat','tstar','-ascii')
% my new guess
phit = phifun(tstar);
save('A8.dat','phit','-ascii')

%% Problem 6
% modify phi(t) equation
ii = 0;
while nrm_gradf >= 10^-4
    ii = ii + 1;
    % update gradient
    gradf = [gradx(phit), grady(phit)].';
    % update norm of gradient
    nrm_gradf = norm(gradf, Inf);
    % update phi(t) equation
    phifun = @(t) phit-t*gradf;
    % update temp
    temp = @(t) fun(phifun(t));
    % update tstar for phi(optimal t)
    tstar = fminbnd(temp, 0, 0.1);
    % update new guess
    phit = phifun(tstar);
end
save('A9.dat','phit','-ascii')
save('A10.dat','ii','-ascii')

%% Problem 7
% Writeup Problems
clf
x = linspace(-8,8,21);
y = linspace(-20,30,21);
[X,Y] = meshgrid(x,y);
fsurf = (a-X).^2 + b*(Y-X.^2).^2;
surf(X,Y,fsurf)
axis([-8 8 -20 30 0 10000]);
caxis([0 10000])
colorbar
view(-20,30)
daspect([1 3 1000])
title("Rosenbrock's Banana Function")
xlabel('x')
ylabel('y')
hold on
plot3(a,a^2,fun([a,a^2]),'r*','MarkerSize',10)
print(gcf,'-dpng','banana_surf.png');

%% Problem 8
clf
x2 = linspace(-8,8,100);
y2 = linspace(-20,30,100);
[X2,Y2] = meshgrid(x2,y2);
fsurf2 = (a-X2).^2 + b*(Y2-X2.^2).^2;
level = logspace(0,4,20);
contourf(X2,Y2,fsurf2,level)
caxis([0 10000])
colorbar
title("Contours of Rosenbrock's Banana Function")
xlabel('x')
ylabel('y')
hold on
plot(a,a^2,'ro')
print(gcf,'-dpng','banana_contour.png');

%% Problem 9
% the initial guess
phit = iguess.';
xsave = phit(1);
ysave = phit(2);
% just for setting up initial condition before loop
gradf = [gradx(phit), grady(phit)].';
nrm_gradf = norm(gradf, Inf);
% IF the initial guess worked (we know it doesn't)
% will skip while loop
% copied from problem 6
while nrm_gradf >= 10^-4
    % update gradient
    gradf = [gradx(phit), grady(phit)].';
    % update norm of gradient
    nrm_gradf = norm(gradf, Inf);
    % update phi(t) equation
    phifun = @(t) phit-t*gradf;
    % update temp
    temp = @(t) fun(phifun(t));
    % update tstar for phi(optimal t)
    tstar = fminbnd(temp, 0, 0.1);
    % update new guess
    phit = phifun(tstar);
    xsave = [xsave phit(1)];
    ysave = [ysave phit(2)];
end

clf
x2 = linspace(-4,4,100);
y2 = linspace(0,10,100);
[X2,Y2] = meshgrid(x2,y2);
fsurf2 = (a-X2).^2 + b*(Y2-X2.^2).^2;
level = logspace(0,4,20);
contour(X2,Y2,fsurf2,level)
caxis([0 10000])
xlabel('x')
ylabel('y')
hold on
% eliminate fence-post issue
for jj = 1:length(xsave)-1
    plot(xsave(jj),ysave(jj),'r.','MarkerSize',10)
    plot([xsave(jj) xsave(jj+1)],[ysave(jj) ysave(jj+1)],'r-')
end
plot(xsave(jj+1),ysave(jj+1),'r.','MarkerSize',10)
print(gcf,'-dpng','descent_iterations.png');

clf
x2 = linspace(2.97,3.01,100);
y2 = linspace(8.93,9.04,100);
[X2,Y2] = meshgrid(x2,y2);
fsurf2 = (a-X2).^2 + b*(Y2-X2.^2).^2;
level = linspace(0.9,1.5,200);
contour(X2,Y2,fsurf2,level)
caxis([0 10000])
axis equal 
xlim([2.97 3.01])
ylim([8.93 9.04])
xlabel('x')
ylabel('y')
hold on
% eliminate fence-post issue
for jj = 1:length(xsave)-1
    plot(xsave(jj),ysave(jj),'r.','MarkerSize',10)
    plot([xsave(jj) xsave(jj+1)],[ysave(jj) ysave(jj+1)],'r-')
end
plot(xsave(jj+1),ysave(jj+1),'r.','MarkerSize',10)
print(gcf,'-dpng','descent_iterations_closeup.png');
