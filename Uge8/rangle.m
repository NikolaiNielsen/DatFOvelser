function r = rangle(r)
	% The purpose of this function is to calculate the field of vision for the different cells
	% The way this is done is by using the dot product of the separation vector and velocity vector, to calculate the angle between these. This allows us to calculate whether or not a cell should flee, die, get sick, give chase or what have you.
	race = r.race;
	r1 = race == 1;
	r2 = race == 2;
	panic = race == 3;
	spanic = race == 4;
	sick = race == 5;
	hunt = race == 6;
	r.sight =

	for in = 1:length(r.t)
		inRace = race(in);
		for out = 1:length(r.t)
			if in == out
				continue
			end



		end
	end


end