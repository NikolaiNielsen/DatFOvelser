%% Nu med drivningskraft

n = 6005
t = 7.414159
gamma = 0
eps = 1.5
driven = 1
g = 1
l = 1
omega = 1

% Parametre
x(1) = 1;
y(1) = 0; 
dt = t/n;
omega = sqrt(g/l);

if driven == 1
% 	x = zeros(n,1);
% 	y = x;
% 	dx = x;
% 	dy = x;
	dx(2) = y(1);
	dy(2) = y(1)*(eps-x(1)^2)-x(1)*omega^2;
	x(2) = x(1)+dx(2)*dt;
	y(2) = y(1)+dy(2)*dt;
	for i = 3:n+1
		dx(i) = y(i-1);
		dy(i) = (eps-x(i-1)^2)*y(i-1)-omega^2*x(i-1);
		x(i) = x(i-1) + (1.5*dx(i)-0.5*(dx(i-1))) * dt;
		y(i) = y(i-1) + (1.5*dy(i)-0.5*(dy(i-1))) * dt;
	end
else
% 	x = zeros(n,1);
% 	y = x;
% 	dx = x;
% 	dy = x;
	dx(2) = y(1);
	dy(2) = -gamma*y(1)-omega^2*x(1);
	x(2) = x(1)+dx(2)*dt;
	y(2) = y(1)+dy(2)*dt;
	for i = 3:n+1
		dx(i) = y(i-1);
		dy(i) = -gamma*y(i-1)-omega^2*x(i-1);
		x(i) = x(i-1) + (1.5*dx(i)-0.5*(dx(i-1))) * dt;
		y(i) = y(i-1) + (1.5*dy(i)-0.5*(dy(i-1))) * dt;
	end
end