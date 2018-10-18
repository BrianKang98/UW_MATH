% Problem 5
% first plot
close all; clear all;
clf
set(gcf,'position',[20 50 600 250],'paperpositionmode','auto')
nodes = [0 0; 1 1; 2 1; 3 1;
    4 0; 3 0; 2 0; 1 0];
trusses = [1 2; 2 3; 3 4; 4 5; 5 6;
    6 7; 7 8; 8 1; 2 8; 2 7;
    3 7; 4 7; 4 6];
for ii = 1:13
    mytruss = trusses(ii,:);
    plot(nodes(mytruss,1), nodes(mytruss,2), 'Linewidth', 3)
    axis equal
    axis ([-0.5 4.5 -0.5 1.5])
    xticks(0:4)
    yticks(0:1)
    title('Trusses of Bridge')
    hold on
end
print(gcf,'-dpng','bridge_trusses.png');

%% second plot
plot(nodes(:,1), nodes(:,2), 'o', 'MarkerSize', 20, 'MarkerFaceColor', 'w', 'MarkerEdgeColor', 'k', 'Linewidth', 2)
title('Trusses and Nodes of Bridge')
print(gcf,'-dpng','bridge_nodes_and_trusses.png');

%% third plot
% bring back the force vector
s = 1/sqrt(2);
w_6 = 4;
w_7 = 10;
w_8 = 5;
A = zeros(13);
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
b = [0;0;0;0;0;0;0;0;w_6;0;w_7;0;w_8];
x = A\b;

clf
set(gcf,'position',[20 50 600 250],'paperpositionmode','auto')
nodes = [0 0; 1 1; 2 1; 3 1;
    4 0; 3 0; 2 0; 1 0];
trusses = [1 2; 2 3; 3 4; 4 5; 5 6;
    6 7; 7 8; 8 1; 2 8; 2 7;
    3 7; 4 7; 4 6];
% plot the bridge
for ii = 1:13
    myColor = 'r';
    mySize = abs(x(ii));
    if x(ii) >= 0
        myColor = 'g';
        if abs(x(ii)) < 1
            mySize = 1;
        end
    end
    mytruss = trusses(ii,:);
    if abs(x(ii)) > 1
        plot(nodes(mytruss,1), nodes(mytruss,2), 'Linewidth', mySize, 'color', myColor)
    else
        plot(nodes(mytruss,1), nodes(mytruss,2), '--', 'Linewidth', mySize, 'color', myColor)
    end
    axis equal
    axis ([-0.5 4.5 -0.5 1.5])
    xticks(0:4)
    yticks(0:1)
    title('Forces on Truss Bridge')
    hold on
end
% plot the circles
plot(nodes(:,1), nodes(:,2), 'o', 'MarkerSize', 20, 'MarkerFaceColor', 'w', 'MarkerEdgeColor', 'k', 'Linewidth', 2)
print(gcf,'-dpng','bridge_forces.png');


