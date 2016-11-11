%% Initial conditions
% change these to other values (only numbers) and see what happens!
side = 100;			% size of the (square) board
tend = 75;			% number of iterations to run for
r.dot_size = 15;	% Size of the dots for the graphics

% For race 1:
n1 = 50;			% number of individuals of race 1
v_f1 = 0.5;			% Normal speed for race 1
t_f1 = 10;			% num steps a race 1 cell moves in a given direction
r_panic = 10;		% panic radius for race 1, should be smaller than r_f2
t_panic = 15;		% panic time for race 1
s_panic = 2;		% Speed when panicing (primary and secondary)
r_pp = 5;			% secondary panic radius
t_pp = 10;			% secondary panic time
r_syg = 3;			% sickness radius
t_syg = 15;			% Sickness time
s_sick = 1.5;		% Speed when sick
r_die = 1;			% distance between race 1 and 2, where race 1 dies
					% (if 1 is in 2s fov, otherwise 2 dies)

% For race 2:
n2 = 25;			% number of cells race 2
v_f2 = 0.2;			% Normal speed for race 2
t_f2 = 3;			% time for race 2
r_fol = 15;			% vision radius for race 2.
t_fol = 10;			% steps an r2 cell follows an r1 cell

%% Initialize the simulation.
% You shouldn't edit below this line, unless you know what you're doing.

% Closes all previous figures. Mostly for debugging purposes where the simulation is run multiple
% times and I'm too lazy to close them after each run.
close all

% Vectors corresponding to the times and speeds of states.
% 1: healthy r1
% 2: normal r2
% 3: Panicy r1
% 4: secondary panic r1
% 5: sick r1
% 6: hunting r2
r.resetTime 	= [	t_f1, 			t_f2, 			t_panic,...
					t_pp, 			t_syg, 			t_fol];
r.speed 		= [	v_f1, 			v_f2, 			s_panic*v_f1,...
				 	s_panic*v_f1, 	s_sick*v_f1, 	v_f2];
				 % This is the cosine of the angle for the field of vision
r.vis 			= [	0, 	1/sqrt(2),	0, ...
					0, 	0, 	1/sqrt(2)];
r.col 			= [ 'g','r','b','c','m','k'];
r.r1rad 		= [r_panic, r_syg, r_die,r_pp];
r.r2rad			= r_fol;
r.side			= side;
r.n 			= [n1,n2];
r.dt = 1;


r = init(r);

figure('position',[20,20,550,550],'OuterPosition',[100,100,750,600])
hold on
p = plotter(r,0);
title(sprintf('%d',1))

% For printing the figures to .png files
% q = 1
% print(sprintf('plot%d',q),'-dpng')

for i = 2:tend
	% For printing the figures to .png files
	% if i == 26 || i == 51 || i == 76
	% 	q = q+1;
	% 	print(sprintf('plot%d',q),'-dpng')
	% end

	% Stores the last position in a separate array. It's used for getting the next position and
	% checking edgecases. For some reason, when I put it in the r struct, edgecases misbehaves.
	rlast = r.pos;


	% r.rv = rvec(rlast);
	% r.rvlen = rvlen(r.rv);
	r = rv(r);
 	r = statechange(r);

	% counting down the time variable towards 0 (where a change in direction happens)
	r.t = r.t-1;

	% Logic array of which cells need updated velocities
	r.tally = r.t == 0;

	% restart time counter
	[r.t,r.race] = tid(r);

	% update the direction and velocity
	r.vel = velupdate(r);


	% new position for individuals. Simple first order Euler integration
	r.pos = rlast+r.vel*r.dt;

	% Edgecases are checked. If they meet the edge, they're reflected
	r = edgecase(r,rlast);

	% Delete the last iterations scatter plots, plot the new ones and pause
	% the simulation.
	title(sprintf('%d',i))
	p = plotter(r,1,p);
end
% For printing the figures to .png files
% q = q+1;
% print(sprintf('plot%d',q),'-dpng')