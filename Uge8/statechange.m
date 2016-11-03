function r = statechange(r)
	% The purpose of this function is to calculate the field of vision for the different cells
	% The way this is done is by using the dot product of the separation vector and velocity vector, to calculate the angle between these. This allows us to calculate whether or not a cell should flee, die, get sick, give chase or what have you.
	race = r.race;
	r1 = race == 1;
	r2 = race == 2;
	panic = race == 3;
	spanic = race == 4;
	sick = race == 5;
	hunt = race == 6;

	% Slamkoder et forloop
	for in = 1:length(r.t)
		inRace = race(in);

		% Healthy race 1
		if inRace == 1
			v = r.vel(in);
			for out = 1:length(r.t)
				outRace = race(out);
				if outRace == 2 || outRace == 6
					% fprintf('rvlen = %f',rvlen)
					if r.rvlen(1,in,out) <= r.r1rad(2)
						newrace = 2;
						% fprintf('in = %d, new race = %d\n', in,newrace)
						r.t(in) = r.resetTime(newrace);
						r.race(in) = newrace;
					elseif r.rvlen(1,in,out) <= r.r1rad(1)
						newrace = 3;
						r.vel(:,in) = -r.vel(:,in);
						% fprintf('in = %d, new race = %d\n', in,newrace)
						r.t(in) = r.resetTime(newrace);
						r.race(in) = newrace;
					end

				end
			end
		% elseif inRace == 2
		% elseif inRace == 3

		% elseif inRace == 4
		% elseif inRace == 5

		% else


		end
	end


end