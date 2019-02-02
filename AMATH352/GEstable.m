function [Aug] = GEstable(A,b)

n = size(A,1);
Aug = [A b];

for i = 1:n
    % part a
    % Search for largest abs value and swap row to main diagonal
    big = max(abs(Aug(i:n,i))); % check ones on or below the main diagonal
    if Aug(i,i) ~= big
        k = find(abs(Aug(i:n,i))==big,1)+i-1; % search for the row to be swapped
        temp = Aug(k,:);
        Aug(k,:) = Aug(i,:);
        Aug(i,:) = temp;
    end
    
    % part b
    % If the diagonal element is now not zero, make it a 1
    if Aug(i,i) ~= 0
        tmp = Aug(i,i);
        Aug(i,:) = Aug(i,:) / tmp;
    end
    
    % part c
    % Zero out all of the non-diagonal elements of column i
    for j=[1:(i-1) (i+1):n]
        m = Aug(j,i);
        Aug(j,:) = Aug(j,:) - m*Aug(i,:);
    end
end

end