% Problem 1
s = 1/sqrt(2);
w_6 = 4;
w_7 = 10;
w_8 = 5;
A = zeros(13);
% set up matrix A
A(1,1)=-s;A(1,2)=1;A(1,10)=s;
A(2,1)=-s;A(2,9)=-1;A(2,10)=-s;
A(3,2)=-1;A(3,3)=1;
A(4,11)=-1;
A(5,3)=-1;A(5,4)=s;A(5,12)=-s;
A(6,4)=-s;A(6,12)=-s;A(6,13)=-1;
A(7,4)=-s;A(7,5)=-1;
A(8,5)=1;A(8,6)=-1;
A(9,13)=1;
A(10,6)=1;A(10,7)=-1;A(10,10)=-s;A(10,12)=s;
A(11,10)=s;A(11,11)=1;A(11,12)=s;
A(12,7)=1;A(12,8)=-1;
A(13,9)=1;
% set up vector b
b = [0;0;0;0;0;0;0;0;w_6;0;w_7;0;w_8];
% save the matrix A to file
save("A1.dat", "A", "-ascii")

% Problem 2
x = A\b;
% save the vector x to file
save("B1.dat", "x", "-ascii")
for ii = 1:13
    if abs(x(ii,1)) < 10^-4
        % save truss number to file
        save("B2.dat", "ii", "-ascii")
        break;
    end
end

% Problem 3
% will skip when a value >= 30
while max(abs(x)) < 30
    % until then keep updating
    w_6 = w_6 + 0.01;
    b = [0;0;0;0;0;0;0;0;w_6;0;w_7;0;w_8];
    x = A\b;
end
% save the weight and vector to file
save("C1.dat", "w_6", "-ascii")
save("C2.dat", "x", "-ascii")

% Problem 4
% return to default
w_6 = 4;
b = [0;0;0;0;0;0;0;0;w_6;0;w_7;0;w_8];
x = A\b;
% will skip when a value >= 26 || <= -40
while max(x) < 26 && min(x) > -40
    % until then keep updating
    w_6 = w_6 + 0.01;
    b = [0;0;0;0;0;0;0;0;w_6;0;w_7;0;w_8];
    x = A\b;
end
% save the weight and vector to file
save("D1.dat", "w_6", "-ascii")
save("D2.dat", "x", "-ascii")
