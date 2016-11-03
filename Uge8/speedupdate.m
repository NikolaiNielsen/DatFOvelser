function vel = velupdate(r)

	% Load the vel array, so we don't accidentally set them to 0.
	vel = r.vel(:,:);
	
	% Loop over the array to check which velocities needs updating
	for j = 1:length(r.t);
		
		% If the time is 0 for the j'th particle, update its direction and
		% velocity
		if r.tally(1,j)
			r.dir(j) = rand()*2*pi;
			vel(1,j) = r.Hast(r.race(j)) * cos(r.dir(j));
			vel(2,j) = r.Hast(r.race(j)) * sin(r.dir(j));
		end
	end
end