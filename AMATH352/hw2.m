% Homework 2
% Problem 1
u = [exp(-2); pi/4; cos(2); -1/7];
v = [3; 1; -2; 4];
A1 = norm(u,2);  % norm(X) = norm(X,2)
A2 = norm(u,Inf);
A3 = norm(u,1);
A4 = [norm(u,3); norm(u,7); norm(u,15)];
A5 = u'*v;  % X'*Y = dot(X,Y)
A6 = acos(A5/(A1*norm(v)));
for ii = 1:6
    save(['A' num2str(ii) '.dat'],['A' num2str(ii)],'-ascii')
end

