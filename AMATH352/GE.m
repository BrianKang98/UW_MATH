function [Aug] = GE(A,b)
% Does Gaussian Elimination to solve Ax = b
% Inputs:
%   A - square matrix of coefficients
%   b - vector of right-hand side
% Outputs:
%   Aug - reduced augmented matrix

n = size(A,1);
Aug = [A b];


for i = 1:n
    
    % Check for a zero and swap rows if necessary
    if Aug(i,i) == 0
        for j = i+1:n
            if Aug(j,i) ~= 0
                tmp = Aug(i,:);
                Aug(i,:) = Aug(j,:);
                Aug(j,:) = tmp;
                break
            end
        end
    end
    
    % If the diagonal element is now not zero, make it a 1
    if Aug(i,i) ~= 0
        tmp = Aug(i,i);
        Aug(i,:) = Aug(i,:) / tmp;
    end
    
    % Zero out all of the non-diagonal elements of column i
    for j=[1:(i-1) (i+1):n]
        m = Aug(j,i);
        Aug(j,:) = Aug(j,:) - m*Aug(i,:);
    end
end



end

