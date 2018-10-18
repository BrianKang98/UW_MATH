% Problem 1
% Scorelator Portion
n = 40;
v = ones(1,n)*-2;
v_d = ones(1,n-1);
v_u = ones(1,n-1);
A = diag(v,0) + diag(v_d,-1) + diag(v_u,1);
save('A1.dat','A','-ascii');
dx = 1/(n+1);
tmp = (1:n).';
b = dx^2*sin(2*pi*dx*tmp);
save('A2.dat','b','-ascii');

%% Problem 2
x_backslash = A\b;
save('B1.dat','x_backslash','-ascii');
[L,U,P] = lu(A);
save('B2.dat','L','-ascii');
save('B3.dat','U','-ascii');
save('B4.dat','P','-ascii');
y = L\(P*b);
save('B5.dat','y','-ascii');
x_lu = U\y;
save('B6.dat','x_lu','-ascii');
% check
% norm(x_lu - x_backslash)

%% Problem 3
D = diag(diag(A));
T = A - D;
% initial guess
x = ones(n,1);
for ii = 1:2000
    xnew = - D \ (T*x - b);
    x = xnew;
end
x_jacobi_1s = x;
save('C1.dat','x_jacobi_1s','-ascii');
% check
% norm(x_jacobi_1s - x_backslash)
% next initial guess
x = zeros(n,1);
for ii = 1:2000
    if norm(A*x - b) < 10^-5
        break;
    end
    xnew = - D \ (T*x - b);
    x = xnew;
end
x_jacobi_0s = x;
save('C2.dat','x_jacobi_0s','-ascii');
% check
% norm(x_jacobi_0s - x_backslash)

%% Problem 4
% Writeup Portion
clf
set(gcf,'position',[20 50 600 300],'paperpositionmode','auto')
subplot(1,2,1)
spy(A, 'k')
title('Sparsity Structure of A')
xlabel('Column, j')
ylabel('Row, i')
subplot(1,2,2)
spy(A==-2, 'k')
hold on
spy(A==1, 'r')
title('Elements of A')
xlabel('Column, j')
ylabel('Row, i')
legend('A_{i,j} = -2','A_{i,j} = 1','Location','northeast')
print(gcf,'-dpng','structure_A.png');

%% Problem 5
clf
set(gcf,'position',[20 50 600 300],'paperpositionmode','auto')
subplot(1,2,1)
spy(diag(diag(L)), 'k')
hold on
spy(tril(L,-1), 'g')
title('Sparsity Structure of L')
xlabel('Column, j')
ylabel('Row, i')
subplot(1,2,2)
spy(diag(diag(U)), 'k')
hold on
spy(triu(U,1), 'g')
title('Sparsity Structure of U')
xlabel('Column, j')
ylabel('Row, i')
print(gcf,'-dpng','structure_LU.png');

%% Problem 6
ts = linspace(0,1,n+2).';
ts = ts(2:end-1);
clf
subplot(2,1,1)
plot(ts,x_backslash,'k');
hold on
plot(ts,x_lu,'r.')
title('Solution by LU Decomposition')
ylabel('Solution')
legend('x=A\\b','Solution by LU Decomposition','Location','southeast')
subplot(2,1,2)
plot(ts,x_lu-x_backslash,'r.')
ylabel('Error')
print(gcf,'-dpng','error_lu.png');

clf
plot(x_jacobi_1s,'g*');
title("Solution by Jacobi – initial condition all 1's")
print(gcf,'-dpng','error_jacobi_1s.png');
clf
plot(x_jacobi_0s,'bo');
title("Solution by Jacobi – initial condition all 0's")
print(gcf,'-dpng','error_jacobi_0s.png');