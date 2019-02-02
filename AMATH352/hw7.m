close all; clear all; clc
% Homework 7
% Problem 1
A = [2 3 -1 5; 3 -4 2 6; 2 1 5 7; 2 0 1 2];
b = [16; 54; 40; 15];
A1 = cond(A);   % condition number
temp = GE(A,b);
xn = temp(:,(size(temp,2)));
xe = [2; -4; 1 ;5];
A2 = norm(xe-xn)/norm(xe);  % relative error

%% Problem 2
A = [10^-8 10^8 3; 1 0 4; -1 0 2];
b = [2*10^8; -1; 1];
A3 = cond(A);   % condition number
temp = GE(A,b);
xn = temp(:,(size(temp,2)));
xe = [-1; 2+10^-16; 0];
A4 = norm(xe-xn)/norm(xe);  % relative error

%% Problem 3: better GE algorithm function
temp = GEstable(A,b);
xn = temp(:,(size(temp,2)));
A5 = xn;
A6 = norm(xe-xn)/norm(xe);  % relative error

%% Problem 4: requires problem 3
A = hilb(15);
xe = ones(15,1);
A7 = cond(A);   % condition number
b = A*xe;
temp = GE(A,b);
xn = temp(:,(size(temp,2)));
A8 = norm(xe-xn)/norm(xe);  % relative error
temp = GEstable(A,b);
xn = temp(:,(size(temp,2)));
A9 = xn;
A10 = norm(xe-xn)/norm(xe);  % relative error

for ii = 1:10
    save(['A' num2str(ii) '.dat'],['A' num2str(ii)],'-ascii')
end
