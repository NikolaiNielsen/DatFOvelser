function vel = velupdate(r)

	% Load the vel array, so we don't accidentally set them to 0.
	vel = r.vel(:,:);

	% Loop over the array to check which velocities needs updating
	for in = 1:length(r.t);

		% If the time is 0 for the in'th particle, update its direction and
		% velocity
		if r.tally(1,in)
			r.dir(in) = rand()*2*pi;
			% Get the speed from the array of reference speeds.
			vel(1,in) = r.speed(r.race(in)) * cos(r.dir(in));
			vel(2,in) = r.speed(r.race(in)) * sin(r.dir(in));
		end
		% If it's on the hunt we update the vector all the time.
		if r.race(in) == 6
			% We get the victim ID
			victim = r.chase(in);

			% We divide the separation vector with its length to obtain a unit vector, then scale it with r.speed(6) for the appropriate velocity
			dirvector = r.rv(:,victim,in);
			dirlength = r.rvlen(victim,in);
			vel(:,in) = dirvector*r.speed(6)/dirlength;
		end
	end
end