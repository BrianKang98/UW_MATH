function [L,U,P] = LUpivot(A)
% Perform an LU decomposition with partial pivoting
% Input: a square matrix A
% Outputs: A lower triangular matrix L and an upper triangular matrix U 
%          such that A = LU; and a permutation matrix P

n = size(A,1);
L = eye(n); % L starts as the nxn identity matrix
P = eye(n); % P starts as the nxn identity matrix

for i = 1:n-1
    
    % Search for largest abs value and swap row to main diagonal
    big = max(abs(A(i:n,i))); % check ones on or below the main diagonal
    if A(i,i) ~= big
        k = find(abs(A(i:n,i))==big,1)+i-1; % search for the row to be swapped
        % swap rows in A
        temp = A(k,:);
        A(k,:) = A(i,:);
        A(i,:) = temp;
        % swap rows in P
        temp2 = P(k,:);
        P(k,:) = P(i,:);
        P(i,:) = temp2;
        % swap the lower triangle in L
        if i >= 2
            temp3 = L(i,1:i-1);
            L(i,1:i-1) = L(k,1:i-1);
            L(k,1:i-1) = temp3;
        end
    end
    
    for j=(i+1):n
        m = A(j,i) / A(i,i);
        A(j,:) = A(j,:) - m*A(i,:);
        L(j,i) = m;
    end
end
U = A;

end

