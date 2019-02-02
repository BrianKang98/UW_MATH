close all; clear all; clc
% Homework 9
% Problem 1
A = [5 1 2 5 3; 1 8 5 9 3; 2 3 8 3 3; 5 5 8 8 5; 7 2 1 1 4];
[V,D] = eig(A);
A1 = max(abs(diag(D)));
A2 = V(:,find(A1)); % eigenvector

%% Problem 2
% initial guess
x0 = [1; 0; 0; 0; 0];
xn = x0;
for ii = 1:10
    y = A*xn;
    xn = y/norm(y);
end
lambda = dot((A*xn),xn)/norm(xn)^2;
A3 = norm(A2-xn)/norm(A2)*1000; % relative error of eigenvector
A4 = (lambda-A1)/A1*1000; % relative error of eigenvalue

%% Problem 3
An = A;
n = size(A,1);
V = eye(n);
for ii = 1:10
    [Q,R] = qr(An);
    An = R*Q;
    V = V*Q;
end
A5 = diag(An);
A6 = V(:,size(V,2));

%% Problem 4
A = [7 9 -5 5; 9 7 5 -5; -5 5 7 9; 5 -5 9 7];
% initial guess
x0 = [1; 0; 0; 0];
xn = x0;
for ii = 1:20
    y = A*xn;
    xn = y/norm(y);
end
lambda = (A*xn)'*xn/norm(xn)^2;
A7 = [lambda; xn];

% initial guess
x0 = [0; 0; 0; 1];
xn = x0;
for ii = 1:20
    y = A*xn;
    xn = y/norm(y);
end
lambda = (A*xn)'*xn/norm(xn)^2;
A8 = [lambda; xn];

%% Problem 5
load('drum.mat')
[V,D] = eig(drum);
eigvals = diag(D);
temp = sort(eigvals,'ascend');  % eigenvaules from small to big
A9 = temp(1:10);

freq = [82.2; 158; 217; 227];
temp2 = sqrt(A9); % square roots of the eigenvalues
closeVal = zeros(4,1);
% actVal = zeros(4,1);   % for Extra Credit
for ii = 1:4
    n = freq(ii);
    dist = abs(temp2-n);
    minDist = min(dist);
    index = find(dist == minDist);
    closeVal(ii) = temp2(index);
%     actVal(ii) = A9(index); % eigenvalues of A10 but not sqrt-ed
end
A10 = sort(closeVal,'ascend');

% % Extra Credit plots
% indxs = zeros(4,1);
% for ii = 1:4
%     n = actVal(ii);
%     dist = abs(eigvals-n);
%     index = find(dist == 0);
%     indxs(ii) = index;
%     
%     % plot and save figures
%     drum_figure(D(indxs(ii)),V(:,indxs(ii)));
%     print(gcf,'-dpng',['drumfig' num2str(ii) '.png']);
% end
% fig1 = imread('drumfig1.png');
% fig2 = imread('drumfig2.png');
% fig3 = imread('drumfig3.png');
% fig4 = imread('drumfig4.png');
% finFig = montage([fig1, fig2; fig3, fig4]);
% print(gcf,'-dpng','drumfigs.png');
% 
% % just extra simulations
% drum_animation(D(indxs(1)),V(:,indxs(1)));
% drum_animation(D(indxs(2)),V(:,indxs(2)));
% drum_animation(D(indxs(3)),V(:,indxs(3)));
% drum_animation(D(indxs(4)),V(:,indxs(4)));

for ii = 1:10
    save(['A' num2str(ii) '.dat'],['A' num2str(ii)],'-ascii')
end





