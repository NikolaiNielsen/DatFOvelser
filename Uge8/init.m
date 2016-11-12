function r = init(r)
	% This function takes care of all the initial conditions of the simulation.
	% It creates n1+n2 cells, n1 of race 1 and n2 of race 2, gives them a
	% random position, direction and velocity along this direction. It also
	% sets the time counter to the correct values.

	n = r.n(1)+r.n(2);

	% The starting positions.
	r.start(1,:) = rand(n,1)*r.side;
	r.start(2,:) = rand(n,1)*r.side;
	% Setting the races
	r.race(1:r.n(1)) = 1;
	r.race(r.n(1)+1:n) = 2;
	% Logical arrays for each race
	r.r1 = r.race == 1;
	r.r2 = r.race == 2;

	% The starting positions are loaded in the pos array
	r.pos(:,:) = r.start;

	% The random directions and velocities
	r.dir = rand(1,n)*2*pi;
	r.vel(1,r.r1) = r.speed(1) * cos(r.dir(r.r1));
	r.vel(2,r.r1) = r.speed(1) * sin(r.dir(r.r1));
	r.vel(1,r.r2) = r.speed(2) * cos(r.dir(r.r2));
	r.vel(2,r.r2) = r.speed(2) * sin(r.dir(r.r2));

	% Setting the time counters.
	r.t(r.r1) = r.resetTime(1);
	r.t(r.r2) = r.resetTime(2);
end