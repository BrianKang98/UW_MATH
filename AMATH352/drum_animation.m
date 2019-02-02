function [] = drum_animation(lam,vec1)
% Creates an animation of a drum
% Inputs:
%   lam = eigenvalue of "drum" matrix
%   vec1 = corresponding eigenvector of "drum" matrix

dx = .1;

Lenx = 2.5;
Leny = 2.5;

xv = -Lenx:dx:Lenx;
yv = -Leny:dx:Leny;

Nx = numel(xv);
Ny = numel(yv);

[x,y] = meshgrid(xv,yv);

r1 = sqrt( (x).^2 + (y).^2 );
domain = r1 < 2;


clf
framerate = 1/15;
if abs(lam-26044) < 1000
    framerate = 1/10;
end

for tt=1:100
    
    vec1_reshape = 0*x;
    vec1_reshape(domain) = vec1;
    
    cla
    surf(x,y,vec1_reshape*sin(tt*framerate*sqrt(lam)/1.2))
    hold on
    ff = 0*x;
    ff(domain) = nan;
    title(sqrt(lam));
    axis tight
    zlim([-1 1]*.1);
    caxis([-1 1]*.1);
    shading flat
    surf(x,y,ff,'facecolor','k');
    daspect([1 1 .1]);
    view([-40 8])
    pause(framerate);
end

hold off


end

