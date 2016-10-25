function [x,y] = oscillator(n,t,gamma,epsilon,type,driven)

g = 1;
l = 1;
x = ones(n+1,1);
y = x;
x(1) = 1;
y(1) = 0;
dx = x;
dy = x;
omega = sqrt(g/l);
dt = t/n;

if driven == 1
	d = @(x,y) y*(epsilon-x.^2)-x*omega^2;
elseif driven == 0
	d = @(x,y) -gamma*y-omega^2*x;
end

if type == 0	% euler
	% vi introducerer en dummy-variabel dx0 til denne funktion,
	% så man ikke behøver flere if-statements eller for-loops.
	nextstep = @(x,dx1,dx0) x+dx1*dt;
else			% højereorden
	nextstep = @(x,dx1,dx0) x+(1.5*dx1-0.5*dx0)*dt;
end

dx(2) = y(1);
dy(2) = d(x(1),y(1));
x(2) = x(1)+dx(2)*dt;
y(2) = y(1)+dy(2)*dt;

for i = 3:n+1
	dx(i) = y(i-1);
	dy(i) = d(x(i-1),y(i-1));
	x(i) = nextstep(x(i-1),dx(i),dx(i-1));
	y(i) = nextstep(y(i-1),dy(i),dy(i-1));
% 	x(i) = x(i-1) + (1.5*dx(i)-0.5*(dx(i-1))) * dt;
% 	y(i) = y(i-1) + (1.5*dy(i)-0.5*(dy(i-1))) * dt;
end

