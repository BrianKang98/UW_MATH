function [L,U] = LUdecomp(A)
% Perform an LU decomposition 
% Input: a square matrix A
% Outputs: A lower triangular matrix L and an upper triangular matrix U 
%          such that A = LU

n = size(A,1);
L = eye(n); % L starts as the nxn identity matrix

for i = 1:n-1
    for j=(i+1):n
        m = A(j,i) / A(i,i);
        A(j,:) = A(j,:) - m*A(i,:);
        L(j,i) = m;
    end
end

U = A;


end

