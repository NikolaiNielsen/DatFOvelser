%function r=orbit(r, v, m, tend, dt, graph, nplot

function r=orbit
% main routine for the orbit calculations of the 3 body problem.
% initialise the start positions here and then solve for the
% trajectory. Finally plots the three trajectories for a comparison
% with the provided image.

global G ETA DT_INIT Ekin Epot T JJ rp
%load('rtest.mat');
r=[1 -2 1 2 0 1; 3 -1 -1 1 -3 0; 0 0 0 0 0 0];     % initial data
v=[0 0 0 0 0 0; 0 0 0 0 0 0; 0 0 0 0 0 0];
m=[3 4 5 7 2 5];
% m = [m;m;m];
DT_INIT=5e-2;                                      % first timestep
tend=.4;                                           % end time of integration

simple=true;                                      % choice of dA/dt algorithm (false => analytic equation

if simple == true                                 % needed variables when using the analytic expression for dA/dt
   s=size(r);
%    aold=zeros(s);
   rv_old=0;
end
G = 1;
ETA=1e-3;                                           % Scaling of the time stepping
dt=DT_INIT;                                        % first dt value

t=0;                                               % Start time
ii=1;                                              % number of integration steps

rv=rvec(r);                                        % variable calculations needed for deriving energy quantities
rl=rvlen(rv);
E=energy(m,rl,v);
Epot=E(1);                                         % variables to contain the energy values for plotting
Ekin=E(2);
T=0;                                               % Time variable for energy plotting
JJ=1;                                              % Number of data points in plot array
nplot=1000000;                                         % number of iterations between plotting
rp=r;                                              % first position point for plotting

while t < tend                                     % main loop for the integration
   %dtold=dt;
   rv=rvec(r);            	                   % 3xnxn
   rl=rvlen(rv);          	                   % 3xn
   a=acc(m,rv,rl);        	                   % 3xnxn

   if simple==true                                 % The simple approximation for dA/dt
      aa = zeros(s);%[aa,simple]=aac(a,aold,dtold,ii); 	                   % 3xn
      %aold=a;
	  simple = false;
   else
      aa=aac_full(m, rv, rl, v); 	   % 3xn The more correct version of dA/dt
      rv_old=rv;
   end

   dt=dtval(a,aa,ii);                              % dt determination
   vn=vstep(v,a,aa,dt);	                           % updating the velocity vectors
   rn=rstep(r,v,a,aa,dt);	                   % updating the position vectors

   if (fix(ii/nplot) == ii/nplot)
      plot_data(m, rn, vn, t, tend);
   end

   r=rn;                                           % replace new variables in the ones to use
   v=vn;
   t=t+dt;
   ii=ii+1;
   %fprintf('ii = %d\ndt = %f\nt+dt = %f\n',ii,dt,t);
end

r(:,1)
end

%% rstep
function rn=rstep(r,v,a,aa,dt)
% calculate the time stepping of the point depending on eq(7)
rn=r+v.*dt+0.5.*a.*dt^2+1/6.*aa.*dt.^3;
end

%% rvec
function rv=rvec(r)
% calculate the distance between points (assumes r(3,#))
% where # represents the number of different vectors.
s=size(r);
rv=zeros(s(1),s(2),s(2));

for j=1:s(2)
  for k=1:s(2)
	rv(:,j,k)=r(:,j)-r(:,k);
  end
end

end

%% rvlen
function rl=rvlen(rv)
% calculate the length of the vectors (rv(3,#) or rv(3,#,#) format)

s=size(rv);

if ndims(rv) == 3 && s(1) == 3
  rl=zeros(s(2),s(3));
  rl(:,:)=sqrt(rv(1,:,:).^2+rv(2,:,:).^2+rv(3,:,:).^2);
elseif ndims(rv) == 2 && s(1) == 3
  rl=zeros(1,s(2));
  for j=1:s(1)
    rl(j)=sqrt(rv(1,j).^2+rv(2,j).^2+rv(3,j).^2);
  end
else
    fprintf('The rvlen routine does not support the dimension of rv: (%i %i)\n',s)
    fprintf('has to be of dimension (3,#) or (3,#,#)\n')
    rl=-1;
end

end

%% vstep
function vn=vstep(v,a,aa,dt)

% calculate the time stepping of the point depending on eq(5)

      vn=v+dt*a+0.5*aa*dt^2;

end

%% acc
function a=acc(m,rv,rl)

% calculate the acceleration of the object eq(3)

global G
%load('rtest.mat');
s=size(rv);
a=zeros(s(1),s(2));
b = zeros(s(1),s(2),s(2));

for in=1:s(2)
	for out=1:s(2)
		if in ~= out
			%fprintf('in = %d\nout = %d\n',in,out)
			b(:,out,in) = G*m(out)*rv(:,in,out)/rl(in,out)^3;
			a(:,in)=a(:,in)-b(:,out,in);
		end
	end
end

% a
% acc_test
end

%% dtval
function dt=dtval(a, aa, ii)

% determine the time step dependent on acceleration changes using eq(8)

global ETA DT_INIT

if ii > 2
  al=rvlen(a);
  aal=rvlen(aa);
  dt=min(ETA*3*al./aal);
else
  dt=DT_INIT;
end

end

%% plot_data
function plot_data(m, rn, vn, t, tend)

% plot the trajectory of the particles and their potential/kineti and total energy

global JJ Ekin Epot rp T
col=[ '-g' '-b' '-r' '-k' '-c' '-m'];
JJ=JJ+1;
rp(:,:,JJ)=rn;                               % add point for later plotting
subplot(3,1,1:2)                             % make two plots
rx=zeros(1,length(rp(1,1,:))); ry=rx;        % create arrays to hold plot data
rx(:)=rp(1,1,:);
ry(:)=rp(2,1,:);
hold off                                     % freeze plot frame
plot(rx,ry,'-r')                             % plot first data set
axis ([-2 2 -3.1 3.1])
xlabel('x position') ; ylabel('y position'); title(['A multi body problem at time ',num2str(t,'%6.2f')]);
hold all                                     % keep plot frame setup
for k=2:length(m)                            % add the other objects to the plot
    rx(:)=rp(1,k,:);
    ry(:)=rp(2,k,:);
    plot(rx,ry,col(k*2-1:k*2))
end

subplot(3,1,3)                                % set the plot area to the second one
rv=rvec(rn);                                  % calculate data for energy calculation
rl=rvlen(rv);
E=energy(m,rl,vn);
Ekin(JJ)=E(2);                                % Store values in data arrays for plotting
Epot(JJ)=E(1);
T(JJ)=t;
hold off
plot(T,Ekin,'-r',T,Epot,'-b',T,Ekin+Epot,'-g') % plot the energy data
axis ([0 tend -700 500]);
xlabel('Time'); ylabel('Energy');
%legend('E kin','E pot','E total');

drawnow;                                      % force the updating of the plot frame to take place
end

%% aac_full
function accdot=aac_full(m, rv, rl, v)

global G
% determine the derivative using eq(4) in exercise 3.

n=size(m,2);
accdot=zeros(3,n);
for in=1:n
	for out=1:n
		if in ~= out
			accdot(:,in)=accdot(:,in)-G.*m(out).*(v(:,in)./rl(in,out).^3- ...
			3.*rv(:,in,out).*sum(rv(:,in,out).*v(:,in))./(rl(in,out).^5));
		end
	end
end

end

%% energy
function E=energy(m,rl,v)

global G
% calculate the energy of the particles at each timestep

n=length(m);

% kinetic energy: 0.5*m*v^2
Ek=0;
for i=1:3
    Ek=Ek+0.5*sum(m(:).*v(i,:)'.^2,1);
end

% potential energy  -Gm_i m_j/|r_ij|
Ep=0;
for i=1:n
    for j=i+1:n
        Ep=Ep-G*m(i)*m(j)/rl(i,j);
    end
end

E=[Ep Ek];

end
