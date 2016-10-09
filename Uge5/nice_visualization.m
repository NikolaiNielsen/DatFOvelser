%% Visualisering i 2d og 3d

clear all
close all
clc

x = linspace(0,4*pi);
y = linspace(0,4*pi,50);

xx = x'*ones(1,length(y));
yy = ones(length(x),1)*y;

s = sin(xx).*cos(yy);
vx = sin(yy);
vy = cos(xx);

figure
hold on
imagesc(x,y,s);
colorbar;
