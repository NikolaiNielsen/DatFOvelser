%% Visualisering i 2d og 3d

clear all
close all
clc

figure(1)

% Først defineres 2d data
x = linspace(0,4*pi);
y = linspace(0,4*pi);

xx = x'*ones(1,length(y));
yy = ones(length(x),1)*y;

s = sin(xx).*cos(yy);

% surf contour
subplot(2,1,1)
hold on
colormap jet
axis equal
title('lpk331')
surfc(xx,yy,s)
view(3)
hold off


% Så 3d data
[x2,y2,z2,s2] = flow;
vx2 = sin(x2);
vy2 = cos(y2);
vz2 = cos(z2);

% Quiver3
subplot(2,1,2)
hold on
quiver3(x2,y2,z2,vx2,vy2,vz2)
view(24,27)
hold off

% Gemmer figuren som png
print('nice_visualization','-dpng')


