close all; clear all; clc
% HW6
% Problem 1
A = [4+10^(-16) 2; 2 1];
A1 = [2; 10^(-16)];
A2 = [rank(A); det(A)];

%% Problem 2
% override A
A = [1 10^8; 10^8 10^16];
A3 = [1; 0];
A4 = [rank(A); det(A)];

%% Problem 3
% override A
A = zeros(13,13);
A(1,1)=-1/2; A(1,2)=1; A(1,10)=1/2;
A(2,1)=-sqrt(3)/2; A(2,9)=-1; A(2,10)=-sqrt(3)/2;
A(3,2)=-1; A(3,3)=1;
A(4,11)=-1;
A(5,3)=-1; A(5,4)=1/2; A(5,12)=-1/2;
A(6,4)=-sqrt(3)/2; A(6,12)=-sqrt(3)/2; A(6,13)=-1;
A(7,4)=-1/2; A(7,5)=-1;
A(8,5)=1; A(8,6)=-1;
A(9,13)=1;
A(10,6)=1; A(10,7)=-1; A(10,10)=-1/2; A(10,12)=1/2;
A(11,10)=sqrt(3)/2; A(11,11)=1; A(11,12)=sqrt(3)/2;
A(12,7)=1; A(12,8)=-1; 
A(13,9)=1;

b = zeros(13,1);
b(9)=10000; b(11)=11500; b(13)=15000; 
x = A\b;
A5 = norm(x,Inf);

A6 = zeros(10,1);
for ii = 1:10
    % override Wf(b5)
    b(9) = b(9)+1000;
    x = A\b;
    A6(ii) = norm(x,Inf);
end

%% Problem 4
% override A,x
A = hilb(15);
x = ones(15,1);
b = A*x;
A7 = b;
A8 = norm(A\b-x)/norm(x);

for ii = 1:8
    save(['A' num2str(ii) '.dat'],['A' num2str(ii)],'-ascii')
end
