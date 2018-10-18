x1 = -10:0.1:10;
y1 = sin(x1);

x2 = [-5, sqrt(3) pi 4];
y2 = sin(x2);

x3 = linspace(-10, 10, 64);
y3 = x3.* sin(x3);

A = 2;

subplot(2,1,1)

plot(x1,y1, 'Linewidth',[2]), hold on
plot(x2,y2, 'co', 'Linewidth',[3])
plot(x3,y3, '-k.', 'Linewidth',[2])

%plot(x1,y1,x2,y2, 'g*',x3,y3, 'yd:', 'Linewidth',[3])

xlabel('x values','Fontsize',[15])
ylabel('y values', 'Fontsize',[15])
title(['my graph A = ' num2str(A)], 'Fontsize',[15])
text(1, 5, 'stuff', 'Fontsize',[15])

set(gca, 'Fontsize',[15])

grid on
%axis off

legend('data 1', 'data 2', 'data 3', 'Location', 'Best')

subplot(2,2,4)
plot(x3,y3, 'm:d', 'Linewidth',[2])
set(gca, 'Fontsize',[15])
grid on
