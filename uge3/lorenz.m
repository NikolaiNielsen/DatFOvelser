function [x,y,z] = lorenz(x0,y0,z0,t,dt,dt_gem)
tal = 0;
sigma = 10;
beta = 8/3;
rho = 28;

if x0 == 0 && y0 == 0 && z0 == 0
	disp('Nein! Du må ikke bruge 0,0,0 som startpunkt')
	return
end

% Til udregning af næste tidsskridt
nextstep = @(x,dx1,dx0) x+(1.5*dx1-0.5*dx0)*dt;

% tæller, der holder styr antallet af gemte punkter
% nsave = 2;


% savetime = t/dt_gem;
nextsave = dt_gem;

xsave(1) = x0;
ysave(1) = y0;
zsave(1) = z0;

x(1) = x0;
y(1) = y0;
z(1) = z0;
dx(1) = sigma*(y(1)-x(1));
dy(1) = x(1)*(rho-z(1))-y(1);
dz(1) = x(1)*y(1)-beta*z(1);

x(2) = x(1) + dx(1)*dt;
y(2) = y(1) + dy(1)*dt;
z(2) = z(1) + dz(1)*dt;

while tal <= t
	% Regner differentialerne fra 
	dx(end+1) = sigma*(y(end)-x(end));
	dy(end+1) = x(end)*(rho-z(end))-y(end);
	dz(end+1) = x(end)*y(end)-beta*z(end);
	
	x(end+1) = nextstep(x(end),dx(end),dx(end-1));
	y(end+1) = nextstep(y(end),dy(end),dy(end-1));
	z(end+1) = nextstep(z(end),dz(end),dz(end-1));
	
	if tal >= nextsave
		xsave(end+1) = x(end);
		ysave(end+1) = y(end);
		zsave(end+1) = z(end);
		
		nextsave = nextsave + dt_gem;
	end
	
	tal = tal + dt;
end

x = xsave;
y = ysave;
z = zsave;

end
