%% Egen test
clear all
close all

nx = 30;			% Antal grid-punkter
A = .1;				% Amplituden af den magnetiske b�lge
dx = 2*pi/nx;		% afstanden mellem hvert x-punkt
x = dx:dx:2*pi;		% alle x-koordinater
k = 1;				% b�lgetallet
B0 = A*sin(k*x);	% Startv�rdien for b�lgens position
v0 =zeros(1,nx);	% Startv�rdien for b�lgens hastighed
dt = dx/3;			% tidslig skridt (der skal bruges 3, da det er en
					% "tre-trins-raket"

t = 6;
t_gem = dt;

[B,v,t_snap] = alfven(x,B0,v0,t,dt,t_gem);

figure
hold on
surf(x,t_snap,v);   % plotter med de korrekte v�rdier p� de to akser
shading interp;      % pr�v med og uden denne
colormap jet;        % v�lger en farvetabel
title('Alfven wave')
xlabel('x-position')
ylabel('t-time')

%% Med Klaus' data
clear all
close all
n = 2.01e+02;
tend = pi;
Lx = 2*pi;
t_gem = pi/2;
A = 5.0e-02;
k = 1;
dt = 1.041988e-2;
x = dt*3:dt*3:Lx;
B0 = A*sin(k*x); v0 = A*sin(k*x);

[B,v,t_snap] = alfven(x,B0,v0,tend,dt,t_gem);

figure
hold on
surf(x,t_snap,v);   % plotter med de korrekte v�rdier p� de to akser
shading interp;      % pr�v med og uden denne
colormap jet;        % v�lger en farvetabel
title('Alfven wave')
xlabel('x-position')
ylabel('t-time')