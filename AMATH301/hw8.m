% Homework 8
close all; clear all; clc
% Scorelator Problems PART I
% Problem 1
g = 9.8; % Gravity
l = 10;  % Length of pendulum
A = [0 1; -g/l 0];
dt = 0.01; % Small steps
T = 50;    % End of derivative steps

thsave_FE = [1]; % Initial Values
phisave_FE = [0];
temp = [thsave_FE; phisave_FE];
for ii = 1:T/dt
    % temp is the Zk part, f(Zk) = A*Zk
    temp(:,ii+1) = (eye(2) + dt*A)*temp(:,ii);
    thsave_FE = [thsave_FE; temp(1,ii+1)];
    phisave_FE = [phisave_FE; temp(2,ii+1)];
end
save('A1.dat','thsave_FE','-ascii')
save('A2.dat','phisave_FE','-ascii')

%% Problem 2
thsave_BE = [1]; % Initial Values
phisave_BE = [0];
temp = [thsave_BE; phisave_BE];
for ii = 1:T/dt
    temp(:,ii+1) = inv(eye(2) - A*dt)*temp(:,ii);
    thsave_BE = [thsave_BE; temp(1,ii+1)];
    phisave_BE = [phisave_BE; temp(2,ii+1)];
end
save('B1.dat','thsave_BE','-ascii')
save('B2.dat','phisave_BE','-ascii')

%% Problem 3
thsave_LF = [1]; % Initial Values
phisave_LF = [0];
temp = [thsave_LF; phisave_LF];
% Forward Euler once
temp(:,2) = (eye(2) + dt*A)*temp(:,1);
thsave_LF = [thsave_LF; temp(1,2)];
phisave_LF = [phisave_LF; temp(2,2)];
% Leapfrog method
for ii = 2:(T/dt-1) % stops at 5000-1=4999 -> LF is now 5000x1 vector
    temp(:,ii+1) = temp(:,ii-1)+2*dt*A*temp(:,ii);
    thsave_LF = [thsave_LF; temp(1,ii+1)];
    phisave_LF = [phisave_LF; temp(2,ii+1)];
end
% Backward Euler once
temp(:,T/dt+1) = inv(eye(2) - A*dt)*temp(:,T/dt);
thsave_LF = [thsave_LF; temp(1,T/dt+1)];
phisave_LF = [phisave_LF; temp(2,T/dt+1)];
save('C1.dat','thsave_LF','-ascii')
save('C2.dat','phisave_LF','-ascii')

%% Problem 4
thsave_ODE = [1]; % Initial Values
phisave_ODE = [0];
temp = [thsave_ODE; phisave_ODE];
[t,xGood] = ode45(@(t,x) A*x, 0:dt:T, temp);
thsave_ODE45 = xGood(:,1);
phisave_ODE45 = xGood(:,2);
save('D1.dat','thsave_ODE45','-ascii')
save('D2.dat','phisave_ODE45','-ascii')

%% Problem 5
% Writeup Problems PART I
clf
p1 = plot(thsave_FE,'g');
hold on
p2 = plot(thsave_BE,'b');
p3 = plot(thsave_LF,'k');
xlabel('t')
ylabel('\theta(t)')
legend([p1 p2 p3],'Forward Euler','Backward Euler','Leapfrog Method','Location','south')
% Max amplitude
plot(ones(length(thsave_LF),1),'r','HandleVisibility','off')
print(gcf,'-dpng','linear_pendulum.png');

%% Problem 6
clf
x = linspace(-2,2,21);
y = linspace(-2,2,21);
[X,Y] = meshgrid(x,y);
quiver(X,Y,Y,-g/l*X)
axis([-2 2 -2 2])
xlabel('\theta')
ylabel('\phi')
hold on
plot(thsave_FE,phisave_FE,'g')
plot(thsave_BE,phisave_BE,'b')
plot(thsave_LF,phisave_LF,'k')
print(gcf,'-dpng','linear_phase_portrait.png');

%% Problem 7
% Scorelator Problems PART II
thsave_ODE2 = [1]; % Initial Values
phisave_ODE2 = [0];
temp = [thsave_ODE2; phisave_ODE2];
[t,xGood2] = ode45(@(t,x) [x(2); -g/l*sin(x(1))], 0:dt:T, temp);
thsave_ODE45 = xGood2(:,1);
phisave_ODE45 = xGood2(:,2);
save('E1.dat','thsave_ODE45','-ascii')
save('E2.dat','phisave_ODE45','-ascii')

%% Problem 8
% Writeup Problems PART II
clf
x2 = linspace(-2*pi,2*pi,25);
y2 = -3:0.5:4;
[X2,Y2] = meshgrid(x2,y2);
quiver(X2,Y2,Y2,-g/l*sin(X2))
axis([-2*pi 2*pi -3 4])
xlabel('\theta')
ylabel('\phi')
hold on
temp = 0;
for ii = 1:5
    if ii==1
        temp = [0.1; 0];
    elseif ii==2
        temp = [1.0; 0];
    elseif ii==3
        temp = [3.0; 0];
    elseif ii==4
        temp = [-2*pi; 2.1];
    else
        temp = [-2*pi; 3];
    end
    [t,xGood3] = ode45(@(t,x) [x(2); -g/l*sin(x(1))], 0:dt:T, temp);
    thsave = xGood3(:,1);
    phisave = xGood3(:,2);
    plot(thsave,phisave)
end
print(gcf,'-dpng','nonlinear_phase_portrait.png');
