clear all; close all; clc;
x = 1;
y = 0;
n = 10000:1000:25000;
t = 2*pi;
g = 1;
l = 1;
gamma = 0;
dt = t./n;
omega = sqrt(g/l);

% afstand = zeros(2,length(n));
% for j = 1:length(n)
% 	px = zeros(n(j),1);
% 	py = px;
for i = 1:n(j)
	dx = y;
	dy = -gamma*y-omega^2*x;
	x = x + dx*dt(j);
	y = y + dy*dt(j);
	
	px(i) = x;
	py(i) = y;
end
% end
figure
hold on
axis equal
plot(px,py)

%% Bedre integration

clear all; close all; clc;
x0 = 1;
y0 = 0;
n = 400;
t = 2*pi;
g = 1;
l = 1;
gamma = 0;
dt = t./n;
omega = sqrt(g/l);

% afstand = zeros(2,length(n));
% for j = 1:length(n)
% 	px = zeros(n(j),1);
% 	py = px;
dx(1) = y0;
dy(1) = -gamma*y0-omega^2*x0;
x(1) = x0+dx(1)*dt;
y(1) = y0+dy(1)*dt;
for i = 2:n
	dx(i) = y(i-1);
	dy(i) = -gamma*y(i-1)-omega^2*x(i-1);
	x(i) = x(i-1) + (1.5*dx(i)-0.5*(dx(i-1))) * dt;
	y(i) = y(i-1) + (1.5*dy(i)-0.5*(dy(i-1))) * dt;
end
% end
figure
hold on
axis equal
plot(x,y)

%% Bedre integration og afstand

clear all; close all; clc;
format long
x0 = 1;
y0 = 0;
n = 400;
t = 2*pi;
g = 1;
l = 1;
gamma = 0;
dt = t./n;
omega = sqrt(g/l);

afstand = zeros(length(n),1);
for j = 1:length(n)
	x = zeros(n(j),1);
	y = x;
	dx = x;
	dy = x;
dx(1) = y0;
dy(1) = -gamma*y0-omega^2*x0;
x(1) = x0+dx(1)*dt(j);
y(1) = y0+dy(1)*dt(j);
afstand(1) = 0;
for i = 2:n(j)+1
	dx(i) = y(i-1);
	dy(i) = -gamma*y(i-1)-omega^2*x(i-1);
	x(i) = x(i-1) + (1.5*dx(i)-0.5*(dx(i-1))) * dt(j);
	y(i) = y(i-1) + (1.5*dy(i)-0.5*(dy(i-1))) * dt(j);
% 	afstand(i) = sqrt((x(1)-x(i))^2 + (y(1)-y(i))^2 );
end
afstand(j) = sqrt((x(1)-x(end))^2 + (y(1)-y(end))^2 );
end
figure
hold on
axis equal
plot(x,y)
% afstand

%% Bedre integration med gamma

clear all; close all; clc;
format long
x0 = 1;
y0 = 0;
n = 400;
t = 2*pi;
g = 1;
l = 1;
gamma = 0:0.05:2;
dt = t./n;
omega = sqrt(g/l);
figure
hold on
axis equal
for j = 1:length(gamma)
	x = zeros(n,1);
	y = x;
	dx = x;
	dy = x;
dx(1) = y0;
dy(1) = -gamma(j)*y0-omega^2*x0;
x(1) = x0+dx(1)*dt;
y(1) = y0+dy(1)*dt;
% afstand(1) = 0;
for i = 2:n+1
	dx(i) = y(i-1);
	dy(i) = -gamma(j)*y(i-1)-omega^2*x(i-1);
	x(i) = x(i-1) + (1.5*dx(i)-0.5*(dx(i-1))) * dt;
	y(i) = y(i-1) + (1.5*dy(i)-0.5*(dy(i-1))) * dt;
% 	afstand(i) = sqrt((x(1)-x(i))^2 + (y(1)-y(i))^2 );
pause(0.001)
	plot(x(i),y(i),'r.')
end
% plot(x,y)
% afstand(j) = sqrt((x(1)-x(end))^2 + (y(1)-y(end))^2 );
end
% figure
% hold on
% axis equal
% plot(x,y)
% afstand

%% Nu med drivningskraft
clear all; close all; clc;
format long

% Parametre
x0 = 1;
y0 = 0;
n = 6e4;
t = 8*pi;
g = 1;
l = 1;
epsilon = [0,1,0];
gamma = [0.1,0,0];
driven = [0,1,0];
dt = t./n;
omega = sqrt(g/l);

figure
hold on
axis equal
for j = 1:length(driven)
	if driven(j) == 1
		disp('driven')
		x = zeros(n,1);
		y = x;
		dx = x;
		dy = x;
		dx(1) = y0;
		dy(1) = y0*(epsilon(j)-x0^2)-x0*omega^2;
		x(1) = x0+dx(1)*dt;
		y(1) = y0+dy(1)*dt;
		for i = 2:n+1	
			dx(i) = y(i-1);
			dy(i) = (epsilon(j)-x(i-1)^2)*y(i-1)-omega^2*x(i-1);
			x(i) = x(i-1) + (1.5*dx(i)-0.5*(dx(i-1))) * dt;
			y(i) = y(i-1) + (1.5*dy(i)-0.5*(dy(i-1))) * dt;
% 			plot(x(i),y(i),'.')
% 			pause(0.1)
		end
	else
		x = zeros(n,1);
		y = x;
		dx = x;
		dy = x;
		dx(1) = y0;
		dy(1) = -gamma(j)*y0-omega^2*x0;
		x(1) = x0+dx(1)*dt;
		y(1) = y0+dy(1)*dt;
		for i = 2:n+1
			dx(i) = y(i-1);
			dy(i) = -gamma(j)*y(i-1)-omega^2*x(i-1);
			x(i) = x(i-1) + (1.5*dx(i)-0.5*(dx(i-1))) * dt;
			y(i) = y(i-1) + (1.5*dy(i)-0.5*(dy(i-1))) * dt;
		end
	end
	plot(x,y)
end