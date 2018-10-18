A = [-1 3;2 1];
B = [5 -4;1 -3];
C = [1 1 6;1 -9 -4];
D = [1 -4;1 -3;-2 3];
x = [2;0];
y = [0;-1];
z = [-2;4;1];
E = magic(4);

ansA = [];
for loop = 1:10
    if loop == 1
        ansA = A-B;
    elseif (loop == 2)
        ansA = 4*x-2*y;
    elseif (loop == 3)
        ansA = A*y;
    elseif (loop == 4)
        ansA = A*(y+x);
    elseif (loop == 5)
        ansA = D*x;
    elseif (loop == 6)
        ansA = D*y+z;
    elseif (loop == 7)
        ansA = A*B;
    elseif (loop == 8)
        ansA = B*A;
    elseif (loop == 9)
        ansA = A*C;
    else
        ansA = C*D;
    end
    save(['A' num2str(loop) '.dat'],'ansA','-ascii')
end

ansB = [];
for loop = 1:10
    if loop == 1
        ansB = A(:,1);
    elseif (loop == 2)
        ansB = B(2,:);
    else
        ansB = E(2:3,2:3);
    end
    save(['B' num2str(loop) '.dat'],'ansB','-ascii')
end
