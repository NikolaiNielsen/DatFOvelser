clear all
close all
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
r.col(1) = 'g';		% color of healthy race 1 cells

% For race 2:
n2 = 50;			% num cells race 2
v_f2 = 0.2;			% Normal speed for race 2
t_f2 = 3;			% time for race 2
r_f2 = 15;			% vision radius for race 2.
t_fol = 10;			% steps an r2 cell follows an r1 cell
r_die2 = 5;			% Distance at which r2 dies, if backstabbed
r.col(2) = 'r';		% color of r2 cells

% Vectors corresponding to the times and speeds of states.
% 1: healthy r1
% 2: normal r2
% 3: Panicy r1
% 4: secondary panic r1
% 5: sick r1
% 6: hunting r2
r.resetTime 	= [t_f1, 	t_f2, 		t_panik,	t_pp, 		t_syg, 		t_fol];
r.Hast 			= [v_f1, 	v_f2, 		2*v_f1, 	2*v_f1, 	1.5*v_f1, 	v_f2];
r.vis 			= [pi/2, 	pi/4, 		pi/2, 		pi/2, 		pi/2, 		pi/4];

%% Lav startposition:
r = init(r,n1,n2,v_f1,v_f2,t_f1,t_f2,stor);


figure
hold on
p1 = scatter(r.pos(1,r.r1,1),r.pos(2,r.r1,1),dot_size,r.col(1),'filled');
p2 = scatter(r.pos(1,r.r2,1),r.pos(2,r.r2,1),dot_size,r.col(2),'filled');
axis([0 stor(1) 0 stor(2)])
pause(ptime)
for i = 2:tend
	%fprintf('i = %d\n', i);
	rv = rvec(r.pos(:,:,i-1));
	rlen = rvlen(rv);


	% counting down the time variable towards 0 (where a change in
	% direction happens)
	r.t = r.t-1;

	% Logic array of which cells need updated velocities
	r.tally(1,:) = r.t == 0;

	% update the direction and velocity
	r.vel(:,:) = velupdate(r);

	% restart time counter
	r.t = tid(r);

	% new position for individuals. Simple first order Euler integration
	r.pos(:,:,i) = r.pos(:,:,i-1) + r.vel*dt;

	% Edgecases are checked. If they meet the edge, they're reflected
	[r.vel, r.pos(:,:,i)] = edgecase(r,dt);
	% r.oob = r.pos(:,:,i) <= 0 | r.pos(:,:,i) >= stor(1);
	% if ~isempty(r.oob)
	% 	% A matrix of 1's and -1's to indicate which velocity components
	% 	% needs to be flipped is used to update the velocity.
	% 	% r.oob is a logical array, and r.oob*(-2)+1 has -1 for flipped
	% 	% components, and 1 for non-flipped components
	% 	r.vel = r.vel.*(r.oob*(-2)+1);
	% 	% update the position with new velocity vectors.
	% 	r.pos(:,:,i) = r.pos(:,:,i-1) + r.vel*dt;
	% end

	% Delete the last iterations scatter plots, plot the new ones and pause
	% the simulation.
	delete(p1);
	delete(p2);
	p1 = scatter(r.pos(1,r.r1,i),r.pos(2,r.r1,i),dot_size,r.col(1),'filled');
	p2 = scatter(r.pos(1,r.r2,i),r.pos(2,r.r2,i),dot_size,r.col(2),'filled');
	pause(ptime)
end