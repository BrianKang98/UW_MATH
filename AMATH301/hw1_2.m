xs = linspace(-2*pi,2*pi);
f = @(x) 1 - x.^2 / 2;
clf
hold on
plot(xs,cos(xs),'k','Linewidth',[3]);
plot(xs,f(xs),'r--','Linewidth',[2]);

axis([-2*pi 2*pi -3 1.5])
xlabel('Space, x')
title('Taylor Approximation of Cosine')
legend('cos(x)','1 - x^2/2','Location','South')

print(gcf,'-dpng','plot_basic.png');
