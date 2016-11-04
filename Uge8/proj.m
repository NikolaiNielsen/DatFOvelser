clear all
%close all
clc

% Variables!
dt = 1;				% time step
vis = 90;			% fov in degrees
stor = 100;			% size of the (square) board
tend = 100;			% number of iterations
r.dot_size = 15;		% Size of the dots for the scatter plot

% For race 1:
n1 = 50;			% number of individuals of race 1
v_f1 = 0.5;			% Normal speed for race 1
t_f1 = 10;			% num steps a race 1 cell moves in a given direction
r_panik = 10;		% panic distance for race 1, must be smaller than r_f2
t_panik = 15;		% panic time for race 1
r_pp = 5;			% secondary panic radius
t_pp = 10;			% secondary panic time
r_syg = 1;			% sickness radius
t_syg = 15;			% Sickness time
r_die = 1;			% distance between race 1 and 2, where race 1 dies (if 1 is in 2s fov, otherwise 2 dies)

% For race 2:
n2 = 25;			% num cells race 2
v_f2 = 0.2;			% Normal speed for race 2
t_f2 = 3;			% time for race 2
r_fol = 15;			% vision radius for race 2.
t_fol = 10;			% steps an r2 cell follows an r1 cell

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
				 	% This is the cosine of the angle
r.vis 			= [	0, 	1/sqrt(2),	0, ...
					0, 	0, 	1/sqrt(2)];
r.col 			= [ 'g','r','b','y','m','k'];
r.r1rad 		= [r_panik, r_syg, r_die,r_pp];
r.r2rad			= r_fol;

%% Lav startposition:
r = init(r,n1,n2,v_f1,v_f2,t_f1,t_f2,stor);

figure
hold on
axis([0 stor 0 stor])
p = plotter(r,0);
title(sprintf('%d',1))

for i = 2:tend
	rlast = r.pos;
	r.rv = rvec(rlast);
	r.rvlen = rvlen(r.rv);
	% r2 = r;
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
	r.pos = nextstep(rlast,r.vel,dt);

	% Edgecases are checked. If they meet the edge, they're reflected
	[r.vel, r.pos] = edgecase(r.vel, r.pos, ...
									rlast, stor, dt);

	% Delete the last iterations scatter plots, plot the new ones and pause
	% the simulation.
	title(sprintf('%d',i))
	p = plotter(r,1,p);
	r.rvlast = r.rv;
	r.rvlenlast = r.rvlen;
end