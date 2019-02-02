close all; clear all; clc
% Homework 8
% Problem 1: finish calculating L matrix
A = [-2 3 7 1; 2 3 -4 1; 4 0 2 1; 3 5 2 -4];
% Problem 2
[L,~] = LUdecomp(A);
A1 = L;
[L,~,~] = lu(A);
A2 = L;

%% Problem 3
B = [10^-20 1; 1 1];
[L,U] = LUdecomp(B);
A3 = L*U;
[L,U,P] = lu(B);
A4 = P^(-1)*L*U;

%% Problem 4
A = [2 1 1; 4 3 3; 8 7 9];
[L,U,P] = LUpivot(A);
A5 = P;
A6 = L*U;

%% Problem 5
inf_sum = pi^2/6;
partial_sum = single(0);
for n = 1:1000
    partial_sum = partial_sum+1/n^2;
end
partial_sum = double(partial_sum);
A7 = (inf_sum-partial_sum)/inf_sum*1000; % relative error

partial_sum = single(0);
for n = 1:5000
    partial_sum = partial_sum+1/n^2;
end
partial_sum = double(partial_sum);
A8 = (inf_sum-partial_sum)/inf_sum*1000; % relative error

partial_sum = single(0);
for n = 1:10000
    partial_sum = partial_sum+1/n^2;
end
partial_sum = double(partial_sum);
A9 = (inf_sum-partial_sum)/inf_sum*1000; % relative error

partial_sum = single(0);
for n = flip(1:10000)
    partial_sum = partial_sum+1/n^2;
end
partial_sum = double(partial_sum);
A10 = (inf_sum-partial_sum)/inf_sum*1000; % relative error

for ii = 1:10
    save(['A' num2str(ii) '.dat'],['A' num2str(ii)],'-ascii')
end