function [] = drum_figure(lam,vec1)
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
    
vec1_reshape = 0*x;
vec1_reshape(domain) = vec1;
    
cla
surf(x,y,vec1_reshape)
hold on
ff = 0*x;
ff(domain) = nan;
title(sqrt(lam));
axis tight
shading flat
surf(x,y,ff,'facecolor','k');
daspect([1 1 .1]);
view([-40 25])
hold off


end

