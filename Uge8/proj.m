clear all
%close all
clc

% Variables!
dt = 1;				% time step
vis = 90;			% fov in degrees
stor = [100 100]; 	% size of the board
ptime = 0.1;		% pausetime
tend = 100;			% number of iterations
dot_size = 15;		% Size of the dots for the scatter plot

% For race 1:
n1 = 25;			% number of individuals of race 1
v_f1 = 0.5;			% Normal speed for race 1
t_f1 = 10;			% num steps a race 1 cell moves in a given direction
r_panik = 10;		% panic distance for race 1, must be smaller than r_f2
t_panik = 15;		% panic time for race 1
t_pp = 10;			% secondary panic time
t_syg = 15;
r_die1 = 5;			% distance between race 1 and 2, where race 1 dies

% For race 2:
n2 = 50;			% num cells race 2
v_f2 = 0.2;			% Normal speed for race 2
t_f2 = 3;			% time for race 2
r_f2 = 15;			% vision radius for race 2.
t_fol = 10;			% steps an r2 cell follows an r1 cell
r_die2 = 5;			% Distance at which r2 dies, if backstabbed

% Vectors corresponding to the times and speeds of states.
% 1: healthy r1
% 2: normal r2
% 3: Panicy r1
% 4: secondary panic r1
% 5: sick r1
% 6: hunting r2
r.resetTime 	= [	t_f1, 		t_f2, 		t_panik,...
					t_pp, 		t_syg, 		t_fol];
r.Hast 			= [	v_f1, 		v_f2, 		2*v_f1,...
				 	2*v_f1, 	1.5*v_f1, 	v_f2];
r.vis 			= [	pi/2, 		pi/4, 		pi/2, ...
					pi/2, 		pi/2, 		pi/4];
r.col 			= [ 'g','r','b'];
% r.panRad		= r_panic;
r.r1rad 		= [r_panik, r_die1];

%% Lav startposition:
r = init(r,n1,n2,v_f1,v_f2,t_f1,t_f2,stor);


figure
hold on
p1 = scatter(r.pos(1,r.r1,1),r.pos(2,r.r1,1),dot_size,r.col(1),'filled');
p2 = scatter(r.pos(1,r.r2,1),r.pos(2,r.r2,1),dot_size,r.col(2),'filled');
p3 = scatter(r.pos(1,r.race == 3,1),r.pos(2,r.race == 3,1),dot_size,r.col(3),'filled');
axis([0 stor(1) 0 stor(2)])
drawnow



for i = 2:tend
	
	r.rv = rvec(r.pos(:,:,i-1));
	r.rvlen = rvlen(r.rv);
	r2 = r;
	r = statechange(r);
	
	% counting down the time variable towards 0 (where a change in
	% direction happens)
	r.t = r.t-1;

	% Logic array of which cells need updated velocities
	r.tally(1,:) = r.t == 0;

	% restart time counter
	[r.t,r.race] = tid(r);

	% update the direction and velocity
	r.vel(:,:) = velupdate(r);



	% new position for individuals. Simple first order Euler integration
	% r.pos(:,:,i) = r.pos(:,:,i-1) + r.vel*dt;
	r.pos(:,:,i) = nextstep(r.pos(:,:,i-1),r.vel,dt);

	% Edgecases are checked. If they meet the edge, they're reflected
	[r.vel, r.pos(:,:,i)] = edgecase(r.vel, r.pos(:,:,i), ...
									r.pos(:,:,i-1), stor, dt);

	% Delete the last iterations scatter plots, plot the new ones and pause
	% the simulation.
	delete(p1);
	delete(p2);
	delete(p3);
	p1 = scatter(r.pos(1,r.r1,i),r.pos(2,r.r1,i),dot_size,r.col(1),'filled');
	p2 = scatter(r.pos(1,r.r2,i),r.pos(2,r.r2,i),dot_size,r.col(2),'filled');
	p3 = scatter(r.pos(1,r.race == 3,i),r.pos(2,r.race == 3,i),dot_size,r.col(3),'filled');
	drawnow
end