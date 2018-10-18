% Homework #1
% Problem 1
a1 = zeros(1,11);
for ii = 1:11
    a1(ii) = 2*ii-1;
end
save('A1.dat','a1','-ascii')

a2 = [sqrt(5); exp(2); cos(1)];
save('A2.dat','a2','-ascii')

a3 = zeros(3,5);
save('A3.dat','a3','-ascii')

%% Problem 2
A = [3 1; -3 5];
B = [2 -1; 4 -2];
C = [-4 2; 1 -3; -2 2];
x = [3; -2];
y = [4; 1];

a4 = A+B;
a5 = 4*x-3*y;
a6 = B*x;
a7 = C*y;
a8 = B*A;

for ii = 4:8
    save(['A' num2str(ii) '.dat'],['a' num2str(ii)],'-ascii')
end