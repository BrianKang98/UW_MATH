% Homework 4
% Problem 1
A = [2 0; 0 1];
B = [1 0; 0 -1];
C = [1 0; 0 0];
D = [0 -1; 1 0];
E = [sqrt(3)/2 -1/2; 1/2 sqrt(3)/2];
F = [-sqrt(2)/2 -sqrt(2)/2; sqrt(2)/2 -sqrt(2)/2];
A1 = A*B*D;  %D is the first operation, A is last
A2 = D*F;
A3 = E.';
A4 = A^(-1)*2;
A5 = E*C*E.';
A6 = B*D*E;

% % for testing result
% plotv((B*D*E)*[1/2 1/2;1/2 1])
% axis([-2 2 -2 2])

% Problem 2
x = [1; 1; 1];
M1 = [1/6 1/3 1/2; 1/4 1/2 1/4; 1/3 1/3 1/3];
M2 = [1 0 1/2; 1/2 1/3 1/2; 0 1 1];
M3 = [1/4 1/2 -1/3; 1/2 1/4 -1/3; 1/4 1/2 1/4];
A7 = norm(x);
norms = [norm(M1^15*x); norm(M2^8*x); norm(M3^10*x)];
A8 = min(norms);
A9 = median(norms);
A10 = max(norms);

for ii = 1:10
    save(['A' num2str(ii) '.dat'],['A' num2str(ii)],'-ascii')
end






