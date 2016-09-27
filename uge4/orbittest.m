%% Test af orbit:

clear all
close all
clc

global G

rnext = @(r,v,a,adt,dt) r+v.*dt+1/2.*a.*dt.^2+1/6.*adt.*dt.^3;
vnext = @(v,a,adt,dt) v+a.*dt + 1/2.*adt.*dt.^2;

% Startbetingelser
r_init = [1 -2 1; 3 -1 -1; 0 0 0];	% Objekternes startpositioner
v_init = [0 0 0; 0 0 0; 0 0 0];		% objekternes starthastigheder
m = [3 4 5];						% Masserne af objekterne
t_end = 2;							% Sluttiden
dt_initial = 5e-2 ;					% Det første tidsskridt
graph_on_off = false;				% Om der skal plottes eller ej
n_plot = 2;						% Antal tidsskridt per plot
G = 1;								% Gravitationskonstant

i = 1;								% tællevariabel
t = 0;								% tidsvariabel


% Initialisering af arrays og input af startværdier
r(:,:,i) = r_init;
rt(:,:,1) = r_init;
v(:,:,i) = v_init;
nextsave = n_plot;
Adot(:,:,i) = zeros(3,size(r_init,2));
dt(1) = dt_initial;
dt(2) = dt_initial;

rv = rvec(r(:,:,end));
rl = rvlen(rv);
acc(:,:,i) = accvec(m,rv,rl);


t = t+dt(end);
i = i+1;

while t <= t_end
	
	r(:,:,end+1) = rnext(r(:,:,end),v(:,:,end),acc(:,:,end),Adot(:,:,end),dt(end));
	
	rv = rvec(r(:,:,end));
	rl = rvlen(rv);
	acc(:,:,end+1) = accvec(m,rv,rl);
	Adot(:,:,end+1) = (acc(:,:,end)-acc(:,:,end-1))./dt(end-1);
	dt(end+1) = dtval(acc(:,:,end),Adot(:,:,end));
	v(:,:,end+1) = vnext(v(:,:,end),acc(:,:,end),Adot(:,:,end),dt(end));
	
	% Hvis det er tid til at gemme, så gemmes der (sker hvert n_plot tidsskridt)
	if i == nextsave
		rt(:,:,end+1) = r(:,:,end); 
		nextsave = nextsave+n_plot;
	end
	
	t = t + dt(end);
	i = i+1;
end


%% Test af orbit.m

clear all
close all
clc

global G

% Startbetingelser
r_init = [1 -2 1; 3 -1 -1; 0 0 0];	% Objekternes startpositioner
v_init = [0 0 0; 0 0 0; 0 0 0];		% objekternes starthastigheder
m = [3 4 5];						% Masserne af objekterne
t_end = 200;							% Sluttiden
dt_initial = 5e-2 ;					% Det første tidsskridt
graph_on_off = false;				% Om der skal plottes eller ej
n_plot = 1;						% Antal tidsskridt per plot
G = 1;								% Gravitationskonstant


% 	rnext = @(r,v,a,adt,dt) r+v.*dt+1/2.*a.*dt.^2+1/6.*adt.*dt.^3;
% 	vnext = @(v,a,adt,dt) v+a.*dt + 1/2.*adt.*dt.^2;
% 
% 
% 	i = 1								% tællevariabel
% 	t = 0								% tidsvariabel
% 
% 
% 	% Initialisering af arrays og input af startværdier
% 	r(:,:,i) = r_init;
% 	rt(:,:,1) = r_init;
% 	v(:,:,i) = v_init;
% 	nextsave = n_plot
% 	Adot(:,:,i) = zeros(3,size(r_init,2));
% 	dt(1) = dt_initial;
% 	dt(2) = dt_initial;
% 
% 	rv = rvec(r(:,:,end));
% 	rl = rvlen(rv);
% 	acc(:,:,i) = accvec(m,rv,rl);
% 	
% 	t = t+dt(end)
% 	i = i+1
% 
% 	while t <= t_end
% 
% 		r(:,:,end+1) = rnext(r(:,:,end),v(:,:,end),acc(:,:,end),Adot(:,:,end),dt(end));
% 
% 		rv = rvec(r(:,:,end));
% 		rl = rvlen(rv);
% 		acc(:,:,end+1) = accvec(m,rv,rl);
% 		Adot(:,:,end+1) = (acc(:,:,end)-acc(:,:,end-1))./dt(end-1);
% 		dt(end+1) = dtval(acc(:,:,end),Adot(:,:,end));
% 		v(:,:,end+1) = vnext(v(:,:,end),acc(:,:,end),Adot(:,:,end),dt(end));
% 
% 		% Hvis det er tid til at gemme, så gemmes der (sker hvert n_plot tidsskridt)
% 		if i >= nextsave
% 			rt(:,:,end+1) = r(:,:,end); 
% 			nextsave = nextsave+n_plot
% 		end
% 
% 		t = t + dt(end)
% 		i = i+1
% 	end

[rt,nextsave] = orbit(r_init,v_init,m,t_end,dt_initial,graph_on_off,n_plot);
[~,objectnum,tnum] = size(rt);
xplot = reshape(rt(1,:,:),[objectnum,tnum])';
yplot = reshape(rt(2,:,:),[objectnum,tnum])';
zplot = reshape(rt(3,:,:),[objectnum,tnum])';

figure
hold on
for i = 1:objectnum
	plot3(xplot(:,i),yplot(:,i),zplot(:,i))
end
xlabel('x')
ylabel('y')