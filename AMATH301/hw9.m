%--------------------------------------------------------
% NOTE: all code should work if run each section in order
%--------------------------------------------------------

% Problem 1: Scorelator
close all; clear all; clc
m = 1.0;
l = m;
g = 9.8;
% x(1)=th1, x(2)=th2, x(3)=p1, x(4)=p2
inival = [pi/2; pi/2; 0; 0];
[T,X] = ode45(@(t,x) [6/(m*l^2)*(2*x(3)-3*cos(x(1)-x(2))*x(4))/(16-9*cos(x(1)-x(2))^2); 
                      6/(m*l^2)*(8*x(4)-3*cos(x(1)-x(2))*x(3))/(16-9*cos(x(1)-x(2))^2);
                      -1/2*m*l^2*(x(3)*x(4)*sin(x(1)-x(2))+3*g/l*sin(x(1)));
                      -1/2*m*l^2*(-x(3)*x(4)*sin(x(1)-x(2))+g/l*sin(x(2)))], 0:0.01:20, inival);
trimsol1 = T(1:500,:);
trimsol2 = X(1:500,:);
save('A1.dat','trimsol1','-ascii')
save('A2.dat','trimsol2','-ascii')

%% Problem 2: Scorelator
tt = 20;
h = [1 0.1 0.01 0.001 0.0001];
for ii = 1:5
    options = odeset('MaxStep',h(ii));
    [T2,X] = ode45(@(t,x) [6/(m*l^2)*(2*x(3)-3*cos(x(1)-x(2))*x(4))/(16-9*cos(x(1)-x(2))^2); 
                      6/(m*l^2)*(8*x(4)-3*cos(x(1)-x(2))*x(3))/(16-9*cos(x(1)-x(2))^2);
                      -1/2*m*l^2*(x(3)*x(4)*sin(x(1)-x(2))+3*g/l*sin(x(1)));
                      -1/2*m*l^2*(-x(3)*x(4)*sin(x(1)-x(2))+g/l*sin(x(2)))], 0:0.01:tt, inival, options);
    % for problem 3 and 5
    if ii == 1
        X1 = X(:,1);
        X1_2 = X(:,2);
    elseif ii == 2
        X2 = X(:,1);
        X2_2 = X(:,2);
    elseif ii == 3
        X3 = X(:,1);
        X3_2 = X(:,2);
    elseif ii == 4
        X4 = X(:,1);
        X4_2 = X(:,2);
    else
        X5 = X(:,1);
        X5_2 = X(:,2);
    end
    X = X(1:500,:);
    save(['B' num2str(ii) '.dat'],'X','-ascii')
end

%% Problem 3: Writeup
clf
subplot(5,1,1)
plot(T2,X1)
title(['maxstep = ' num2str(h(1))])
ylabel('\theta_{1}(t)')
set(gca,'xtick',0:2:tt)
grid on
subplot(5,1,2)
plot(T2,X2)
title(['maxstep = ' num2str(h(2))])
ylabel('\theta_{1}(t)')
set(gca,'xtick',0:2:tt)
grid on
subplot(5,1,3)
plot(T2,X3)
title(['maxstep = ' num2str(h(3))])
ylabel('\theta_{1}(t)')
set(gca,'xtick',0:2:tt)
grid on
subplot(5,1,4)
plot(T2,X4)
title(['maxstep = ' num2str(h(4))])
ylabel('\theta_{1}(t)')
set(gca,'xtick',0:2:tt)
grid on
subplot(5,1,5)
plot(T2,X5)
title(['maxstep = ' num2str(h(5))])
ylabel('\theta_{1}(t)')
set(gca,'xtick',0:2:tt)
xlabel('Time')
grid on
print(gcf,'-dpng','maxstep_compare.png');

%% Problem 4: Scorelator
options = odeset('MaxStep',0.001);
for ii = 1:4
    inival = [pi/2; round(pi/2,ii); 0; 0];
    [T3,X] = ode45(@(t,x) [6/(m*l^2)*(2*x(3)-3*cos(x(1)-x(2))*x(4))/(16-9*cos(x(1)-x(2))^2); 
                      6/(m*l^2)*(8*x(4)-3*cos(x(1)-x(2))*x(3))/(16-9*cos(x(1)-x(2))^2);
                      -1/2*m*l^2*(x(3)*x(4)*sin(x(1)-x(2))+3*g/l*sin(x(1)));
                      -1/2*m*l^2*(-x(3)*x(4)*sin(x(1)-x(2))+g/l*sin(x(2)))], 0:0.01:15, inival, options);
    % for problem 5
    if ii == 1
        X21 = X(:,1);
        X21_2 = X(:,2);
    elseif ii == 2
        X22 = X(:,1);
        X22_2 = X(:,2);
    elseif ii == 3
        X23 = X(:,1);
        X23_2 = X(:,2);
    elseif ii == 4
        X24 = X(:,1);
        X24_2 = X(:,2);
    else
        X25 = X(:,1);
        X25_2 = X(:,2);
    end
    X = X(1:500,:);
    save(['C' num2str(ii) '.dat'],'X','-ascii')
end

%% Problem 5: Writeup
clf
for ii = 1:4
    subplot(4,2,ii*2-1)
    plot(T2,eval(['X' num2str(ii)]),'k')
    ylabel('\theta_{1}(t)')
    axis([0 max(T3) -5 3])
    hold on
    plot(T3,eval(['X2' num2str(ii)]),'r')
    f = legend('\theta_{2}(0) = \pi/2',['\theta_{2}(0) = ' num2str(round(pi/2,ii))],'Orientation','horizontal','Location','best');
    set(f,'FontSize',10)
end
xlabel('Time, t')
for ii = 1:4
    subplot(4,2,ii*2)
    plot(T2,eval(['X4_2']),'k')
    ylabel('\theta_{2}(t)')
    axis([0 max(T3) -10 35])
    hold on
    plot(T3,eval(['X2' num2str(ii) '_2']),'r')
end
xlabel('Time, t')
print(gcf,'-dpng','perturbed_solutions.png');

%% Problem 6: Scorelator
g = 9.8;
l = 10.0;
% x(1)=theta, x(2)=phi
[T,X] = ode45(@(t,x) [x(2); -g/l*sin(x(1))], 0:0.1:60, [3.1; 0]);
% for problem 7
Xth = X(:,1);
Xph = X(:,2);
X = X(1:500,:);
save('D1.dat','X','-ascii')

%% Problem 7: Writeup
clf
plot(T,Xth)
hold on
plot(T,Xph)
title('Non-conservative numerical solution')
xlabel('Time, t')
legend('\theta(t)','\phi(t)', 'Location','southwest')
print(gcf,'-dpng','non_conservative1.png');

%% Problem 8: Scorelator
h = [1 0.1 0.01 0.001];
for ii = 1:4
    options = odeset('MaxStep',h(ii));
    [T,X] = ode45(@(t,x) [x(2); -g/l*sin(x(1))], 0:0.1:500, [3.14159; 0], options);
    % for problem 9
    if ii == 1
        sol1 = X(:,1);
        sol1_2 = X(:,2);
    elseif ii == 2
        sol2 = X(:,1);
        sol2_2 = X(:,2);
    elseif ii == 3
        sol3 = X(:,1);
        sol3_2 = X(:,2);
    else
        sol4 = X(:,1);
        sol4_2 = X(:,2);
    end
    X = X(1:500,:);
    save(['E' num2str(ii) '.dat'],'X','-ascii')
end

%% Problem 9: Writeup
clf
subplot(4,1,1)
plot(T,sol1,'r','Linewidth',2)
hold on
plot(T,sol1_2,'b')
title(['Maximum Timestep = ' num2str(h(1))])
axis([0 500 -110 10])
legend('\theta(t)','\phi(t)','Location','southwest')
for ii = 2:4
    subplot(4,1,ii)
    plot(T,eval(['sol' num2str(ii)]),'r','Linewidth',2)
    hold on
    plot(T,eval(['sol' num2str(ii) '_2']),'b')
    title(['Maximum Timestep = ' num2str(h(ii))])
    axis([0 500 -4 4])
end
xlabel('Time, t')
print(gcf,'-dpng','near_heteroclinic_connection.png');





